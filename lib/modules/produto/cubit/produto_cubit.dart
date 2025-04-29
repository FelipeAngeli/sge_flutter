import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_state.dart';

class ProdutoCubit extends Cubit<ProdutoState> {
  final ProdutoService produtoService;

  ProdutoCubit({required this.produtoService}) : super(ProdutoInitial()) {
    loadProdutos();
  }

  Future<void> loadProdutos() async {
    emit(ProdutoLoading());
    final produtos = await produtoService.listarProdutos();
    emit(ProdutoSuccess(produtos));
  }

  Future<void> adicionarProduto(ProdutoModel produto) async {
    await produtoService.adicionarProduto(produto);
    await loadProdutos();
  }

  Future<void> atualizarProduto(ProdutoModel produto) async {
    await produtoService.atualizarProduto(produto);
    await loadProdutos();
  }

  Future<void> removerProduto(String id) async {
    await produtoService.removerProduto(id);
    await loadProdutos();
  }
}
