import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/platform/native_bridge.dart';
import 'media_tool.dart';

sealed class MediaJobState {
  const MediaJobState();
}

class MediaJobIdle extends MediaJobState {
  const MediaJobIdle();
}

class MediaJobRunning extends MediaJobState {
  final double progress;
  final String message;
  const MediaJobRunning(this.progress, this.message);
}

class MediaJobFinished extends MediaJobState {
  final bool success;
  final String message;
  final String? outputPath;
  const MediaJobFinished({required this.success, required this.message, this.outputPath});
}

class MediaJobController extends StateNotifier<MediaJobState> {
  MediaJobController() : super(const MediaJobIdle()) {
    _sub = NativeBridge.mediaJobEvents().listen(_onEvent);
  }
  StreamSubscription? _sub;

  void _onEvent(Map<String, dynamic> e) {
    final phase = e['phase'] as String? ?? '';
    if (phase == 'running') {
      state = MediaJobRunning(
        (e['progress'] as num?)?.toDouble() ?? 0.3,
        e['message'] as String? ?? 'Working…',
      );
    } else if (phase == 'finished') {
      state = MediaJobFinished(
        success: true,
        message: e['message'] as String? ?? 'Done',
        outputPath: e['outputPath'] as String?,
      );
    } else if (phase == 'failed') {
      state = MediaJobFinished(
        success: false,
        message: e['message'] as String? ?? 'Failed',
      );
    }
  }

  Future<void> start({
    required MediaToolType type,
    required List<String> paths,
    required QualityLevel level,
  }) async {
    await startRaw(type: type.id, paths: paths, level: level.id);
  }

  /// Start a native media job by raw type id (textCard / slideshow / media tools).
  Future<void> startRaw({
    required String type,
    required List<String> paths,
    required String level,
  }) async {
    state = const MediaJobRunning(0.05, 'Starting…');
    await NativeBridge.startMediaJob(
      type: type,
      paths: paths,
      level: level,
    );
  }

  Future<void> cancel() async {
    await NativeBridge.cancelMediaJob();
  }

  void reset() => state = const MediaJobIdle();

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

final mediaJobProvider =
    StateNotifierProvider<MediaJobController, MediaJobState>((ref) => MediaJobController());
