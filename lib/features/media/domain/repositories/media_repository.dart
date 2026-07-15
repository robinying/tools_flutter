import '../../../../core/error/error.dart';
import '../entities/media_job_state.dart';
import '../entities/media_tool.dart';

/// Thick media repository: FFmpeg jobs + gallery save.
abstract class MediaRepository {
  /// Start a native job by tool type.
  Future<Result<void>> startToolJob({
    required MediaToolType type,
    required List<String> paths,
    required QualityLevel level,
  });

  /// Start by raw type id (textCard / slideshow / tools).
  Future<Result<void>> startRawJob({
    required String type,
    required List<String> paths,
    required String level,
  });

  Future<Result<void>> cancelJob();

  /// Broadcast stream of native progress events.
  Stream<MediaJobEvent> watchJobEvents();

  /// Save processed file to system gallery (video/image/audio by extension).
  Future<Result<String?>> saveOutput(String path);
}
