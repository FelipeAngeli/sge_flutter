import 'package:flutter/material.dart';
import 'package:charts_painter/chart.dart';

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
    final chartData = ChartData(
      [
        [ChartItem(entradas)],
        [ChartItem(saidas)],
      ],
    );

    final chartState = ChartState(
      data: chartData,
      itemOptions: const BarItemOptions(
        maxBarWidth: 24,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 🔥 evita overflow
        children: [
          SizedBox(
            height: 180, // 🔥 ajuste para caber o gráfico e legenda
            child: AnimatedChart(
              state: chartState,
              duration: const Duration(milliseconds: 800), // Animação suave
              curve: Curves.easeOut, // Curva de animação
              width: double.infinity,
              height: 180,
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Legenda(label: 'Entradas', color: Colors.green),
              _Legenda(label: 'Saídas', color: Colors.red),
            ],
          ),
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
