import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_state.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/core/services/caixa_service.dart';

class EstoqueCubit extends Cubit<EstoqueState> {
  final ProdutoService produtoService;
  final CaixaService caixaService;

  EstoqueCubit({
    required this.produtoService,
    required this.caixaService,
  }) : super(EstoqueInitial());

  Future<void> loadEstoque() async {
    try {
      emit(EstoqueLoading());
      final produtos =
          await produtoService.listarProdutos(); // ✅ corrigido com await
      emit(EstoqueLoaded(produtos));
    } catch (e) {
      emit(EstoqueError('Erro ao carregar estoque: $e'));
    }
  }

  Future<void> adicionarProdutoAoEstoque(
      String produtoId, int quantidade) async {
    try {
      await produtoService.adicionarEstoque(produtoId, quantidade);
      await loadEstoque();
    } catch (e) {
      emit(EstoqueError('Erro ao adicionar estoque: $e'));
    }
  }

  Future<void> venderProduto(String produtoId) async {
    try {
      final produto = await produtoService.buscarProduto(produtoId);
      if (produto != null && produto.estoque > 0) {
        await produtoService.removerEstoque(produtoId, 1);

        await caixaService.registrarEntradaVenda(
          valor: produto.preco,
          descricao: 'Venda de ${produto.nome}',
        );

        await loadEstoque();
      } else {
        emit(EstoqueError('Produto esgotado!'));
      }
    } catch (e) {
      emit(EstoqueError('Erro ao vender produto: $e'));
    }
  }
}
