import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/lux_models.dart';

class SnapshotLocalDatasource {
  Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    _db = await openDatabase(
      p.join(dir.path, 'light_lux.db'),
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
          CREATE TABLE light_entries(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp INTEGER NOT NULL,
            lux_value REAL NOT NULL,
            note TEXT NOT NULL DEFAULT ''
          )
        ''');
      },
    );
    return _db!;
  }

  Future<void> insert(Snapshot s) async {
    final d = await _database;
    await d.insert('light_entries', {
      'timestamp': s.timestamp,
      'lux_value': s.lux,
      'note': s.note,
    });
  }

  Future<List<Snapshot>> all() async {
    final d = await _database;
    final rows = await d.query('light_entries', orderBy: 'timestamp DESC');
    return rows
        .map(
          (m) => Snapshot(
            id: m['id'] as int?,
            timestamp: m['timestamp'] as int,
            lux: (m['lux_value'] as num).toDouble(),
            note: (m['note'] as String?) ?? '',
          ),
        )
        .toList();
  }

  Future<void> delete(int id) async {
    final d = await _database;
    await d.delete('light_entries', where: 'id=?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final d = await _database;
    await d.delete('light_entries');
  }
}
