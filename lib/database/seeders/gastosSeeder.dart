import 'package:sqflite/sqflite.dart';
import '../models/gasto_tipo.dart';
import '../models/gasto_categoria.dart';

class Seeder {
  Future<void> gastosSeeder(Database db) async {
    // Insertar tipos de gasto
    List<GastoTipo> tipos = [
      GastoTipo(nombre: 'Necesidades básicas'),
      GastoTipo(nombre: 'Hogar'),
      GastoTipo(nombre: 'Entretenimiento'),
      GastoTipo(nombre: 'Ropa'),
    ];

    for (var tipo in tipos) {
      await db.insert('gasto_tipo', tipo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    // Insertar categorías de gasto para cada tipo
    List<GastoCategoria> categorias = [
      GastoCategoria(nombre: 'Alimentación', idTipo: 1),
      GastoCategoria(nombre: 'Transporte público', idTipo: 1),
      GastoCategoria(nombre: 'Mantenimiento del hogar', idTipo: 2),
      GastoCategoria(nombre: 'Decoración', idTipo: 2),
      GastoCategoria(nombre: 'Cine', idTipo: 3),
      GastoCategoria(nombre: 'Restaurantes', idTipo: 3),
      GastoCategoria(nombre: 'Ropa casual', idTipo: 4),
      GastoCategoria(nombre: 'Calzado', idTipo: 4),
    ];

    for (var categoria in categorias) {
      await db.insert('gasto_categoria', categoria.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
