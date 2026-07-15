import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/media_job_datasource.dart';
import '../../data/repositories/media_repository_impl.dart';
import '../../domain/entities/media_job_state.dart';
import '../../domain/entities/media_tool.dart';
import '../../domain/repositories/media_repository.dart';

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  return MediaRepositoryImpl(MediaJobDatasource());
});

final mediaJobProvider =
    StateNotifierProvider<MediaJobNotifier, MediaJobState>((ref) {
  return MediaJobNotifier(ref.watch(mediaRepositoryProvider));
});

class MediaJobNotifier extends StateNotifier<MediaJobState> {
  MediaJobNotifier(this._repo) : super(const MediaJobState.idle()) {
    _sub = _repo.watchJobEvents().listen(_onEvent);
  }

  final MediaRepository _repo;
  StreamSubscription<MediaJobEvent>? _sub;

  void _onEvent(MediaJobEvent e) {
    state = e.when(
      running: (progress, message) =>
          MediaJobState.running(progress: progress, message: message),
      finished: (message, outputPath) => MediaJobState.finished(
        success: true,
        message: message,
        outputPath: outputPath,
      ),
      failed: (message) => MediaJobState.finished(
        success: false,
        message: message,
      ),
    );
  }

  Future<void> start({
    required MediaToolType type,
    required List<String> paths,
    required QualityLevel level,
  }) async {
    state = const MediaJobState.running(progress: 0.05, message: 'Starting…');
    final result = await _repo.startToolJob(
      type: type,
      paths: paths,
      level: level,
    );
    result.fold(
      onSuccess: (_) {},
      onFailure: (f) {
        state = MediaJobState.finished(
          success: false,
          message: f.displayMessage,
        );
      },
    );
  }

  /// textCard / slideshow / raw type ids.
  Future<void> startRaw({
    required String type,
    required List<String> paths,
    required String level,
  }) async {
    state = const MediaJobState.running(progress: 0.05, message: 'Starting…');
    final result = await _repo.startRawJob(
      type: type,
      paths: paths,
      level: level,
    );
    result.fold(
      onSuccess: (_) {},
      onFailure: (f) {
        state = MediaJobState.finished(
          success: false,
          message: f.displayMessage,
        );
      },
    );
  }

  Future<void> cancel() async {
    await _repo.cancelJob();
  }

  Future<String?> saveOutput(String path) async {
    final result = await _repo.saveOutput(path);
    return result.valueOrNull;
  }

  void reset() => state = const MediaJobState.idle();

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
