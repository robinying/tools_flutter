import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/platform/native_bridge.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/text_option_chip.dart';
import '../data/media_job_controller.dart';
import '../data/media_tool.dart';

class MediaToolPage extends ConsumerStatefulWidget {
  final MediaToolType type;
  const MediaToolPage({super.key, required this.type});

  @override
  ConsumerState<MediaToolPage> createState() => _MediaToolPageState();
}

class _MediaToolPageState extends ConsumerState<MediaToolPage> {
  final List<String> _paths = [];
  QualityLevel _level = QualityLevel.medium;

  Future<void> _pick() async {
    await Permission.photos.request();
    await Permission.videos.request();
    final result = await FilePicker.platform.pickFiles(
      type: widget.type.isImage ? FileType.image : FileType.video,
      allowMultiple: widget.type.multi || widget.type.isImage,
    );
    if (result == null) return;
    setState(() {
      _paths
        ..clear()
        ..addAll(result.paths.whereType<String>());
    });
  }

  Future<void> _start() async {
    if (_paths.isEmpty) return;
    if (widget.type.multi && _paths.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least 2 videos')),
      );
      return;
    }
    await Permission.notification.request();
    await ref.read(mediaJobProvider.notifier).start(
          type: widget.type,
          paths: List.of(_paths),
          level: _level,
        );
  }

  @override
  Widget build(BuildContext context) {
    final job = ref.watch(mediaJobProvider);
    ref.listen(mediaJobProvider, (prev, next) async {
      if (next is MediaJobFinished) {
        if (next.success && next.outputPath != null) {
          final p = next.outputPath!;
          String? uri;
          if (p.endsWith('.m4a') || p.endsWith('.mp3')) {
            uri = await NativeBridge.saveAudio(p);
          } else if (p.endsWith('.jpg') || p.endsWith('.png') || p.endsWith('.gif')) {
            uri = await NativeBridge.saveImage(p);
          } else {
            uri = await NativeBridge.saveVideo(p);
          }
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(uri != null ? 'Saved: $uri' : 'Done: $p')),
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
    final canStart = _paths.isNotEmpty &&
        !running &&
        (!widget.type.multi || _paths.length >= 2);

    return Scaffold(
      appBar: AppBar(title: Text(widget.type.title)),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: running ? null : _pick,
              child: Text(_paths.isEmpty ? 'Select file' : 'Reselect (${_paths.length})'),
            ),
            const SizedBox(height: AppDimens.md),
            if (_paths.isNotEmpty)
              Text(
                _paths.map((e) => e.split('/').last).join('\n'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(height: AppDimens.lg),
            Text('Options', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppDimens.sm),
            Wrap(
              spacing: AppDimens.sm,
              children: [
                for (final l in QualityLevel.values)
                  TextOptionChip(
                    label: l.labelFor(widget.type),
                    selected: _level == l,
                    onTap: () => setState(() => _level = l),
                    enabled: !running,
                  ),
              ],
            ),
            const Spacer(),
            if (job is MediaJobRunning) ...[
              LinearProgressIndicator(value: job.progress.clamp(0.05, 1.0)),
              const SizedBox(height: AppDimens.sm),
              Text(job.message),
              const SizedBox(height: AppDimens.md),
              OutlinedButton(
                onPressed: () => ref.read(mediaJobProvider.notifier).cancel(),
                child: const Text('Cancel'),
              ),
            ] else
              FilledButton(
                onPressed: canStart ? _start : null,
                child: const Text('Start'),
              ),
          ],
        ),
      ),
    );
  }
}
