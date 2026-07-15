package com.robin.tools_flutter

import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.Paint
import android.graphics.pdf.PdfDocument
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import com.arthenica.ffmpegkit.FFmpegKit
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

        // Raw FFmpeg channel removed (open args surface). Use media_job only.

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CH_MEDIA_JOB)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "start" -> {
                        if (MediaJobService.isJobRunning()) {
                            result.error("BUSY", "Another job is running", null)
                            return@setMethodCallHandler
                        }
                        val type = call.argument<String>("type") ?: ""
                        val paths = call.argument<List<String>>("paths") ?: emptyList()
                        val level = call.argument<String>("level") ?: "medium"
                        val intent = Intent(this, MediaJobService::class.java).apply {
                            putExtra(MediaJobService.EXTRA_TYPE, type)
                            putExtra(MediaJobService.EXTRA_LEVEL, level)
                            putStringArrayListExtra(
                                MediaJobService.EXTRA_PATHS,
                                ArrayList(paths),
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
                            val lux = event.values[0].toDouble()
                            // EventChannel must be invoked on the platform thread / UI thread
                            runOnUiThread {
                                try {
                                    lightEvents?.success(lux)
                                } catch (e: Exception) {
                                    Log.w(TAG, "light emit failed", e)
                                }
                            }
                        }

                        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
                    }
                    lightListener = listener
                    sm.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_UI)
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
                            try {
                                val uri = saveVideoToGallery(File(path))
                                runOnUiThread { result.success(uri) }
                            } catch (e: Exception) {
                                Log.e(TAG, "saveVideo", e)
                                runOnUiThread { result.error("GALLERY", e.message, null) }
                            }
                        }
                    }
                    "saveImage" -> {
                        val path = call.argument<String>("path") ?: ""
                        executor.execute {
                            try {
                                val uri = saveImageToGallery(File(path))
                                runOnUiThread { result.success(uri) }
                            } catch (e: Exception) {
                                Log.e(TAG, "saveImage", e)
                                runOnUiThread { result.error("GALLERY", e.message, null) }
                            }
                        }
                    }
                    "saveAudio" -> {
                        val path = call.argument<String>("path") ?: ""
                        executor.execute {
                            try {
                                val uri = saveAudioToGallery(File(path))
                                runOnUiThread { result.success(uri) }
                            } catch (e: Exception) {
                                Log.e(TAG, "saveAudio", e)
                                runOnUiThread { result.error("GALLERY", e.message, null) }
                            }
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    override fun onDestroy() {
        lightListener?.let { listener ->
            val sm = getSystemService(Context.SENSOR_SERVICE) as SensorManager
            sm.unregisterListener(listener)
        }
        lightListener = null
        lightEvents = null
        executor.shutdownNow()
        super.onDestroy()
    }

    private fun convertEpubStub(epubPath: String): String {
        val name = File(epubPath).nameWithoutExtension.ifBlank { "ebook" }
        val outDir = File(cacheDir, "ebook_out").apply { mkdirs() }
        pruneDir(outDir, maxFiles = 12)
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
        page.canvas.drawText(
            "(Stub conversion page — full pipeline uses native WebView/PDFBox)",
            48f,
            160f,
            paint,
        )
        doc.finishPage(page)
        FileOutputStream(out).use { doc.writeTo(it) }
        doc.close()

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
            if (!copyFileToMediaStore(uri, out, values, MediaStore.Downloads.IS_PENDING)) {
                return out.absolutePath
            }
            return uri.toString()
        }
        return out.absolutePath
    }

    private fun saveVideoToGallery(file: File): String? {
        requireReadableFile(file)
        val values = ContentValues().apply {
            put(MediaStore.Video.Media.DISPLAY_NAME, file.name)
            put(MediaStore.Video.Media.MIME_TYPE, "video/mp4")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(
                    MediaStore.Video.Media.RELATIVE_PATH,
                    Environment.DIRECTORY_MOVIES + "/VideoEditor",
                )
                put(MediaStore.Video.Media.IS_PENDING, 1)
            }
        }
        val collection = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            MediaStore.Video.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        } else MediaStore.Video.Media.EXTERNAL_CONTENT_URI
        val uri = contentResolver.insert(collection, values) ?: return file.absolutePath
        if (!copyFileToMediaStore(uri, file, values, MediaStore.Video.Media.IS_PENDING)) {
            return null
        }
        return uri.toString()
    }

    private fun saveImageToGallery(file: File): String? {
        requireReadableFile(file)
        val values = ContentValues().apply {
            put(MediaStore.Images.Media.DISPLAY_NAME, file.name)
            put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(
                    MediaStore.Images.Media.RELATIVE_PATH,
                    Environment.DIRECTORY_PICTURES + "/Tools",
                )
                put(MediaStore.Images.Media.IS_PENDING, 1)
            }
        }
        val collection = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            MediaStore.Images.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        } else MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val uri = contentResolver.insert(collection, values) ?: return file.absolutePath
        if (!copyFileToMediaStore(uri, file, values, MediaStore.Images.Media.IS_PENDING)) {
            return null
        }
        return uri.toString()
    }

    private fun saveAudioToGallery(file: File): String? {
        requireReadableFile(file)
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
        if (!copyFileToMediaStore(uri, file, values, MediaStore.Audio.Media.IS_PENDING)) {
            return null
        }
        return uri.toString()
    }

    private fun requireReadableFile(file: File) {
        if (!file.isFile || !file.canRead()) {
            throw IllegalArgumentException("File not readable: ${file.path}")
        }
    }

    /**
     * Write [file] into [uri]. On failure deletes the MediaStore row (no ghost IS_PENDING entries).
     * @return true if write + clear-pending succeeded
     */
    private fun copyFileToMediaStore(
        uri: Uri,
        file: File,
        pendingValues: ContentValues,
        pendingColumn: String,
    ): Boolean {
        return try {
            val os = contentResolver.openOutputStream(uri)
                ?: throw IllegalStateException("openOutputStream returned null")
            os.use { out ->
                FileInputStream(file).use { input -> input.copyTo(out) }
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                pendingValues.clear()
                pendingValues.put(pendingColumn, 0)
                contentResolver.update(uri, pendingValues, null, null)
            }
            true
        } catch (e: Exception) {
            Log.e(TAG, "MediaStore write failed, deleting row $uri", e)
            try {
                contentResolver.delete(uri, null, null)
            } catch (del: Exception) {
                Log.w(TAG, "Failed to delete pending MediaStore row", del)
            }
            false
        }
    }

    private fun pruneDir(dir: File, maxFiles: Int) {
        val files = dir.listFiles()?.filter { it.isFile }?.sortedByDescending { it.lastModified() }
            ?: return
        if (files.size > maxFiles) {
            files.drop(maxFiles).forEach { it.delete() }
        }
    }

    companion object {
        private const val TAG = "ToolsFlutter"
        const val CH_MEDIA_JOB = "com.robin.tools/media_job"
        const val CH_MEDIA_EVENTS = "com.robin.tools/media_events"
        const val CH_LIGHT = "com.robin.tools/light_sensor"
        const val CH_LIGHT_EVENTS = "com.robin.tools/light_sensor_events"
        const val CH_EBOOK = "com.robin.tools/ebook"
        const val CH_GALLERY = "com.robin.tools/gallery"
    }
}
