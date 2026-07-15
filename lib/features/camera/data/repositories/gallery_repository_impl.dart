import 'package:flutter/services.dart';

import '../../../../core/error/error.dart';
import '../../../../core/platform/native_bridge.dart';
import '../../domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  @override
  Future<Result<String?>> saveImage(String path) async {
    try {
      return Result.success(await NativeBridge.saveImage(path));
    } on PlatformException catch (e) {
      return Result.failure(
        AppFailure.platform(message: e.message ?? e.code, code: e.code),
      );
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Result<String?>> saveVideo(String path) async {
    try {
      return Result.success(await NativeBridge.saveVideo(path));
    } on PlatformException catch (e) {
      return Result.failure(
        AppFailure.platform(message: e.message ?? e.code, code: e.code),
      );
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }
}
