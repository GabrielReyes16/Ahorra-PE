import '../database/models/gastoModel.dart';
import '../database/tables/gastoTable.dart';
import '../database/database_helper.dart';

/// Servicio para manejar operaciones relacionadas con los gastos
class FetchGastoService {
  /// Obtiene la lista de gastos del día actual
  Future<List<GastoModel>> fetchGastosHoy() async {
    try {
      final db = await DatabaseHelper.instance.database;

      // Fecha actual
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // Obtener todos los registros y filtrar por fecha de hoy
      final gastos = await GastoTable.readAll(db);
      final gastosHoy = gastos.where((gasto) {
        final gastoDate = DateTime.parse(gasto.fecha);
        return DateTime(gastoDate.year, gastoDate.month, gastoDate.day)
            .isAtSameMomentAs(today);
      }).toList();

      // Ordenar los gastos por fecha de más nuevo a más antiguo
      gastosHoy.sort((a, b) => DateTime.parse(b.fecha).compareTo(DateTime.parse(a.fecha)));

      print('Fetch completado. Se encontraron ${gastosHoy.length} registros para hoy');
      print('Total de registros: ${gastos.length}');
      return gastosHoy;
    } catch (e) {
      print('Error en fetchGastosHoy: $e');
      rethrow;
    }
  }
}
