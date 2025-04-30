import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'venda_state.dart';

class VendaCubit extends Cubit<VendaState> {
  final ProdutoService _produtoService;

  VendaCubit(this._produtoService) : super(const VendaInitial());

  Future<void> carregarProdutos() async {
    emit(const VendaLoading());
    try {
      final produtos = await _produtoService.listarProdutos();
      emit(VendaLoaded(produtos: produtos));
    } catch (e) {
      emit(VendaFailure('Erro ao carregar produtos: $e'));
    }
  }

  void selecionarProduto(ProdutoModel produto) {
    final currentState = state;
    if (currentState is VendaLoaded) {
      emit(currentState.copyWith(
        produtoSelecionado: produto,
        quantidade: 1,
      ));
    }
  }

  void atualizarQuantidade(int novaQuantidade) {
    final currentState = state;
    if (currentState is VendaLoaded) {
      emit(currentState.copyWith(quantidade: novaQuantidade));
    }
  }

  Future<void> finalizarVenda() async {
    final currentState = state;
    if (currentState is VendaLoaded &&
        currentState.produtoSelecionado != null) {
      emit(const VendaLoading());

      final produto = currentState.produtoSelecionado!;
      final quantidade = currentState.quantidade;

      if (quantidade <= 0) {
        emit(const VendaFailure('A quantidade deve ser maior que zero.'));
        return;
      }

      if (produto.estoque < quantidade) {
        emit(const VendaFailure('Estoque insuficiente.'));
        return;
      }

      try {
        produto.estoque -= quantidade;
        produto.vendas += quantidade;
        await _produtoService.atualizarProduto(produto);

        final produtosAtualizados = await _produtoService.listarProdutos();
        emit(VendaLoaded(produtos: produtosAtualizados));
      } catch (e) {
        emit(VendaFailure('Erro ao registrar venda: $e'));
      }
    }
  }
}
