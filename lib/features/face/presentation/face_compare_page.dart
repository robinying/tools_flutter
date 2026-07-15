import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';

class FaceComparePage extends StatefulWidget {
  const FaceComparePage({super.key});
  @override
  State<FaceComparePage> createState() => _FaceComparePageState();
}

class _FaceComparePageState extends State<FaceComparePage> {
  final _picker = ImagePicker();
  final _detector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.accurate,
      enableLandmarks: true,
    ),
  );
  String? _pathA;
  String? _pathB;
  String? _result;
  bool _busy = false;

  Future<void> _pick(bool a) async {
    final x = await _picker.pickImage(source: ImageSource.gallery);
    if (x == null) return;
    setState(() {
      if (a) _pathA = x.path;
      else _pathB = x.path;
      _result = null;
    });
  }

  Future<List<double>?> _embedding(String path) async {
    final input = InputImage.fromFilePath(path);
    final faces = await _detector.processImage(input);
    if (faces.isEmpty) return null;
    final f = faces.first;
    final box = f.boundingBox;
    // Geometry feature vector (normalized) — works without TFLite model
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

  Future<void> _compare() async {
    if (_pathA == null || _pathB == null) return;
    setState(() {
      _busy = true;
      _result = null;
    });
    try {
      final ea = await _embedding(_pathA!);
      final eb = await _embedding(_pathB!);
      if (ea == null || eb == null) {
        setState(() => _result = 'Face not detected in one or both images');
        return;
      }
      final sim = _cosine(ea, eb);
      final pct = (sim * 100).clamp(0, 100);
      setState(() => _result = 'Similarity: ${pct.toStringAsFixed(1)}% (landmark geometry)');
    } catch (e) {
      setState(() => _result = '$e');
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    _detector.close();
    super.dispose();
  }

  Widget _thumb(String? path, String label, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: path == null
              ? Center(child: Text(label))
              : Image.file(File(path), fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Compare')),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          children: [
            Row(
              children: [
                _thumb(_pathA, 'Photo A', () => _pick(true)),
                const SizedBox(width: AppDimens.md),
                _thumb(_pathB, 'Photo B', () => _pick(false)),
              ],
            ),
            const SizedBox(height: AppDimens.lg),
            FilledButton(
              onPressed: _busy || _pathA == null || _pathB == null ? null : _compare,
              child: Text(_busy ? 'Comparing…' : 'Compare'),
            ),
            const SizedBox(height: AppDimens.lg),
            if (_result != null)
              Text(_result!, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
