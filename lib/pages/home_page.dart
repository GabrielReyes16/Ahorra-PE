import 'package:flutter/material.dart';
import '../components/transaction_card_component.dart';
import '../components/today_expenses_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
    text: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
  );

  final List<String> categories = ['Comida', 'Transporte', 'Entretenimiento'];

  void _handleAdd() {
    // Lógica para manejar el botón Agregar
    print("Categoría seleccionada: ${categories[0]}");
    print("Monto: ${amountController.text}");
    print("Descripción: ${descriptionController.text}");
    print("Fecha: ${dateController.text}");
    // Aquí podrías agregar lógica para almacenar datos en la BD o lista.
  }

  @override
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
    ),
    body: Column(
      children: [
        TransactionCard(
          dropdownItems: categories,
          amountController: amountController,
          descriptionController: descriptionController,
          dateController: dateController,
          onAddPressed: _handleAdd,
        ),
        const SizedBox(height: 16), // Espacio entre el TransactionCard y el texto
        const Text(
          'GASTOS DEL DÍA',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16), // Espacio después del texto
        

        const TodayExpenses(), // Asegúrate de importar este widget
      ],
    ),
  );
}

}
