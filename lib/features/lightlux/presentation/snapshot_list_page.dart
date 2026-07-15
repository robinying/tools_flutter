import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import 'providers/light_providers.dart';

class SnapshotListPage extends ConsumerWidget {
  const SnapshotListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(snapshotListProvider);
    final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Snapshots'),
        actions: [
          async.maybeWhen(
            data: (items) => items.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.delete_sweep),
                    onPressed: () =>
                        ref.read(snapshotListProvider.notifier).deleteAll(),
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (items) => items.isEmpty
            ? const Center(child: Text('No snapshots yet'))
            : ListView.separated(
                padding: const EdgeInsets.all(AppDimens.lg),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppDimens.sm),
                itemBuilder: (_, i) {
                  final e = items[i];
                  return Card(
                    child: ListTile(
                      title: Text(
                        '${e.lux.toStringAsFixed(1)} lux',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        '${fmt.format(DateTime.fromMillisecondsSinceEpoch(e.timestamp))}'
                        '${e.note.isNotEmpty ? '\n${e.note}' : ''}',
                      ),
                      isThreeLine: e.note.isNotEmpty,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          if (e.id != null) {
                            await ref
                                .read(snapshotListProvider.notifier)
                                .delete(e.id!);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
