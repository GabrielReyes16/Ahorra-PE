import 'package:AhorraPE/database/tables/gastoTable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await GastoTable.createTable(db);

    // Agrega más tablas aquí
  }

  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    // Manejo de migraciones si es necesario
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
