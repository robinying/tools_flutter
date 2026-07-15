import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../data/snapshot_db.dart';

class SnapshotListPage extends StatefulWidget {
  const SnapshotListPage({super.key});
  @override
  State<SnapshotListPage> createState() => _SnapshotListPageState();
}

class _SnapshotListPageState extends State<SnapshotListPage> {
  final _db = SnapshotDb();
  List<Snapshot> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final all = await _db.all();
    if (mounted) setState(() => _items = all);
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snapshots'),
        actions: [
          if (_items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () async {
                await _db.deleteAll();
                await _load();
              },
            ),
        ],
      ),
      body: _items.isEmpty
          ? const Center(child: Text('No snapshots yet'))
          : ListView.separated(
              padding: const EdgeInsets.all(AppDimens.lg),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppDimens.sm),
              itemBuilder: (_, i) {
                final e = _items[i];
                return Card(
                  child: ListTile(
                    title: Text('${e.lux.toStringAsFixed(1)} lux',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    subtitle: Text(
                      '${fmt.format(DateTime.fromMillisecondsSinceEpoch(e.timestamp))}'
                      '${e.note.isNotEmpty ? '\n${e.note}' : ''}',
                    ),
                    isThreeLine: e.note.isNotEmpty,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        if (e.id != null) await _db.delete(e.id!);
                        await _load();
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
