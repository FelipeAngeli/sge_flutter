import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/financeiro/widgets/grafico_entradas_saidas.dart';
import '../../../models/movimento_financeiro_model.dart';
import '../../../shared/widgets/primary_button.dart';
import '../cubit/financeiro_cubit.dart';
import '../cubit/financeiro_state.dart';
import '../widgets/resumo_card.dart';

class FinanceiroListPage extends StatelessWidget {
  const FinanceiroListPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FinanceiroCubit>(context).loadDashboard();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Financeiro'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.navigate('/'),
        ),
      ),
      body: BlocBuilder<FinanceiroCubit, FinanceiroState>(
        builder: (context, state) {
          if (state is FinanceiroLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FinanceiroLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResumoCard(
                    titulo: 'Valor Total em Estoque',
                    valor: state.totalEstoque,
                    cor: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  ResumoCard(
                    titulo: 'Entradas (7 dias)',
                    valor: state.totalEntradas,
                    cor: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  ResumoCard(
                    titulo: 'Saídas (7 dias)',
                    valor: state.totalSaidas,
                    cor: Colors.red,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Gráfico de Entradas e Saídas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 220,
                    child: GraficoEntradasSaidas(
                      entradas: state.totalEntradas,
                      saidas: state.totalSaidas,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 🌟 Botões alinhados verticalmente com espaçamento
                  PrimaryButton(
                    label: 'Contas a Pagar / Receber',
                    onPressed: () => Modular.to.pushNamed('/financeiro/contas'),
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: 'Nova Conta',
                    onPressed: () =>
                        Modular.to.pushNamed('/financeiro/conta-form'),
                  ),

                  const SizedBox(height: 32),
                  const Text(
                    'Últimas Movimentações',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.movimentacoesRecentes.length,
                    itemBuilder: (context, index) {
                      final MovimentoFinanceiroModel mov =
                          state.movimentacoesRecentes[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(
                            mov.tipo == 'entrada'
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: mov.tipo == 'entrada'
                                ? Colors.green
                                : Colors.red,
                          ),
                          title: Text(mov.descricao),
                          subtitle: Text(_formatarData(mov.data)),
                          trailing: Text(
                            'R\$ ${mov.valor.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: mov.tipo == 'entrada'
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
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
