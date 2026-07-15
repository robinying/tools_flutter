package com.robin.tools_flutter

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.Paint
import android.graphics.pdf.PdfDocument
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import android.content.ContentValues
import android.util.Log
import com.arthenica.ffmpegkit.FFmpegKit
import com.arthenica.ffmpegkit.ReturnCode
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    private val executor = Executors.newSingleThreadExecutor()
    private var lightEvents: EventChannel.EventSink? = null
    private var lightListener: SensorEventListener? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CH_FFMPEG)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "run" -> {
                        @Suppress("UNCHECKED_CAST")
                        val args = call.argument<List<String>>("args") ?: emptyList()
                        executor.execute {
                            try {
                                val session = FFmpegKit.executeWithArguments(args.toTypedArray())
                                val ok = ReturnCode.isSuccess(session.returnCode)
                                runOnUiThread {
                                    if (ok) result.success(
                                        mapOf(
                                            "ok" to true,
                                            "logs" to (session.allLogsAsString ?: "")
                                        )
                                    ) else result.success(
                                        mapOf(
                                            "ok" to false,
                                            "logs" to (session.allLogsAsString ?: "ffmpeg failed"),
                                            "code" to (session.returnCode?.value ?: -1)
                                        )
                                    )
                                }
                            } catch (e: Exception) {
                                Log.e(TAG, "ffmpeg", e)
                                runOnUiThread {
                                    result.error("FFMPEG", e.message, null)
                                }
                            }
                        }
                    }
                    "cancel" -> {
                        FFmpegKit.cancel()
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CH_MEDIA_JOB)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "start" -> {
                        val type = call.argument<String>("type") ?: ""
                        val paths = call.argument<List<String>>("paths") ?: emptyList()
                        val level = call.argument<String>("level") ?: "medium"
                        val intent = Intent(this, MediaJobService::class.java).apply {
                            putExtra(MediaJobService.EXTRA_TYPE, type)
                            putExtra(MediaJobService.EXTRA_LEVEL, level)
                            putStringArrayListExtra(
                                MediaJobService.EXTRA_PATHS,
                                ArrayList(paths)
                            )
                        }
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            startForegroundService(intent)
                        } else {
                            startService(intent)
                        }
                        result.success(true)
                    }
                    "cancel" -> {
                        MediaJobService.cancelRequested = true
                        FFmpegKit.cancel()
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CH_MEDIA_EVENTS)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    MediaJobService.eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    MediaJobService.eventSink = null
                }
            })

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CH_LIGHT)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "available" -> {
                        val sm = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                        result.success(sm.getDefaultSensor(Sensor.TYPE_LIGHT) != null)
                    }
                    else -> result.notImplemented()
                }
            }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CH_LIGHT_EVENTS)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    lightEvents = events
                    val sm = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                    val sensor = sm.getDefaultSensor(Sensor.TYPE_LIGHT)
                    if (sensor == null) {
                        events?.error("NO_SENSOR", "No TYPE_LIGHT", null)
                        return
                    }
                    val listener = object : SensorEventListener {
                        override fun onSensorChanged(event: SensorEvent) {
                            lightEvents?.success(event.values[0].toDouble())
                        }

                        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
                    }
                    lightListener = listener
                    sm.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_NORMAL)
                }

                override fun onCancel(arguments: Any?) {
                    val sm = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                    lightListener?.let { sm.unregisterListener(it) }
                    lightListener = null
                    lightEvents = null
                }
            })

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CH_EBOOK)
            .setMethodCallHandler { call, result ->
                if (call.method == "convert") {
                    val path = call.argument<String>("path") ?: ""
                    executor.execute {
                        try {
                            val out = convertEpubStub(path)
                            runOnUiThread { result.success(out) }
                        } catch (e: Exception) {
                            runOnUiThread { result.error("EBOOK", e.message, null) }
                        }
                    }
                } else result.notImplemented()
            }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CH_GALLERY)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "saveVideo" -> {
                        val path = call.argument<String>("path") ?: ""
                        executor.execute {
                            val uri = saveVideoToGallery(File(path))
                            runOnUiThread { result.success(uri) }
                        }
                    }
                    "saveImage" -> {
                        val path = call.argument<String>("path") ?: ""
                        executor.execute {
                            val uri = saveImageToGallery(File(path))
                            runOnUiThread { result.success(uri) }
                        }
                    }
                    "saveAudio" -> {
                        val path = call.argument<String>("path") ?: ""
                        executor.execute {
                            val uri = saveAudioToGallery(File(path))
                            runOnUiThread { result.success(uri) }
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun convertEpubStub(epubPath: String): String {
        val name = File(epubPath).nameWithoutExtension.ifBlank { "ebook" }
        val outDir = File(cacheDir, "ebook_out").apply { mkdirs() }
        val out = File(outDir, "${name}_${System.currentTimeMillis()}.pdf")
        val doc = PdfDocument()
        val pageInfo = PdfDocument.PageInfo.Builder(595, 842, 1).create()
        val page = doc.startPage(pageInfo)
        val paint = Paint().apply {
            color = Color.BLACK
            textSize = 18f
        }
        page.canvas.drawText("Tools Flutter · EPUB → PDF", 48f, 80f, paint)
        page.canvas.drawText("Source: ${File(epubPath).name}", 48f, 120f, paint)
        page.canvas.drawText("(Stub conversion page — full pipeline uses native WebView/PDFBox)", 48f, 160f, paint)
        doc.finishPage(page)
        FileOutputStream(out).use { doc.writeTo(it) }
        doc.close()
        // save to downloads
        val values = ContentValues().apply {
            put(MediaStore.Downloads.DISPLAY_NAME, out.name)
            put(MediaStore.Downloads.MIME_TYPE, "application/pdf")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS + "/Tools")
                put(MediaStore.Downloads.IS_PENDING, 1)
            }
        }
        val collection = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            MediaStore.Downloads.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        } else {
            MediaStore.Files.getContentUri("external")
        }
        val uri = contentResolver.insert(collection, values)
        if (uri != null) {
            contentResolver.openOutputStream(uri)?.use { os ->
                FileInputStream(out).use { it.copyTo(os) }
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                values.clear()
                values.put(MediaStore.Downloads.IS_PENDING, 0)
                contentResolver.update(uri, values, null, null)
            }
            return uri.toString()
        }
        return out.absolutePath
    }

    private fun saveVideoToGallery(file: File): String? {
        val values = ContentValues().apply {
            put(MediaStore.Video.Media.DISPLAY_NAME, file.name)
            put(MediaStore.Video.Media.MIME_TYPE, "video/mp4")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(MediaStore.Video.Media.RELATIVE_PATH, Environment.DIRECTORY_MOVIES + "/VideoEditor")
                put(MediaStore.Video.Media.IS_PENDING, 1)
            }
        }
        val collection = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            MediaStore.Video.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        } else MediaStore.Video.Media.EXTERNAL_CONTENT_URI
        val uri = contentResolver.insert(collection, values) ?: return file.absolutePath
        contentResolver.openOutputStream(uri)?.use { os ->
            FileInputStream(file).use { it.copyTo(os) }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            values.clear()
            values.put(MediaStore.Video.Media.IS_PENDING, 0)
            contentResolver.update(uri, values, null, null)
        }
        return uri.toString()
    }

    private fun saveImageToGallery(file: File): String? {
        val values = ContentValues().apply {
            put(MediaStore.Images.Media.DISPLAY_NAME, file.name)
            put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(MediaStore.Images.Media.RELATIVE_PATH, Environment.DIRECTORY_PICTURES + "/Tools")
                put(MediaStore.Images.Media.IS_PENDING, 1)
            }
        }
        val collection = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            MediaStore.Images.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        } else MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val uri = contentResolver.insert(collection, values) ?: return file.absolutePath
        contentResolver.openOutputStream(uri)?.use { os ->
            FileInputStream(file).use { it.copyTo(os) }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            values.clear()
            values.put(MediaStore.Images.Media.IS_PENDING, 0)
            contentResolver.update(uri, values, null, null)
        }
        return uri.toString()
    }

    private fun saveAudioToGallery(file: File): String? {
        val values = ContentValues().apply {
            put(MediaStore.Audio.Media.DISPLAY_NAME, file.name)
            put(MediaStore.Audio.Media.MIME_TYPE, "audio/mp4")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(MediaStore.Audio.Media.RELATIVE_PATH, Environment.DIRECTORY_MUSIC + "/Tools")
                put(MediaStore.Audio.Media.IS_PENDING, 1)
            }
        }
        val collection = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            MediaStore.Audio.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        } else MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
        val uri = contentResolver.insert(collection, values) ?: return file.absolutePath
        contentResolver.openOutputStream(uri)?.use { os ->
            FileInputStream(file).use { it.copyTo(os) }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            values.clear()
            values.put(MediaStore.Audio.Media.IS_PENDING, 1)
            values.put(MediaStore.Audio.Media.IS_PENDING, 0)
            contentResolver.update(uri, values, null, null)
        }
        return uri.toString()
    }

    companion object {
        private const val TAG = "ToolsFlutter"
        const val CH_FFMPEG = "com.robin.tools/ffmpeg"
        const val CH_MEDIA_JOB = "com.robin.tools/media_job"
        const val CH_MEDIA_EVENTS = "com.robin.tools/media_events"
        const val CH_LIGHT = "com.robin.tools/light_sensor"
        const val CH_LIGHT_EVENTS = "com.robin.tools/light_sensor_events"
        const val CH_EBOOK = "com.robin.tools/ebook"
        const val CH_GALLERY = "com.robin.tools/gallery"
    }
}
