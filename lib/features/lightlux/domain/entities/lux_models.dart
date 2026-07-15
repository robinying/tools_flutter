import 'package:freezed_annotation/freezed_annotation.dart';

part 'lux_models.freezed.dart';

enum LuxScene {
  veryDark('Very dark / night'),
  dimIndoor('Dim indoor / night light'),
  indoor('Typical indoor'),
  brightIndoor('Bright indoor / office'),
  overcast('Overcast / bright room'),
  daylight('Daylight (shade)'),
  fullDaylight('Full daylight'),
  directSun('Direct sun');

  final String label;
  const LuxScene(this.label);

  static LuxScene fromLux(double lux) {
    final v = lux < 0 ? 0.0 : lux;
    if (v < 1) return LuxScene.veryDark;
    if (v < 50) return LuxScene.dimIndoor;
    if (v < 200) return LuxScene.indoor;
    if (v < 500) return LuxScene.brightIndoor;
    if (v < 2000) return LuxScene.overcast;
    if (v < 10000) return LuxScene.daylight;
    if (v < 25000) return LuxScene.fullDaylight;
    return LuxScene.directSun;
  }
}

enum ChartWindow {
  s15(15000, '15s'),
  s60(60000, '60s'),
  m5(300000, '5m');

  final int ms;
  final String label;
  const ChartWindow(this.ms, this.label);
}

@freezed
class ChartPoint with _$ChartPoint {
  const factory ChartPoint({required int t, required double lux}) = _ChartPoint;
}

@freezed
class ChartStats with _$ChartStats {
  const factory ChartStats({
    @Default(0) double min,
    @Default(0) double max,
    @Default(0) double avg,
    @Default(0) int n,
  }) = _ChartStats;

  factory ChartStats.fromPoints(List<ChartPoint> pts) {
    if (pts.isEmpty) return const ChartStats();
    final vs = pts.map((e) => e.lux).toList();
    final sum = vs.fold<double>(0, (a, b) => a + b);
    return ChartStats(
      min: vs.reduce((a, b) => a < b ? a : b),
      max: vs.reduce((a, b) => a > b ? a : b),
      avg: sum / vs.length,
      n: vs.length,
    );
  }
}

@freezed
class Snapshot with _$Snapshot {
  const factory Snapshot({
    int? id,
    required int timestamp,
    required double lux,
    @Default('') String note,
  }) = _Snapshot;
}

@freezed
sealed class LightMeterUiState with _$LightMeterUiState {
  const factory LightMeterUiState.loading() = LightMeterLoading;

  const factory LightMeterUiState.unavailable({String? error}) =
      LightMeterUnavailable;

  const factory LightMeterUiState.ready({
    @Default(0) double lux,
    @Default([]) List<ChartPoint> buffer,
    @Default(ChartWindow.s60) ChartWindow window,
    String? streamError,
  }) = LightMeterReady;
}
