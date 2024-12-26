import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'package:flutter/services.dart';

class TransactionCard extends StatefulWidget {
  final void Function(String?)? onDropdownChanged;
  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final TextEditingController dateController;
  final VoidCallback onAddPressed;

  const TransactionCard({
    super.key,
    this.onDropdownChanged,
    required this.amountController,
    required this.descriptionController,
    required this.dateController,
    required this.onAddPressed, 
    required List<String> dropdownItems,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> expenseTypes = [];
  List<Map<String, dynamic>> categories = [];
  
  String? selectedExpenseType;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadExpenseTypes();
  }

  // Cargar los tipos de gasto desde la base de datos
 Future<void> _loadExpenseTypes() async {
  final expenseTypesList = await databaseHelper.getTipos();
  setState(() {
    expenseTypes = expenseTypesList;
  });
}

void _onExpenseTypeChanged(String? newValue) async {
  setState(() {
    selectedExpenseType = newValue;
    selectedCategory = null; // Resetear categoría seleccionada
    categories = [];
  });

  // Cargar categorías para el tipo seleccionado
  if (newValue != null) {
    final tipoId = expenseTypes.firstWhere((type) => type['nombre'] == newValue)['id'];
    final categoriasList = await databaseHelper.getCategorias(tipoId);
    setState(() {
      categories = categoriasList;
    });
  }
}

  // Cuando se selecciona una categoría
  void _onCategoryChanged(String? newValue) {
    setState(() {
      selectedCategory = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Selector para el tipo de gasto
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Tipo de gasto',
                    border: OutlineInputBorder(),
                  ),
                  items: expenseTypes
                      .map((item) => DropdownMenuItem<String>(
                            value: item['nombre'], // Asegúrate de que esto sea un String
                            child: Text(item['nombre']),
                          ))
                      .toList(),
                  onChanged: _onExpenseTypeChanged,
                  value: selectedExpenseType,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Selector para la categoría, se actualiza según el tipo de gasto
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                  ),
                  items: categories
                      .map((item) => DropdownMenuItem<String>(
                            value: item['nombre'], // Asegúrate de que esto sea un String
                            child: Text(item['nombre']),
                          ))
                      .toList(),
                  onChanged: _onCategoryChanged,
                  value: selectedCategory,
                ),
              ),
              const SizedBox(width: 8),
              // Campo de Monto
              Expanded(
                child: TextField(
                  controller: widget.amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Monto',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Campo de Descripción
          TextField(
            controller: widget.descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // Selector de Fecha
          TextField(
            controller: widget.dateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Fecha',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    widget.dateController.text =
                        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Botón Agregar
          ElevatedButton(
            onPressed: widget.onAddPressed,
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
