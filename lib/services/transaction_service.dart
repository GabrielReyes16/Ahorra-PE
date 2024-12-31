import 'package:flutter/material.dart';
import '../database/models/gastoModel.dart';
import '../database/tables/gastoTable.dart';

/// Función para agregar una transacción
Future<void> addTransaction({
  required BuildContext context,
  required String? selectedExpenseType,
  required String? selectedCategory,
  required TextEditingController amountController,
  required TextEditingController descriptionController,
  required TextEditingController dateController,
  required Function onAddPressed,
  required dynamic db,
}) async {
  // Desenfocar cualquier campo de entrada seleccionado
  FocusScope.of(context).unfocus();

  // Validación de campos requeridos
  if (selectedExpenseType == null ||
      selectedCategory == null ||
      amountController.text.isEmpty ||
      dateController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor, completa los campos requeridos')),
    );
    return;
  }

  try {
    // Crear el modelo del gasto
    final gasto = GastoModel(
      tipo: selectedExpenseType,
      categoria: selectedCategory,
      monto: amountController.text,
      descripcion: descriptionController.text.isEmpty ? '' : descriptionController.text,
      fecha: dateController.text,
      isActive: true,
    );

    // Guardar el gasto en la base de datos
    await GastoTable.create(gasto, db);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gasto agregado exitosamente')),
    );

    // Notificar al componente padre que debe actualizarse
    onAddPressed();

    // Limpia el formulario
    amountController.clear();
    descriptionController.clear();
    dateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al agregar gasto: $e')),
    );
  }
}
