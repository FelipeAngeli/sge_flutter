import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/financeiro_service.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/modules/financeiro/cubit/financeiro_state.dart';
import 'package:sge_flutter/models/lancamento_model.dart';

class FinanceiroCubit extends Cubit<FinanceiroState> {
  final FinanceiroService financeiroService;
  final ProdutoService produtoService;

  FinanceiroCubit({
    required this.financeiroService,
    required this.produtoService,
  }) : super(FinanceiroInitial());

  Future<void> loadDashboard() async {
    try {
      emit(FinanceiroLoading());

      final produtos = await produtoService.listarProdutos();
      final totalEstoque = produtos.fold(
          0.0, (sum, produto) => sum + (produto.preco * produto.estoque));

      final entradas7dias =
          financeiroService.calcularTotalEntradasUltimosDias(7);
      final saidas7dias = financeiroService.calcularTotalSaidasUltimosDias(7);
      final movimentacoesRecentes =
          financeiroService.listarMovimentacoesUltimosDias(7);

      emit(FinanceiroLoaded(
        totalEstoque: totalEstoque,
        totalEntradas: entradas7dias,
        totalSaidas: saidas7dias,
        movimentacoesRecentes: movimentacoesRecentes,
      ));
    } catch (e) {
      emit(FinanceiroError('Erro ao carregar dashboard: $e'));
    }
  }

  Future<void> loadContas() async {
    try {
      emit(FinanceiroLoading());

      final contas = financeiroService.listarLancamentos();

      emit(FinanceiroContasLoaded(contas: contas));
    } catch (e) {
      emit(FinanceiroError('Erro ao carregar contas: $e'));
    }
  }

  Future<void> adicionarLancamento(LancamentoModel lancamento) async {
    try {
      await financeiroService.adicionarLancamento(lancamento);
      loadContas(); // Atualiza lista após adicionar
    } catch (e) {
      emit(FinanceiroError('Erro ao adicionar conta: $e'));
    }
  }

  Future<void> marcarComoPago(String id) async {
    try {
      await financeiroService.marcarComoPago(id);
      loadContas(); // Atualiza lista após marcar como pago
    } catch (e) {
      emit(FinanceiroError('Erro ao marcar conta como paga: $e'));
    }
  }
}
