import '../../../../core/platform/native_bridge.dart';

/// Platform channel access for media FGS jobs and gallery.
class MediaJobDatasource {
  Future<void> startJob({
    required String type,
    required List<String> paths,
    required String level,
  }) =>
      NativeBridge.startMediaJob(type: type, paths: paths, level: level);

  Future<void> cancelJob() => NativeBridge.cancelMediaJob();

  Stream<Map<String, dynamic>> jobEventMaps() => NativeBridge.mediaJobEvents();

  Future<String?> saveVideo(String path) => NativeBridge.saveVideo(path);
  Future<String?> saveImage(String path) => NativeBridge.saveImage(path);
  Future<String?> saveAudio(String path) => NativeBridge.saveAudio(path);
}
