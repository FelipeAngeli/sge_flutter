import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_state.dart';

class ProdutoCubit extends Cubit<ProdutoState> {
  final ProdutoService produtoService;

  ProdutoCubit({required this.produtoService}) : super(ProdutoInitial());

  Future<void> loadProdutos() async {
    emit(ProdutoLoading());
    try {
      final produtos = await produtoService.listarProdutos();
      emit(ProdutoSuccess(produtos));
    } catch (e) {
      emit(ProdutoFailure('Erro ao carregar produtos: $e'));
    }
  }

  Future<void> adicionarProduto(ProdutoModel produto) async {
    try {
      await produtoService.adicionarProduto(produto);
      await loadProdutos();
    } catch (e) {
      emit(ProdutoFailure('Erro ao adicionar produto: $e'));
    }
  }

  Future<void> atualizarProduto(ProdutoModel produto) async {
    try {
      await produtoService.atualizarProduto(produto);
      await loadProdutos();
    } catch (e) {
      emit(ProdutoFailure('Erro ao atualizar produto: $e'));
    }
  }

  Future<void> removerProduto(String id) async {
    try {
      await produtoService.removerProduto(id);
      await loadProdutos();
    } catch (e) {
      emit(ProdutoFailure('Erro ao remover produto: $e'));
    }
  }
}
