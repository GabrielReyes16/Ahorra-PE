import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: const Center(
        child: Text(
          'Esta es la página de tu perfil.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
