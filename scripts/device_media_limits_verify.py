#!/usr/bin/env python3
"""Verify native FFmpeg media admission limits on an explicit Android device."""
from __future__ import annotations

import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path

PKG = "com.robin.tools_flutter"
DEVICE_DIR = "/sdcard/Download/tools_flutter_m01"
TIMEOUT_SECONDS = 45


def run(command: list[str], check: bool = True) -> str:
    result = subprocess.run(command, capture_output=True, text=True)
    if check and result.returncode != 0:
        raise RuntimeError(f"failed: {' '.join(command)}\n{result.stderr}")
    return (result.stdout or "") + (result.stderr or "")


def adb(serial: str, *args: str, check: bool = True) -> str:
    return run(["adb", "-s", serial, *args], check=check)


def require_tool(name: str) -> None:
    if shutil.which(name) is None:
        raise RuntimeError(f"{name} is required but was not found on PATH")


def create_fixtures(root: Path) -> None:
    run([
        "ffmpeg", "-y", "-f", "lavfi", "-i", "testsrc=size=640x360:rate=24",
        "-f", "lavfi", "-i", "sine=frequency=1000", "-t", "2",
        "-c:v", "mpeg4", "-c:a", "aac", str(root / "valid.mp4"),
    ])
    run([
        "ffmpeg", "-y", "-f", "lavfi", "-i", "color=c=red:s=4096x4096",
        "-frames:v", "1", str(root / "over_pixels.png"),
    ])
    run([
        "ffmpeg", "-y", "-f", "lavfi", "-i", "testsrc=size=320x240:rate=1",
        "-t", "901", "-c:v", "mpeg4", str(root / "over_duration.mp4"),
    ])
    (root / "malformed.mp4").write_text("not media", encoding="utf-8")


def stage_fixtures(serial: str, root: Path) -> None:
    adb(serial, "shell", "rm", "-rf", DEVICE_DIR)
    adb(serial, "shell", "mkdir", "-p", f"{DEVICE_DIR}/slides")
    for fixture in root.iterdir():
        adb(serial, "push", str(fixture), f"{DEVICE_DIR}/{fixture.name}")
    adb(
        serial,
        "shell",
        "dd",
        "if=/dev/zero",
        f"of={DEVICE_DIR}/oversize.mp4",
        "bs=1M",
        "count=257",
    )
    for index in range(31):
        adb(serial, "push", str(root / "over_pixels.png"), f"{DEVICE_DIR}/slides/{index}.png")


def start_job(serial: str, job_type: str, paths: list[str]) -> str:
    adb(serial, "logcat", "-c", check=False)
    adb(
        serial,
        "shell",
        "am",
        "start-foreground-service",
        "-n",
        f"{PKG}/.MediaJobService",
        "--es",
        "type",
        job_type,
        "--es",
        "level",
        "medium",
        "--esa",
        "paths",
        ",".join(paths),
        check=False,
    )
    deadline = time.monotonic() + TIMEOUT_SECONDS
    while time.monotonic() < deadline:
        time.sleep(1)
        logs = adb(
            serial,
            "logcat",
            "-d",
            "-s",
            "MediaJobService:V",
            "AndroidRuntime:E",
            check=False,
        )
        lowered = logs.lower()
        if "fatal exception" in lowered:
            return logs
        if "phase=failed" in lowered or "phase=finished" in lowered:
            return logs
    return adb(serial, "logcat", "-d", "-s", "MediaJobService:V", "AndroidRuntime:E", check=False)


def expect_failure(serial: str, name: str, job_type: str, paths: list[str], message: str) -> bool:
    logs = start_job(serial, job_type, paths)
    passed = "fatal exception" not in logs.lower() and message.lower() in logs.lower()
    print(f"{'PASS' if passed else 'FAIL'} {name}: expected {message!r}")
    if not passed:
        print(logs[-1000:])
    return passed


def expect_success(serial: str) -> bool:
    logs = start_job(serial, "videoCompress", [f"{DEVICE_DIR}/valid.mp4"])
    passed = "fatal exception" not in logs.lower() and "phase=finished" in logs.lower()
    print(f"{'PASS' if passed else 'FAIL'} valid control job")
    if not passed:
        print(logs[-1000:])
    return passed


def main() -> int:
    if len(sys.argv) != 2:
        print(f"Usage: {Path(sys.argv[0]).name} <device-serial>")
        return 2
    serial = sys.argv[1]
    require_tool("adb")
    require_tool("ffmpeg")
    with tempfile.TemporaryDirectory(prefix="tools_flutter_m01_") as directory:
        fixtures = Path(directory)
        create_fixtures(fixtures)
        try:
            stage_fixtures(serial, fixtures)
            cases = [
                expect_failure(
                    serial,
                    "oversize input",
                    "videoCompress",
                    [f"{DEVICE_DIR}/oversize.mp4"],
                    "Input file is too large",
                ),
                expect_failure(
                    serial,
                    "over-pixel image",
                    "imageCompress",
                    [f"{DEVICE_DIR}/over_pixels.png"],
                    "Media pixel count is too large",
                ),
                expect_failure(
                    serial,
                    "over-duration video",
                    "videoCompress",
                    [f"{DEVICE_DIR}/over_duration.mp4"],
                    "Media duration is too long",
                ),
                expect_failure(
                    serial,
                    "malformed video",
                    "videoCompress",
                    [f"{DEVICE_DIR}/malformed.mp4"],
                    "Invalid or unsupported media file",
                ),
                expect_failure(
                    serial,
                    "too many slideshow images",
                    "slideshow",
                    [f"{DEVICE_DIR}/slides/{index}.png" for index in range(31)],
                    "Select 2–30 files for slideshow",
                ),
                expect_success(serial),
            ]
        finally:
            adb(serial, "shell", "rm", "-rf", DEVICE_DIR, check=False)
    return 0 if all(cases) else 1


if __name__ == "__main__":
    sys.exit(main())
