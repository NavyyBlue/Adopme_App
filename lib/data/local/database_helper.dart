import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'pets_database_helper.dart';
import 'missing_pets_database_helper.dart';

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
    String path = join(await getDatabasesPath(), 'main_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await PetsDatabaseHelper.onCreate(db);
    await MissingPetsDatabaseHelper.onCreate(db);
  }
}