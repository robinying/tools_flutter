import 'package:flutter/services.dart';

import '../../../../core/error/error.dart';
import '../../../../core/platform/native_bridge.dart';
import '../../domain/repositories/ebook_repository.dart';

class EbookRepositoryImpl implements EbookRepository {
  @override
  Future<Result<String>> convertEpub(String path) async {
    if (path.isEmpty) {
      return const Result.failure(
        AppFailure.invalidInput(message: 'No EPUB selected'),
      );
    }
    try {
      final out = await NativeBridge.convertEpub(path);
      return Result.success(out);
    } on PlatformException catch (e) {
      return Result.failure(
        AppFailure.platform(message: e.message ?? e.code, code: e.code),
      );
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }
}
