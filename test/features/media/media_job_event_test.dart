import 'package:flutter_test/flutter_test.dart';
import 'package:tools_flutter/features/media/domain/entities/media_job_state.dart';

void main() {
  group('MediaJobEvent.fromMap', () {
    test('running', () {
      final e = MediaJobEvent.fromMap({
        'phase': 'running',
        'progress': 0.4,
        'message': 'Encoding…',
      });
      expect(
        e,
        isA<MediaJobEventRunning>()
            .having((x) => x.progress, 'progress', 0.4)
            .having((x) => x.message, 'message', 'Encoding…'),
      );
    });

    test('finished', () {
      final e = MediaJobEvent.fromMap({
        'phase': 'finished',
        'message': 'Done',
        'outputPath': '/tmp/out.mp4',
      });
      expect(
        e,
        isA<MediaJobEventFinished>()
            .having((x) => x.outputPath, 'outputPath', '/tmp/out.mp4'),
      );
    });

    test('failed', () {
      final e = MediaJobEvent.fromMap({
        'phase': 'failed',
        'message': 'FFmpeg failed',
      });
      expect(
        e,
        isA<MediaJobEventFailed>()
            .having((x) => x.message, 'message', 'FFmpeg failed'),
      );
    });
  });
}
