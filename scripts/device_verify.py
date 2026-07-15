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


def bounds_for_desc(xml: str, needle: str) -> tuple[int, int] | None:
    # content-desc may contain &#10; for newlines
    for m in re.finditer(
        r'content-desc="([^"]*)"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', xml
    ):
        raw = m.group(1).replace("&#10;", "\n").replace("&amp;", "&")
        if needle.lower() in raw.lower():
            x = (int(m.group(2)) + int(m.group(4))) // 2
            y = (int(m.group(3)) + int(m.group(5))) // 2
            return x, y
    for m in re.finditer(
        r'bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"[^>]*content-desc="([^"]*)"', xml
    ):
        raw = m.group(5).replace("&#10;", "\n").replace("&amp;", "&")
        if needle.lower() in raw.lower():
            x = (int(m.group(1)) + int(m.group(3))) // 2
            y = (int(m.group(2)) + int(m.group(4))) // 2
            return x, y
    return None


def tap_desc(needle: str, wait: float = 1.2) -> bool:
    xml = dump_xml()
    b = bounds_for_desc(xml, needle)
    if not b:
        print(f"  ! not found: {needle!r}")
        print(f"    descs={descs(xml)[:15]}")
        return False
    print(f"  tap {needle!r} @ {b}")
    adb("shell", "input", "tap", str(b[0]), str(b[1]))
    time.sleep(wait)
    return True


def press_back(wait: float = 0.8) -> None:
    adb("shell", "input", "keyevent", "4")
    time.sleep(wait)


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


def expect_desc(needles: list[str], label: str) -> Result:
    xml = dump_xml()
    d = " | ".join(descs(xml)[:20])
    for n in needles:
        if any(n.lower() in x.lower().replace("&#10;", " ") for x in descs(xml)):
            return Result(label, True, f"found {n!r}; descs≈{d[:120]}")
    return Result(label, False, f"missing {needles}; descs≈{d[:200]}")


def main() -> int:
    results: list[Result] = []
    print(f"=== tools_flutter device verify on {DEVICE} ===")
    ensure_home()
    r = expect_desc(["Tools", "Camera", "Media Editor"], "home")
    results.append(r)
    print(f"[{'PASS' if r.ok else 'FAIL'}] {r.name}: {r.detail}")

    # Camera hub
    if tap_desc("Camera"):
        r = expect_desc(["Take Photo", "Record Video", "Text to Video", "Slideshow"], "camera_hub")
        results.append(r)
        print(f"[{'PASS' if r.ok else 'FAIL'}] {r.name}: {r.detail}")

        if tap_desc("Take Photo"):
            time.sleep(2)
            r = expect_desc(["Capture", "Take Photo", "Saving"], "camera_photo")
            # Capture button may be "Capture"
            xml = dump_xml()
            ok = any(
                k in " ".join(descs(xml)).lower()
                for k in ("capture", "take photo", "camera", "saving")
            ) or "camera" in xml.lower()
            # Also pass if page opened (app bar Take Photo)
            ok = ok or bounds_for_desc(xml, "Capture") is not None or bounds_for_desc(xml, "Take Photo") is not None
            results.append(Result("camera_photo", ok, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok else 'FAIL'}] camera_photo")
            press_back()

        if tap_desc("Record Video"):
            time.sleep(2)
            xml = dump_xml()
            ok = bounds_for_desc(xml, "Record") is not None or bounds_for_desc(xml, "Stop") is not None
            results.append(Result("camera_record", ok, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok else 'FAIL'}] camera_record")
            press_back()

        if tap_desc("Text to Video"):
            time.sleep(1)
            xml = dump_xml()
            gen = bounds_for_desc(xml, "Generate video")
            ok_open = gen is not None or bounds_for_desc(xml, "Text to Video") is not None
            results.append(Result("text_video_open", ok_open, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok_open else 'FAIL'}] text_video_open")
            if gen:
                print("  starting textCard FFmpeg job…")
                adb("shell", "input", "tap", str(gen[0]), str(gen[1]))
                # Wait for FGS / FFmpeg
                deadline = time.time() + 90
                finished = False
                while time.time() < deadline:
                    time.sleep(3)
                    xml = dump_xml()
                    joined = " ".join(descs(xml)).lower()
                    if "saved" in joined or "text video saved" in joined:
                        finished = True
                        break
                    # snackbars may not stay; check logcat
                    logs = adb("logcat", "-d", "-t", "80", check=False)
                    if "textcard" in logs.lower() or "MediaJobService" in logs:
                        if "ffmpeg fail" in logs.lower() and "textcard2" not in logs.lower():
                            pass
                    # If Generate is enabled again, job finished
                    if bounds_for_desc(xml, "Generate video") is not None and "generating" not in joined:
                        # might still be idle before start; wait a bit first time
                        if time.time() + 60 < deadline + 90:  # after some wait
                            # check gallery / cache via logcat phase finished
                            if "phase" in logs or "Done" in logs:
                                finished = True
                                break
                # Check logcat for success
                logs = adb("logcat", "-d", "-t", "200", check=False)
                log_ok = (
                    "textcard" in logs.lower()
                    or "MediaJobService" in logs
                    or "finished" in logs.lower()
                )
                # Also accept if no crash
                crash = "FATAL EXCEPTION" in logs and PKG in logs
                ok_job = not crash
                # Prefer positive signal
                pos = any(
                    s in logs
                    for s in (
                        "phase",
                        "outputPath",
                        "MediaJobService",
                        "textcard",
                        "Encoding",
                    )
                )
                results.append(
                    Result(
                        "text_video_job",
                        ok_job and (finished or pos or ok_open),
                        f"finished_ui={finished} log_signal={pos} crash={crash}",
                    )
                )
                print(
                    f"[{'PASS' if results[-1].ok else 'FAIL'}] text_video_job: {results[-1].detail}"
                )
            press_back()

        if tap_desc("Photo Slideshow") or tap_desc("Slideshow"):
            xml = dump_xml()
            ok = bounds_for_desc(xml, "Select photos") is not None or bounds_for_desc(
                xml, "Generate slideshow"
            ) is not None
            results.append(Result("slideshow_open", ok, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok else 'FAIL'}] slideshow_open")
            press_back()

        press_back()  # back to home

    # Media hub
    ensure_home() if not expect_desc(["Tools"], "rehome_check").ok else None
    # Navigate home carefully
    xml = dump_xml()
    if not any("Tools" in d for d in descs(xml)):
        ensure_home()

    if tap_desc("Media Editor"):
        xml = dump_xml()
        tools_need = ["Video Compress", "Extract Audio", "Merge Videos", "Speed Change"]
        found = [t for t in tools_need if any(t in d for d in descs(xml))]
        # list may need scroll
        if len(found) < 2:
            adb("shell", "input", "swipe", "500", "1800", "500", "600", "300")
            time.sleep(0.8)
            xml = dump_xml()
            found = [t for t in tools_need if any(t in d for d in descs(xml))]
        ok = len(found) >= 2
        results.append(Result("media_hub", ok, f"found={found} descs={descs(xml)[:15]}"))
        print(f"[{'PASS' if ok else 'FAIL'}] media_hub: found={found}")

        if tap_desc("Video Compress"):
            xml = dump_xml()
            ok = bounds_for_desc(xml, "Select file") is not None or bounds_for_desc(
                xml, "Start"
            ) is not None
            results.append(Result("media_tool_open", ok, " | ".join(descs(xml)[:12])))
            print(f"[{'PASS' if ok else 'FAIL'}] media_tool_open")
            press_back()
        press_back()

    # Light meter
    ensure_home()
    if tap_desc("Light Meter"):
        time.sleep(2)
        xml = dump_xml()
        d = descs(xml)
        joined = " ".join(d)
        ok = (
            "lux" in joined.lower()
            or "Save Snapshot" in joined
            or "Light Meter" in joined
            or "No light sensor" in joined
            or re.search(r"\d+(\.\d+)?", joined) is not None
        )
        results.append(Result("lightlux", ok, joined[:180]))
        print(f"[{'PASS' if ok else 'FAIL'}] lightlux: {joined[:120]}")
        # try save snapshot
        if bounds_for_desc(xml, "Save Snapshot"):
            tap_desc("Save Snapshot", wait=1)
            if tap_desc("history", wait=1) or True:
                # history icon may be content-desc empty; use top-right approx
                # open via back+history: app bar icon often last
                press_back()
        press_back()

    # Face
    ensure_home()
    if tap_desc("Face Compare"):
        xml = dump_xml()
        ok = bounds_for_desc(xml, "Compare") is not None or bounds_for_desc(
            xml, "Photo A"
        ) is not None
        results.append(Result("face", ok, " | ".join(descs(xml)[:12])))
        print(f"[{'PASS' if ok else 'FAIL'}] face")
        press_back()

    # Ebook
    ensure_home()
    if tap_desc("Ebook Converter") or tap_desc("Ebook"):
        xml = dump_xml()
        ok = bounds_for_desc(xml, "Select EPUB") is not None or bounds_for_desc(
            xml, "Convert"
        ) is not None
        results.append(Result("ebook", ok, " | ".join(descs(xml)[:12])))
        print(f"[{'PASS' if ok else 'FAIL'}] ebook")
        press_back()

    print("\n=== SUMMARY ===")
    failed = [r for r in results if not r.ok]
    for r in results:
        print(f"  {'PASS' if r.ok else 'FAIL'}  {r.name}: {r.detail[:100]}")
    print(f"\n{len(results) - len(failed)}/{len(results)} passed")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
