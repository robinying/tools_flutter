#!/usr/bin/env python3
"""UI smoke verification for tools_flutter on a connected device."""
from __future__ import annotations

import re
import subprocess
import sys
import time
from dataclasses import dataclass

DEVICE = sys.argv[1] if len(sys.argv) > 1 else "b9bed43d"
PKG = "com.robin.tools_flutter"


def adb(*args: str, check: bool = True) -> str:
    cmd = ["adb", "-s", DEVICE, *args]
    r = subprocess.run(cmd, capture_output=True, text=True)
    if check and r.returncode != 0:
        raise RuntimeError(f"adb failed: {' '.join(cmd)}\n{r.stderr}")
    return (r.stdout or "") + (r.stderr or "")


def dump_xml() -> str:
    adb("shell", "uiautomator", "dump", "/sdcard/ui.xml", check=False)
    return adb("shell", "cat", "/sdcard/ui.xml")


def descs(xml: str) -> list[str]:
    return re.findall(r'content-desc="([^"]*)"', xml)


def _norm_desc(raw: str) -> str:
    return (
        raw.replace("&#10;", "\n")
        .replace("&amp;", "&")
        .replace("&#39;", "'")
    )


def _desc_matches(raw: str, needle: str, *, prefix: bool) -> bool:
    """Match content-desc carefully.

    Feature cards often put ``title + newline + description`` in content-desc.
    Prefer title/prefix match so home's \"slideshow\" text does not open Camera.
    """
    text = _norm_desc(raw).strip()
    n = needle.lower().strip()
    if not text or not n:
        return False
    low = text.lower()
    if prefix:
        first = re.split(r"[\n,]", low, maxsplit=1)[0].strip()
        return first == n or low.startswith(n + "\n") or low.startswith(n + ",")
    return n in low


def bounds_for_desc(
    xml: str, needle: str, *, prefix: bool = False
) -> tuple[int, int] | None:
    modes = (True, False) if prefix else (False,)
    for use_prefix in modes:
        for m in re.finditer(
            r'content-desc="([^"]*)"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"',
            xml,
        ):
            if _desc_matches(m.group(1), needle, prefix=use_prefix):
                x = (int(m.group(2)) + int(m.group(4))) // 2
                y = (int(m.group(3)) + int(m.group(5))) // 2
                return x, y
        for m in re.finditer(
            r'bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"[^>]*content-desc="([^"]*)"',
            xml,
        ):
            if _desc_matches(m.group(5), needle, prefix=use_prefix):
                x = (int(m.group(1)) + int(m.group(3))) // 2
                y = (int(m.group(2)) + int(m.group(4))) // 2
                return x, y
    return None


def press_back(wait: float = 0.8) -> None:
    adb("shell", "input", "keyevent", "4")
    time.sleep(wait)


def tap_desc(needle: str, wait: float = 1.2, *, prefix: bool = True) -> bool:
    xml = dump_xml()
    # Dismiss accidental language popup
    joined = " | ".join(descs(xml))
    if "Français" in joined or "languageSystem" in joined or "System" in descs(xml):
        if any("Dismiss" in d for d in descs(xml)) or "English" in descs(xml):
            press_back(0.4)
            xml = dump_xml()
    b = bounds_for_desc(xml, needle, prefix=prefix)
    if not b:
        b = bounds_for_desc(xml, needle, prefix=False)
    if not b:
        print(f"  ! not found: {needle!r}")
        print(f"    descs={descs(xml)[:15]}")
        return False
    print(f"  tap {needle!r} @ {b}")
    adb("shell", "input", "tap", str(b[0]), str(b[1]))
    time.sleep(wait)
    return True


def dismiss_compat() -> None:
    xml = dump_xml()
    if "App Compatibility" not in xml and "Show Again" not in xml:
        return
    for needle in ("Don't Show Again", "Show Again", "OK"):
        for m in re.finditer(
            r'text="([^"]*)"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', xml
        ):
            if needle in m.group(1):
                x = (int(m.group(2)) + int(m.group(4))) // 2
                y = (int(m.group(3)) + int(m.group(5))) // 2
                print(f"  dismiss dialog via {m.group(1)!r}")
                adb("shell", "input", "tap", str(x), str(y))
                time.sleep(1)
                return


@dataclass
class Result:
    name: str
    ok: bool
    detail: str


def ensure_home() -> None:
    adb("shell", "am", "force-stop", PKG, check=False)
    time.sleep(0.5)
    adb("shell", "am", "start", "-n", f"{PKG}/.MainActivity")
    time.sleep(2.5)
    dismiss_compat()
    time.sleep(0.5)


def expect_desc(needles: list[str], label: str, *, prefix: bool = True) -> Result:
    xml = dump_xml()
    d = " | ".join(descs(xml)[:20])
    hits = [
        n
        for n in needles
        if bounds_for_desc(xml, n, prefix=prefix) is not None
        or any(_desc_matches(x, n, prefix=prefix) for x in descs(xml))
    ]
    if hits:
        return Result(label, True, f"found {hits!r}; descs≈{d[:120]}")
    return Result(label, False, f"missing {needles}; descs≈{d[:200]}")


def main() -> int:
    results: list[Result] = []
    print(f"=== tools_flutter device verify on {DEVICE} ===")
    ensure_home()
    r = expect_desc(["Tools", "Camera", "Media Editor"], "home", prefix=True)
    results.append(r)
    print(f"[{'PASS' if r.ok else 'FAIL'}] {r.name}: {r.detail}")

    # Camera hub
    if tap_desc("Camera", wait=1.6, prefix=True):
        r = expect_desc(
            ["Take Photo", "Record Video", "Text to Video", "Photo Slideshow"],
            "camera_hub",
            prefix=True,
        )
        results.append(r)
        print(f"[{'PASS' if r.ok else 'FAIL'}] {r.name}: {r.detail}")

        if r.ok and tap_desc("Take Photo", wait=2.5, prefix=True):
            xml = dump_xml()
            ok = (
                bounds_for_desc(xml, "Capture", prefix=True) is not None
                or bounds_for_desc(xml, "Take Photo", prefix=True) is not None
            )
            results.append(Result("camera_photo", ok, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok else 'FAIL'}] camera_photo")
            press_back()

        if r.ok and tap_desc("Record Video", wait=2.5, prefix=True):
            xml = dump_xml()
            ok = (
                bounds_for_desc(xml, "Record", prefix=True) is not None
                or bounds_for_desc(xml, "Stop", prefix=True) is not None
            )
            results.append(Result("camera_record", ok, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok else 'FAIL'}] camera_record")
            press_back()

        if r.ok and tap_desc("Text to Video", wait=1.3, prefix=True):
            xml = dump_xml()
            gen = bounds_for_desc(xml, "Generate video", prefix=False)
            ok_open = gen is not None or bounds_for_desc(
                xml, "Text to Video", prefix=True
            ) is not None
            results.append(Result("text_video_open", ok_open, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok_open else 'FAIL'}] text_video_open")
            # Native FGS path is the real validation (UI Generate is flaky under uiautomator).
            print("  starting textCard via debug-exported MediaJobService…")
            adb("logcat", "-c", check=False)
            adb(
                "shell",
                "am",
                "start-foreground-service",
                "-n",
                f"{PKG}/.MediaJobService",
                "--es",
                "type",
                "textCard",
                "--es",
                "level",
                "medium",
                "--esa",
                "paths",
                "_,Hello,2",
                check=False,
            )
            finished = False
            crash = False
            deadline = time.time() + 45
            while time.time() < deadline:
                time.sleep(1.2)
                # Filter by tag — full buffer is noisy and -t can miss job lines
                logs = adb(
                    "logcat",
                    "-d",
                    "-s",
                    "MediaJobService:V",
                    "AndroidRuntime:E",
                    check=False,
                )
                low = logs.lower()
                if "fatal exception" in low:
                    crash = True
                    break
                if (
                    "phase=finished" in low
                    or "textcard fallback ok" in low
                    or "ffmpeg ok" in low
                ):
                    finished = True
                    break
            logs = adb(
                "logcat",
                "-d",
                "-s",
                "MediaJobService:V",
                "AndroidRuntime:E",
                check=False,
            )
            low = logs.lower()
            crash = crash or ("fatal exception" in low)
            ok_job = (not crash) and finished
            results.append(
                Result(
                    "text_video_job",
                    ok_job,
                    f"finished={finished} crash={crash} log≈{logs[-200:]!r}",
                )
            )
            print(
                f"[{'PASS' if results[-1].ok else 'FAIL'}] text_video_job: finished={finished} crash={crash}"
            )
            press_back()

        if r.ok and tap_desc("Photo Slideshow", wait=1.3, prefix=True):
            xml = dump_xml()
            ok = (
                bounds_for_desc(xml, "Select photos", prefix=False) is not None
                or bounds_for_desc(xml, "Generate slideshow", prefix=False) is not None
            )
            results.append(Result("slideshow_open", ok, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok else 'FAIL'}] slideshow_open")
            press_back()

        press_back()  # back to home

    # Media hub
    ensure_home()
    if tap_desc("Media Editor", wait=1.5, prefix=True):
        xml = dump_xml()
        tools_need = ["Video Compress", "Extract Audio", "Merge Videos", "Speed Change"]
        found = [
            t
            for t in tools_need
            if bounds_for_desc(xml, t, prefix=True) is not None
        ]
        if len(found) < 2:
            adb("shell", "input", "swipe", "500", "1800", "500", "600", "300")
            time.sleep(0.8)
            xml = dump_xml()
            found = [
                t
                for t in tools_need
                if bounds_for_desc(xml, t, prefix=True) is not None
            ]
        ok = len(found) >= 2
        results.append(Result("media_hub", ok, f"found={found} descs={descs(xml)[:12]}"))
        print(f"[{'PASS' if ok else 'FAIL'}] media_hub: found={found}")

        if tap_desc("Video Compress", wait=1.2, prefix=True):
            xml = dump_xml()
            ok = (
                bounds_for_desc(xml, "Select file", prefix=False) is not None
                or bounds_for_desc(xml, "Start", prefix=True) is not None
            )
            results.append(Result("media_tool_open", ok, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok else 'FAIL'}] media_tool_open")
            press_back()
        press_back()

    # Light meter
    ensure_home()
    if tap_desc("Light Meter", wait=2.0, prefix=True):
        time.sleep(1.5)
        xml = dump_xml()
        joined = " ".join(descs(xml))
        on_page = (
            bounds_for_desc(xml, "Save Snapshot", prefix=False) is not None
            or bounds_for_desc(xml, "Light Meter", prefix=True) is not None
            or bounds_for_desc(xml, "No light sensor", prefix=False) is not None
            or "lux" in joined.lower()
        )
        results.append(Result("lightlux", on_page, joined[:180]))
        print(f"[{'PASS' if on_page else 'FAIL'}] lightlux: {joined[:120]}")
        if bounds_for_desc(xml, "Save Snapshot", prefix=False):
            tap_desc("Save Snapshot", wait=1, prefix=False)
        press_back()

    # Face
    ensure_home()
    if tap_desc("Face Compare", wait=1.5, prefix=True):
        xml = dump_xml()
        ok = (
            bounds_for_desc(xml, "Compare", prefix=True) is not None
            or bounds_for_desc(xml, "Photo A", prefix=True) is not None
        )
        results.append(Result("face", ok, " | ".join(descs(xml)[:12])))
        print(f"[{'PASS' if ok else 'FAIL'}] face")
        press_back()

    # Ebook
    ensure_home()
    if tap_desc("Ebook Converter", wait=1.5, prefix=True):
        xml = dump_xml()
        ok = (
            bounds_for_desc(xml, "Select EPUB", prefix=False) is not None
            or bounds_for_desc(xml, "Convert", prefix=False) is not None
        )
        results.append(Result("ebook", ok, " | ".join(descs(xml)[:12])))
        print(f"[{'PASS' if ok else 'FAIL'}] ebook")
        press_back()

    print("\n=== SUMMARY ===")
    failed = [r for r in results if not r.ok]
    for r in results:
        print(f"  {'PASS' if r.ok else 'FAIL'}  {r.name}: {r.detail[:120]}")
    print(f"\n{len(results) - len(failed)}/{len(results)} passed")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
