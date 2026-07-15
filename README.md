# Tools Flutter

Flutter port of the **Tools** Android multi-utility app (`com.robin.tools` → `com.robin.tools_flutter`).

Implements Phases 0–5 from `Tools/docs/flutter-implementation-guide.md`:

| Phase | Scope | Status |
|-------|--------|--------|
| 0 | Scaffold, theme, `go_router`, home hub | Done |
| 1–2 | FFmpeg MethodChannel + `MediaJobService` FGS + Media tools UI | Done |
| 3–4 | Camera photo/record + text card + slideshow | Done |
| 5 | LightLux + Face + Ebook (EPUB stub PDF) | Done |

## Features

- **Media Editor** — compress video/image, GIF, extract/strip audio, transcode, speed, reverse, merge, crop, volume/fade
- **Camera** — photo, video record, text-to-video, photo slideshow
- **Light Meter** — `TYPE_LIGHT` lux, scene labels, chart windows, sqflite snapshots
- **Face Compare** — ML Kit landmarks + geometry cosine similarity
- **Ebook** — EPUB → single-page PDF stub (Downloads/Tools)

## Stack

- Flutter 3.32 / Dart 3.8
- **Riverpod** + **GoRouter** + **Freezed**
- Architecture: feature-first, **thick Repository + Notifier** (domain interfaces + data impl)
- Local `android/app/libs/ffmpeg-kit.aar` + smart-exception
- Android FGS `mediaProcessing` (`MediaJobService`)
- camera / file_picker / google_mlkit_face_detection / sqflite

Generated Freezed files (`*.freezed.dart`) are **committed**.

## Build & install

```bash
cd tools_flutter
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk
adb shell am start -n com.robin.tools_flutter/.MainActivity
```

minSdk **28**, targetSdk **35**, applicationId `com.robin.tools_flutter`.

## Device verification

```bash
# UI smoke (home → each hub)
python3 scripts/device_verify.py <serial>

# Debug-only: start media jobs via adb (service exported in debug)
adb shell am start-foreground-service \
  -n com.robin.tools_flutter/.MediaJobService \
  --es type videoCompress --es level medium \
  --esa paths /data/user/0/com.robin.tools_flutter/cache/tftest.mp4
```

## Notes

- First launch on Android 15+ may show a **16 KB page-size** compatibility dialog for debug builds (FFmpeg / Flutter native libs).
- Bundled FFmpeg may lack `drawtext`; text-card falls back to a solid-color MP4.
- Release builds keep `MediaJobService` **exported=false** (debug manifest overrides for adb testing only).

## License

Private — All rights reserved.
