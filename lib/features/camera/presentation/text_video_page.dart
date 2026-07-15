import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/platform/native_bridge.dart';
import '../../../core/theme/app_theme.dart';
import '../../media/data/media_job_controller.dart';

class TextVideoPage extends ConsumerStatefulWidget {
  const TextVideoPage({super.key});
  @override
  ConsumerState<TextVideoPage> createState() => _TextVideoPageState();
}

class _TextVideoPageState extends ConsumerState<TextVideoPage> {
  final _ctrl = TextEditingController(text: 'Hello Tools');
  double _duration = 3;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _gen() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    final job = ref.read(mediaJobProvider);
    if (job is MediaJobRunning) return;
    await ref.read(mediaJobProvider.notifier).startRaw(
          type: 'textCard',
          paths: ['_', text, _duration.toInt().toString()],
          level: 'medium',
        );
  }

  @override
  Widget build(BuildContext context) {
    final job = ref.watch(mediaJobProvider);
    ref.listen(mediaJobProvider, (prev, next) async {
      if (next is MediaJobFinished) {
        if (next.success && next.outputPath != null) {
          await NativeBridge.saveVideo(next.outputPath!);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Text video saved')),
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
      appBar: AppBar(title: const Text('Text to Video')),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              maxLines: 4,
              enabled: !running,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Text',
              ),
            ),
            const SizedBox(height: AppDimens.lg),
            Text('Duration: ${_duration.toInt()} s'),
            Slider(
              value: _duration,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: running ? null : (v) => setState(() => _duration = v),
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
              onPressed: running ? null : _gen,
              child: Text(running ? 'Generating…' : 'Generate video'),
            ),
          ],
        ),
      ),
    );
  }
}
