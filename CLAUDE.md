# CLAUDE.md — tools_flutter

Guidance for agents working on this Flutter port of the Tools Android app.

## Stack decisions

| Choice | Decision |
|--------|----------|
| State / DI | **Riverpod** (`flutter_riverpod`) |
| Routing | **GoRouter** |
| Models / sealed state | **Freezed** (`freezed_annotation` + `freezed`) |
| Architecture | **Feature-first Clean-ish**: thick **Repository + Notifier** (no per-method UseCase by default) |
| Generated code | **Commit** `*.freezed.dart` (and `*.g.dart` when added) to git |

### Layering per feature

```
features/<name>/
  domain/          # entities (Freezed), repository interfaces
  data/            # repository impl, datasources (NativeBridge, sqflite, …)
  presentation/    # pages + Riverpod Notifiers
```

- **presentation** → **domain** ← **data**
- Repositories return `Result<T>` / streams; Notifiers map to UI state.
- Prefer fat repositories over a UseCase class per action unless the flow is multi-step.

## Commands

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
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

After editing any `@freezed` type, re-run `build_runner` and **commit** the generated files.

## Architecture (current)

```
lib/
  main.dart                 # ProviderScope + MaterialApp.router
  routing/app_router.dart   # go_router
  core/
    error/                  # AppFailure + Result (Freezed)
    theme/, widgets/, platform/NativeBridge
  features/
    home/
    media/                  # domain + data + presentation (MediaRepository / MediaJobNotifier)
    camera/                 # reuses mediaJobProvider for text/slideshow
    lightlux/
    face/
    ebook/
android/app/
  libs/ffmpeg-kit.aar
  MainActivity.kt           # Method/EventChannels
  MediaJobService.kt        # FGS mediaProcessing + FFmpeg jobs
```

- Features do not depend on each other; shared code lives in `core/`.
- Long media work runs in `MediaJobService` (foreground), progress via `EventChannel`.
- Migration status: **Phases A–D done** (Media, LightLux, Camera gallery, Face, Ebook).

## Native channels (`NativeBridge`)

| Channel | Purpose |
|---------|---------|
| `com.robin.tools/media_job` + `media_events` | Start/cancel typed FFmpeg job + progress (raw FFmpeg channel removed) |
| `com.robin.tools/light_sensor` + events | TYPE_LIGHT lux stream |
| `com.robin.tools/ebook` | EPUB stub PDF |
| `com.robin.tools/gallery` | Save video/image/audio to MediaStore |

Treat `NativeBridge` as a **platform datasource**; repository impls wrap it.

## Conventions

- Prefer extending `MediaToolType` + `MediaJobService.runJob` over one-off screens.
- Light sensor events **must** be emitted on the UI thread (MainActivity).
- Throttle Light Meter UI rebuilds (~8–10 Hz); exclude live numbers from Semantics.
- minSdk 28, targetSdk 35, applicationId `com.robin.tools_flutter`.
- Errors: map to `AppFailure`, return `Result.failure(...)` from repositories.

## Device notes

- Debug may show Android 15+ 16KB page-size warning (FFmpeg ELF alignment).
- Bundled FFmpeg may lack `drawtext` → textCard falls back to solid color.
- System multi-select pickers are flaky under automation; inject cache paths for FFmpeg tests.
