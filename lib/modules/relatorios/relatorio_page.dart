import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'relatorio_cubit.dart';
import '../../models/movimento_caixa_model.dart';

class RelatorioPage extends StatefulWidget {
  const RelatorioPage({super.key});

  @override
  State<RelatorioPage> createState() => _RelatorioPageState();
}

class _RelatorioPageState extends State<RelatorioPage> {
  @override
  void initState() {
    super.initState();
    context.read<RelatorioCubit>().loadMovimentos();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RelatorioCubit>();
    final movimentos = cubit.state;

    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios de Caixa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: movimentos.isEmpty
            ? const Center(child: Text('Nenhum movimento registrado.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Entradas vs Saídas',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: _getMaxValue(movimentos) * 1.2,
                        barGroups: _buildBarGroups(movimentos),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(value == 0 ? 'Entrada' : 'Saída');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text('R\$${value.toStringAsFixed(0)}');
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  double _getMaxValue(List<MovimentoCaixaModel> movimentos) {
    final entradas = movimentos.where((m) => m.tipo == 'entrada').toList();
    final saidas = movimentos.where((m) => m.tipo == 'saida').toList();

    double totalEntradas = entradas.fold(0, (sum, m) => sum + m.valor);
    double totalSaidas = saidas.fold(0, (sum, m) => sum + m.valor);

    return [totalEntradas, totalSaidas].reduce((a, b) => a > b ? a : b);
  }

  List<BarChartGroupData> _buildBarGroups(
      List<MovimentoCaixaModel> movimentos) {
    final entradas = movimentos.where((m) => m.tipo == 'entrada').toList();
    final saidas = movimentos.where((m) => m.tipo == 'saida').toList();

    double totalEntradas = entradas.fold(0, (sum, m) => sum + m.valor);
    double totalSaidas = saidas.fold(0, (sum, m) => sum + m.valor);

    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: totalEntradas,
            color: Colors.green,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: totalSaidas,
            color: Colors.red,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    ];
  }
}
