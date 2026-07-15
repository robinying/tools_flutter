package com.robin.tools_flutter

import android.content.Context
import java.io.File

/**
 * Input path allow-list for FFmpeg jobs.
 * Blocks /proc /sys /dev and non-readable paths; allows app storage and common user media roots.
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
        val p = canonicalPath
        return p.startsWith("/proc") ||
            p.startsWith("/sys") ||
            p.startsWith("/dev") ||
            p.startsWith("/acct") ||
            p == "/" ||
            p.isEmpty()
    }

    /**
     * @return null if ok, otherwise error message
     */
    fun validateMediaFile(context: Context, path: String): String? {
        if (path.isBlank() || path.contains('\u0000')) {
            return "Invalid path"
        }
        // Placeholder used by textCard UI (not a real input file)
        if (path == "_") return null

        val file = File(path)
        if (!file.isFile || !file.canRead()) {
            return "File not readable: ${file.name}"
        }
        val canonical = try {
            file.canonicalFile.absolutePath
        } catch (e: Exception) {
            return "Invalid path: ${e.message}"
        }
        if (isBlockedSystemPath(canonical)) {
            return "Path not allowed"
        }
        if (allowedAppRoots(context).any { isUnder(file, it) }) {
            return null
        }
        // User-selected media (scoped storage / shared volumes)
        if (canonical.startsWith("/storage/") ||
            canonical.startsWith("/sdcard/") ||
            canonical.startsWith("/mnt/")
        ) {
            return null
        }
        return "Path outside allowed storage"
    }

    fun validateJobPaths(context: Context, type: String, paths: List<String>): String? {
        when (type) {
            "textCard" -> {
                // paths: [placeholder, text, duration]
                val duration = paths.getOrNull(2) ?: "3"
                val secs = duration.toIntOrNull()
                if (secs == null || secs < 1 || secs > 30) {
                    return "Invalid duration (1–30s)"
                }
                return null
            }
            "merge", "slideshow" -> {
                if (paths.isEmpty()) return "No input files"
                for (p in paths) {
                    validateMediaFile(context, p)?.let { return it }
                }
                return null
            }
            else -> {
                if (paths.isEmpty()) return "No input files"
                return validateMediaFile(context, paths[0])
            }
        }
    }
}
