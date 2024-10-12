import 'package:sqflite/sqflite.dart';

class MissingPetsDatabaseHelper {
  static Future<void> onCreate(Database db) async {
    await db.execute('''
      CREATE TABLE missing_pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        species TEXT,
        breed TEXT,
        weight REAL,
        size TEXT,
        age INTEGER,
        color TEXT,
        imageUrl TEXT,
        description TEXT,
        location TEXT
      )
    ''');
  }

  static Future<int> insertMissingPet(Database db, Map<String, dynamic> missingPet) async {
    return await db.insert('missing_pets', missingPet);
  }

  static Future<List<Map<String, dynamic>>> getMissingPets(Database db) async {
    return await db.query('missing_pets');
  }

  static Future<int> updateMissingPet(Database db, Map<String, dynamic> missingPet) async {
    int id = missingPet['id'];
    return await db.update('missing_pets', missingPet, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteMissingPet(Database db, int id) async {
    return await db.delete('missing_pets', where: 'id = ?', whereArgs: [id]);
  }
}