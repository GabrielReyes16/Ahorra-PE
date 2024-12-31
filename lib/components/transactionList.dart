import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../database/models/gastoModel.dart';
import '../database/tables/gastoTable.dart';
import '../database/database_helper.dart';
import 'package:AhorraPE/utils/expense_icons.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late Future<List<GastoModel>> _futureGastos;

  @override
  void initState() {
    super.initState();
    _futureGastos = _fetchGastos();
  }

  Future<void> _refreshGastos() async {
    setState(() {
      _futureGastos = _fetchGastos();
    });
  }

  Future<List<GastoModel>> _fetchGastos() async {
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

  Future<void> _deleteTransaction(GastoModel gasto) async {
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
    await _refreshGastos();

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


  void _showDeleteConfirmationDialog(BuildContext context, GastoModel gasto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Estás seguro de eliminar este gasto?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Cerrar el diálogo primero
              await _deleteTransaction(gasto); // Eliminar el gasto después
            },
            child: const Text('Sí'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo sin eliminar
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GastoModel>>(
      future: _futureGastos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar los datos: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay gastos registrados.'));
        }

        final List<GastoModel> gastos = snapshot.data!;

        final totalHoy = gastos.fold<double>(
            0, (sum, gasto) => sum + double.parse(gasto.monto));

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total del día: S/ ${totalHoy.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: gastos.length,
                itemBuilder: (context, index) {
                  final gasto = gastos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                        getIconForExpenses(gasto.tipo),
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        'S/ ${gasto.monto} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        gasto.descripcion.isEmpty ? gasto.categoria : gasto.descripcion,
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, gasto);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
