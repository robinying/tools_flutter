import '../../../../core/error/error.dart';

/// Save camera / media outputs to the system gallery.
abstract class GalleryRepository {
  Future<Result<String?>> saveImage(String path);
  Future<Result<String?>> saveVideo(String path);
}
