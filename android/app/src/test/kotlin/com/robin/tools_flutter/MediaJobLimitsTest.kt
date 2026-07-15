package com.robin.tools_flutter

import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class MediaJobLimitsTest {

    @Test
    fun `accepts boundary valid slideshow`() {
        val facts = List(MediaJobLimits.MAX_SLIDESHOW_INPUTS) {
            MediaInputFacts(
                bytes = 1L,
                width = 4000,
                height = 3000,
                durationMs = null,
            )
        }

        assertNull(MediaJobLimits.validateMediaFacts("slideshow", facts))
    }

    @Test
    fun `rejects slideshow above input limit`() {
        val error = MediaJobLimits.validateShape(
            "slideshow",
            List(MediaJobLimits.MAX_SLIDESHOW_INPUTS + 1) { "image.jpg" },
        )

        assertEquals("Select 2–30 files for slideshow", error)
    }

    @Test
    fun `rejects media above pixel limit`() {
        val error = MediaJobLimits.validateMediaFacts(
            "imageCompress",
            listOf(
                MediaInputFacts(
                    bytes = 1L,
                    width = 4000,
                    height = 4000,
                    durationMs = null,
                ),
            ),
        )

        assertEquals("Media pixel count is too large", error)
    }

    @Test
    fun `rejects video above duration limit`() {
        val error = MediaJobLimits.validateMediaFacts(
            "videoCompress",
            listOf(
                MediaInputFacts(
                    bytes = 1L,
                    width = 1920,
                    height = 1080,
                    durationMs = MediaJobLimits.MAX_DURATION_MS + 1L,
                ),
            ),
        )

        assertEquals("Media duration is too long", error)
    }

    @Test
    fun `rejects aggregate merge duration above limit`() {
        // Each input stays within MAX_DURATION_MS; three clips sum past MAX_MERGE_DURATION_MS.
        val clipMs = MediaJobLimits.MAX_DURATION_MS
        val error = MediaJobLimits.validateMediaFacts(
            "merge",
            listOf(
                MediaInputFacts(bytes = 1L, width = 1920, height = 1080, durationMs = clipMs),
                MediaInputFacts(bytes = 1L, width = 1920, height = 1080, durationMs = clipMs),
                MediaInputFacts(bytes = 1L, width = 1920, height = 1080, durationMs = 1L),
            ),
        )

        assertEquals("Total merge duration is too long", error)
    }

    @Test
    fun `rejects aggregate size above limit`() {
        val error = MediaJobLimits.validateMediaFacts(
            "merge",
            listOf(
                MediaInputFacts(
                    bytes = MediaJobLimits.MAX_INPUT_BYTES,
                    width = 1920,
                    height = 1080,
                    durationMs = 1L,
                ),
                MediaInputFacts(
                    bytes = MediaJobLimits.MAX_INPUT_BYTES + 1L,
                    width = 1920,
                    height = 1080,
                    durationMs = 1L,
                ),
            ),
        )

        assertEquals("Input file is too large", error)
    }

    @Test
    fun `rejects malformed text card input`() {
        assertEquals(
            "Invalid text card input",
            MediaJobLimits.validateShape("textCard", listOf("_", "text")),
        )
        assertEquals(
            "Text is too long",
            MediaJobLimits.validateTextCard("x".repeat(MediaJobLimits.MAX_TEXT_LENGTH + 1), 3),
        )
    }
}
