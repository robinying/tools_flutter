package com.robin.tools_flutter

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import androidx.core.app.NotificationCompat
import com.arthenica.ffmpegkit.FFmpegKit
import com.arthenica.ffmpegkit.ReturnCode
import io.flutter.plugin.common.EventChannel
import java.io.File
import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicBoolean

class MediaJobService : Service() {
    private val executor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // Must call startForeground ASAP (Android 8+/12+ FGS contract)
        try {
            startAsForeground()
        } catch (e: Exception) {
            Log.e(TAG, "startForeground failed", e)
            stopSelf()
            return START_NOT_STICKY
        }

        val type = intent?.getStringExtra(EXTRA_TYPE)
        if (type.isNullOrBlank()) {
            failAndMaybeStop("No job type", stopService = !jobRunning.get())
            return START_NOT_STICKY
        }
        val level = intent.getStringExtra(EXTRA_LEVEL) ?: "medium"
        val paths = readPaths(intent)
        if (paths.isEmpty()) {
            failAndMaybeStop("No input files", stopService = !jobRunning.get())
            return START_NOT_STICKY
        }

        MediaPathPolicy.validateJobPaths(this, type, paths)?.let { err ->
            failAndMaybeStop(err, stopService = !jobRunning.get())
            return START_NOT_STICKY
        }

        // Single-flight: reject concurrent jobs (shared cancel/eventSink)
        if (!jobRunning.compareAndSet(false, true)) {
            emit(mapOf("phase" to "failed", "message" to "Another job is running"))
            // Keep existing job's FGS; do not stopSelf
            return START_NOT_STICKY
        }

        cancelRequested = false
        val jobId = startId
        executor.execute {
            try {
                emit(mapOf("phase" to "running", "progress" to 0.05, "message" to "Starting…"))
                val out = runJob(type, paths, level)
                when {
                    cancelRequested -> emit(mapOf("phase" to "failed", "message" to "Cancelled"))
                    out != null -> emit(
                        mapOf(
                            "phase" to "finished",
                            "progress" to 1.0,
                            "message" to "Done",
                            "outputPath" to out,
                        ),
                    )
                    else -> emit(mapOf("phase" to "failed", "message" to "FFmpeg failed"))
                }
            } catch (e: Exception) {
                Log.e(TAG, "job failed", e)
                emit(mapOf("phase" to "failed", "message" to (e.message ?: "error")))
            } catch (t: Throwable) {
                Log.e(TAG, "job fatal", t)
                emit(mapOf("phase" to "failed", "message" to (t.message ?: "fatal")))
            } finally {
                jobRunning.set(false)
                try {
                    stopForeground(STOP_FOREGROUND_REMOVE)
                } catch (_: Exception) {
                }
                stopSelf(jobId)
            }
        }
        return START_NOT_STICKY
    }

    override fun onDestroy() {
        cancelRequested = true
        try {
            FFmpegKit.cancel()
        } catch (_: Exception) {
        }
        executor.shutdownNow()
        super.onDestroy()
    }

    private fun failAndMaybeStop(message: String, stopService: Boolean) {
        emit(mapOf("phase" to "failed", "message" to message))
        if (stopService) {
            try {
                stopForeground(STOP_FOREGROUND_REMOVE)
            } catch (_: Exception) {
            }
            stopSelf()
        }
    }

    private fun readPaths(intent: Intent): ArrayList<String> {
        val raw = intent.extras?.get(EXTRA_PATHS) ?: return arrayListOf()
        return when (raw) {
            is ArrayList<*> -> ArrayList(raw.mapNotNull { it?.toString() })
            is Array<*> -> ArrayList(raw.mapNotNull { it?.toString() })
            is String -> arrayListOf(raw)
            else -> arrayListOf()
        }
    }

    private fun startAsForeground() {
        val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            nm.createNotificationChannel(
                NotificationChannel(CHANNEL, "Media Jobs", NotificationManager.IMPORTANCE_LOW),
            )
        }
        val notification: Notification = NotificationCompat.Builder(this, CHANNEL)
            .setContentTitle("Tools Flutter")
            .setContentText("Processing media…")
            .setSmallIcon(android.R.drawable.ic_menu_upload)
            .setOngoing(true)
            .build()
        if (Build.VERSION.SDK_INT >= 35) {
            startForeground(
                NOTIF_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROCESSING,
            )
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            @Suppress("DEPRECATION")
            startForeground(NOTIF_ID, notification, 0)
        } else {
            startForeground(NOTIF_ID, notification)
        }
    }

    private fun runJob(type: String, paths: List<String>, level: String): String? {
        val outDir = File(cacheDir, "media_out").apply { mkdirs() }
        pruneMediaCache(outDir)
        val ts = System.currentTimeMillis()
        emit(mapOf("phase" to "running", "progress" to 0.15, "message" to type))
        if (cancelRequested) return null
        Log.i(TAG, "runJob type=$type level=$level paths=$paths")

        val plan = MediaJobCommands.build(type, paths, level, outDir, cacheDir, ts) ?: return null

        if (type == "merge") {
            emit(mapOf("phase" to "running", "progress" to 0.4, "message" to "Merging…"))
            val session = FFmpegKit.executeWithArguments(plan.args)
            if (ReturnCode.isSuccess(session.returnCode)) {
                plan.listFile?.delete()
                return plan.outputPath
            }
            val listFile = plan.listFile ?: return null
            val re = MediaJobCommands.mergeReencode(listFile, plan.outputPath)
            val s2 = FFmpegKit.executeWithArguments(re)
            listFile.delete()
            return if (ReturnCode.isSuccess(s2.returnCode)) plan.outputPath else null
        }

        emit(mapOf("phase" to "running", "progress" to 0.45, "message" to "Encoding…"))
        if (cancelRequested) return null
        Log.i(TAG, "ffmpeg args=${plan.args.joinToString(" ")}")
        val session = FFmpegKit.executeWithArguments(plan.args)
        if (ReturnCode.isSuccess(session.returnCode)) {
            Log.i(TAG, "ffmpeg ok -> ${plan.outputPath}")
            return plan.outputPath
        }

        Log.e(TAG, "ffmpeg fail code=${session.returnCode}: ${session.allLogsAsString}")

        when (type) {
            "stripAudio" -> {
                val retry = MediaJobCommands.retryStripAudio(paths[0], outDir, ts)
                val s2 = FFmpegKit.executeWithArguments(retry.args)
                if (ReturnCode.isSuccess(s2.returnCode)) return retry.outputPath
            }
            "speed" -> {
                val retry = MediaJobCommands.retrySpeed(paths[0], level, outDir, ts)
                val s2 = FFmpegKit.executeWithArguments(retry.args)
                if (ReturnCode.isSuccess(s2.returnCode)) return retry.outputPath
            }
            "textCard" -> {
                val durationSec = (paths.getOrNull(2) ?: "3").toIntOrNull()?.coerceIn(1, 30) ?: 3
                val retry = MediaJobCommands.retryTextCardSolid(durationSec, outDir, ts)
                val s2 = FFmpegKit.executeWithArguments(retry.args)
                if (ReturnCode.isSuccess(s2.returnCode)) {
                    Log.i(TAG, "textCard fallback ok -> ${retry.outputPath}")
                    return retry.outputPath
                }
            }
        }
        return null
    }

    /**
     * Keep recent outputs (gallery save may still need the file); drop old/oversized cache.
     */
    private fun pruneMediaCache(outDir: File) {
        val files = outDir.listFiles()?.filter { it.isFile } ?: return
        val now = System.currentTimeMillis()
        val maxAgeMs = 24L * 60 * 60 * 1000
        val maxFiles = 24
        // Age-based
        files.filter { now - it.lastModified() > maxAgeMs }.forEach { it.delete() }
        // Count-based: keep newest
        val remaining = outDir.listFiles()?.filter { it.isFile }?.sortedByDescending { it.lastModified() }
            ?: return
        if (remaining.size > maxFiles) {
            remaining.drop(maxFiles).forEach { it.delete() }
        }
    }

    /** EventChannel must be invoked on the main/platform thread. */
    private fun emit(map: Map<String, Any?>) {
        val deliver = Runnable {
            try {
                Log.i(TAG, "emit $map")
                eventSink?.success(map)
            } catch (e: Exception) {
                Log.w(TAG, "emit failed", e)
            }
        }
        if (Looper.myLooper() == Looper.getMainLooper()) {
            deliver.run()
        } else {
            mainHandler.post(deliver)
        }
    }

    companion object {
        private const val TAG = "MediaJobService"
        private const val CHANNEL = "tools_flutter_media"
        private const val NOTIF_ID = 42
        const val EXTRA_TYPE = "type"
        const val EXTRA_LEVEL = "level"
        const val EXTRA_PATHS = "paths"

        @Volatile
        var eventSink: EventChannel.EventSink? = null

        @Volatile
        var cancelRequested: Boolean = false

        private val jobRunning = AtomicBoolean(false)

        fun isJobRunning(): Boolean = jobRunning.get()
    }
}
