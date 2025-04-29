import 'package:sge_flutter/shared/widgets/produtos_vendidos_card.dart';

sealed class RelatorioState {}

class RelatorioInitial extends RelatorioState {}

class RelatorioLoading extends RelatorioState {}

class RelatorioError extends RelatorioState {
  final String message;
  RelatorioError(this.message);
}

class RelatorioLoaded extends RelatorioState {
  final int totalProdutosEmEstoque;
  final Map<String, int> estoquePorCategoria;
  final Map<String, int> vendasPorProduto;
  final List<ProdutoVendido> topProdutos;

  RelatorioLoaded({
    required this.totalProdutosEmEstoque,
    required this.estoquePorCategoria,
    required this.vendasPorProduto,
    required this.topProdutos,
  });
}
