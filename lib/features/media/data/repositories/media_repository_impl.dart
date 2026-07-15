import 'package:flutter/services.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/media_job_state.dart';
import '../../domain/entities/media_tool.dart';
import '../../domain/repositories/media_repository.dart';
import '../datasources/media_job_datasource.dart';

class MediaRepositoryImpl implements MediaRepository {
  MediaRepositoryImpl(this._ds);

  final MediaJobDatasource _ds;

  @override
  Future<Result<void>> startToolJob({
    required MediaToolType type,
    required List<String> paths,
    required QualityLevel level,
  }) =>
      startRawJob(type: type.id, paths: paths, level: level.id);

  @override
  Future<Result<void>> startRawJob({
    required String type,
    required List<String> paths,
    required String level,
  }) async {
    if (type.isEmpty) {
      return const Result.failure(
        AppFailure.invalidInput(message: 'Missing job type'),
      );
    }
    if (paths.isEmpty) {
      return const Result.failure(
        AppFailure.invalidInput(message: 'No input files'),
      );
    }
    try {
      await _ds.startJob(type: type, paths: paths, level: level);
      return const Result.success(null);
    } on PlatformException catch (e) {
      return Result.failure(
        AppFailure.platform(message: e.message ?? e.code, code: e.code),
      );
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Result<void>> cancelJob() async {
    try {
      await _ds.cancelJob();
      return const Result.success(null);
    } on PlatformException catch (e) {
      return Result.failure(
        AppFailure.platform(message: e.message ?? e.code, code: e.code),
      );
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }

  @override
  Stream<MediaJobEvent> watchJobEvents() {
    return _ds.jobEventMaps().map(MediaJobEvent.fromMap);
  }

  @override
  Future<Result<String?>> saveOutput(String path) async {
    try {
      final lower = path.toLowerCase();
      final String? uri;
      if (lower.endsWith('.m4a') || lower.endsWith('.mp3') || lower.endsWith('.aac')) {
        uri = await _ds.saveAudio(path);
      } else if (lower.endsWith('.jpg') ||
          lower.endsWith('.jpeg') ||
          lower.endsWith('.png') ||
          lower.endsWith('.gif') ||
          lower.endsWith('.webp')) {
        uri = await _ds.saveImage(path);
      } else {
        uri = await _ds.saveVideo(path);
      }
      return Result.success(uri);
    } on PlatformException catch (e) {
      return Result.failure(
        AppFailure.platform(message: e.message ?? e.code, code: e.code),
      );
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }
}
