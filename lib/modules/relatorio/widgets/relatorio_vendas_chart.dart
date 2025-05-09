import 'package:flutter/material.dart';

class RelatorioTopVendasChart extends StatelessWidget {
  final Map<String, int> data;

  const RelatorioTopVendasChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.values.fold<int>(0, (sum, item) => sum + item);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top 3 Produtos Mais Vendidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (data.isEmpty)
              const Center(child: Text('Nenhum dado disponível')),
            ...data.entries.map((entry) {
              final percent = total == 0 ? 0.0 : entry.value / total;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${entry.key} (${entry.value} vendas)'),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          flex: (percent * 100).toInt(),
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
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
