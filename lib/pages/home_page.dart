import 'package:AhorraPE/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../components/transaction_card_component.dart';
import '../database/tables/gastoTable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database? db;
  DatabaseHelper? dbHelper;
  bool shouldRefresh = false; // Variable para controlar la actualización

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    db = await openDatabase(
      'app.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await GastoTable.createTable(db);
      },
    );
    setState(() {}); 
  }

  void refreshList() {
    setState(() {
      shouldRefresh = !shouldRefresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: db == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransactionCard(
                    db: db!,
                    amountController: amountController,
                    descriptionController: descriptionController,
                    dateController: dateController,
                    onAddPressed: () {
                      refreshList(); // Actualiza la lista cuando se agrega una transacción
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}
