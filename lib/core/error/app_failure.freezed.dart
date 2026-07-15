// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) platform,
    required TResult Function() cancelled,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) invalidInput,
    required TResult Function(String message) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? platform,
    TResult? Function()? cancelled,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? invalidInput,
    TResult? Function(String message)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? platform,
    TResult Function()? cancelled,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? invalidInput,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppFailureCopyWith<$Res> {
  factory $AppFailureCopyWith(
    AppFailure value,
    $Res Function(AppFailure) then,
  ) = _$AppFailureCopyWithImpl<$Res, AppFailure>;
}

/// @nodoc
class _$AppFailureCopyWithImpl<$Res, $Val extends AppFailure>
    implements $AppFailureCopyWith<$Res> {
  _$AppFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PlatformFailureImplCopyWith<$Res> {
  factory _$$PlatformFailureImplCopyWith(
    _$PlatformFailureImpl value,
    $Res Function(_$PlatformFailureImpl) then,
  ) = __$$PlatformFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$PlatformFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$PlatformFailureImpl>
    implements _$$PlatformFailureImplCopyWith<$Res> {
  __$$PlatformFailureImplCopyWithImpl(
    _$PlatformFailureImpl _value,
    $Res Function(_$PlatformFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? code = freezed}) {
    return _then(
      _$PlatformFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PlatformFailureImpl extends PlatformFailure {
  const _$PlatformFailureImpl({required this.message, this.code}) : super._();

  @override
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'AppFailure.platform(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlatformFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlatformFailureImplCopyWith<_$PlatformFailureImpl> get copyWith =>
      __$$PlatformFailureImplCopyWithImpl<_$PlatformFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) platform,
    required TResult Function() cancelled,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) invalidInput,
    required TResult Function(String message) unknown,
  }) {
    return platform(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? platform,
    TResult? Function()? cancelled,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? invalidInput,
    TResult? Function(String message)? unknown,
  }) {
    return platform?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? platform,
    TResult Function()? cancelled,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? invalidInput,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (platform != null) {
      return platform(message, code);
    }
    return orElse();
  }
}

abstract class PlatformFailure extends AppFailure {
  const factory PlatformFailure({
    required final String message,
    final String? code,
  }) = _$PlatformFailureImpl;
  const PlatformFailure._() : super._();

  String get message;
  String? get code;

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlatformFailureImplCopyWith<_$PlatformFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelledFailureImplCopyWith<$Res> {
  factory _$$CancelledFailureImplCopyWith(
    _$CancelledFailureImpl value,
    $Res Function(_$CancelledFailureImpl) then,
  ) = __$$CancelledFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CancelledFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$CancelledFailureImpl>
    implements _$$CancelledFailureImplCopyWith<$Res> {
  __$$CancelledFailureImplCopyWithImpl(
    _$CancelledFailureImpl _value,
    $Res Function(_$CancelledFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CancelledFailureImpl extends CancelledFailure {
  const _$CancelledFailureImpl() : super._();

  @override
  String toString() {
    return 'AppFailure.cancelled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelledFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) platform,
    required TResult Function() cancelled,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) invalidInput,
    required TResult Function(String message) unknown,
  }) {
    return cancelled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? platform,
    TResult? Function()? cancelled,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? invalidInput,
    TResult? Function(String message)? unknown,
  }) {
    return cancelled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? platform,
    TResult Function()? cancelled,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? invalidInput,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled();
    }
    return orElse();
  }
}

abstract class CancelledFailure extends AppFailure {
  const factory CancelledFailure() = _$CancelledFailureImpl;
  const CancelledFailure._() : super._();
}

/// @nodoc
abstract class _$$NotFoundFailureImplCopyWith<$Res> {
  factory _$$NotFoundFailureImplCopyWith(
    _$NotFoundFailureImpl value,
    $Res Function(_$NotFoundFailureImpl) then,
  ) = __$$NotFoundFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$NotFoundFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$NotFoundFailureImpl>
    implements _$$NotFoundFailureImplCopyWith<$Res> {
  __$$NotFoundFailureImplCopyWithImpl(
    _$NotFoundFailureImpl _value,
    $Res Function(_$NotFoundFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$NotFoundFailureImpl(
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NotFoundFailureImpl extends NotFoundFailure {
  const _$NotFoundFailureImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'AppFailure.notFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      __$$NotFoundFailureImplCopyWithImpl<_$NotFoundFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) platform,
    required TResult Function() cancelled,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) invalidInput,
    required TResult Function(String message) unknown,
  }) {
    return notFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? platform,
    TResult? Function()? cancelled,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? invalidInput,
    TResult? Function(String message)? unknown,
  }) {
    return notFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? platform,
    TResult Function()? cancelled,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? invalidInput,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message);
    }
    return orElse();
  }
}

abstract class NotFoundFailure extends AppFailure {
  const factory NotFoundFailure({final String? message}) =
      _$NotFoundFailureImpl;
  const NotFoundFailure._() : super._();

  String? get message;

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidInputFailureImplCopyWith<$Res> {
  factory _$$InvalidInputFailureImplCopyWith(
    _$InvalidInputFailureImpl value,
    $Res Function(_$InvalidInputFailureImpl) then,
  ) = __$$InvalidInputFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$InvalidInputFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$InvalidInputFailureImpl>
    implements _$$InvalidInputFailureImplCopyWith<$Res> {
  __$$InvalidInputFailureImplCopyWithImpl(
    _$InvalidInputFailureImpl _value,
    $Res Function(_$InvalidInputFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$InvalidInputFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InvalidInputFailureImpl extends InvalidInputFailure {
  const _$InvalidInputFailureImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'AppFailure.invalidInput(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidInputFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidInputFailureImplCopyWith<_$InvalidInputFailureImpl> get copyWith =>
      __$$InvalidInputFailureImplCopyWithImpl<_$InvalidInputFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) platform,
    required TResult Function() cancelled,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) invalidInput,
    required TResult Function(String message) unknown,
  }) {
    return invalidInput(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? platform,
    TResult? Function()? cancelled,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? invalidInput,
    TResult? Function(String message)? unknown,
  }) {
    return invalidInput?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? platform,
    TResult Function()? cancelled,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? invalidInput,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (invalidInput != null) {
      return invalidInput(message);
    }
    return orElse();
  }
}

abstract class InvalidInputFailure extends AppFailure {
  const factory InvalidInputFailure({required final String message}) =
      _$InvalidInputFailureImpl;
  const InvalidInputFailure._() : super._();

  String get message;

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvalidInputFailureImplCopyWith<_$InvalidInputFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(
    _$UnknownFailureImpl value,
    $Res Function(_$UnknownFailureImpl) then,
  ) = __$$UnknownFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
    _$UnknownFailureImpl _value,
    $Res Function(_$UnknownFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UnknownFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnknownFailureImpl extends UnknownFailure {
  const _$UnknownFailureImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'AppFailure.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, String? code) platform,
    required TResult Function() cancelled,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) invalidInput,
    required TResult Function(String message) unknown,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? code)? platform,
    TResult? Function()? cancelled,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? invalidInput,
    TResult? Function(String message)? unknown,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? code)? platform,
    TResult Function()? cancelled,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? invalidInput,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }
}

abstract class UnknownFailure extends AppFailure {
  const factory UnknownFailure({required final String message}) =
      _$UnknownFailureImpl;
  const UnknownFailure._() : super._();

  String get message;

  /// Create a copy of AppFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
