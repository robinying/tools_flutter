import 'dart:math' as math;

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../domain/entities/face_compare_result.dart';
import '../../domain/repositories/face_repository.dart';

class FaceRepositoryImpl implements FaceRepository {
  FaceRepositoryImpl()
      : _detector = FaceDetector(
          options: FaceDetectorOptions(
            performanceMode: FaceDetectorMode.accurate,
            enableLandmarks: true,
          ),
        );

  final FaceDetector _detector;

  Future<List<double>?> _embedding(String path) async {
    final input = InputImage.fromFilePath(path);
    final faces = await _detector.processImage(input);
    if (faces.isEmpty) return null;
    final f = faces.first;
    final box = f.boundingBox;
    final w = box.width == 0 ? 1.0 : box.width;
    final h = box.height == 0 ? 1.0 : box.height;
    double lx(FaceLandmarkType t) {
      final lm = f.landmarks[t]?.position;
      if (lm == null) return 0.5;
      return ((lm.x - box.left) / w).clamp(0.0, 1.0);
    }

    double ly(FaceLandmarkType t) {
      final lm = f.landmarks[t]?.position;
      if (lm == null) return 0.5;
      return ((lm.y - box.top) / h).clamp(0.0, 1.0);
    }

    return [
      box.width / (box.width + box.height),
      f.headEulerAngleY ?? 0,
      f.headEulerAngleZ ?? 0,
      lx(FaceLandmarkType.leftEye),
      ly(FaceLandmarkType.leftEye),
      lx(FaceLandmarkType.rightEye),
      ly(FaceLandmarkType.rightEye),
      lx(FaceLandmarkType.noseBase),
      ly(FaceLandmarkType.noseBase),
      lx(FaceLandmarkType.leftMouth),
      ly(FaceLandmarkType.leftMouth),
      lx(FaceLandmarkType.rightMouth),
      ly(FaceLandmarkType.rightMouth),
    ];
  }

  double _cosine(List<double> a, List<double> b) {
    var dot = 0.0, na = 0.0, nb = 0.0;
    final n = math.min(a.length, b.length);
    for (var i = 0; i < n; i++) {
      dot += a[i] * b[i];
      na += a[i] * a[i];
      nb += b[i] * b[i];
    }
    if (na == 0 || nb == 0) return 0;
    return dot / (math.sqrt(na) * math.sqrt(nb));
  }

  @override
  Future<FaceCompareResult> compare(String pathA, String pathB) async {
    try {
      final ea = await _embedding(pathA);
      final eb = await _embedding(pathB);
      if (ea == null || eb == null) {
        return const FaceCompareResult.noFace();
      }
      final sim = _cosine(ea, eb);
      final pct = (sim * 100).clamp(0.0, 100.0);
      return FaceCompareResult.success(similarityPercent: pct);
    } catch (e) {
      return FaceCompareResult.error(message: e.toString());
    }
  }

  @override
  Future<void> dispose() => _detector.close();
}
