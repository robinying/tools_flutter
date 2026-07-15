// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_job_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MediaJobEvent {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double progress, String message) running,
    required TResult Function(String message, String? outputPath) finished,
    required TResult Function(String message) failed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double progress, String message)? running,
    TResult? Function(String message, String? outputPath)? finished,
    TResult? Function(String message)? failed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double progress, String message)? running,
    TResult Function(String message, String? outputPath)? finished,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaJobEventCopyWith<MediaJobEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaJobEventCopyWith<$Res> {
  factory $MediaJobEventCopyWith(
    MediaJobEvent value,
    $Res Function(MediaJobEvent) then,
  ) = _$MediaJobEventCopyWithImpl<$Res, MediaJobEvent>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$MediaJobEventCopyWithImpl<$Res, $Val extends MediaJobEvent>
    implements $MediaJobEventCopyWith<$Res> {
  _$MediaJobEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MediaJobEventRunningImplCopyWith<$Res>
    implements $MediaJobEventCopyWith<$Res> {
  factory _$$MediaJobEventRunningImplCopyWith(
    _$MediaJobEventRunningImpl value,
    $Res Function(_$MediaJobEventRunningImpl) then,
  ) = __$$MediaJobEventRunningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double progress, String message});
}

/// @nodoc
class __$$MediaJobEventRunningImplCopyWithImpl<$Res>
    extends _$MediaJobEventCopyWithImpl<$Res, _$MediaJobEventRunningImpl>
    implements _$$MediaJobEventRunningImplCopyWith<$Res> {
  __$$MediaJobEventRunningImplCopyWithImpl(
    _$MediaJobEventRunningImpl _value,
    $Res Function(_$MediaJobEventRunningImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? progress = null, Object? message = null}) {
    return _then(
      _$MediaJobEventRunningImpl(
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MediaJobEventRunningImpl implements MediaJobEventRunning {
  const _$MediaJobEventRunningImpl({
    required this.progress,
    required this.message,
  });

  @override
  final double progress;
  @override
  final String message;

  @override
  String toString() {
    return 'MediaJobEvent.running(progress: $progress, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaJobEventRunningImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress, message);

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaJobEventRunningImplCopyWith<_$MediaJobEventRunningImpl>
  get copyWith =>
      __$$MediaJobEventRunningImplCopyWithImpl<_$MediaJobEventRunningImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double progress, String message) running,
    required TResult Function(String message, String? outputPath) finished,
    required TResult Function(String message) failed,
  }) {
    return running(progress, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double progress, String message)? running,
    TResult? Function(String message, String? outputPath)? finished,
    TResult? Function(String message)? failed,
  }) {
    return running?.call(progress, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double progress, String message)? running,
    TResult Function(String message, String? outputPath)? finished,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running(progress, message);
    }
    return orElse();
  }
}

abstract class MediaJobEventRunning implements MediaJobEvent {
  const factory MediaJobEventRunning({
    required final double progress,
    required final String message,
  }) = _$MediaJobEventRunningImpl;

  double get progress;
  @override
  String get message;

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaJobEventRunningImplCopyWith<_$MediaJobEventRunningImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MediaJobEventFinishedImplCopyWith<$Res>
    implements $MediaJobEventCopyWith<$Res> {
  factory _$$MediaJobEventFinishedImplCopyWith(
    _$MediaJobEventFinishedImpl value,
    $Res Function(_$MediaJobEventFinishedImpl) then,
  ) = __$$MediaJobEventFinishedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? outputPath});
}

/// @nodoc
class __$$MediaJobEventFinishedImplCopyWithImpl<$Res>
    extends _$MediaJobEventCopyWithImpl<$Res, _$MediaJobEventFinishedImpl>
    implements _$$MediaJobEventFinishedImplCopyWith<$Res> {
  __$$MediaJobEventFinishedImplCopyWithImpl(
    _$MediaJobEventFinishedImpl _value,
    $Res Function(_$MediaJobEventFinishedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? outputPath = freezed}) {
    return _then(
      _$MediaJobEventFinishedImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        outputPath: freezed == outputPath
            ? _value.outputPath
            : outputPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$MediaJobEventFinishedImpl implements MediaJobEventFinished {
  const _$MediaJobEventFinishedImpl({required this.message, this.outputPath});

  @override
  final String message;
  @override
  final String? outputPath;

  @override
  String toString() {
    return 'MediaJobEvent.finished(message: $message, outputPath: $outputPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaJobEventFinishedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.outputPath, outputPath) ||
                other.outputPath == outputPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, outputPath);

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaJobEventFinishedImplCopyWith<_$MediaJobEventFinishedImpl>
  get copyWith =>
      __$$MediaJobEventFinishedImplCopyWithImpl<_$MediaJobEventFinishedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double progress, String message) running,
    required TResult Function(String message, String? outputPath) finished,
    required TResult Function(String message) failed,
  }) {
    return finished(message, outputPath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double progress, String message)? running,
    TResult? Function(String message, String? outputPath)? finished,
    TResult? Function(String message)? failed,
  }) {
    return finished?.call(message, outputPath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double progress, String message)? running,
    TResult Function(String message, String? outputPath)? finished,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (finished != null) {
      return finished(message, outputPath);
    }
    return orElse();
  }
}

abstract class MediaJobEventFinished implements MediaJobEvent {
  const factory MediaJobEventFinished({
    required final String message,
    final String? outputPath,
  }) = _$MediaJobEventFinishedImpl;

  @override
  String get message;
  String? get outputPath;

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaJobEventFinishedImplCopyWith<_$MediaJobEventFinishedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MediaJobEventFailedImplCopyWith<$Res>
    implements $MediaJobEventCopyWith<$Res> {
  factory _$$MediaJobEventFailedImplCopyWith(
    _$MediaJobEventFailedImpl value,
    $Res Function(_$MediaJobEventFailedImpl) then,
  ) = __$$MediaJobEventFailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MediaJobEventFailedImplCopyWithImpl<$Res>
    extends _$MediaJobEventCopyWithImpl<$Res, _$MediaJobEventFailedImpl>
    implements _$$MediaJobEventFailedImplCopyWith<$Res> {
  __$$MediaJobEventFailedImplCopyWithImpl(
    _$MediaJobEventFailedImpl _value,
    $Res Function(_$MediaJobEventFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$MediaJobEventFailedImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MediaJobEventFailedImpl implements MediaJobEventFailed {
  const _$MediaJobEventFailedImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'MediaJobEvent.failed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaJobEventFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaJobEventFailedImplCopyWith<_$MediaJobEventFailedImpl> get copyWith =>
      __$$MediaJobEventFailedImplCopyWithImpl<_$MediaJobEventFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double progress, String message) running,
    required TResult Function(String message, String? outputPath) finished,
    required TResult Function(String message) failed,
  }) {
    return failed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double progress, String message)? running,
    TResult? Function(String message, String? outputPath)? finished,
    TResult? Function(String message)? failed,
  }) {
    return failed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double progress, String message)? running,
    TResult Function(String message, String? outputPath)? finished,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(message);
    }
    return orElse();
  }
}

abstract class MediaJobEventFailed implements MediaJobEvent {
  const factory MediaJobEventFailed({required final String message}) =
      _$MediaJobEventFailedImpl;

  @override
  String get message;

  /// Create a copy of MediaJobEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaJobEventFailedImplCopyWith<_$MediaJobEventFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MediaJobState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(double progress, String message) running,
    required TResult Function(bool success, String message, String? outputPath)
    finished,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(double progress, String message)? running,
    TResult? Function(bool success, String message, String? outputPath)?
    finished,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(double progress, String message)? running,
    TResult Function(bool success, String message, String? outputPath)?
    finished,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaJobStateCopyWith<$Res> {
  factory $MediaJobStateCopyWith(
    MediaJobState value,
    $Res Function(MediaJobState) then,
  ) = _$MediaJobStateCopyWithImpl<$Res, MediaJobState>;
}

/// @nodoc
class _$MediaJobStateCopyWithImpl<$Res, $Val extends MediaJobState>
    implements $MediaJobStateCopyWith<$Res> {
  _$MediaJobStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaJobState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MediaJobIdleImplCopyWith<$Res> {
  factory _$$MediaJobIdleImplCopyWith(
    _$MediaJobIdleImpl value,
    $Res Function(_$MediaJobIdleImpl) then,
  ) = __$$MediaJobIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MediaJobIdleImplCopyWithImpl<$Res>
    extends _$MediaJobStateCopyWithImpl<$Res, _$MediaJobIdleImpl>
    implements _$$MediaJobIdleImplCopyWith<$Res> {
  __$$MediaJobIdleImplCopyWithImpl(
    _$MediaJobIdleImpl _value,
    $Res Function(_$MediaJobIdleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaJobState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MediaJobIdleImpl implements MediaJobIdle {
  const _$MediaJobIdleImpl();

  @override
  String toString() {
    return 'MediaJobState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MediaJobIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(double progress, String message) running,
    required TResult Function(bool success, String message, String? outputPath)
    finished,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(double progress, String message)? running,
    TResult? Function(bool success, String message, String? outputPath)?
    finished,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(double progress, String message)? running,
    TResult Function(bool success, String message, String? outputPath)?
    finished,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }
}

abstract class MediaJobIdle implements MediaJobState {
  const factory MediaJobIdle() = _$MediaJobIdleImpl;
}

/// @nodoc
abstract class _$$MediaJobRunningImplCopyWith<$Res> {
  factory _$$MediaJobRunningImplCopyWith(
    _$MediaJobRunningImpl value,
    $Res Function(_$MediaJobRunningImpl) then,
  ) = __$$MediaJobRunningImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double progress, String message});
}

/// @nodoc
class __$$MediaJobRunningImplCopyWithImpl<$Res>
    extends _$MediaJobStateCopyWithImpl<$Res, _$MediaJobRunningImpl>
    implements _$$MediaJobRunningImplCopyWith<$Res> {
  __$$MediaJobRunningImplCopyWithImpl(
    _$MediaJobRunningImpl _value,
    $Res Function(_$MediaJobRunningImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaJobState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? progress = null, Object? message = null}) {
    return _then(
      _$MediaJobRunningImpl(
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MediaJobRunningImpl implements MediaJobRunning {
  const _$MediaJobRunningImpl({
    this.progress = 0.05,
    this.message = 'Starting…',
  });

  @override
  @JsonKey()
  final double progress;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'MediaJobState.running(progress: $progress, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaJobRunningImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress, message);

  /// Create a copy of MediaJobState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaJobRunningImplCopyWith<_$MediaJobRunningImpl> get copyWith =>
      __$$MediaJobRunningImplCopyWithImpl<_$MediaJobRunningImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(double progress, String message) running,
    required TResult Function(bool success, String message, String? outputPath)
    finished,
  }) {
    return running(progress, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(double progress, String message)? running,
    TResult? Function(bool success, String message, String? outputPath)?
    finished,
  }) {
    return running?.call(progress, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(double progress, String message)? running,
    TResult Function(bool success, String message, String? outputPath)?
    finished,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running(progress, message);
    }
    return orElse();
  }
}

abstract class MediaJobRunning implements MediaJobState {
  const factory MediaJobRunning({final double progress, final String message}) =
      _$MediaJobRunningImpl;

  double get progress;
  String get message;

  /// Create a copy of MediaJobState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaJobRunningImplCopyWith<_$MediaJobRunningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MediaJobFinishedImplCopyWith<$Res> {
  factory _$$MediaJobFinishedImplCopyWith(
    _$MediaJobFinishedImpl value,
    $Res Function(_$MediaJobFinishedImpl) then,
  ) = __$$MediaJobFinishedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool success, String message, String? outputPath});
}

/// @nodoc
class __$$MediaJobFinishedImplCopyWithImpl<$Res>
    extends _$MediaJobStateCopyWithImpl<$Res, _$MediaJobFinishedImpl>
    implements _$$MediaJobFinishedImplCopyWith<$Res> {
  __$$MediaJobFinishedImplCopyWithImpl(
    _$MediaJobFinishedImpl _value,
    $Res Function(_$MediaJobFinishedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaJobState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? outputPath = freezed,
  }) {
    return _then(
      _$MediaJobFinishedImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        outputPath: freezed == outputPath
            ? _value.outputPath
            : outputPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$MediaJobFinishedImpl implements MediaJobFinished {
  const _$MediaJobFinishedImpl({
    required this.success,
    required this.message,
    this.outputPath,
  });

  @override
  final bool success;
  @override
  final String message;
  @override
  final String? outputPath;

  @override
  String toString() {
    return 'MediaJobState.finished(success: $success, message: $message, outputPath: $outputPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaJobFinishedImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.outputPath, outputPath) ||
                other.outputPath == outputPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, success, message, outputPath);

  /// Create a copy of MediaJobState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaJobFinishedImplCopyWith<_$MediaJobFinishedImpl> get copyWith =>
      __$$MediaJobFinishedImplCopyWithImpl<_$MediaJobFinishedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(double progress, String message) running,
    required TResult Function(bool success, String message, String? outputPath)
    finished,
  }) {
    return finished(success, message, outputPath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(double progress, String message)? running,
    TResult? Function(bool success, String message, String? outputPath)?
    finished,
  }) {
    return finished?.call(success, message, outputPath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(double progress, String message)? running,
    TResult Function(bool success, String message, String? outputPath)?
    finished,
    required TResult orElse(),
  }) {
    if (finished != null) {
      return finished(success, message, outputPath);
    }
    return orElse();
  }
}

abstract class MediaJobFinished implements MediaJobState {
  const factory MediaJobFinished({
    required final bool success,
    required final String message,
    final String? outputPath,
  }) = _$MediaJobFinishedImpl;

  bool get success;
  String get message;
  String? get outputPath;

  /// Create a copy of MediaJobState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaJobFinishedImplCopyWith<_$MediaJobFinishedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
