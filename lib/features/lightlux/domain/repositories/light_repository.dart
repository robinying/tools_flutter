import '../../../../core/error/error.dart';
import '../entities/lux_models.dart';

abstract class LightRepository {
  Future<Result<bool>> isSensorAvailable();
  Stream<double> watchLux();
  Future<Result<void>> saveSnapshot(Snapshot snapshot);
  Future<Result<List<Snapshot>>> loadSnapshots();
  Future<Result<void>> deleteSnapshot(int id);
  Future<Result<void>> deleteAllSnapshots();
}
