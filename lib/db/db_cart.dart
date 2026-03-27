import 'package:mobile_assignment/model/plant_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbCart {
  static Database? _db;
  static const String DB_NAME = 'cart2.db';
  static const String TABLE = 'cart';
  static const int VERSION =2;

  // Open database
  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: VERSION,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE(
            plant_id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            price REAL,
            image TEXT,
            category TEXT,
            discount REAL,
            qty INTEGER,
            isSelected INTEGER,
            isFavorite INTEGER,
            cart INTEGER
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<void> insertOrUpdatePlant(PlantModel plant, int qty) async {
    final db = await getDatabase();

    // Check if item already exists
    final result = await db.query(
      TABLE,
      where: 'plant_id = ?',
      whereArgs: [plant.plantId],
    );

    if (result.isNotEmpty) {
      // Update quantity
      int currentQty = result.first['qty'] as int;
      await db.update(
        TABLE,
        {'qty': currentQty + qty},
        where: 'plant_id = ?',
        whereArgs: [plant.plantId],
      );
    } else {
      // Insert new item
      await db.insert(
        TABLE,
        {
          'plant_id': plant.plantId,
          'name': plant.name,
          'description': plant.description,
          'price': plant.price,
          'image': plant.image,
          'category': plant.category,
          'discount': plant.discount,
          'qty': qty,
          'isSelected': 0,
          'isFavorite': plant.isFavorite ? 1 : 0,
          'cart': 1,
        },
      );
    }
  }

  // Get all plants in cart
  static Future<List<PlantModel>> getCart() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(TABLE);
    return List.generate(maps.length, (i) => PlantModel.fromMap(maps[i]));
  }

  // Delete plant
  static Future<void> deletePlant(String plantId) async {
    final db = await getDatabase();
    await db.delete(TABLE, where: 'plant_id = ?', whereArgs: [plantId]);
  }

  // Delete all selected
  static Future<void> deleteSelected() async {
    final db = await getDatabase();
    await db.delete(TABLE, where: 'isSelected = ?', whereArgs: [1]);
  }

  // Update quantity
  static Future<void> updateQty(String plantId, int qty) async {
    final db = await getDatabase();
    await db.update(TABLE, {'qty': qty},
        where: 'plant_id = ?', whereArgs: [plantId]);
  }

  // Update selection
  static Future<void> updateSelection(String plantId, bool isSelected) async {
    final db = await getDatabase();
    await db.update(TABLE, {'isSelected': isSelected ? 1 : 0},
        where: 'plant_id = ?', whereArgs: [plantId]);
  }




  static Future<void> deleteAllCart() async {
  final db = await getDatabase();
  await db.delete(TABLE);
}

}
