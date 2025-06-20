import 'package:sqflite/sqflite.dart';

class PetsDatabaseHelper {
  static Future<void> onCreate(Database db) async {
    await db.execute('''
      CREATE TABLE pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        species TEXT,
        breed TEXT,
        weight REAL,
        size TEXT,
        age INTEGER,
        color TEXT,
        imageUrl TEXT
      )
    ''');
  }

  static Future<int> insertPet(Database db, Map<String, dynamic> pet) async {
    return await db.insert('pets', pet);
  }

  static Future<List<Map<String, dynamic>>> getPets(Database db) async {
    return await db.query('pets');
  }

  static Future<int> updatePet(Database db, Map<String, dynamic> pet) async {
    int id = pet['id'];
    return await db.update('pets', pet, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deletePet(Database db, int id) async {
    return await db.delete('pets', where: 'id = ?', whereArgs: [id]);
  }
}