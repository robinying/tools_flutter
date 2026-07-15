package com.robin.tools_flutter

import android.os.StatFs
import com.arthenica.ffmpegkit.FFmpegKit
import com.arthenica.ffmpegkit.ReturnCode
import java.io.File
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicReference

/** Executes one approved FFmpeg plan within the native resource budget. */
object MediaJobExecutionGuard {

    sealed class Result {
        data object Success : Result()
        data object Cancelled : Result()
        data object TimedOut : Result()
        data object OutputTooLarge : Result()
        data object InsufficientStorage : Result()
        data object Failed : Result()
    }

    private enum class AbortReason {
        CANCELLED,
        TIMEOUT,
        OUTPUT_TOO_LARGE,
        INSUFFICIENT_STORAGE,
    }

    fun run(
        args: Array<String>,
        output: File,
        outputDir: File,
        deadlineElapsedMs: Long,
        isCancellationRequested: () -> Boolean,
    ): Result {
        if (!hasEnoughSpace(outputDir, MediaJobLimits.MAX_OUTPUT_BYTES)) {
            return Result.InsufficientStorage
        }

        val abortReason = AtomicReference<AbortReason?>(null)
        val watchdog = Executors.newSingleThreadScheduledExecutor()
        val abort = { reason: AbortReason ->
            if (abortReason.compareAndSet(null, reason)) {
                FFmpegKit.cancel()
            }
        }
        val check = Runnable {
            when {
                isCancellationRequested() -> abort(AbortReason.CANCELLED)
                android.os.SystemClock.elapsedRealtime() >= deadlineElapsedMs -> abort(AbortReason.TIMEOUT)
                output.isFile && output.length() > MediaJobLimits.MAX_OUTPUT_BYTES -> {
                    abort(AbortReason.OUTPUT_TOO_LARGE)
                }
                !hasEnoughSpace(outputDir, 0L) -> abort(AbortReason.INSUFFICIENT_STORAGE)
            }
        }

        val result = try {
            watchdog.scheduleAtFixedRate(check, 0L, 1L, TimeUnit.SECONDS)
            val session = FFmpegKit.executeWithArguments(args)
            when {
                isCancellationRequested() -> Result.Cancelled
                abortReason.get() == AbortReason.CANCELLED -> Result.Cancelled
                abortReason.get() == AbortReason.TIMEOUT -> Result.TimedOut
                abortReason.get() == AbortReason.OUTPUT_TOO_LARGE -> Result.OutputTooLarge
                abortReason.get() == AbortReason.INSUFFICIENT_STORAGE -> Result.InsufficientStorage
                ReturnCode.isSuccess(session.returnCode) &&
                    output.isFile &&
                    output.length() in 1..MediaJobLimits.MAX_OUTPUT_BYTES &&
                    hasEnoughSpace(outputDir, 0L) -> Result.Success
                else -> Result.Failed
            }
        } catch (_: Exception) {
            Result.Failed
        } finally {
            watchdog.shutdownNow()
        }
        if (result !is Result.Success) {
            output.delete()
        }
        return result
    }

    fun hasEnoughSpace(directory: File, outputReservationBytes: Long): Boolean {
        if (outputReservationBytes > Long.MAX_VALUE - MediaJobLimits.MIN_FREE_BYTES) {
            return false
        }
        return try {
            val available = StatFs(directory.absolutePath).availableBytes
            available >= MediaJobLimits.MIN_FREE_BYTES + outputReservationBytes
        } catch (_: IllegalArgumentException) {
            false
        }
    }
}
