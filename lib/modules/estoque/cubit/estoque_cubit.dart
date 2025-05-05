import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/core/services/financeiro_service.dart';
import 'package:sge_flutter/core/services/fornecedor_service.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_state.dart';

class EstoqueCubit extends Cubit<EstoqueState> {
  final ProdutoService produtoService;
  final FinanceiroService financeiroService;
  final FornecedorService fornecedorService;
  bool _isClosed = false;

  EstoqueCubit({
    required this.produtoService,
    required this.financeiroService,
    required this.fornecedorService,
  }) : super(EstoqueInitial());

  void _safeEmit(EstoqueState state) {
    if (!_isClosed) {
      emit(state);
    }
  }

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  Future<void> loadEstoque() async {
    try {
      _safeEmit(EstoqueLoading());
      final produtos = await produtoService.listarProdutos();
      _safeEmit(EstoqueLoaded(produtos));
    } catch (e) {
      _safeEmit(EstoqueError('Erro ao carregar estoque: $e'));
    }
  }

  Future<void> adicionarProdutoAoEstoque(
      String produtoId, int quantidade) async {
    try {
      await produtoService.adicionarEstoque(produtoId, quantidade);
      await loadEstoque();
    } catch (e) {
      _safeEmit(EstoqueError('Erro ao adicionar estoque: $e'));
    }
  }

  Future<void> venderProduto(String produtoId) async {
    try {
      final produto = await produtoService.buscarProduto(produtoId);
      if (produto != null && produto.estoque > 0) {
        await produtoService.removerEstoque(produtoId, 1);
        await financeiroService.registrarEntradaVenda(
          valor: produto.preco,
          descricao: 'Venda de ${produto.nome}',
        );
        await loadEstoque();
      } else {
        _safeEmit(EstoqueError('Produto esgotado!'));
      }
    } catch (e) {
      _safeEmit(EstoqueError('Erro ao vender produto: $e'));
    }
  }

  Future<void> associarFornecedor(String produtoId, String fornecedorId) async {
    try {
      await fornecedorService.associarProdutoAoFornecedor(
        fornecedorId: fornecedorId,
        produtoId: produtoId,
      );
      await loadEstoque();
    } catch (e) {
      _safeEmit(EstoqueError('Erro ao associar fornecedor: $e'));
    }
  }

  Future<void> removerFornecedor(String produtoId, String fornecedorId) async {
    try {
      await fornecedorService.removerProdutoDoFornecedor(
        fornecedorId: fornecedorId,
        produtoId: produtoId,
      );
      await loadEstoque();
    } catch (e) {
      _safeEmit(EstoqueError('Erro ao remover fornecedor: $e'));
    }
  }
}
