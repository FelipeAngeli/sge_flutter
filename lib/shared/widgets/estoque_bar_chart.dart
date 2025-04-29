import 'package:flutter/material.dart';

class EstoqueBarChart extends StatelessWidget {
  final Map<String, int> estoquePorCategoria;

  const EstoqueBarChart({super.key, required this.estoquePorCategoria});

  @override
  Widget build(BuildContext context) {
    final total = estoquePorCategoria.values.fold<int>(0, (a, b) => a + b);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Distribuição por Categoria',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...estoquePorCategoria.entries.map((entry) {
              final percent = total == 0 ? 0.0 : entry.value / total;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${entry.key} (${entry.value})'),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          flex: (percent * 100).toInt(),
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 100 - (percent * 100).toInt(),
                          child: Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
