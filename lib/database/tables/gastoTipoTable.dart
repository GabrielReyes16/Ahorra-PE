import 'package:sqflite/sqflite.dart';
import '../constants/gastoTipoFields.dart';
import '../models/gastoTipoModel.dart';

class GastoTipoTable {
  static const String tableName = GastoTipoFields.tableName;

  /// Crea la tabla en la base de datos.
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        ${GastoTipoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${GastoTipoFields.name} TEXT NOT NULL,
        ${GastoTipoFields.isActive} INTEGER NOT NULL
      )
    ''');
  }

  /// Inserta un nuevo registro en la tabla.
  static Future<GastoTipoModel> create(GastoTipoModel gastoTipo, Database db) async {
    final id = await db.insert(tableName, gastoTipo.toJSON());
    return gastoTipo.copy(id: id);
  }

  /// Lee todos los registros de la tabla.
  static Future<List<GastoTipoModel>> readAll(Database db) async {
    final result = await db.query(tableName);
    return result.map((json) => GastoTipoModel.fromJSON(json)).toList();
  }

  /// Lee un registro específico por ID.
  static Future<GastoTipoModel?> readById(int id, Database db) async {
    final maps = await db.query(
      tableName,
      columns: GastoTipoFields.values,
      where: '${GastoTipoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return GastoTipoModel.fromJSON(maps.first);
    } else {
      return null;
    }
  }

  /// Actualiza un registro en la tabla.
  static Future<int> update(GastoTipoModel gastoTipo, Database db) async {
    return await db.update(
      tableName,
      gastoTipo.toJSON(),
      where: '${GastoTipoFields.id} = ?',
      whereArgs: [gastoTipo.id],
    );
  }

  /// Elimina un registro por ID.
  static Future<int> delete(int id, Database db) async {
    return await db.delete(
      tableName,
      where: '${GastoTipoFields.id} = ?',
      whereArgs: [id],
    );
  }
}
