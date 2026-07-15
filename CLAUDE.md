# CLAUDE.md — tools_flutter

Guidance for agents working on this Flutter port of the Tools Android app.

## Commands

```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk
adb shell am start -n com.robin.tools_flutter/.MainActivity

# UI smoke (device serial optional)
python3 scripts/device_verify.py b9bed43d

# Debug media job (service exported only in debug)
adb shell am start-foreground-service \
  -n com.robin.tools_flutter/.MediaJobService \
  --es type videoCompress --es level medium \
  --esa paths /data/user/0/com.robin.tools_flutter/cache/tftest.mp4
```

## Architecture

```
lib/
  main.dart                 # ProviderScope + MaterialApp.router
  routing/app_router.dart   # go_router
  core/                     # theme, FeatureCard, NativeBridge
  features/
    home/
    media/                  # tools list + MediaJobController (Riverpod)
    camera/                 # photo / record / text / slideshow
    lightlux/               # TYPE_LIGHT + sqflite
    face/                   # ML Kit landmarks
    ebook/                  # EPUB→PDF via native channel
android/app/
  libs/ffmpeg-kit.aar
  MainActivity.kt           # Method/EventChannels
  MediaJobService.kt        # FGS mediaProcessing + FFmpeg jobs
```

- **No DI framework** — Riverpod for media job state only.
- Features do not depend on each other; shared code lives in `core/`.
- Long media work runs in `MediaJobService` (foreground), progress via `EventChannel`.

## Native channels (`NativeBridge`)

| Channel | Purpose |
|---------|---------|
| `com.robin.tools/ffmpeg` | Direct FFmpeg args (optional) |
| `com.robin.tools/media_job` + `media_events` | Start/cancel job + progress |
| `com.robin.tools/light_sensor` + events | TYPE_LIGHT lux stream |
| `com.robin.tools/ebook` | EPUB stub PDF |
| `com.robin.tools/gallery` | Save video/image/audio to MediaStore |

## Conventions

- Prefer extending `MediaToolType` + `MediaJobService.runJob` over one-off screens.
- Light sensor events **must** be emitted on the UI thread (MainActivity).
- Throttle Light Meter UI rebuilds (~8–10 Hz); exclude live numbers from Semantics.
- minSdk 28, targetSdk 35, applicationId `com.robin.tools_flutter`.

## Device notes

- Debug may show Android 15+ 16KB page-size warning (FFmpeg ELF alignment).
- Bundled FFmpeg may lack `drawtext` → textCard falls back to solid color.
- System multi-select pickers are flaky under automation; inject cache paths for FFmpeg tests.
