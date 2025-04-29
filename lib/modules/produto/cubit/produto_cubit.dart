import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/produto_model.dart';
import '../../../core/services/produto_service.dart';
import 'produto_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoCubit extends Cubit<ProdutoState> {
  final ProdutoService produtoService;

  ProdutoCubit({required this.produtoService}) : super(ProdutoInitial());

  Future<void> loadProdutos() async {
    emit(ProdutoLoading());
    final produtos = await produtoService.listarProdutos();
    emit(ProdutoLoaded(produtos));
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
