import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
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
                    child: charts.BarChart(
                      _buildSeries(movimentos),
                      animate: true,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  List<charts.Series<MovimentoCaixaModel, String>> _buildSeries(
      List<MovimentoCaixaModel> movimentos) {
    final entradas = movimentos.where((m) => m.tipo == 'entrada').toList();
    final saidas = movimentos.where((m) => m.tipo == 'saida').toList();

    double totalEntradas = entradas.fold(0, (sum, m) => sum + m.valor);
    double totalSaidas = saidas.fold(0, (sum, m) => sum + m.valor);

    final data = [
      MovimentoCaixaModel(
          id: '1',
          data: DateTime.now(),
          valor: totalEntradas,
          tipo: 'Entrada',
          descricao: ''),
      MovimentoCaixaModel(
          id: '2',
          data: DateTime.now(),
          valor: totalSaidas,
          tipo: 'Saída',
          descricao: ''),
    ];

    return [
      charts.Series<MovimentoCaixaModel, String>(
        id: 'Movimentos',
        domainFn: (MovimentoCaixaModel mov, _) => mov.tipo,
        measureFn: (MovimentoCaixaModel mov, _) => mov.valor,
        data: data,
        labelAccessorFn: (MovimentoCaixaModel mov, _) =>
            'R\$${mov.valor.toStringAsFixed(2)}',
      ),
    ];
  }
}
