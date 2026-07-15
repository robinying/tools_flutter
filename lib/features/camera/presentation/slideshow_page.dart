import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_ext.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/text_option_chip.dart';
import '../../media/domain/entities/media_job_state.dart';
import '../../media/presentation/providers/media_job_notifier.dart';

class SlideshowPage extends ConsumerStatefulWidget {
  const SlideshowPage({super.key});
  @override
  ConsumerState<SlideshowPage> createState() => _SlideshowPageState();
}

class _SlideshowPageState extends ConsumerState<SlideshowPage> {
  List<String> _paths = [];
  String _level = 'medium'; // 2s

  Future<void> _pick() async {
    final r = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
    if (r == null) return;
    setState(() => _paths = r.paths.whereType<String>().toList());
  }

  Future<void> _run() async {
    final l = context.l10n;
    if (_paths.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.selectAtLeast2Photos)),
      );
      return;
    }
    final job = ref.read(mediaJobProvider);
    if (job is MediaJobRunning) return;
    await ref.read(mediaJobProvider.notifier).startRaw(
          type: 'slideshow',
          paths: List.of(_paths),
          level: _level,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final job = ref.watch(mediaJobProvider);
    ref.listen(mediaJobProvider, (prev, next) async {
      if (next is MediaJobFinished) {
        if (next.success && next.outputPath != null) {
          final uri =
              await ref.read(mediaJobProvider.notifier).saveOutput(next.outputPath!);
          if (context.mounted) {
            final loc = context.l10n;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  uri != null ? loc.slideshowSaved : loc.gallerySaveFailed,
                ),
              ),
            );
          }
        } else if (!next.success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.message)),
          );
        }
      }
    });

    final running = job is MediaJobRunning;

    return Scaffold(
      appBar: AppBar(title: Text(l.slideshowTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: running ? null : _pick,
              child: Text(
                _paths.isEmpty
                    ? l.selectPhotos
                    : l.photosSelected(_paths.length),
              ),
            ),
            const SizedBox(height: AppDimens.lg),
            Text(l.secondsPerPhoto),
            Wrap(
              spacing: AppDimens.sm,
              children: [
                TextOptionChip(
                  label: '1s',
                  selected: _level == 'low',
                  onTap: () => setState(() => _level = 'low'),
                  enabled: !running,
                ),
                TextOptionChip(
                  label: '2s',
                  selected: _level == 'medium',
                  onTap: () => setState(() => _level = 'medium'),
                  enabled: !running,
                ),
                TextOptionChip(
                  label: '3s',
                  selected: _level == 'high',
                  onTap: () => setState(() => _level = 'high'),
                  enabled: !running,
                ),
              ],
            ),
            if (job is MediaJobRunning) ...[
              const SizedBox(height: AppDimens.lg),
              LinearProgressIndicator(
                value: job.progress.clamp(0.05, 1.0),
              ),
              const SizedBox(height: AppDimens.sm),
              Text(job.message),
            ],
            const Spacer(),
            FilledButton(
              onPressed: running || _paths.length < 2 ? null : _run,
              child: Text(running ? l.generating : l.generateSlideshow),
            ),
          ],
        ),
      ),
    );
  }
}
