import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pets_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
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

  Future<int> insertPet(Map<String, dynamic> pet) async {
    Database db = await database;
    return await db.insert('pets', pet);
  }

  Future<List<Map<String, dynamic>>> getPets() async {
    Database db = await database;
    return await db.query('pets');
  }

  Future<int> updatePet(Map<String, dynamic> pet) async {
    Database db = await database;
    int id = pet['id'];
    return await db.update('pets', pet, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletePet(int id) async {
    Database db = await database;
    return await db.delete('pets', where: 'id = ?', whereArgs: [id]);
  }
}