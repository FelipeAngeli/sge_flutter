// lib/modules/relatorio/pages/relatorio_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/relatorio_cubit.dart';
import '../cubit/relatorio_state.dart';

class RelatorioPage extends StatelessWidget {
  const RelatorioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RelatorioCubit>()..gerarRelatorio();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Produtos'),
      ),
      body: BlocBuilder<RelatorioCubit, RelatorioState>(
        builder: (context, state) {
          if (state is RelatorioLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RelatorioLoaded) {
            return ListView.builder(
              itemCount: state.produtos.length,
              itemBuilder: (context, index) {
                final produto = state.produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle:
                      Text('Preço: R\$ ${produto.preco.toStringAsFixed(2)}'),
                );
              },
            );
          } else if (state is RelatorioError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
