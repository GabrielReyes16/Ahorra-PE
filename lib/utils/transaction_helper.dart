import 'package:fluttertoast/fluttertoast.dart';
import '../database/models/gastoModel.dart';
import '../database/tables/gastoTable.dart';
import '../database/database_helper.dart';

Future<List<GastoModel>> fetchGastos() async {
  try {
    final db = await DatabaseHelper.instance.database;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final gastos = await GastoTable.readAll(db);
    final gastosHoy = gastos.where((gasto) {
      final gastoDate = DateTime.parse(gasto.fecha);
      return DateTime(gastoDate.year, gastoDate.month, gastoDate.day)
          .isAtSameMomentAs(today);
    }).toList();

    gastosHoy.sort((a, b) => DateTime.parse(b.fecha).compareTo(DateTime.parse(a.fecha)));

    return gastosHoy;
  } catch (e) {
    rethrow;
  }
}

Future<void> deleteTransaction(
    GastoModel gasto, Future<void> Function() refreshGastos) async {
  if (gasto.id == null) {
    Fluttertoast.showToast(
      msg: "Error: el gasto no tiene un ID válido",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    return;
  }

  try {
    final db = await DatabaseHelper.instance.database;
    await GastoTable.delete(gasto.id!, db);

    // Refrescar la lista de gastos
    await refreshGastos();

    // Mostrar Toast después de eliminar
    Fluttertoast.showToast(
      msg: "Gasto eliminado con éxito",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Error al eliminar gasto: $e",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
