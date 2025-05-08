import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/produto_service.dart';
import '../../relatorio/cubit/relatorio_state.dart';
import '../widgets/produtos_vendidos_card.dart';

class RelatorioCubit extends Cubit<RelatorioState> {
  final ProdutoService _service;

  RelatorioCubit(this._service) : super(RelatorioInitial());

  Future<void> gerarRelatorio() async {
    emit(RelatorioLoading());

    try {
      final produtos = await _service.listarProdutos();

      // Total de produtos em estoque (soma das quantidades)
      final int total = produtos.fold(0, (soma, p) => soma + p.estoque);

      // Estoque por categoria
      final Map<String, int> categoriasMap = {};
      for (final p in produtos) {
        categoriasMap[p.categoria] =
            (categoriasMap[p.categoria] ?? 0) + p.estoque;
      }

      // Vendas por produto
      final Map<String, int> vendasMap = {};
      for (final p in produtos) {
        vendasMap[p.nome] = p.vendas ?? 0;
      }

      // Top 3 produtos mais vendidos
      final top3 = vendasMap.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final List<ProdutoVendido> topProdutos = top3.take(3).map((entry) {
        final produto = produtos.firstWhere((p) => p.nome == entry.key);
        return ProdutoVendido(produto: produto, vendas: entry.value);
      }).toList();

      emit(RelatorioLoaded(
        totalProdutosEmEstoque: total,
        estoquePorCategoria: categoriasMap,
        vendasPorProduto: vendasMap,
        topProdutos: topProdutos,
      ));
    } catch (e) {
      emit(RelatorioError('Erro ao gerar relatório: $e'));
    }
  }
}
