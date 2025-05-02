import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/financeiro/cubit/financeiro_cubit.dart';
import 'package:sge_flutter/modules/financeiro/cubit/financeiro_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContasListPage extends StatelessWidget {
  const ContasListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FinanceiroCubit>(context);
    cubit.loadContas();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contas a Pagar e Receber'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Modular.to.pushNamed('/financeiro/conta-form'),
          ),
        ],
      ),
      body: BlocBuilder<FinanceiroCubit, FinanceiroState>(
        builder: (context, state) {
          if (state is FinanceiroLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FinanceiroContasLoaded) {
            if (state.contas.isEmpty) {
              return const Center(child: Text('Nenhuma conta cadastrada.'));
            }
            return ListView.builder(
              itemCount: state.contas.length,
              itemBuilder: (context, index) {
                final conta = state.contas[index];
                return ListTile(
                  leading: Icon(
                    conta.pago ? Icons.check_circle : Icons.pending,
                    color: conta.pago ? Colors.green : Colors.orange,
                  ),
                  title: Text(conta.descricao),
                  subtitle: Text(
                    'Vencimento: ${_formatarData(conta.dataVencimento)}',
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'editar') {
                        Modular.to.pushNamed('/financeiro/conta-form',
                            arguments: conta);
                      } else if (value == 'pago') {
                        await cubit.financeiroService.marcarComoPago(conta.id);
                        cubit.loadContas();
                      } else if (value == 'excluir') {
                        await cubit.financeiroService
                            .deletarLancamento(conta.id);
                        cubit.loadContas();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: 'editar', child: Text('Editar')),
                      const PopupMenuItem(
                          value: 'pago', child: Text('Marcar como Pago')),
                      const PopupMenuItem(
                          value: 'excluir', child: Text('Excluir')),
                    ],
                  ),
                );
              },
            );
          } else if (state is FinanceiroError) {
            return Center(child: Text('Erro: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }
}
