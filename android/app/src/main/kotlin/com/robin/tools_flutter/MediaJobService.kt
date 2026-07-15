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
                when (val outcome = runJob(type, paths, level)) {
                    is JobOutcome.Success -> emit(
                        mapOf(
                            "phase" to "finished",
                            "progress" to 1.0,
                            "message" to "Done",
                            "outputPath" to outcome.outputPath,
                        ),
                    )
                    is JobOutcome.Failure -> emit(
                        mapOf("phase" to "failed", "message" to outcome.message),
                    )
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

    private fun runJob(type: String, paths: List<String>, level: String): JobOutcome {
        val outDir = File(cacheDir, "media_out")
        if ((!outDir.exists() && !outDir.mkdirs()) || !outDir.isDirectory) {
            return JobOutcome.Failure("Unable to prepare output storage")
        }
        pruneMediaCache(outDir, reserveForOutput = true)
        if (!MediaJobExecutionGuard.hasEnoughSpace(outDir, MediaJobLimits.MAX_OUTPUT_BYTES)) {
            return JobOutcome.Failure("Not enough storage for output")
        }

        val ts = System.currentTimeMillis()
        val deadlineElapsedMs = android.os.SystemClock.elapsedRealtime() + MediaJobLimits.JOB_TIMEOUT_MS
        emit(mapOf("phase" to "running", "progress" to 0.15, "message" to type))
        if (cancelRequested) {
            return JobOutcome.Failure("Cancelled")
        }

        val plan = MediaJobCommands.build(type, paths, level, outDir, cacheDir, ts)
            ?: return JobOutcome.Failure("Unsupported media job")
        try {
            if (type == "merge") {
                emit(mapOf("phase" to "running", "progress" to 0.4, "message" to "Merging…"))
                val primary = runPlan(plan, outDir, deadlineElapsedMs)
                if (primary is MediaJobExecutionGuard.Result.Success) {
                    pruneMediaCache(outDir)
                    return JobOutcome.Success(plan.outputPath)
                }
                if (primary !is MediaJobExecutionGuard.Result.Failed) {
                    return JobOutcome.Failure(primary.message())
                }
                val listFile = plan.listFile ?: return JobOutcome.Failure("FFmpeg failed")
                val fallback = runArgs(
                    MediaJobCommands.mergeReencode(listFile, plan.outputPath),
                    File(plan.outputPath),
                    outDir,
                    deadlineElapsedMs,
                )
                if (fallback is MediaJobExecutionGuard.Result.Success) {
                    pruneMediaCache(outDir)
                    return JobOutcome.Success(plan.outputPath)
                }
                return JobOutcome.Failure(fallback.message())
            }

            emit(mapOf("phase" to "running", "progress" to 0.45, "message" to "Encoding…"))
            val primary = runPlan(plan, outDir, deadlineElapsedMs)
            if (primary is MediaJobExecutionGuard.Result.Success) {
                pruneMediaCache(outDir)
                return JobOutcome.Success(plan.outputPath)
            }
            if (primary !is MediaJobExecutionGuard.Result.Failed) {
                return JobOutcome.Failure(primary.message())
            }

            val fallback = when (type) {
                "stripAudio" -> MediaJobCommands.retryStripAudio(paths[0], outDir, ts)
                "speed" -> MediaJobCommands.retrySpeed(paths[0], level, outDir, ts)
                "textCard" -> MediaJobCommands.retryTextCardSolid(paths[2].toInt(), outDir, ts)
                else -> null
            } ?: return JobOutcome.Failure("FFmpeg failed")
            val fallbackResult = runPlan(fallback, outDir, deadlineElapsedMs)
            if (fallbackResult is MediaJobExecutionGuard.Result.Success) {
                pruneMediaCache(outDir)
                return JobOutcome.Success(fallback.outputPath)
            }
            return JobOutcome.Failure(fallbackResult.message())
        } finally {
            plan.listFile?.delete()
        }
    }

    private fun runPlan(
        plan: MediaJobCommands.Plan,
        outDir: File,
        deadlineElapsedMs: Long,
    ): MediaJobExecutionGuard.Result = runArgs(
        plan.args,
        File(plan.outputPath),
        outDir,
        deadlineElapsedMs,
    )

    private fun runArgs(
        args: Array<String>,
        output: File,
        outDir: File,
        deadlineElapsedMs: Long,
    ): MediaJobExecutionGuard.Result = MediaJobExecutionGuard.run(
        args = args,
        output = output,
        outputDir = outDir,
        deadlineElapsedMs = deadlineElapsedMs,
        isCancellationRequested = { cancelRequested },
    )

    /** Keeps recent output within the count and byte budgets. */
    private fun pruneMediaCache(outDir: File, reserveForOutput: Boolean = false) {
        val now = System.currentTimeMillis()
        val maxAgeMs = 24L * 60 * 60 * 1000
        outDir.listFiles()
            ?.filter { it.isFile && now - it.lastModified() > maxAgeMs }
            ?.forEach { it.delete() }

        outDir.listFiles()
            ?.filter { it.isFile }
            ?.sortedByDescending { it.lastModified() }
            ?.drop(24)
            ?.forEach { it.delete() }

        val byteBudget = if (reserveForOutput) {
            MediaJobLimits.MAX_CACHE_BYTES - MediaJobLimits.MAX_OUTPUT_BYTES
        } else {
            MediaJobLimits.MAX_CACHE_BYTES
        }
        var retainedBytes = outDir.listFiles()?.filter { it.isFile }?.sumOf { it.length() } ?: 0L
        outDir.listFiles()
            ?.filter { it.isFile }
            ?.sortedBy { it.lastModified() }
            ?.forEach { file ->
                if (retainedBytes > byteBudget) {
                    val bytes = file.length()
                    if (file.delete()) {
                        retainedBytes -= bytes
                    }
                }
            }
    }

    private sealed class JobOutcome {
        data class Success(val outputPath: String) : JobOutcome()
        data class Failure(val message: String) : JobOutcome()
    }

    private fun MediaJobExecutionGuard.Result.message(): String = when (this) {
        MediaJobExecutionGuard.Result.Cancelled -> "Cancelled"
        MediaJobExecutionGuard.Result.TimedOut -> "Media job timed out"
        MediaJobExecutionGuard.Result.OutputTooLarge -> "Output exceeds the allowed size"
        MediaJobExecutionGuard.Result.InsufficientStorage -> "Not enough storage for output"
        MediaJobExecutionGuard.Result.Failed -> "FFmpeg failed"
        MediaJobExecutionGuard.Result.Success -> "Done"
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
