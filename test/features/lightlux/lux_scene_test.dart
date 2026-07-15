import 'package:flutter_test/flutter_test.dart';
import 'package:tools_flutter/features/lightlux/domain/entities/lux_models.dart';

void main() {
  test('LuxScene thresholds', () {
    expect(LuxScene.fromLux(0.5), LuxScene.veryDark);
    expect(LuxScene.fromLux(30), LuxScene.dimIndoor);
    expect(LuxScene.fromLux(100), LuxScene.indoor);
    expect(LuxScene.fromLux(30000), LuxScene.directSun);
  });

  test('ChartStats.fromPoints', () {
    final s = ChartStats.fromPoints([
      const ChartPoint(t: 1, lux: 10),
      const ChartPoint(t: 2, lux: 20),
    ]);
    expect(s.min, 10);
    expect(s.max, 20);
    expect(s.avg, 15);
    expect(s.n, 2);
  });
}
