import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/repositories/ebook_repository_impl.dart';
import '../../domain/repositories/ebook_repository.dart';

part 'ebook_providers.freezed.dart';

final ebookRepositoryProvider = Provider<EbookRepository>((ref) {
  return EbookRepositoryImpl();
});

@freezed
class EbookUiState with _$EbookUiState {
  const factory EbookUiState({
    String? path,
    @Default(false) bool busy,
    String? lastMessage,
  }) = _EbookUiState;
}

final ebookProvider =
    StateNotifierProvider.autoDispose<EbookNotifier, EbookUiState>(
  (ref) => EbookNotifier(ref.watch(ebookRepositoryProvider)),
);

class EbookNotifier extends StateNotifier<EbookUiState> {
  EbookNotifier(this._repo) : super(const EbookUiState());

  final EbookRepository _repo;

  void setPath(String path) {
    state = state.copyWith(path: path, lastMessage: null);
  }

  Future<void> convert() async {
    final p = state.path;
    if (p == null) return;
    state = state.copyWith(busy: true, lastMessage: null);
    final r = await _repo.convertEpub(p);
    state = r.fold(
      onSuccess: (out) => state.copyWith(
        busy: false,
        lastMessage: 'PDF ready: $out',
      ),
      onFailure: (f) => state.copyWith(
        busy: false,
        lastMessage: f.displayMessage,
      ),
    );
  }
}
