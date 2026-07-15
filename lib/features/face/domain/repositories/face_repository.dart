import '../entities/face_compare_result.dart';

abstract class FaceRepository {
  Future<FaceCompareResult> compare(String pathA, String pathB);
  Future<void> dispose();
}
