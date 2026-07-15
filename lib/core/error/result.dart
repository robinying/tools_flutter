import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_failure.dart';

part 'result.freezed.dart';

/// Functional result for repository methods (thick repository style).
///
/// Notifiers fold [Result] into UI state instead of try/catch sprawl.
@freezed
sealed class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(AppFailure failure) = FailureResult<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  T? get valueOrNull => switch (this) {
        Success(:final value) => value,
        FailureResult() => null,
      };

  AppFailure? get failureOrNull => switch (this) {
        Success() => null,
        FailureResult(:final failure) => failure,
      };

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(AppFailure failure) onFailure,
  }) =>
      switch (this) {
        Success(:final value) => onSuccess(value),
        FailureResult(:final failure) => onFailure(failure),
      };
}
