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

class ChartPoint {
  final int t;
  final double lux;
  ChartPoint(this.t, this.lux);
}

class ChartStats {
  final double min, max, avg;
  final int n;
  const ChartStats({this.min = 0, this.max = 0, this.avg = 0, this.n = 0});
  factory ChartStats.from(List<ChartPoint> pts) {
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

enum ChartWindow {
  s15(15000, '15s'),
  s60(60000, '60s'),
  m5(300000, '5m');
  final int ms;
  final String label;
  const ChartWindow(this.ms, this.label);
}
