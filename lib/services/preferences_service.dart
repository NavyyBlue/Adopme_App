import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:adopme_frontend/models/preferences/preferences_model.dart';
import 'dart:convert';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();

  static PreferencesService get to => _instance;
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'preferences.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE preferences(id INTEGER PRIMARY KEY, data TEXT)',
        );
      },
    );
  }

  Future<void> setPreferences(PetPreferences preferences) async {
    final db = await database;
    if (preferences.isEmpty()) {
      return;
    }
    await db.insert(
      'preferences',
      {'id': 1, 'data': jsonEncode(preferences.toJson())},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<PetPreferences?> getPreferences() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('preferences', where: 'id = ?', whereArgs: [1]);
    if (maps.isNotEmpty) {
      return PetPreferences.fromJson(jsonDecode(maps.first['data']));
    }
    return null;
  }

  Future<void> clearPreferences() async {
    final db = await database;
    await db.delete('preferences', where: 'id = ?', whereArgs: [1]);
  }
}