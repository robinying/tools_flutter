import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/platform/native_bridge.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/text_option_chip.dart';
import '../data/lux_scene.dart';
import '../data/snapshot_db.dart';

class LightMeterPage extends StatefulWidget {
  const LightMeterPage({super.key});
  @override
  State<LightMeterPage> createState() => _LightMeterPageState();
}

class _LightMeterPageState extends State<LightMeterPage> {
  final _db = SnapshotDb();
  final _noteCtrl = TextEditingController();
  final _buffer = <ChartPoint>[];
  StreamSubscription? _sub;
  bool? _available;
  double _lux = 0;
  ChartWindow _window = ChartWindow.s60;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final ok = await NativeBridge.lightSensorAvailable();
    setState(() => _available = ok);
    if (!ok) return;
    _sub = NativeBridge.lightSensorStream().listen((v) {
      final now = DateTime.now().millisecondsSinceEpoch;
      setState(() {
        _lux = v;
        _buffer.add(ChartPoint(now, v));
        _buffer.removeWhere((p) => now - p.t > 300000);
      });
    });
  }

  List<ChartPoint> get _visible {
    final now = DateTime.now().millisecondsSinceEpoch;
    return _buffer.where((p) => now - p.t <= _window.ms).toList();
  }

  ChartStats get _stats => ChartStats.from(_visible);

  Future<void> _save() async {
    await _db.insert(Snapshot(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      lux: _lux,
      note: _noteCtrl.text.trim(),
    ));
    if (!mounted) return;
    final note = _noteCtrl.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(note.isEmpty
            ? 'Saved: ${_lux.toStringAsFixed(1)} lux'
            : 'Saved: ${_lux.toStringAsFixed(1)} lux — $note'),
      ),
    );
    _noteCtrl.clear();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_available == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Light Meter')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_available == false) {
      return Scaffold(
        appBar: AppBar(title: const Text('Light Meter')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.light_mode, size: 48),
                SizedBox(height: 16),
                Text('No light sensor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text(
                  'This device does not report ambient light (TYPE_LIGHT).',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final stats = _stats;
    final scene = LuxScene.fromLux(_lux);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Light Meter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/lightlux/history'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.lg),
        children: [
          Text(
            _lux.toStringAsFixed(1),
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
                  selected: _window == w,
                  onTap: () => setState(() => _window = w),
                ),
            ],
          ),
          const SizedBox(height: AppDimens.md),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: _LuxPainter(_visible, Theme.of(context).colorScheme.primary),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
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
    final maxLux = (data.map((e) => e.lux).reduce((a, b) => a > b ? a : b) + 10).clamp(100, double.infinity);
    final minT = data.first.t.toDouble();
    final maxT = data.last.t.toDouble();
    final range = (maxT - minT).clamp(1, double.infinity);
    final path = Path();
    for (var i = 0; i < data.length; i++) {
      final p = data[i];
      final x = ((p.t - minT) / range) * size.width;
      final y = size.height - (p.lux / maxLux) * size.height;
      if (i == 0) path.moveTo(x, y);
      else path.lineTo(x, y);
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
