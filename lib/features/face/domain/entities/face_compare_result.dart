import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_compare_result.freezed.dart';

@freezed
sealed class FaceCompareResult with _$FaceCompareResult {
  const factory FaceCompareResult.success({
    required double similarityPercent,
  }) = FaceCompareSuccess;

  const factory FaceCompareResult.noFace() = FaceCompareNoFace;

  const factory FaceCompareResult.error({required String message}) =
      FaceCompareError;
}

@freezed
sealed class FaceCompareUiState with _$FaceCompareUiState {
  const factory FaceCompareUiState({
    String? pathA,
    String? pathB,
    @Default(false) bool busy,
    FaceCompareResult? result,
  }) = _FaceCompareUiState;
}
