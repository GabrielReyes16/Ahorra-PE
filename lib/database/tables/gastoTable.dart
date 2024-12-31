import 'package:sqflite/sqflite.dart';
import '../constants/gastoFields.dart';
import '../models/gastoModel.dart';

class GastoTable {
  static const String tableName = GastoFields.tableName;

  /// Crea la tabla en la base de datos.
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        ${GastoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${GastoFields.tipo} TEXT NOT NULL,
        ${GastoFields.categoria} TEXT NOT NULL,
        ${GastoFields.monto} TEXT NOT NULL,
        ${GastoFields.descripcion} TEXT NOT NULL,
        ${GastoFields.fecha} TEXT NOT NULL,
        ${GastoFields.isActive} INTEGER NOT NULL
      )
    ''');
  }

  /// Inserta un nuevo registro en la tabla.
  static Future<GastoModel> create(GastoModel gastoTipo, Database db) async {
    final id = await db.insert(tableName, gastoTipo.toJSON());
    return gastoTipo.copy(id: id);
  }

  /// Lee todos los registros de la tabla.
static Future<List<GastoModel>> readAll(Database db) async {
  final result = await db.query(
    GastoFields.tableName,
    columns: [
      GastoFields.id,
      GastoFields.tipo,
      GastoFields.categoria,
      GastoFields.monto,
      GastoFields.descripcion,
      GastoFields.fecha,
      GastoFields.isActive,
    ],
    orderBy: '${GastoFields.fecha} DESC',  // Ordena por fecha, de más reciente a más antigua
  );
  return result.map((json) => GastoModel.fromJSON(json)).toList();
}

  /// Lee un registro específico por ID.
  static Future<GastoModel?> readById(int id, Database db) async {
    final maps = await db.query(
      tableName,
      columns: GastoFields.values,
      where: '${GastoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return GastoModel.fromJSON(maps.first);
    } else {
      return null;
    }
  }

  /// Actualiza un registro en la tabla.
  static Future<int> update(GastoModel gastoTipo, Database db) async {
    return await db.update(
      tableName,
      gastoTipo.toJSON(),
      where: '${GastoFields.id} = ?',
      whereArgs: [gastoTipo.id],
    );
  }

  /// Elimina un registro por ID.
  static Future<int> delete(int id, Database db) async {
    return await db.delete(
      tableName,
      where: '${GastoFields.id} = ?',
      whereArgs: [id],
    );
  }
}
