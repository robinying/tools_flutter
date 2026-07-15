import 'package:flutter_test/flutter_test.dart';
import 'package:tools_flutter/core/error/error.dart';

void main() {
  group('AppFailure', () {
    test('displayMessage for platform with code', () {
      const f = AppFailure.platform(message: 'boom', code: 'X');
      expect(f.displayMessage, '[X] boom');
    });

    test('displayMessage for cancelled', () {
      expect(const AppFailure.cancelled().displayMessage, 'Cancelled');
    });
  });

  group('Result', () {
    test('success fold', () {
      const r = Result.success(42);
      expect(r.isSuccess, isTrue);
      expect(r.valueOrNull, 42);
      expect(
        r.fold(onSuccess: (v) => v * 2, onFailure: (_) => -1),
        84,
      );
    });

    test('failure fold', () {
      const r = Result<int>.failure(AppFailure.notFound(message: 'missing'));
      expect(r.isFailure, isTrue);
      expect(r.failureOrNull?.displayMessage, 'missing');
      expect(
        r.fold(onSuccess: (_) => 'ok', onFailure: (f) => f.displayMessage),
        'missing',
      );
    });
  });
}
