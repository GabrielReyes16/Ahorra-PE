import 'package:flutter/material.dart';

class GastosPage extends StatelessWidget {
  const GastosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos'),
      ),
      body: const Center(
        child: Text(
          'Aquí puedes gestionar tus gastos.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
