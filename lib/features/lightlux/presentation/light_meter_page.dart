import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/text_option_chip.dart';
import '../domain/entities/lux_models.dart';
import 'providers/light_providers.dart';

class LightMeterPage extends ConsumerStatefulWidget {
  const LightMeterPage({super.key});
  @override
  ConsumerState<LightMeterPage> createState() => _LightMeterPageState();
}

class _LightMeterPageState extends ConsumerState<LightMeterPage> {
  final _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final r = await ref.read(lightMeterProvider.notifier).saveSnapshot(_noteCtrl.text);
    if (!mounted) return;
    if (r.success) {
      final note = r.note ?? '';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            note.isEmpty
                ? 'Saved: ${r.lux!.toStringAsFixed(1)} lux'
                : 'Saved: ${r.lux!.toStringAsFixed(1)} lux — $note',
          ),
        ),
      );
      _noteCtrl.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: ${r.error}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lightMeterProvider);

    return state.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Light Meter')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      unavailable: (error) => Scaffold(
        appBar: AppBar(title: const Text('Light Meter')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.light_mode, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'No light sensor',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  error ??
                      'This device does not report ambient light (TYPE_LIGHT).',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      ready: (lux, buffer, window, streamError) {
        final visible = ref.read(lightMeterProvider.notifier).visiblePoints();
        final stats = ChartStats.fromPoints(visible);
        final scene = LuxScene.fromLux(lux);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Light Meter'),
            actions: [
              IconButton(
                icon: const Icon(Icons.history),
                tooltip: 'History',
                onPressed: () => context.push('/light/history'),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(AppDimens.lg),
            children: [
              if (streamError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppDimens.md),
                  child: Text(
                    streamError,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ExcludeSemantics(
                child: Column(
                  children: [
                    Text(
                      lux.toStringAsFixed(1),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Text('lux', textAlign: TextAlign.center),
                    const SizedBox(height: AppDimens.sm),
                    Text(
                      scene.label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    if (stats.n > 0) ...[
                      const SizedBox(height: AppDimens.md),
                      Text(
                        'Min ${stats.min.toStringAsFixed(1)} · Max ${stats.max.toStringAsFixed(1)} · '
                        'Avg ${stats.avg.toStringAsFixed(1)} · n=${stats.n}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              Semantics(
                label: 'Ambient light ${lux.toStringAsFixed(0)} lux, ${scene.label}',
                child: const SizedBox.shrink(),
              ),
              const SizedBox(height: AppDimens.lg),
              TextField(
                controller: _noteCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Note (optional)',
                ),
              ),
              const SizedBox(height: AppDimens.md),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Save Snapshot'),
              ),
              const SizedBox(height: AppDimens.xl),
              const Text('Real-time chart', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: AppDimens.sm),
              Wrap(
                spacing: AppDimens.sm,
                children: [
                  for (final w in ChartWindow.values)
                    TextOptionChip(
                      label: w.label,
                      selected: window == w,
                      onTap: () =>
                          ref.read(lightMeterProvider.notifier).setWindow(w),
                    ),
                ],
              ),
              const SizedBox(height: AppDimens.md),
              SizedBox(
                height: 200,
                child: CustomPaint(
                  painter: _LuxPainter(visible, Theme.of(context).colorScheme.primary),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LuxPainter extends CustomPainter {
  final List<ChartPoint> data;
  final Color color;
  _LuxPainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;
    final maxLux =
        (data.map((e) => e.lux).reduce((a, b) => a > b ? a : b) + 10).clamp(100, double.infinity);
    final minT = data.first.t.toDouble();
    final maxT = data.last.t.toDouble();
    final range = (maxT - minT).clamp(1, double.infinity);
    final path = Path();
    for (var i = 0; i < data.length; i++) {
      final p = data[i];
      final x = ((p.t - minT) / range) * size.width;
      final y = size.height - (p.lux / maxLux) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant _LuxPainter old) => true;
}
