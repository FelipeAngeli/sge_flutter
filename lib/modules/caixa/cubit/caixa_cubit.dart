import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/caixa_service.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/modules/caixa/cubit/caixa_state.dart';

class CaixaCubit extends Cubit<CaixaState> {
  final CaixaService caixaService;
  final ProdutoService produtoService;

  CaixaCubit({
    required this.caixaService,
    required this.produtoService,
  }) : super(CaixaInitial());

  Future<void> loadDashboard() async {
    try {
      emit(CaixaLoading());

      final produtos = await produtoService.listarProdutos();
      final totalEstoque = produtos.fold(
          0.0, (sum, produto) => sum + (produto.preco * produto.estoque));

      final entradas7dias = caixaService.calcularTotalEntradasUltimosDias(7);
      final saidas7dias = caixaService.calcularTotalSaidasUltimosDias(7);
      final movimentacoesRecentes =
          caixaService.listarMovimentacoesUltimosDias(7);

      emit(CaixaLoaded(
        totalEstoque: totalEstoque,
        totalEntradas: entradas7dias,
        totalSaidas: saidas7dias,
        movimentacoesRecentes: movimentacoesRecentes,
      ));
    } catch (e) {
      emit(CaixaError('Erro ao carregar dashboard: $e'));
    }
  }
}
