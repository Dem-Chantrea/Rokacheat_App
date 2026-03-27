import 'package:mobile_assignment/model/address_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbAddress {
  static final DbAddress instance = DbAddress._internal();
  static Database? _database;

  DbAddress._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'address.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE addresses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        gender TEXT NOT NULL,
        phone TEXT NOT NULL,
        address TEXT NOT NULL,
        detail TEXT,
        photo TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }


  Future<int> insertAddress(AddressModel address) async {
    final db = await database;
    return await db.insert('addresses', address.toMap());
  }


  Future<List<AddressModel>> getAllAddresses() async {
    final db = await database;
    final result = await db.query('addresses', orderBy: 'id DESC');

    return result.map((e) => AddressModel.fromMap(e)).toList();
  }


  Future<int> deleteAddress(int id) async {
    final db = await database;
    return await db.delete('addresses', where: 'id = ?', whereArgs: [id]);
  }
}


