import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repositories/face_repository_impl.dart';
import '../../domain/entities/face_compare_result.dart';
import '../../domain/repositories/face_repository.dart';

final faceRepositoryProvider = Provider<FaceRepository>((ref) {
  final repo = FaceRepositoryImpl();
  ref.onDispose(() => repo.dispose());
  return repo;
});

final faceCompareProvider =
    StateNotifierProvider.autoDispose<FaceCompareNotifier, FaceCompareUiState>(
  (ref) => FaceCompareNotifier(ref.watch(faceRepositoryProvider)),
);

class FaceCompareNotifier extends StateNotifier<FaceCompareUiState> {
  FaceCompareNotifier(this._repo) : super(const FaceCompareUiState());

  final FaceRepository _repo;
  final _picker = ImagePicker();

  Future<void> pickA() async {
    final x = await _picker.pickImage(source: ImageSource.gallery);
    if (x == null) return;
    state = state.copyWith(pathA: x.path, result: null);
  }

  Future<void> pickB() async {
    final x = await _picker.pickImage(source: ImageSource.gallery);
    if (x == null) return;
    state = state.copyWith(pathB: x.path, result: null);
  }

  Future<void> compare() async {
    final a = state.pathA;
    final b = state.pathB;
    if (a == null || b == null) return;
    state = state.copyWith(busy: true, result: null);
    final result = await _repo.compare(a, b);
    state = state.copyWith(busy: false, result: result);
  }
}
