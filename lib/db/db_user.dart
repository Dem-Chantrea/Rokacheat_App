import 'package:mobile_assignment/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUser {
  static Database? _database;

  static Future<Database> getDB() async {
    _database ??= await createDB();
    return _database!;
  }

  static Future<Database> createDB() async {
    final dbPath = await getDatabasesPath();
    final dbFile = join(dbPath, "dbUser1.db");

    return openDatabase(
      dbFile,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE tbUser (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstName TEXT,
            lastName TEXT,
            email TEXT,
            profile TEXT,
            gender TEXT,
            dob TEXT,
            address TEXT
          )
        """);
      },
    );
  }

  // INSERT
  static Future<void> insertUser({
    required String firstName,
    required String lastName,
    required String email,
    required String profile,
    required String gender,
    required String dob,
    required String address,
  }) async {
    final db = await getDB();
    await db.insert("tbUser", {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "profile": profile,
      "gender": gender,
      "dob": dob,
      "address": address,
    });
  }

  // READ
  static Future<List<UserModel>> readUsers() async {
    final db = await getDB();
    final result = await db.query("tbUser");
    return result.map((e) => UserModel.fromMap(e)).toList();
  }

  // UPDATE
  static Future<void> updateUser({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required String profile,
    required String gender,
    required String dob,
    required String address,
  }) async {
    final db = await getDB();
    await db.update(
      "tbUser",
      {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "profile": profile,
        "gender": gender,
        "dob": dob,
        "address": address,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // DELETE
  static Future<void> deleteUser(int id) async {
    final db = await getDB();
    await db.delete(
      "tbUser",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
