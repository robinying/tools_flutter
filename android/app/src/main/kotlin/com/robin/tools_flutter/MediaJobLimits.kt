package com.robin.tools_flutter

/**
 * Resource limits for one native FFmpeg media job.
 *
 * The service applies this policy after path validation and before FFmpeg starts.
 */
object MediaJobLimits {
    const val MAX_MERGE_INPUTS = 16
    const val MAX_SLIDESHOW_INPUTS = 30
    const val MAX_TEXT_LENGTH = 512
    const val MIN_TEXT_CARD_DURATION_SECONDS = 1
    const val MAX_TEXT_CARD_DURATION_SECONDS = 30
    const val MAX_INPUT_BYTES = 256L * 1024L * 1024L
    const val MAX_TOTAL_INPUT_BYTES = 512L * 1024L * 1024L
    const val MAX_WIDTH = 4096
    const val MAX_HEIGHT = 4096
    const val MAX_PIXELS = 12_000_000L
    const val MAX_DURATION_MS = 15L * 60L * 1000L
    const val MAX_MERGE_DURATION_MS = 30L * 60L * 1000L
    const val MAX_OUTPUT_BYTES = 256L * 1024L * 1024L
    const val MAX_CACHE_BYTES = 768L * 1024L * 1024L
    const val MIN_FREE_BYTES = 512L * 1024L * 1024L
    const val JOB_TIMEOUT_MS = 10L * 60L * 1000L

    private val videoJobTypes = setOf(
        "videoCompress",
        "gif",
        "extractAudio",
        "stripAudio",
        "transcode",
        "speed",
        "reverse",
        "crop",
        "volumeFade",
    )

    fun isImageJob(type: String): Boolean = type == "imageCompress" || type == "slideshow"

    fun requiresDimensions(type: String): Boolean = type != "extractAudio"

    fun requiresDuration(type: String): Boolean = !isImageJob(type)

    fun validateShape(type: String, paths: List<String>): String? {
        return when (type) {
            "textCard" -> {
                if (paths.size != 3 || paths[0] != "_") {
                    "Invalid text card input"
                } else {
                    null
                }
            }
            "merge" -> validateMultiInputCount(paths.size, MAX_MERGE_INPUTS, "merge")
            "slideshow" -> validateMultiInputCount(paths.size, MAX_SLIDESHOW_INPUTS, "slideshow")
            "imageCompress" -> validateSingleInputCount(paths.size, "image")
            in videoJobTypes -> validateSingleInputCount(paths.size, "media")
            else -> "Unsupported media job"
        }
    }

    fun validateTextCard(text: String, durationSeconds: Int?): String? {
        if (text.length > MAX_TEXT_LENGTH) {
            return "Text is too long"
        }
        if (durationSeconds == null ||
            durationSeconds < MIN_TEXT_CARD_DURATION_SECONDS ||
            durationSeconds > MAX_TEXT_CARD_DURATION_SECONDS
        ) {
            return "Invalid duration (1–30s)"
        }
        return null
    }

    fun validateMediaFacts(type: String, facts: List<MediaInputFacts>): String? {
        val shapeError = validateShape(type, List(facts.size) { "input" })
        if (shapeError != null && type != "textCard") {
            return shapeError
        }

        var totalBytes = 0L
        var totalDurationMs = 0L
        for (fact in facts) {
            if (fact.bytes < 1L || fact.bytes > MAX_INPUT_BYTES) {
                return "Input file is too large"
            }
            if (totalBytes > MAX_TOTAL_INPUT_BYTES - fact.bytes) {
                return "Total input size is too large"
            }
            totalBytes += fact.bytes

            if (requiresDimensions(type)) {
                val dimensionsError = validateDimensions(fact.width, fact.height)
                if (dimensionsError != null) {
                    return dimensionsError
                }
            }
            if (requiresDuration(type)) {
                val duration = fact.durationMs ?: return "Invalid media duration"
                if (duration < 1L || duration > MAX_DURATION_MS) {
                    return "Media duration is too long"
                }
                if (type == "merge") {
                    if (totalDurationMs > MAX_MERGE_DURATION_MS - duration) {
                        return "Total merge duration is too long"
                    }
                    totalDurationMs += duration
                }
            }
        }
        return null
    }

    fun validateDimensions(width: Int?, height: Int?): String? {
        if (width == null || height == null || width < 1 || height < 1) {
            return "Invalid media dimensions"
        }
        if (width > MAX_WIDTH || height > MAX_HEIGHT) {
            return "Media resolution is too large"
        }
        if (width.toLong() * height.toLong() > MAX_PIXELS) {
            return "Media pixel count is too large"
        }
        return null
    }

    private fun validateSingleInputCount(count: Int, kind: String): String? {
        return if (count == 1) null else "Select exactly one $kind file"
    }

    private fun validateMultiInputCount(count: Int, maxCount: Int, kind: String): String? {
        return if (count in 2..maxCount) null else "Select 2–$maxCount files for $kind"
    }
}

data class MediaInputFacts(
    val bytes: Long,
    val width: Int?,
    val height: Int?,
    val durationMs: Long?,
)
