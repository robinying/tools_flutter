// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ebook_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EbookUiState {
  String? get path => throw _privateConstructorUsedError;
  bool get busy => throw _privateConstructorUsedError;
  String? get lastMessage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String? path, bool busy, String? lastMessage) $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? path, bool busy, String? lastMessage)? $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? path, bool busy, String? lastMessage)? $default, {
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of EbookUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EbookUiStateCopyWith<EbookUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EbookUiStateCopyWith<$Res> {
  factory $EbookUiStateCopyWith(
    EbookUiState value,
    $Res Function(EbookUiState) then,
  ) = _$EbookUiStateCopyWithImpl<$Res, EbookUiState>;
  @useResult
  $Res call({String? path, bool busy, String? lastMessage});
}

/// @nodoc
class _$EbookUiStateCopyWithImpl<$Res, $Val extends EbookUiState>
    implements $EbookUiStateCopyWith<$Res> {
  _$EbookUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EbookUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = freezed,
    Object? busy = null,
    Object? lastMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            path: freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String?,
            busy: null == busy
                ? _value.busy
                : busy // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastMessage: freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EbookUiStateImplCopyWith<$Res>
    implements $EbookUiStateCopyWith<$Res> {
  factory _$$EbookUiStateImplCopyWith(
    _$EbookUiStateImpl value,
    $Res Function(_$EbookUiStateImpl) then,
  ) = __$$EbookUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? path, bool busy, String? lastMessage});
}

/// @nodoc
class __$$EbookUiStateImplCopyWithImpl<$Res>
    extends _$EbookUiStateCopyWithImpl<$Res, _$EbookUiStateImpl>
    implements _$$EbookUiStateImplCopyWith<$Res> {
  __$$EbookUiStateImplCopyWithImpl(
    _$EbookUiStateImpl _value,
    $Res Function(_$EbookUiStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EbookUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = freezed,
    Object? busy = null,
    Object? lastMessage = freezed,
  }) {
    return _then(
      _$EbookUiStateImpl(
        path: freezed == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String?,
        busy: null == busy
            ? _value.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastMessage: freezed == lastMessage
            ? _value.lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$EbookUiStateImpl implements _EbookUiState {
  const _$EbookUiStateImpl({this.path, this.busy = false, this.lastMessage});

  @override
  final String? path;
  @override
  @JsonKey()
  final bool busy;
  @override
  final String? lastMessage;

  @override
  String toString() {
    return 'EbookUiState(path: $path, busy: $busy, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EbookUiStateImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.busy, busy) || other.busy == busy) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, busy, lastMessage);

  /// Create a copy of EbookUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EbookUiStateImplCopyWith<_$EbookUiStateImpl> get copyWith =>
      __$$EbookUiStateImplCopyWithImpl<_$EbookUiStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String? path, bool busy, String? lastMessage) $default,
  ) {
    return $default(path, busy, lastMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? path, bool busy, String? lastMessage)? $default,
  ) {
    return $default?.call(path, busy, lastMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? path, bool busy, String? lastMessage)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(path, busy, lastMessage);
    }
    return orElse();
  }
}

abstract class _EbookUiState implements EbookUiState {
  const factory _EbookUiState({
    final String? path,
    final bool busy,
    final String? lastMessage,
  }) = _$EbookUiStateImpl;

  @override
  String? get path;
  @override
  bool get busy;
  @override
  String? get lastMessage;

  /// Create a copy of EbookUiState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EbookUiStateImplCopyWith<_$EbookUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
