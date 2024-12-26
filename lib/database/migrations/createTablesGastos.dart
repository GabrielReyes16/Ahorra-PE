import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MigrationHelper {
  // Método para crear las tablas
  Future<void> createTablesGastos(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS gasto_tipo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS gasto_categoria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        id_tipo INTEGER,
        FOREIGN KEY (id_tipo) REFERENCES gasto_tipo(id)
      );
    ''');
  }
}
