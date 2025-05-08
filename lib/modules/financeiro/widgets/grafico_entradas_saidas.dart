import 'package:flutter/material.dart';
import 'package:sge_flutter/shared/widgets/custom_bar_chart.dart';

class GraficoEntradasSaidas extends StatelessWidget {
  final double entradas;
  final double saidas;

  const GraficoEntradasSaidas({
    super.key,
    required this.entradas,
    required this.saidas,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260, // 🔥 Corrige o overflow deixando espaço fixo
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomBarChart(
                entradas: entradas,
                saidas: saidas,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Legenda(label: 'Entradas', color: Colors.green),
              _Legenda(label: 'Saídas', color: Colors.red),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _Legenda extends StatelessWidget {
  final String label;
  final Color color;

  const _Legenda({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
