// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lux_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChartPoint {
  int get t => throw _privateConstructorUsedError;
  double get lux => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int t, double lux) $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int t, double lux)? $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int t, double lux)? $default, {
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartPointCopyWith<ChartPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartPointCopyWith<$Res> {
  factory $ChartPointCopyWith(
    ChartPoint value,
    $Res Function(ChartPoint) then,
  ) = _$ChartPointCopyWithImpl<$Res, ChartPoint>;
  @useResult
  $Res call({int t, double lux});
}

/// @nodoc
class _$ChartPointCopyWithImpl<$Res, $Val extends ChartPoint>
    implements $ChartPointCopyWith<$Res> {
  _$ChartPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? t = null, Object? lux = null}) {
    return _then(
      _value.copyWith(
            t: null == t
                ? _value.t
                : t // ignore: cast_nullable_to_non_nullable
                      as int,
            lux: null == lux
                ? _value.lux
                : lux // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChartPointImplCopyWith<$Res>
    implements $ChartPointCopyWith<$Res> {
  factory _$$ChartPointImplCopyWith(
    _$ChartPointImpl value,
    $Res Function(_$ChartPointImpl) then,
  ) = __$$ChartPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int t, double lux});
}

/// @nodoc
class __$$ChartPointImplCopyWithImpl<$Res>
    extends _$ChartPointCopyWithImpl<$Res, _$ChartPointImpl>
    implements _$$ChartPointImplCopyWith<$Res> {
  __$$ChartPointImplCopyWithImpl(
    _$ChartPointImpl _value,
    $Res Function(_$ChartPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? t = null, Object? lux = null}) {
    return _then(
      _$ChartPointImpl(
        t: null == t
            ? _value.t
            : t // ignore: cast_nullable_to_non_nullable
                  as int,
        lux: null == lux
            ? _value.lux
            : lux // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$ChartPointImpl implements _ChartPoint {
  const _$ChartPointImpl({required this.t, required this.lux});

  @override
  final int t;
  @override
  final double lux;

  @override
  String toString() {
    return 'ChartPoint(t: $t, lux: $lux)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartPointImpl &&
            (identical(other.t, t) || other.t == t) &&
            (identical(other.lux, lux) || other.lux == lux));
  }

  @override
  int get hashCode => Object.hash(runtimeType, t, lux);

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartPointImplCopyWith<_$ChartPointImpl> get copyWith =>
      __$$ChartPointImplCopyWithImpl<_$ChartPointImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int t, double lux) $default,
  ) {
    return $default(t, lux);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int t, double lux)? $default,
  ) {
    return $default?.call(t, lux);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int t, double lux)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(t, lux);
    }
    return orElse();
  }
}

abstract class _ChartPoint implements ChartPoint {
  const factory _ChartPoint({required final int t, required final double lux}) =
      _$ChartPointImpl;

  @override
  int get t;
  @override
  double get lux;

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartPointImplCopyWith<_$ChartPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChartStats {
  double get min => throw _privateConstructorUsedError;
  double get max => throw _privateConstructorUsedError;
  double get avg => throw _privateConstructorUsedError;
  int get n => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(double min, double max, double avg, int n) $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(double min, double max, double avg, int n)? $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(double min, double max, double avg, int n)? $default, {
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ChartStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartStatsCopyWith<ChartStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartStatsCopyWith<$Res> {
  factory $ChartStatsCopyWith(
    ChartStats value,
    $Res Function(ChartStats) then,
  ) = _$ChartStatsCopyWithImpl<$Res, ChartStats>;
  @useResult
  $Res call({double min, double max, double avg, int n});
}

/// @nodoc
class _$ChartStatsCopyWithImpl<$Res, $Val extends ChartStats>
    implements $ChartStatsCopyWith<$Res> {
  _$ChartStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? avg = null,
    Object? n = null,
  }) {
    return _then(
      _value.copyWith(
            min: null == min
                ? _value.min
                : min // ignore: cast_nullable_to_non_nullable
                      as double,
            max: null == max
                ? _value.max
                : max // ignore: cast_nullable_to_non_nullable
                      as double,
            avg: null == avg
                ? _value.avg
                : avg // ignore: cast_nullable_to_non_nullable
                      as double,
            n: null == n
                ? _value.n
                : n // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChartStatsImplCopyWith<$Res>
    implements $ChartStatsCopyWith<$Res> {
  factory _$$ChartStatsImplCopyWith(
    _$ChartStatsImpl value,
    $Res Function(_$ChartStatsImpl) then,
  ) = __$$ChartStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double min, double max, double avg, int n});
}

/// @nodoc
class __$$ChartStatsImplCopyWithImpl<$Res>
    extends _$ChartStatsCopyWithImpl<$Res, _$ChartStatsImpl>
    implements _$$ChartStatsImplCopyWith<$Res> {
  __$$ChartStatsImplCopyWithImpl(
    _$ChartStatsImpl _value,
    $Res Function(_$ChartStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? avg = null,
    Object? n = null,
  }) {
    return _then(
      _$ChartStatsImpl(
        min: null == min
            ? _value.min
            : min // ignore: cast_nullable_to_non_nullable
                  as double,
        max: null == max
            ? _value.max
            : max // ignore: cast_nullable_to_non_nullable
                  as double,
        avg: null == avg
            ? _value.avg
            : avg // ignore: cast_nullable_to_non_nullable
                  as double,
        n: null == n
            ? _value.n
            : n // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ChartStatsImpl implements _ChartStats {
  const _$ChartStatsImpl({
    this.min = 0,
    this.max = 0,
    this.avg = 0,
    this.n = 0,
  });

  @override
  @JsonKey()
  final double min;
  @override
  @JsonKey()
  final double max;
  @override
  @JsonKey()
  final double avg;
  @override
  @JsonKey()
  final int n;

  @override
  String toString() {
    return 'ChartStats(min: $min, max: $max, avg: $avg, n: $n)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartStatsImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.avg, avg) || other.avg == avg) &&
            (identical(other.n, n) || other.n == n));
  }

  @override
  int get hashCode => Object.hash(runtimeType, min, max, avg, n);

  /// Create a copy of ChartStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartStatsImplCopyWith<_$ChartStatsImpl> get copyWith =>
      __$$ChartStatsImplCopyWithImpl<_$ChartStatsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(double min, double max, double avg, int n) $default,
  ) {
    return $default(min, max, avg, n);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(double min, double max, double avg, int n)? $default,
  ) {
    return $default?.call(min, max, avg, n);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(double min, double max, double avg, int n)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(min, max, avg, n);
    }
    return orElse();
  }
}

abstract class _ChartStats implements ChartStats {
  const factory _ChartStats({
    final double min,
    final double max,
    final double avg,
    final int n,
  }) = _$ChartStatsImpl;

  @override
  double get min;
  @override
  double get max;
  @override
  double get avg;
  @override
  int get n;

  /// Create a copy of ChartStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartStatsImplCopyWith<_$ChartStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Snapshot {
  int? get id => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  double get lux => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? id, int timestamp, double lux, String note) $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? id, int timestamp, double lux, String note)?
    $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? id, int timestamp, double lux, String note)?
    $default, {
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of Snapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnapshotCopyWith<Snapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnapshotCopyWith<$Res> {
  factory $SnapshotCopyWith(Snapshot value, $Res Function(Snapshot) then) =
      _$SnapshotCopyWithImpl<$Res, Snapshot>;
  @useResult
  $Res call({int? id, int timestamp, double lux, String note});
}

/// @nodoc
class _$SnapshotCopyWithImpl<$Res, $Val extends Snapshot>
    implements $SnapshotCopyWith<$Res> {
  _$SnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Snapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? timestamp = null,
    Object? lux = null,
    Object? note = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as int,
            lux: null == lux
                ? _value.lux
                : lux // ignore: cast_nullable_to_non_nullable
                      as double,
            note: null == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SnapshotImplCopyWith<$Res>
    implements $SnapshotCopyWith<$Res> {
  factory _$$SnapshotImplCopyWith(
    _$SnapshotImpl value,
    $Res Function(_$SnapshotImpl) then,
  ) = __$$SnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, int timestamp, double lux, String note});
}

/// @nodoc
class __$$SnapshotImplCopyWithImpl<$Res>
    extends _$SnapshotCopyWithImpl<$Res, _$SnapshotImpl>
    implements _$$SnapshotImplCopyWith<$Res> {
  __$$SnapshotImplCopyWithImpl(
    _$SnapshotImpl _value,
    $Res Function(_$SnapshotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Snapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? timestamp = null,
    Object? lux = null,
    Object? note = null,
  }) {
    return _then(
      _$SnapshotImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int,
        lux: null == lux
            ? _value.lux
            : lux // ignore: cast_nullable_to_non_nullable
                  as double,
        note: null == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SnapshotImpl implements _Snapshot {
  const _$SnapshotImpl({
    this.id,
    required this.timestamp,
    required this.lux,
    this.note = '',
  });

  @override
  final int? id;
  @override
  final int timestamp;
  @override
  final double lux;
  @override
  @JsonKey()
  final String note;

  @override
  String toString() {
    return 'Snapshot(id: $id, timestamp: $timestamp, lux: $lux, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnapshotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.lux, lux) || other.lux == lux) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, timestamp, lux, note);

  /// Create a copy of Snapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnapshotImplCopyWith<_$SnapshotImpl> get copyWith =>
      __$$SnapshotImplCopyWithImpl<_$SnapshotImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? id, int timestamp, double lux, String note) $default,
  ) {
    return $default(id, timestamp, lux, note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? id, int timestamp, double lux, String note)?
    $default,
  ) {
    return $default?.call(id, timestamp, lux, note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? id, int timestamp, double lux, String note)?
    $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, timestamp, lux, note);
    }
    return orElse();
  }
}

abstract class _Snapshot implements Snapshot {
  const factory _Snapshot({
    final int? id,
    required final int timestamp,
    required final double lux,
    final String note,
  }) = _$SnapshotImpl;

  @override
  int? get id;
  @override
  int get timestamp;
  @override
  double get lux;
  @override
  String get note;

  /// Create a copy of Snapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnapshotImplCopyWith<_$SnapshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LightMeterUiState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String? error) unavailable,
    required TResult Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )
    ready,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String? error)? unavailable,
    TResult? Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )?
    ready,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String? error)? unavailable,
    TResult Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )?
    ready,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LightMeterUiStateCopyWith<$Res> {
  factory $LightMeterUiStateCopyWith(
    LightMeterUiState value,
    $Res Function(LightMeterUiState) then,
  ) = _$LightMeterUiStateCopyWithImpl<$Res, LightMeterUiState>;
}

/// @nodoc
class _$LightMeterUiStateCopyWithImpl<$Res, $Val extends LightMeterUiState>
    implements $LightMeterUiStateCopyWith<$Res> {
  _$LightMeterUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LightMeterUiState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LightMeterLoadingImplCopyWith<$Res> {
  factory _$$LightMeterLoadingImplCopyWith(
    _$LightMeterLoadingImpl value,
    $Res Function(_$LightMeterLoadingImpl) then,
  ) = __$$LightMeterLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LightMeterLoadingImplCopyWithImpl<$Res>
    extends _$LightMeterUiStateCopyWithImpl<$Res, _$LightMeterLoadingImpl>
    implements _$$LightMeterLoadingImplCopyWith<$Res> {
  __$$LightMeterLoadingImplCopyWithImpl(
    _$LightMeterLoadingImpl _value,
    $Res Function(_$LightMeterLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LightMeterUiState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LightMeterLoadingImpl implements LightMeterLoading {
  const _$LightMeterLoadingImpl();

  @override
  String toString() {
    return 'LightMeterUiState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LightMeterLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String? error) unavailable,
    required TResult Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )
    ready,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String? error)? unavailable,
    TResult? Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )?
    ready,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String? error)? unavailable,
    TResult Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )?
    ready,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }
}

abstract class LightMeterLoading implements LightMeterUiState {
  const factory LightMeterLoading() = _$LightMeterLoadingImpl;
}

/// @nodoc
abstract class _$$LightMeterUnavailableImplCopyWith<$Res> {
  factory _$$LightMeterUnavailableImplCopyWith(
    _$LightMeterUnavailableImpl value,
    $Res Function(_$LightMeterUnavailableImpl) then,
  ) = __$$LightMeterUnavailableImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? error});
}

/// @nodoc
class __$$LightMeterUnavailableImplCopyWithImpl<$Res>
    extends _$LightMeterUiStateCopyWithImpl<$Res, _$LightMeterUnavailableImpl>
    implements _$$LightMeterUnavailableImplCopyWith<$Res> {
  __$$LightMeterUnavailableImplCopyWithImpl(
    _$LightMeterUnavailableImpl _value,
    $Res Function(_$LightMeterUnavailableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LightMeterUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = freezed}) {
    return _then(
      _$LightMeterUnavailableImpl(
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LightMeterUnavailableImpl implements LightMeterUnavailable {
  const _$LightMeterUnavailableImpl({this.error});

  @override
  final String? error;

  @override
  String toString() {
    return 'LightMeterUiState.unavailable(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LightMeterUnavailableImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of LightMeterUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LightMeterUnavailableImplCopyWith<_$LightMeterUnavailableImpl>
  get copyWith =>
      __$$LightMeterUnavailableImplCopyWithImpl<_$LightMeterUnavailableImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String? error) unavailable,
    required TResult Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )
    ready,
  }) {
    return unavailable(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String? error)? unavailable,
    TResult? Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )?
    ready,
  }) {
    return unavailable?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String? error)? unavailable,
    TResult Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )?
    ready,
    required TResult orElse(),
  }) {
    if (unavailable != null) {
      return unavailable(error);
    }
    return orElse();
  }
}

abstract class LightMeterUnavailable implements LightMeterUiState {
  const factory LightMeterUnavailable({final String? error}) =
      _$LightMeterUnavailableImpl;

  String? get error;

  /// Create a copy of LightMeterUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LightMeterUnavailableImplCopyWith<_$LightMeterUnavailableImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LightMeterReadyImplCopyWith<$Res> {
  factory _$$LightMeterReadyImplCopyWith(
    _$LightMeterReadyImpl value,
    $Res Function(_$LightMeterReadyImpl) then,
  ) = __$$LightMeterReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    double lux,
    List<ChartPoint> buffer,
    ChartWindow window,
    String? streamError,
  });
}

/// @nodoc
class __$$LightMeterReadyImplCopyWithImpl<$Res>
    extends _$LightMeterUiStateCopyWithImpl<$Res, _$LightMeterReadyImpl>
    implements _$$LightMeterReadyImplCopyWith<$Res> {
  __$$LightMeterReadyImplCopyWithImpl(
    _$LightMeterReadyImpl _value,
    $Res Function(_$LightMeterReadyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LightMeterUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lux = null,
    Object? buffer = null,
    Object? window = null,
    Object? streamError = freezed,
  }) {
    return _then(
      _$LightMeterReadyImpl(
        lux: null == lux
            ? _value.lux
            : lux // ignore: cast_nullable_to_non_nullable
                  as double,
        buffer: null == buffer
            ? _value._buffer
            : buffer // ignore: cast_nullable_to_non_nullable
                  as List<ChartPoint>,
        window: null == window
            ? _value.window
            : window // ignore: cast_nullable_to_non_nullable
                  as ChartWindow,
        streamError: freezed == streamError
            ? _value.streamError
            : streamError // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LightMeterReadyImpl implements LightMeterReady {
  const _$LightMeterReadyImpl({
    this.lux = 0,
    final List<ChartPoint> buffer = const [],
    this.window = ChartWindow.s60,
    this.streamError,
  }) : _buffer = buffer;

  @override
  @JsonKey()
  final double lux;
  final List<ChartPoint> _buffer;
  @override
  @JsonKey()
  List<ChartPoint> get buffer {
    if (_buffer is EqualUnmodifiableListView) return _buffer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buffer);
  }

  @override
  @JsonKey()
  final ChartWindow window;
  @override
  final String? streamError;

  @override
  String toString() {
    return 'LightMeterUiState.ready(lux: $lux, buffer: $buffer, window: $window, streamError: $streamError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LightMeterReadyImpl &&
            (identical(other.lux, lux) || other.lux == lux) &&
            const DeepCollectionEquality().equals(other._buffer, _buffer) &&
            (identical(other.window, window) || other.window == window) &&
            (identical(other.streamError, streamError) ||
                other.streamError == streamError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    lux,
    const DeepCollectionEquality().hash(_buffer),
    window,
    streamError,
  );

  /// Create a copy of LightMeterUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LightMeterReadyImplCopyWith<_$LightMeterReadyImpl> get copyWith =>
      __$$LightMeterReadyImplCopyWithImpl<_$LightMeterReadyImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String? error) unavailable,
    required TResult Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )
    ready,
  }) {
    return ready(lux, buffer, window, streamError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String? error)? unavailable,
    TResult? Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )?
    ready,
  }) {
    return ready?.call(lux, buffer, window, streamError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String? error)? unavailable,
    TResult Function(
      double lux,
      List<ChartPoint> buffer,
      ChartWindow window,
      String? streamError,
    )?
    ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(lux, buffer, window, streamError);
    }
    return orElse();
  }
}

abstract class LightMeterReady implements LightMeterUiState {
  const factory LightMeterReady({
    final double lux,
    final List<ChartPoint> buffer,
    final ChartWindow window,
    final String? streamError,
  }) = _$LightMeterReadyImpl;

  double get lux;
  List<ChartPoint> get buffer;
  ChartWindow get window;
  String? get streamError;

  /// Create a copy of LightMeterUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LightMeterReadyImplCopyWith<_$LightMeterReadyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
