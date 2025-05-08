import 'package:flutter/material.dart';

class RelatorioTopVendasList extends StatelessWidget {
  final Map<String, int> data;

  const RelatorioTopVendasList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lista dos Mais Vendidos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...data.entries.map(
              (e) => ListTile(
                leading: const Icon(Icons.star, color: Colors.amber),
                title: Text(e.key),
                trailing: Text('${e.value} vendas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
