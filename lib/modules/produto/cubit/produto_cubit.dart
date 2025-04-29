import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/produto_model.dart';
import '../../../core/services/produto_service.dart';
import 'produto_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoCubit extends Cubit<ProdutoState> {
  final ProdutoService _service = Modular.get<ProdutoService>();

  ProdutoCubit() : super(ProdutoInitial());

  Future<void> loadProdutos() async {
    emit(ProdutoLoading());
    final produtos = await _service.listarProdutos();
    emit(ProdutoLoaded(produtos));
  }

  Future<void> adicionarProduto(ProdutoModel produto) async {
    await _service.salvarProduto(produto);
    await loadProdutos();
  }

  Future<void> atualizarProduto(ProdutoModel produto) async {
    await _service.atualizarProduto(produto);
    await loadProdutos();
  }

  Future<void> removerProduto(String id) async {
    await _service.removerProduto(id);
    await loadProdutos();
  }
}
