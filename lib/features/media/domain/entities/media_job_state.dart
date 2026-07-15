import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_job_state.freezed.dart';

/// Progress events from the native media job pipeline.
@freezed
sealed class MediaJobEvent with _$MediaJobEvent {
  const factory MediaJobEvent.running({
    required double progress,
    required String message,
  }) = MediaJobEventRunning;

  const factory MediaJobEvent.finished({
    required String message,
    String? outputPath,
  }) = MediaJobEventFinished;

  const factory MediaJobEvent.failed({
    required String message,
  }) = MediaJobEventFailed;

  /// Parse native EventChannel map (`phase`, `progress`, `message`, `outputPath`).
  factory MediaJobEvent.fromMap(Map<String, dynamic> e) {
    final phase = e['phase'] as String? ?? '';
    final message = e['message'] as String? ?? '';
    switch (phase) {
      case 'running':
        return MediaJobEvent.running(
          progress: (e['progress'] as num?)?.toDouble() ?? 0.3,
          message: message.isEmpty ? 'Working…' : message,
        );
      case 'finished':
        return MediaJobEvent.finished(
          message: message.isEmpty ? 'Done' : message,
          outputPath: e['outputPath'] as String?,
        );
      case 'failed':
      default:
        return MediaJobEvent.failed(
          message: message.isEmpty ? 'Failed' : message,
        );
    }
  }
}

/// UI-facing job state held by [MediaJobNotifier].
@freezed
sealed class MediaJobState with _$MediaJobState {
  const factory MediaJobState.idle() = MediaJobIdle;

  const factory MediaJobState.running({
    @Default(0.05) double progress,
    @Default('Starting…') String message,
  }) = MediaJobRunning;

  const factory MediaJobState.finished({
    required bool success,
    required String message,
    String? outputPath,
  }) = MediaJobFinished;
}
