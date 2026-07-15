import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_ext.dart';
import '../../../core/theme/app_theme.dart';
import 'providers/face_providers.dart';

class FaceComparePage extends ConsumerWidget {
  const FaceComparePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final state = ref.watch(faceCompareProvider);
    final notifier = ref.read(faceCompareProvider.notifier);

    String? resultText;
    final r = state.result;
    if (r != null) {
      resultText = r.when(
        success: (pct) => l.faceSimilarity(pct.toStringAsFixed(1)),
        noFace: () => l.faceNoFace,
        error: (m) => m,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.faceTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          children: [
            Text(
              l.faceDisclaimer,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.lg),
            Row(
              children: [
                _thumb(state.pathA, l.facePickA, notifier.pickA),
                const SizedBox(width: AppDimens.md),
                _thumb(state.pathB, l.facePickB, notifier.pickB),
              ],
            ),
            const SizedBox(height: AppDimens.lg),
            FilledButton(
              onPressed: state.busy ||
                      state.pathA == null ||
                      state.pathB == null
                  ? null
                  : notifier.compare,
              child: Text(state.busy ? l.faceBusy : l.faceCompare),
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
