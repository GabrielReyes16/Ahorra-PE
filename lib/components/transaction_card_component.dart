import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:AhorraPE/components/transactionList.dart';
import 'package:AhorraPE/utils/expense_icons.dart';
import 'package:AhorraPE/services/transaction_service.dart';

class TransactionCard extends StatefulWidget {
  final Database db;
  final void Function(String?)? onDropdownChanged;
  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final TextEditingController dateController;
  final Function onAddPressed;

  const TransactionCard({
    super.key,
    required this.db,
    this.onDropdownChanged,
    required this.amountController,
    required this.descriptionController,
    required this.dateController,
    required this.onAddPressed,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}


class _TransactionCardState extends State<TransactionCard> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  Key transactionListKey = UniqueKey();

  // Lista de tipos de gasto
  final List<Map<String, dynamic>> expenseTypes = [
    {'id': '1', 'nombre': 'Necesidades básicas'},
    {'id': '2', 'nombre': 'Hogar'},
    {'id': '3', 'nombre': 'Trabajo'},
    {'id': '4', 'nombre': 'Estudios'},
    {'id': '5', 'nombre': 'Salud'},
    {'id': '6', 'nombre': 'Entretenimiento y recreación'},
    {'id': '7', 'nombre': 'Ropa y accesorios'},
    {'id': '8', 'nombre': 'Regalos y eventos'},
    {'id': '9', 'nombre': 'Transporte'},
    {'id': '10', 'nombre': 'Tecnología'},
    {'id': '11', 'nombre': 'Inversiones y ahorros'},
    {'id': '12', 'nombre': 'Mascotas'},
    {'id': '13', 'nombre': 'Otros gastos'},
  ];

  // Mapeo de categorías por tipo
  final Map<String, List<String>> categoriesMap = {
    '1': [
      'Alimentación',
      'Alquiler o hipoteca',
      'Servicios básicos',
      'Internet y telefonía',
      'Cuidado personal'
    ],
    '2': [
      'Mantenimiento del hogar',
      'Reparaciones',
      'Decoración',
      'Muebles',
      'Electrodomésticos'
    ],
    '3': [
      'Herramientas de trabajo',
      'Software o suscripciones',
      'Almuerzos en el trabajo'
    ],
    '4': [
      'Educación',
      'Utiles de oficina',
      'Software o suscripciones',
      'Refrigerios'
    ],
    '5': [
      'Consultas médicas',
      'Seguros médicos',
      'Medicamentos',
      'Exámenes médicos',
      'Gimnasio',
      'Terapias'
    ],
    '6': [
      'Salidas al cine',
      'Restaurantes',
      'Fiestas y eventos',
      'Streaming',
      'Viajes',
      'Actividades al aire libre',
      'Juegos de video'
    ],
    '7': [
      'Ropa casual',
      'Ropa formal',
      'Calzado',
      'Joyería y relojes',
      'Bolsos y mochilas',
      'Accesorios'
    ],
    '8': [
      'Cumpleaños',
      'Aniversarios',
      'Bodas',
      'Navidad',
      'San Valentín',
      'Regalos casuales'
    ],
    '9': [
      'Transporte público',
      'Combustible',
      'Mantenimiento del vehículo',
      'Seguros del vehículo',
      'Taxis',
      'Estacionamiento'
    ],
    '10': [
      'Audio',
      'Videdo',
      'Computadoras',
      'Reparaciones',
      'Complementos electrónicos',
      'Suscripciones digitales'
    ],
    '11': [
      'Depósitos a plazo fijo',
      'Fondos de inversión',
      'Criptomonedas',
      'Ahorro mensual'
    ],
    '12': [
      'Alimento para mascotas',
      'Veterinario',
      'Juguetes y accesorios',
      'Baños y grooming'
    ],
    '13': [
      'Impuestos',
      'Multas',
      'Donaciones',
      'Seguros no médicos',
      'Emergencias',
      'Gastos imprevistos'
    ],
  };

  String? selectedExpenseType;
  String? selectedCategory;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    // Establece la fecha actual por defecto
    final currentDate = DateTime.now();
    widget.dateController.text =
        "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";
  
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
DropdownButtonFormField<String>(
  decoration: const InputDecoration(
    labelText: 'Tipo de gasto',
    border: OutlineInputBorder(),
  ),
  items: expenseTypes
      .map((item) => DropdownMenuItem<String>(
            value: item['id'],
            child: Row(
              children: [
                Icon(
                  getIconForExpenseType(int.parse(item['id'])),
                  color: Colors.blueGrey,
                ),
                const SizedBox(width: 10),
                Text(item['nombre']),
              ],
            ),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      selectedExpenseType = value;
      // Solo actualizamos las categorías sin cambiar la lista de transacciones
      categories = value != null ? categoriesMap[value]! : [];
      selectedCategory = null;
    });
  },
  value: selectedExpenseType,
),

const SizedBox(height: 16),

Row(
  children: [
    Expanded(
      flex: 2,
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Categoría',
          border: OutlineInputBorder(),
        ),
        items: categories
            .map((category) => DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedCategory = value;
          });
        },
        value: selectedCategory,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
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
          TextField(
            controller: widget.descriptionController,
            maxLines: null,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: widget.dateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Fecha',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final DateTime now = DateTime.now();
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (selectedDate != null) {
                    final String formattedDate =
                        "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}";

                    setState(() {
                      if (selectedDate.day == now.day &&
                          selectedDate.month == now.month &&
                          selectedDate.year == now.year) {
                        widget.dateController.text =
                            "hoy"; // Mostrar "hoy" en el campo
                      } else {
                        widget.dateController.text =
                            formattedDate; // Mostrar fecha formateada
                      }

                      // Guardar la fecha seleccionada en un formato interno si es necesario
                      widget.dateController.value =
                          widget.dateController.value.copyWith(
                        text: formattedDate,
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: formattedDate.length),
                        ),
                      );
                    });
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            await addTransaction(
              context: context,
              selectedExpenseType: selectedExpenseType,
              selectedCategory: selectedCategory,
              amountController: widget.amountController,
              descriptionController: widget.descriptionController,
              dateController: widget.dateController,
              onAddPressed: () async {
                setState(() {
                  // Cambia la clave para forzar la reconstrucción de TransactionList
                  transactionListKey = UniqueKey();
                });
              },
              db: widget.db,
            );

            // Limpia todos los campos y actualiza la fecha
            setState(() {
              selectedExpenseType = null;
              selectedCategory = null;
              categories = [];
              widget.amountController.clear();
              widget.descriptionController.clear();
              final currentDate = DateTime.now();
              widget.dateController.text =
                  "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";
            });
          },
          child: const Text('Agregar'),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 10),
        SizedBox(
          height: 300, // Ajusta este valor según sea necesario
          child: TransactionList(key: transactionListKey), // Usa la clave dinámicaUse UniqueKey instead of DateTime
            ),
          ],
      ),
    );
  }
}
