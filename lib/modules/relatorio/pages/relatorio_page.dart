import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/relatorio/cubit/relatorio_cubit.dart';
import 'package:sge_flutter/modules/relatorio/cubit/relatorio_state.dart';
import 'package:sge_flutter/modules/relatorio/widgets/grafico_estoque_estoque_categoria.dart';
import 'package:sge_flutter/modules/relatorio/widgets/produtos_vendidos_card.dart';
import 'package:sge_flutter/modules/relatorio/widgets/relatorio_total_estoque_card.dart';
import 'package:sge_flutter/modules/relatorio/widgets/relatorio_vendas_chart.dart';
import 'package:sge_flutter/modules/relatorio/widgets/relatorio_vendas_list.dart';

class RelatorioPage extends StatelessWidget {
  const RelatorioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<RelatorioCubit>()..gerarRelatorio(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Relatório Geral'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Modular.to.navigate('/'),
          ),
        ),
        body: BlocBuilder<RelatorioCubit, RelatorioState>(
          builder: (context, state) {
            if (state is RelatorioLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RelatorioLoaded) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  RelatorioTotalEstoqueCard(
                      total: state.totalProdutosEmEstoque),
                  const SizedBox(height: 16),
                  RelatorioEstoqueCategoriaChart(
                      dados: state.estoquePorCategoria),
                  const SizedBox(height: 16),
                  RelatorioTopVendasChart(data: state.vendasPorProduto),
                  const SizedBox(height: 16),
                  RelatorioTopVendasList(data: state.vendasPorProduto),
                  const SizedBox(height: 16),
                  TopProdutosVendidosCard(
                      produtosMaisVendidos: state.topProdutos),
                ],
              );
            }

            if (state is RelatorioError) {
              return Center(child: Text('Erro: ${state.message}'));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
