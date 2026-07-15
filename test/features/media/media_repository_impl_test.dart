import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:tools_flutter/core/error/error.dart';
import 'package:tools_flutter/features/media/data/datasources/media_job_datasource.dart';
import 'package:tools_flutter/features/media/data/repositories/media_repository_impl.dart';
import 'package:tools_flutter/features/media/domain/entities/media_tool.dart';

class _FakeDs extends MediaJobDatasource {
  String? lastType;
  List<String>? lastPaths;
  String? lastLevel;
  bool cancelCalled = false;
  Exception? throwOnStart;

  @override
  Future<void> startJob({
    required String type,
    required List<String> paths,
    required String level,
  }) async {
    if (throwOnStart != null) throw throwOnStart!;
    lastType = type;
    lastPaths = paths;
    lastLevel = level;
  }

  @override
  Future<void> cancelJob() async {
    cancelCalled = true;
  }

  @override
  Stream<Map<String, dynamic>> jobEventMaps() => const Stream.empty();

  @override
  Future<String?> saveVideo(String path) async => 'content://video';

  @override
  Future<String?> saveImage(String path) async => 'content://image';

  @override
  Future<String?> saveAudio(String path) async => 'content://audio';
}

void main() {
  late _FakeDs ds;
  late MediaRepositoryImpl repo;

  setUp(() {
    ds = _FakeDs();
    repo = MediaRepositoryImpl(ds);
  });

  test('startToolJob maps type and level ids', () async {
    final r = await repo.startToolJob(
      type: MediaToolType.videoCompress,
      paths: ['/a.mp4'],
      level: QualityLevel.high,
    );
    expect(r.isSuccess, isTrue);
    expect(ds.lastType, 'videoCompress');
    expect(ds.lastPaths, ['/a.mp4']);
    expect(ds.lastLevel, 'high');
  });

  test('startRawJob rejects empty paths', () async {
    final r = await repo.startRawJob(type: 'gif', paths: [], level: 'medium');
    expect(r.isFailure, isTrue);
    expect(r.failureOrNull, isA<InvalidInputFailure>());
  });

  test('cancelJob', () async {
    final r = await repo.cancelJob();
    expect(r.isSuccess, isTrue);
    expect(ds.cancelCalled, isTrue);
  });

  test('saveOutput routes by extension', () async {
    expect((await repo.saveOutput('/x.mp4')).valueOrNull, 'content://video');
    expect((await repo.saveOutput('/x.jpg')).valueOrNull, 'content://image');
    expect((await repo.saveOutput('/x.m4a')).valueOrNull, 'content://audio');
  });
}
