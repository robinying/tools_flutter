import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

/// Shared failure type for repositories and notifiers.
///
/// Prefer mapping platform exceptions here instead of leaking [Exception]
/// into presentation.
@freezed
sealed class AppFailure with _$AppFailure {
  const AppFailure._();

  /// Native channel / platform error.
  const factory AppFailure.platform({
    required String message,
    String? code,
  }) = PlatformFailure;

  /// User or system cancelled an operation.
  const factory AppFailure.cancelled() = CancelledFailure;

  /// Missing input or resource (file, sensor, face, etc.).
  const factory AppFailure.notFound({String? message}) = NotFoundFailure;

  /// Validation / bad arguments.
  const factory AppFailure.invalidInput({required String message}) =
      InvalidInputFailure;

  /// Catch-all.
  const factory AppFailure.unknown({required String message}) = UnknownFailure;

  String get displayMessage => when(
        platform: (message, code) =>
            code == null || code.isEmpty ? message : '[$code] $message',
        cancelled: () => 'Cancelled',
        notFound: (message) => message ?? 'Not found',
        invalidInput: (message) => message,
        unknown: (message) => message,
      );
}
