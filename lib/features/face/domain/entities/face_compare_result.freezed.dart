// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_compare_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FaceCompareResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double similarityPercent) success,
    required TResult Function() noFace,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double similarityPercent)? success,
    TResult? Function()? noFace,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double similarityPercent)? success,
    TResult Function()? noFace,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaceCompareResultCopyWith<$Res> {
  factory $FaceCompareResultCopyWith(
    FaceCompareResult value,
    $Res Function(FaceCompareResult) then,
  ) = _$FaceCompareResultCopyWithImpl<$Res, FaceCompareResult>;
}

/// @nodoc
class _$FaceCompareResultCopyWithImpl<$Res, $Val extends FaceCompareResult>
    implements $FaceCompareResultCopyWith<$Res> {
  _$FaceCompareResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaceCompareResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FaceCompareSuccessImplCopyWith<$Res> {
  factory _$$FaceCompareSuccessImplCopyWith(
    _$FaceCompareSuccessImpl value,
    $Res Function(_$FaceCompareSuccessImpl) then,
  ) = __$$FaceCompareSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double similarityPercent});
}

/// @nodoc
class __$$FaceCompareSuccessImplCopyWithImpl<$Res>
    extends _$FaceCompareResultCopyWithImpl<$Res, _$FaceCompareSuccessImpl>
    implements _$$FaceCompareSuccessImplCopyWith<$Res> {
  __$$FaceCompareSuccessImplCopyWithImpl(
    _$FaceCompareSuccessImpl _value,
    $Res Function(_$FaceCompareSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaceCompareResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? similarityPercent = null}) {
    return _then(
      _$FaceCompareSuccessImpl(
        similarityPercent: null == similarityPercent
            ? _value.similarityPercent
            : similarityPercent // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$FaceCompareSuccessImpl implements FaceCompareSuccess {
  const _$FaceCompareSuccessImpl({required this.similarityPercent});

  @override
  final double similarityPercent;

  @override
  String toString() {
    return 'FaceCompareResult.success(similarityPercent: $similarityPercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceCompareSuccessImpl &&
            (identical(other.similarityPercent, similarityPercent) ||
                other.similarityPercent == similarityPercent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, similarityPercent);

  /// Create a copy of FaceCompareResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceCompareSuccessImplCopyWith<_$FaceCompareSuccessImpl> get copyWith =>
      __$$FaceCompareSuccessImplCopyWithImpl<_$FaceCompareSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double similarityPercent) success,
    required TResult Function() noFace,
    required TResult Function(String message) error,
  }) {
    return success(similarityPercent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double similarityPercent)? success,
    TResult? Function()? noFace,
    TResult? Function(String message)? error,
  }) {
    return success?.call(similarityPercent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double similarityPercent)? success,
    TResult Function()? noFace,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(similarityPercent);
    }
    return orElse();
  }
}

abstract class FaceCompareSuccess implements FaceCompareResult {
  const factory FaceCompareSuccess({required final double similarityPercent}) =
      _$FaceCompareSuccessImpl;

  double get similarityPercent;

  /// Create a copy of FaceCompareResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceCompareSuccessImplCopyWith<_$FaceCompareSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FaceCompareNoFaceImplCopyWith<$Res> {
  factory _$$FaceCompareNoFaceImplCopyWith(
    _$FaceCompareNoFaceImpl value,
    $Res Function(_$FaceCompareNoFaceImpl) then,
  ) = __$$FaceCompareNoFaceImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FaceCompareNoFaceImplCopyWithImpl<$Res>
    extends _$FaceCompareResultCopyWithImpl<$Res, _$FaceCompareNoFaceImpl>
    implements _$$FaceCompareNoFaceImplCopyWith<$Res> {
  __$$FaceCompareNoFaceImplCopyWithImpl(
    _$FaceCompareNoFaceImpl _value,
    $Res Function(_$FaceCompareNoFaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaceCompareResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FaceCompareNoFaceImpl implements FaceCompareNoFace {
  const _$FaceCompareNoFaceImpl();

  @override
  String toString() {
    return 'FaceCompareResult.noFace()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FaceCompareNoFaceImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double similarityPercent) success,
    required TResult Function() noFace,
    required TResult Function(String message) error,
  }) {
    return noFace();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double similarityPercent)? success,
    TResult? Function()? noFace,
    TResult? Function(String message)? error,
  }) {
    return noFace?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double similarityPercent)? success,
    TResult Function()? noFace,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (noFace != null) {
      return noFace();
    }
    return orElse();
  }
}

abstract class FaceCompareNoFace implements FaceCompareResult {
  const factory FaceCompareNoFace() = _$FaceCompareNoFaceImpl;
}

/// @nodoc
abstract class _$$FaceCompareErrorImplCopyWith<$Res> {
  factory _$$FaceCompareErrorImplCopyWith(
    _$FaceCompareErrorImpl value,
    $Res Function(_$FaceCompareErrorImpl) then,
  ) = __$$FaceCompareErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FaceCompareErrorImplCopyWithImpl<$Res>
    extends _$FaceCompareResultCopyWithImpl<$Res, _$FaceCompareErrorImpl>
    implements _$$FaceCompareErrorImplCopyWith<$Res> {
  __$$FaceCompareErrorImplCopyWithImpl(
    _$FaceCompareErrorImpl _value,
    $Res Function(_$FaceCompareErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaceCompareResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$FaceCompareErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FaceCompareErrorImpl implements FaceCompareError {
  const _$FaceCompareErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'FaceCompareResult.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceCompareErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of FaceCompareResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceCompareErrorImplCopyWith<_$FaceCompareErrorImpl> get copyWith =>
      __$$FaceCompareErrorImplCopyWithImpl<_$FaceCompareErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double similarityPercent) success,
    required TResult Function() noFace,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double similarityPercent)? success,
    TResult? Function()? noFace,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double similarityPercent)? success,
    TResult Function()? noFace,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }
}

abstract class FaceCompareError implements FaceCompareResult {
  const factory FaceCompareError({required final String message}) =
      _$FaceCompareErrorImpl;

  String get message;

  /// Create a copy of FaceCompareResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceCompareErrorImplCopyWith<_$FaceCompareErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FaceCompareUiState {
  String? get pathA => throw _privateConstructorUsedError;
  String? get pathB => throw _privateConstructorUsedError;
  bool get busy => throw _privateConstructorUsedError;
  FaceCompareResult? get result => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      String? pathA,
      String? pathB,
      bool busy,
      FaceCompareResult? result,
    )
    $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      String? pathA,
      String? pathB,
      bool busy,
      FaceCompareResult? result,
    )?
    $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      String? pathA,
      String? pathB,
      bool busy,
      FaceCompareResult? result,
    )?
    $default, {
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of FaceCompareUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaceCompareUiStateCopyWith<FaceCompareUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaceCompareUiStateCopyWith<$Res> {
  factory $FaceCompareUiStateCopyWith(
    FaceCompareUiState value,
    $Res Function(FaceCompareUiState) then,
  ) = _$FaceCompareUiStateCopyWithImpl<$Res, FaceCompareUiState>;
  @useResult
  $Res call({
    String? pathA,
    String? pathB,
    bool busy,
    FaceCompareResult? result,
  });

  $FaceCompareResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$FaceCompareUiStateCopyWithImpl<$Res, $Val extends FaceCompareUiState>
    implements $FaceCompareUiStateCopyWith<$Res> {
  _$FaceCompareUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaceCompareUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pathA = freezed,
    Object? pathB = freezed,
    Object? busy = null,
    Object? result = freezed,
  }) {
    return _then(
      _value.copyWith(
            pathA: freezed == pathA
                ? _value.pathA
                : pathA // ignore: cast_nullable_to_non_nullable
                      as String?,
            pathB: freezed == pathB
                ? _value.pathB
                : pathB // ignore: cast_nullable_to_non_nullable
                      as String?,
            busy: null == busy
                ? _value.busy
                : busy // ignore: cast_nullable_to_non_nullable
                      as bool,
            result: freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as FaceCompareResult?,
          )
          as $Val,
    );
  }

  /// Create a copy of FaceCompareUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FaceCompareResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $FaceCompareResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FaceCompareUiStateImplCopyWith<$Res>
    implements $FaceCompareUiStateCopyWith<$Res> {
  factory _$$FaceCompareUiStateImplCopyWith(
    _$FaceCompareUiStateImpl value,
    $Res Function(_$FaceCompareUiStateImpl) then,
  ) = __$$FaceCompareUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? pathA,
    String? pathB,
    bool busy,
    FaceCompareResult? result,
  });

  @override
  $FaceCompareResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$FaceCompareUiStateImplCopyWithImpl<$Res>
    extends _$FaceCompareUiStateCopyWithImpl<$Res, _$FaceCompareUiStateImpl>
    implements _$$FaceCompareUiStateImplCopyWith<$Res> {
  __$$FaceCompareUiStateImplCopyWithImpl(
    _$FaceCompareUiStateImpl _value,
    $Res Function(_$FaceCompareUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaceCompareUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pathA = freezed,
    Object? pathB = freezed,
    Object? busy = null,
    Object? result = freezed,
  }) {
    return _then(
      _$FaceCompareUiStateImpl(
        pathA: freezed == pathA
            ? _value.pathA
            : pathA // ignore: cast_nullable_to_non_nullable
                  as String?,
        pathB: freezed == pathB
            ? _value.pathB
            : pathB // ignore: cast_nullable_to_non_nullable
                  as String?,
        busy: null == busy
            ? _value.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        result: freezed == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as FaceCompareResult?,
      ),
    );
  }
}

/// @nodoc

class _$FaceCompareUiStateImpl implements _FaceCompareUiState {
  const _$FaceCompareUiStateImpl({
    this.pathA,
    this.pathB,
    this.busy = false,
    this.result,
  });

  @override
  final String? pathA;
  @override
  final String? pathB;
  @override
  @JsonKey()
  final bool busy;
  @override
  final FaceCompareResult? result;

  @override
  String toString() {
    return 'FaceCompareUiState(pathA: $pathA, pathB: $pathB, busy: $busy, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceCompareUiStateImpl &&
            (identical(other.pathA, pathA) || other.pathA == pathA) &&
            (identical(other.pathB, pathB) || other.pathB == pathB) &&
            (identical(other.busy, busy) || other.busy == busy) &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pathA, pathB, busy, result);

  /// Create a copy of FaceCompareUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceCompareUiStateImplCopyWith<_$FaceCompareUiStateImpl> get copyWith =>
      __$$FaceCompareUiStateImplCopyWithImpl<_$FaceCompareUiStateImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      String? pathA,
      String? pathB,
      bool busy,
      FaceCompareResult? result,
    )
    $default,
  ) {
    return $default(pathA, pathB, busy, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      String? pathA,
      String? pathB,
      bool busy,
      FaceCompareResult? result,
    )?
    $default,
  ) {
    return $default?.call(pathA, pathB, busy, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      String? pathA,
      String? pathB,
      bool busy,
      FaceCompareResult? result,
    )?
    $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(pathA, pathB, busy, result);
    }
    return orElse();
  }
}

abstract class _FaceCompareUiState implements FaceCompareUiState {
  const factory _FaceCompareUiState({
    final String? pathA,
    final String? pathB,
    final bool busy,
    final FaceCompareResult? result,
  }) = _$FaceCompareUiStateImpl;

  @override
  String? get pathA;
  @override
  String? get pathB;
  @override
  bool get busy;
  @override
  FaceCompareResult? get result;

  /// Create a copy of FaceCompareUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceCompareUiStateImplCopyWith<_$FaceCompareUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
