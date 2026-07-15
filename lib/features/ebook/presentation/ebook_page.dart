import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_ext.dart';
import '../../../core/theme/app_theme.dart';
import 'providers/ebook_providers.dart';

class EbookPage extends ConsumerWidget {
  const EbookPage({super.key});

  Future<void> _pick(WidgetRef ref) async {
    final r = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub'],
    );
    if (r == null || r.paths.isEmpty) return;
    final path = r.paths.first;
    if (path != null) {
      ref.read(ebookProvider.notifier).setPath(path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final state = ref.watch(ebookProvider);

    ref.listen(ebookProvider, (prev, next) {
      final msg = next.lastMessage;
      if (msg != null && msg != prev?.lastMessage && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(l.ebookTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l.ebookStubNote),
            const SizedBox(height: AppDimens.lg),
            FilledButton(
              onPressed: state.busy ? null : () => _pick(ref),
              child: Text(
                state.path == null ? l.ebookPick : state.path!.split('/').last,
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: state.busy || state.path == null
                  ? null
                  : () => ref.read(ebookProvider.notifier).convert(),
              child: Text(state.busy ? l.ebookBusy : l.ebookConvert),
            ),
          ],
        ),
      ),
    );
  }
}
