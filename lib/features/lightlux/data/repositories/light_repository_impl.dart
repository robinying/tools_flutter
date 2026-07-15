import 'package:flutter/services.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/lux_models.dart';
import '../../domain/repositories/light_repository.dart';
import '../datasources/light_sensor_datasource.dart';
import '../datasources/snapshot_local_datasource.dart';

class LightRepositoryImpl implements LightRepository {
  LightRepositoryImpl(this._sensor, this._snapshots);

  final LightSensorDatasource _sensor;
  final SnapshotLocalDatasource _snapshots;

  @override
  Future<Result<bool>> isSensorAvailable() async {
    try {
      return Result.success(await _sensor.available());
    } on PlatformException catch (e) {
      return Result.failure(
        AppFailure.platform(message: e.message ?? e.code, code: e.code),
      );
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }

  @override
  Stream<double> watchLux() => _sensor.luxStream();

  @override
  Future<Result<void>> saveSnapshot(Snapshot snapshot) async {
    try {
      await _snapshots.insert(snapshot);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Result<List<Snapshot>>> loadSnapshots() async {
    try {
      return Result.success(await _snapshots.all());
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteSnapshot(int id) async {
    try {
      await _snapshots.delete(id);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteAllSnapshots() async {
    try {
      await _snapshots.deleteAll();
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AppFailure.unknown(message: e.toString()));
    }
  }
}
