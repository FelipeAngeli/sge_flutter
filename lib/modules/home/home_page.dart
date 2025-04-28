import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SGE - Sistema de Gestão Empresarial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO: Implementar logout
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Bem-vindo ao SGE'),
      ),
    );
  }
}
