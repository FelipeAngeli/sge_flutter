import 'package:flutter/material.dart';

class RelatorioEstoqueCategoriaChart extends StatelessWidget {
  final Map<String, int> dados;

  const RelatorioEstoqueCategoriaChart({super.key, required this.dados});

  @override
  Widget build(BuildContext context) {
    final total = dados.values.fold<int>(0, (a, b) => a + b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dados.entries.map((entry) {
        final porcentagem = total == 0 ? 0.0 : entry.value / total;
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
                    flex: (porcentagem * 100).toInt(),
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 100 - (porcentagem * 100).toInt(),
                    child: Container(),
                  )
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
