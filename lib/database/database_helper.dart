import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'migrations/createTablesGastos.dart';
import 'seeders/gastosSeeder.dart';

class DatabaseHelper {
  static const _databaseName = "expense.db";
  static const _databaseVersion = 1;

  static const tableTipo = 'gasto_tipo';
  static const tableCategoria = 'gasto_categoria';

  // Columnas para la tabla 'gasto_tipo'
  static const columnId = 'id';
  static const columnNombre = 'nombre';

  // Columnas para la tabla 'gasto_categoria'
  static const columnCategoriaId = 'id';
  static const columnCategoriaNombre = 'nombre';
  static const columnCategoriaTipoId = 'id_tipo';

  // Singleton y acceso a la base de datos
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    MigrationHelper().createTablesGastos(db);
  }

  // Cargar los tipos de gasto desde la base de datos
  Future<List<Map<String, dynamic>>> getTipos() async {
    Database db = await database;
    return await db.query(tableTipo);
  }

  // Cargar las categorías para un tipo de gasto específico
  Future<List<Map<String, dynamic>>> getCategorias(int tipoId) async {
    Database db = await database;
    return await db.query(tableCategoria,
        where: '$columnCategoriaTipoId = ?', whereArgs: [tipoId]);
  }
}
