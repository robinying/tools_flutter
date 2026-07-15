package com.robin.tools_flutter

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.arthenica.ffmpegkit.FFmpegKit
import com.arthenica.ffmpegkit.ReturnCode
import io.flutter.plugin.common.EventChannel
import java.io.File
import java.util.concurrent.Executors

class MediaJobService : Service() {
    private val executor = Executors.newSingleThreadExecutor()

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
            emit(mapOf("phase" to "failed", "message" to "No job type"))
            stopForeground(STOP_FOREGROUND_REMOVE)
            stopSelf()
            return START_NOT_STICKY
        }
        val level = intent.getStringExtra(EXTRA_LEVEL) ?: "medium"
        val paths = readPaths(intent)
        if (paths.isEmpty()) {
            emit(mapOf("phase" to "failed", "message" to "No input files"))
            stopForeground(STOP_FOREGROUND_REMOVE)
            stopSelf()
            return START_NOT_STICKY
        }

        cancelRequested = false
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
                            "outputPath" to out
                        )
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
                try {
                    stopForeground(STOP_FOREGROUND_REMOVE)
                } catch (_: Exception) {
                }
                stopSelf()
            }
        }
        return START_NOT_STICKY
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
                NotificationChannel(CHANNEL, "Media Jobs", NotificationManager.IMPORTANCE_LOW)
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
                ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROCESSING
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
        val ts = System.currentTimeMillis()
        emit(mapOf("phase" to "running", "progress" to 0.15, "message" to type))
        if (cancelRequested) return null
        Log.i(TAG, "runJob type=$type level=$level paths=$paths")

        if (type == "merge") {
            if (paths.size < 2) return null
            val listFile = File(cacheDir, "concat_$ts.txt")
            listFile.writeText(paths.joinToString("\n") { "file '${it.replace("'", "'\\''")}'" })
            val out = File(outDir, "merged_$ts.mp4").absolutePath
            emit(mapOf("phase" to "running", "progress" to 0.4, "message" to "Merging…"))
            val copyArgs = arrayOf(
                "-f", "concat", "-safe", "0", "-i", listFile.absolutePath,
                "-c", "copy", "-y", out
            )
            val session = FFmpegKit.executeWithArguments(copyArgs)
            if (ReturnCode.isSuccess(session.returnCode)) return out
            val re = arrayOf(
                "-f", "concat", "-safe", "0", "-i", listFile.absolutePath,
                "-c:v", "mpeg4", "-q:v", "5", "-c:a", "aac", "-y", out
            )
            val s2 = FFmpegKit.executeWithArguments(re)
            return if (ReturnCode.isSuccess(s2.returnCode)) out else null
        }

        val out: String
        val args: Array<String> = when (type) {
            "videoCompress" -> {
                val q = when (level) {
                    "low" -> "8"; "high" -> "3"; else -> "5"
                }
                out = File(outDir, "compressed_$ts.mp4").absolutePath
                arrayOf("-i", paths[0], "-c:v", "mpeg4", "-q:v", q, "-c:a", "aac", "-b:a", "128k", "-y", out)
            }
            "extractAudio" -> {
                val br = when (level) {
                    "low" -> "96k"; "high" -> "192k"; else -> "128k"
                }
                out = File(outDir, "audio_$ts.m4a").absolutePath
                arrayOf("-i", paths[0], "-vn", "-c:a", "aac", "-b:a", br, "-y", out)
            }
            "stripAudio" -> {
                out = File(outDir, "muted_$ts.mp4").absolutePath
                arrayOf("-i", paths[0], "-c:v", "copy", "-an", "-y", out)
            }
            "transcode" -> {
                out = File(outDir, "transcoded_$ts.mp4").absolutePath
                arrayOf(
                    "-i", paths[0], "-c:v", "mpeg4", "-q:v", "5",
                    "-c:a", "aac", "-b:a", "128k", "-movflags", "+faststart", "-y", out
                )
            }
            "speed" -> {
                val speed = when (level) {
                    "low" -> 0.5; "high" -> 2.0; else -> 1.5
                }
                val setpts = 1.0 / speed
                out = File(outDir, "speed_$ts.mp4").absolutePath
                arrayOf(
                    "-i", paths[0],
                    "-filter_complex", "[0:v]setpts=${setpts}*PTS[v];[0:a]atempo=$speed[a]",
                    "-map", "[v]", "-map", "[a]",
                    "-c:v", "mpeg4", "-q:v", "5", "-c:a", "aac", "-b:a", "128k", "-y", out
                )
            }
            "reverse" -> {
                out = File(outDir, "reverse_$ts.mp4").absolutePath
                if (level == "medium") {
                    arrayOf(
                        "-i", paths[0], "-vf", "reverse", "-af", "areverse",
                        "-c:v", "mpeg4", "-q:v", "5", "-c:a", "aac", "-y", out
                    )
                } else {
                    arrayOf(
                        "-i", paths[0], "-vf", "reverse", "-an",
                        "-c:v", "mpeg4", "-q:v", "5", "-y", out
                    )
                }
            }
            "crop" -> {
                val ratio = when (level) {
                    "low" -> "1"; "high" -> "16/9"; else -> "9/16"
                }
                val crop =
                    "crop=if(gt(a\\,$ratio)\\,ih*$ratio\\,iw):if(gt(a\\,$ratio)\\,ih\\,iw/($ratio))"
                out = File(outDir, "crop_$ts.mp4").absolutePath
                arrayOf(
                    "-i", paths[0], "-vf", crop, "-c:v", "mpeg4", "-q:v", "5",
                    "-c:a", "aac", "-b:a", "128k", "-y", out
                )
            }
            "volumeFade" -> {
                val vol = when (level) {
                    "low" -> 0.5; "high" -> 1.5; else -> 1.0
                }
                out = File(outDir, "vol_$ts.mp4").absolutePath
                arrayOf(
                    "-i", paths[0], "-c:v", "copy",
                    "-af", "volume=$vol,afade=t=in:st=0:d=0.5",
                    "-c:a", "aac", "-y", out
                )
            }
            "gif" -> {
                out = File(outDir, "anim_$ts.gif").absolutePath
                val fps = when (level) {
                    "low" -> "8"; "high" -> "15"; else -> "10"
                }
                arrayOf("-i", paths[0], "-vf", "fps=$fps,scale=480:-1:flags=lanczos", "-y", out)
            }
            "imageCompress" -> {
                out = File(outDir, "img_$ts.jpg").absolutePath
                val q = when (level) {
                    "low" -> "8"; "high" -> "2"; else -> "5"
                }
                arrayOf("-i", paths[0], "-q:v", q, "-y", out)
            }
            "textCard" -> {
                val text = paths.getOrNull(1) ?: "Hello"
                val duration = paths.getOrNull(2) ?: "3"
                out = File(outDir, "textcard_$ts.mp4").absolutePath
                val escaped = text.replace("\\", "\\\\").replace(":", "\\:").replace("'", "\\'")
                arrayOf(
                    "-f", "lavfi", "-i", "color=c=0x2D1B4E:s=720x1280:d=$duration",
                    "-vf",
                    "drawtext=text='$escaped':fontcolor=white:fontsize=48:x=(w-text_w)/2:y=(h-text_h)/2",
                    "-c:v", "mpeg4", "-q:v", "5", "-y", out
                )
            }
            "slideshow" -> {
                val sec = when (level) {
                    "low" -> 1; "high" -> 3; else -> 2
                }
                if (paths.isEmpty()) return null
                out = File(outDir, "slideshow_$ts.mp4").absolutePath
                val inputs = mutableListOf<String>()
                paths.forEach { p ->
                    inputs.addAll(listOf("-loop", "1", "-t", "$sec", "-i", p))
                }
                val n = paths.size
                val scaleParts = (0 until n).joinToString("") {
                    "[$it:v]scale=720:1280:force_original_aspect_ratio=decrease," +
                        "pad=720:1280:(ow-iw)/2:(oh-ih)/2,setsar=1,format=yuv420p[v$it];"
                }
                val concatIn = (0 until n).joinToString("") { "[v$it]" }
                val filter = "${scaleParts}${concatIn}concat=n=$n:v=1:a=0[outv]"
                (inputs + listOf(
                    "-filter_complex", filter, "-map", "[outv]",
                    "-c:v", "mpeg4", "-q:v", "5", "-y", out
                )).toTypedArray()
            }
            else -> return null
        }

        emit(mapOf("phase" to "running", "progress" to 0.45, "message" to "Encoding…"))
        if (cancelRequested) return null
        Log.i(TAG, "ffmpeg args=${args.joinToString(" ")}")
        val session = FFmpegKit.executeWithArguments(args)
        if (ReturnCode.isSuccess(session.returnCode)) {
            Log.i(TAG, "ffmpeg ok -> $out")
            return out
        }

        Log.e(TAG, "ffmpeg fail code=${session.returnCode}: ${session.allLogsAsString}")
        if (type == "stripAudio") {
            val retryOut = File(outDir, "muted2_$ts.mp4").absolutePath
            val retry = arrayOf(
                "-i", paths[0], "-c:v", "mpeg4", "-q:v", "5", "-an", "-y", retryOut
            )
            val s2 = FFmpegKit.executeWithArguments(retry)
            if (ReturnCode.isSuccess(s2.returnCode)) return retryOut
        }
        if (type == "speed") {
            val speed = when (level) {
                "low" -> 0.5; "high" -> 2.0; else -> 1.5
            }
            val setpts = 1.0 / speed
            val retryOut = File(outDir, "speed2_$ts.mp4").absolutePath
            val retry = arrayOf(
                "-i", paths[0], "-filter:v", "setpts=${setpts}*PTS", "-an",
                "-c:v", "mpeg4", "-q:v", "5", "-y", retryOut
            )
            val s2 = FFmpegKit.executeWithArguments(retry)
            if (ReturnCode.isSuccess(s2.returnCode)) return retryOut
        }
        if (type == "textCard") {
            // font may fail drawtext — solid color only
            val duration = paths.getOrNull(2) ?: "3"
            val retryOut = File(outDir, "textcard2_$ts.mp4").absolutePath
            val retry = arrayOf(
                "-f", "lavfi", "-i", "color=c=0x2D1B4E:s=720x1280:d=$duration",
                "-c:v", "mpeg4", "-q:v", "5", "-y", retryOut
            )
            val s2 = FFmpegKit.executeWithArguments(retry)
            if (ReturnCode.isSuccess(s2.returnCode)) {
                Log.i(TAG, "textCard fallback ok -> $retryOut")
                return retryOut
            }
        }
        return null
    }

    private fun emit(map: Map<String, Any?>) {
        try {
            Log.i(TAG, "emit $map")
            eventSink?.success(map)
        } catch (e: Exception) {
            Log.w(TAG, "emit failed", e)
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
    }
}
