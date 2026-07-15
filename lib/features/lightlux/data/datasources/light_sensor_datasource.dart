import '../../../../core/platform/native_bridge.dart';

class LightSensorDatasource {
  Future<bool> available() => NativeBridge.lightSensorAvailable();
  Stream<double> luxStream() => NativeBridge.lightSensorStream();
}
