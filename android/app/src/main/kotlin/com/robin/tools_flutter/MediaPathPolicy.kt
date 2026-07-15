package com.robin.tools_flutter

import android.content.Context
import android.graphics.BitmapFactory
import android.media.MediaMetadataRetriever
import java.io.File

/**
 * Input path and resource policy for FFmpeg jobs.
 * Blocks system paths and rejects inputs that exceed native media limits.
 */
object MediaPathPolicy {

    fun allowedAppRoots(context: Context): List<File> {
        val roots = mutableListOf(
            context.cacheDir,
            context.filesDir,
            context.codeCacheDir,
        )
        context.externalCacheDir?.let { roots.add(it) }
        context.getExternalFilesDir(null)?.let { roots.add(it) }
        context.externalCacheDirs?.forEach { if (it != null) roots.add(it) }
        context.getExternalFilesDirs(null)?.forEach { if (it != null) roots.add(it) }
        return roots
    }

    fun isUnder(file: File, root: File): Boolean {
        return try {
            val canon = file.canonicalFile.absolutePath
            val rootCanon = root.canonicalFile.absolutePath
            canon == rootCanon || canon.startsWith(rootCanon + File.separator)
        } catch (_: Exception) {
            false
        }
    }

    fun isBlockedSystemPath(canonicalPath: String): Boolean {
        return canonicalPath.startsWith("/proc") ||
            canonicalPath.startsWith("/sys") ||
            canonicalPath.startsWith("/dev") ||
            canonicalPath.startsWith("/acct") ||
            canonicalPath == "/" ||
            canonicalPath.isEmpty()
    }

    /**
     * @return null if ok, otherwise an error message safe to show to users.
     */
    fun validateJobPaths(context: Context, type: String, paths: List<String>): String? {
        MediaJobLimits.validateShape(type, paths)?.let { return it }
        if (type == "textCard") {
            return MediaJobLimits.validateTextCard(paths[1], paths[2].toIntOrNull())
        }

        val inputs = ArrayList<MediaInputFacts>(paths.size)
        var totalBytes = 0L
        for (path in paths) {
            val file = validateMediaFile(context, path) ?: return "Invalid media file"
            val bytes = file.length()
            if (bytes > MediaJobLimits.MAX_INPUT_BYTES) {
                return "Input file is too large"
            }
            if (totalBytes > MediaJobLimits.MAX_TOTAL_INPUT_BYTES - bytes) {
                return "Total input size is too large"
            }
            totalBytes += bytes
            val facts = if (MediaJobLimits.isImageJob(type)) {
                readImageFacts(file)
            } else {
                readMediaFacts(file)
            } ?: return "Invalid or unsupported media file"
            inputs.add(facts)
        }
        return MediaJobLimits.validateMediaFacts(type, inputs)
    }

    private fun validateMediaFile(context: Context, path: String): File? {
        if (path.isBlank() || path.any { it.code == 0 }) {
            return null
        }
        val file = File(path)
        if (!file.isFile || !file.canRead()) {
            return null
        }
        val canonical = try {
            file.canonicalFile
        } catch (_: Exception) {
            return null
        }
        if (isBlockedSystemPath(canonical.absolutePath)) {
            return null
        }
        if (allowedAppRoots(context).any { isUnder(canonical, it) }) {
            return canonical
        }
        if (canonical.path.startsWith("/storage/") ||
            canonical.path.startsWith("/sdcard/") ||
            canonical.path.startsWith("/mnt/")
        ) {
            return canonical
        }
        return null
    }

    private fun readImageFacts(file: File): MediaInputFacts? {
        val options = BitmapFactory.Options().apply { inJustDecodeBounds = true }
        BitmapFactory.decodeFile(file.absolutePath, options)
        if (options.outWidth < 1 || options.outHeight < 1) {
            return null
        }
        return MediaInputFacts(
            bytes = file.length(),
            width = options.outWidth,
            height = options.outHeight,
            durationMs = null,
        )
    }

    private fun readMediaFacts(file: File): MediaInputFacts? {
        val retriever = MediaMetadataRetriever()
        return try {
            retriever.setDataSource(file.absolutePath)
            val width = retriever.extractMetadata(
                MediaMetadataRetriever.METADATA_KEY_VIDEO_WIDTH,
            )?.toIntOrNull()
            val height = retriever.extractMetadata(
                MediaMetadataRetriever.METADATA_KEY_VIDEO_HEIGHT,
            )?.toIntOrNull()
            val duration = retriever.extractMetadata(
                MediaMetadataRetriever.METADATA_KEY_DURATION,
            )?.toLongOrNull()
            MediaInputFacts(
                bytes = file.length(),
                width = width,
                height = height,
                durationMs = duration,
            )
        } catch (_: Exception) {
            null
        } finally {
            retriever.release()
        }
    }
}
