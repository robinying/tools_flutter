package com.robin.tools_flutter

import java.io.File

/**
 * Builds FFmpeg argument arrays per job type (keeps [MediaJobService] thin).
 */
object MediaJobCommands {

    data class Plan(
        val outputPath: String,
        val args: Array<String>,
        val listFile: File? = null,
    )

    fun build(
        type: String,
        paths: List<String>,
        level: String,
        outDir: File,
        cacheDir: File,
        ts: Long,
    ): Plan? {
        return when (type) {
            "merge" -> buildMerge(paths, outDir, cacheDir, ts)
            "videoCompress" -> {
                val q = when (level) {
                    "low" -> "8"; "high" -> "3"; else -> "5"
                }
                val out = File(outDir, "compressed_$ts.mp4").absolutePath
                Plan(
                    out,
                    arrayOf(
                        "-i", paths[0], "-c:v", "mpeg4", "-q:v", q,
                        "-c:a", "aac", "-b:a", "128k", "-y", out,
                    ),
                )
            }
            "extractAudio" -> {
                val br = when (level) {
                    "low" -> "96k"; "high" -> "192k"; else -> "128k"
                }
                val out = File(outDir, "audio_$ts.m4a").absolutePath
                Plan(out, arrayOf("-i", paths[0], "-vn", "-c:a", "aac", "-b:a", br, "-y", out))
            }
            "stripAudio" -> {
                val out = File(outDir, "muted_$ts.mp4").absolutePath
                Plan(out, arrayOf("-i", paths[0], "-c:v", "copy", "-an", "-y", out))
            }
            "transcode" -> {
                val out = File(outDir, "transcoded_$ts.mp4").absolutePath
                Plan(
                    out,
                    arrayOf(
                        "-i", paths[0], "-c:v", "mpeg4", "-q:v", "5",
                        "-c:a", "aac", "-b:a", "128k", "-movflags", "+faststart", "-y", out,
                    ),
                )
            }
            "speed" -> {
                val speed = when (level) {
                    "low" -> 0.5; "high" -> 2.0; else -> 1.5
                }
                val setpts = 1.0 / speed
                val out = File(outDir, "speed_$ts.mp4").absolutePath
                Plan(
                    out,
                    arrayOf(
                        "-i", paths[0],
                        "-filter_complex", "[0:v]setpts=${setpts}*PTS[v];[0:a]atempo=$speed[a]",
                        "-map", "[v]", "-map", "[a]",
                        "-c:v", "mpeg4", "-q:v", "5", "-c:a", "aac", "-b:a", "128k", "-y", out,
                    ),
                )
            }
            "reverse" -> {
                val out = File(outDir, "reverse_$ts.mp4").absolutePath
                val args = if (level == "medium") {
                    arrayOf(
                        "-i", paths[0], "-vf", "reverse", "-af", "areverse",
                        "-c:v", "mpeg4", "-q:v", "5", "-c:a", "aac", "-y", out,
                    )
                } else {
                    arrayOf(
                        "-i", paths[0], "-vf", "reverse", "-an",
                        "-c:v", "mpeg4", "-q:v", "5", "-y", out,
                    )
                }
                Plan(out, args)
            }
            "crop" -> {
                val ratio = when (level) {
                    "low" -> "1"; "high" -> "16/9"; else -> "9/16"
                }
                val crop =
                    "crop=if(gt(a\\,$ratio)\\,ih*$ratio\\,iw):if(gt(a\\,$ratio)\\,ih\\,iw/($ratio))"
                val out = File(outDir, "crop_$ts.mp4").absolutePath
                Plan(
                    out,
                    arrayOf(
                        "-i", paths[0], "-vf", crop, "-c:v", "mpeg4", "-q:v", "5",
                        "-c:a", "aac", "-b:a", "128k", "-y", out,
                    ),
                )
            }
            "volumeFade" -> {
                val vol = when (level) {
                    "low" -> 0.5; "high" -> 1.5; else -> 1.0
                }
                val out = File(outDir, "vol_$ts.mp4").absolutePath
                Plan(
                    out,
                    arrayOf(
                        "-i", paths[0], "-c:v", "copy",
                        "-af", "volume=$vol,afade=t=in:st=0:d=0.5",
                        "-c:a", "aac", "-y", out,
                    ),
                )
            }
            "gif" -> {
                val out = File(outDir, "anim_$ts.gif").absolutePath
                val fps = when (level) {
                    "low" -> "8"; "high" -> "15"; else -> "10"
                }
                Plan(
                    out,
                    arrayOf("-i", paths[0], "-vf", "fps=$fps,scale=480:-1:flags=lanczos", "-y", out),
                )
            }
            "imageCompress" -> {
                val out = File(outDir, "img_$ts.jpg").absolutePath
                val q = when (level) {
                    "low" -> "8"; "high" -> "2"; else -> "5"
                }
                Plan(out, arrayOf("-i", paths[0], "-q:v", q, "-y", out))
            }
            "textCard" -> buildTextCard(paths, outDir, ts)
            "slideshow" -> buildSlideshow(paths, level, outDir, ts)
            else -> null
        }
    }

    fun retryStripAudio(input: String, outDir: File, ts: Long): Plan {
        val out = File(outDir, "muted2_$ts.mp4").absolutePath
        return Plan(
            out,
            arrayOf("-i", input, "-c:v", "mpeg4", "-q:v", "5", "-an", "-y", out),
        )
    }

    fun retrySpeed(input: String, level: String, outDir: File, ts: Long): Plan {
        val speed = when (level) {
            "low" -> 0.5; "high" -> 2.0; else -> 1.5
        }
        val setpts = 1.0 / speed
        val out = File(outDir, "speed2_$ts.mp4").absolutePath
        return Plan(
            out,
            arrayOf(
                "-i", input, "-filter:v", "setpts=${setpts}*PTS", "-an",
                "-c:v", "mpeg4", "-q:v", "5", "-y", out,
            ),
        )
    }

    fun retryTextCardSolid(durationSec: Int, outDir: File, ts: Long): Plan {
        val out = File(outDir, "textcard2_$ts.mp4").absolutePath
        return Plan(
            out,
            arrayOf(
                "-f", "lavfi", "-i", "color=c=0x2D1B4E:s=720x1280:d=$durationSec",
                "-c:v", "mpeg4", "-q:v", "5", "-y", out,
            ),
        )
    }

    private fun buildMerge(
        paths: List<String>,
        outDir: File,
        cacheDir: File,
        ts: Long,
    ): Plan? {
        if (paths.size < 2) return null
        val listFile = File(cacheDir, "concat_$ts.txt")
        listFile.writeText(paths.joinToString("\n") { "file '${it.replace("'", "'\\''")}'" })
        val out = File(outDir, "merged_$ts.mp4").absolutePath
        return Plan(
            out,
            arrayOf(
                "-f", "concat", "-safe", "0", "-i", listFile.absolutePath,
                "-c", "copy", "-y", out,
            ),
            listFile = listFile,
        )
    }

    fun mergeReencode(listFile: File, out: String): Array<String> = arrayOf(
        "-f", "concat", "-safe", "0", "-i", listFile.absolutePath,
        "-c:v", "mpeg4", "-q:v", "5", "-c:a", "aac", "-y", out,
    )

    private fun buildTextCard(paths: List<String>, outDir: File, ts: Long): Plan {
        val text = paths.getOrNull(1) ?: "Hello"
        val durationSec = (paths.getOrNull(2) ?: "3").toIntOrNull()?.coerceIn(1, 30) ?: 3
        val out = File(outDir, "textcard_$ts.mp4").absolutePath
        val escaped = text
            .replace("\\", "\\\\")
            .replace(":", "\\:")
            .replace("'", "\\'")
            .replace("%", "%%")
        return Plan(
            out,
            arrayOf(
                "-f", "lavfi", "-i", "color=c=0x2D1B4E:s=720x1280:d=$durationSec",
                "-vf",
                "drawtext=text='$escaped':fontcolor=white:fontsize=48:x=(w-text_w)/2:y=(h-text_h)/2",
                "-c:v", "mpeg4", "-q:v", "5", "-y", out,
            ),
        )
    }

    private fun buildSlideshow(
        paths: List<String>,
        level: String,
        outDir: File,
        ts: Long,
    ): Plan? {
        if (paths.isEmpty()) return null
        val sec = when (level) {
            "low" -> 1; "high" -> 3; else -> 2
        }
        val out = File(outDir, "slideshow_$ts.mp4").absolutePath
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
        val args = (inputs + listOf(
            "-filter_complex", filter, "-map", "[outv]",
            "-c:v", "mpeg4", "-q:v", "5", "-y", out,
        )).toTypedArray()
        return Plan(out, args)
    }
}
