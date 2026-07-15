import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/light_sensor_datasource.dart';
import '../../data/datasources/snapshot_local_datasource.dart';
import '../../data/repositories/light_repository_impl.dart';
import '../../domain/entities/lux_models.dart';
import '../../domain/repositories/light_repository.dart';

final lightRepositoryProvider = Provider<LightRepository>((ref) {
  return LightRepositoryImpl(
    LightSensorDatasource(),
    SnapshotLocalDatasource(),
  );
});

final lightMeterProvider =
    StateNotifierProvider.autoDispose<LightMeterNotifier, LightMeterUiState>(
  (ref) => LightMeterNotifier(ref.watch(lightRepositoryProvider)),
);

final snapshotListProvider =
    StateNotifierProvider.autoDispose<SnapshotListNotifier, AsyncValue<List<Snapshot>>>(
  (ref) => SnapshotListNotifier(ref.watch(lightRepositoryProvider)),
);

class LightMeterNotifier extends StateNotifier<LightMeterUiState> {
  LightMeterNotifier(this._repo) : super(const LightMeterUiState.loading()) {
    _init();
  }

  final LightRepository _repo;
  StreamSubscription<double>? _sub;
  final List<ChartPoint> _buffer = [];
  ChartWindow _window = ChartWindow.s60;
  double _lux = 0;
  int _lastUi = 0;

  Future<void> _init() async {
    final avail = await _repo.isSensorAvailable();
    await avail.fold(
      onSuccess: (ok) async {
        if (!ok) {
          state = const LightMeterUiState.unavailable();
          return;
        }
        state = LightMeterUiState.ready(lux: 0, buffer: const [], window: _window);
        _sub = _repo.watchLux().listen(
          _onLux,
          onError: (e) {
            final cur = state;
            if (cur is LightMeterReady) {
              state = cur.copyWith(streamError: e.toString());
            }
          },
        );
      },
      onFailure: (f) {
        state = LightMeterUiState.unavailable(error: f.displayMessage);
      },
    );
  }

  void _onLux(double v) {
    final now = DateTime.now().millisecondsSinceEpoch;
    _buffer.add(ChartPoint(t: now, lux: v));
    _buffer.removeWhere((p) => now - p.t > 300000);
    _lux = v;
    if (now - _lastUi < 120) return;
    _lastUi = now;
    state = LightMeterUiState.ready(
      lux: _lux,
      buffer: List.unmodifiable(_buffer),
      window: _window,
    );
  }

  void setWindow(ChartWindow w) {
    _window = w;
    final cur = state;
    if (cur is LightMeterReady) {
      state = cur.copyWith(window: w);
    }
  }

  Future<ResultSave> saveSnapshot(String note) async {
    final r = await _repo.saveSnapshot(
      Snapshot(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        lux: _lux,
        note: note.trim(),
      ),
    );
    return r.fold(
      onSuccess: (_) => ResultSave.ok(_lux, note.trim()),
      onFailure: (f) => ResultSave.err(f.displayMessage),
    );
  }

  List<ChartPoint> visiblePoints() {
    final now = DateTime.now().millisecondsSinceEpoch;
    return _buffer.where((p) => now - p.t <= _window.ms).toList();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

class ResultSave {
  final bool success;
  final double? lux;
  final String? note;
  final String? error;
  ResultSave.ok(this.lux, this.note)
      : success = true,
        error = null;
  ResultSave.err(this.error)
      : success = false,
        lux = null,
        note = null;
}

class SnapshotListNotifier extends StateNotifier<AsyncValue<List<Snapshot>>> {
  SnapshotListNotifier(this._repo) : super(const AsyncValue.loading()) {
    reload();
  }

  final LightRepository _repo;

  Future<void> reload() async {
    state = const AsyncValue.loading();
    final r = await _repo.loadSnapshots();
    r.fold(
      onSuccess: (list) => state = AsyncValue.data(list),
      onFailure: (f) => state = AsyncValue.error(f.displayMessage, StackTrace.current),
    );
  }

  Future<void> delete(int id) async {
    await _repo.deleteSnapshot(id);
    await reload();
  }

  Future<void> deleteAll() async {
    await _repo.deleteAllSnapshots();
    await reload();
  }
}
