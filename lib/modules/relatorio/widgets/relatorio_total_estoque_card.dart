import 'package:flutter/material.dart';

class RelatorioTotalEstoqueCard extends StatelessWidget {
  final int total;

  const RelatorioTotalEstoqueCard({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.inventory_2, size: 40),
        title: const Text('Total de Produtos em Estoque'),
        subtitle: Text('$total unidades'),
      ),
    );
  }
}
