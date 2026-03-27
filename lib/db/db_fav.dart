import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbFavorite {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await openDatabase(
      join(await getDatabasesPath(), 'favorite.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            plant_id TEXT PRIMARY KEY
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<void> insert(String plantId) async {
    final db = await database;
    await db.insert(
      'favorites',
      {'plant_id': plantId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  static Future<void> deleteFav(String plantId) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'plant_id = ?',
      whereArgs: [plantId],
    );
  }


  static Future<List<String>> getAll() async {
    final db = await database;
    final result = await db.query('favorites');
    return result.map((e) => e['plant_id'] as String).toList();
  }


  static Future<bool> isFavorite(String plantId) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'plant_id = ?',
      whereArgs: [plantId],
    );
    return result.isNotEmpty;
  }

  static Future<void> deleteAllFav() async {
  final db = await database;
  await db.delete('favorites');
}
}




