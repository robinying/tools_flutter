import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import 'providers/face_providers.dart';

class FaceComparePage extends ConsumerWidget {
  const FaceComparePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(faceCompareProvider);
    final notifier = ref.read(faceCompareProvider.notifier);

    String? resultText;
    final r = state.result;
    if (r != null) {
      resultText = r.when(
        success: (pct) =>
            'Similarity: ${pct.toStringAsFixed(1)}% (landmark geometry)',
        noFace: () => 'Face not detected in one or both images',
        error: (m) => m,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Face Compare')),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          children: [
            Row(
              children: [
                _thumb(state.pathA, 'Photo A', notifier.pickA),
                const SizedBox(width: AppDimens.md),
                _thumb(state.pathB, 'Photo B', notifier.pickB),
              ],
            ),
            const SizedBox(height: AppDimens.lg),
            FilledButton(
              onPressed: state.busy ||
                      state.pathA == null ||
                      state.pathB == null
                  ? null
                  : notifier.compare,
              child: Text(state.busy ? 'Comparing…' : 'Compare'),
            ),
            const SizedBox(height: AppDimens.lg),
            if (resultText != null)
              Text(resultText, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
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
}
