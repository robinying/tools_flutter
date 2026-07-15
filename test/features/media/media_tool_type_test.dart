import 'package:flutter_test/flutter_test.dart';
import 'package:tools_flutter/features/media/domain/entities/media_tool.dart';

void main() {
  group('MediaToolType.tryParse', () {
    test('parses known ids', () {
      expect(MediaToolType.tryParse('videoCompress'), MediaToolType.videoCompress);
      expect(MediaToolType.tryParse('merge'), MediaToolType.merge);
    });

    test('returns null for unknown or empty', () {
      expect(MediaToolType.tryParse(null), isNull);
      expect(MediaToolType.tryParse(''), isNull);
      expect(MediaToolType.tryParse('nope'), isNull);
    });
  });

  group('MediaToolType.fromId', () {
    test('throws on unknown id', () {
      expect(() => MediaToolType.fromId('bad'), throwsArgumentError);
    });
  });
}
