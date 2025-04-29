import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_state.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:hive/hive.dart';

class EstoqueCubit extends Cubit<EstoqueState> {
  final Box<ProdutoModel> _produtoBox = Hive.box<ProdutoModel>('produtos');

  EstoqueCubit() : super(EstoqueInitial());

  Future<void> loadEstoque() async {
    emit(EstoqueLoading());
    try {
      final produtos = _produtoBox.values.toList();
      emit(EstoqueLoaded(produtos));
    } catch (e) {
      emit(EstoqueError('Erro ao carregar o estoque.'));
    }
  }

  Future<void> adicionarProduto(ProdutoModel produto) async {
    try {
      await _produtoBox.put(produto.id, produto);
      await loadEstoque();
    } catch (e) {
      emit(EstoqueError('Erro ao adicionar produto.'));
    }
  }

  Future<void> removerProduto(String id) async {
    try {
      await _produtoBox.delete(id);
      await loadEstoque();
    } catch (e) {
      emit(EstoqueError('Erro ao remover produto.'));
    }
  }
}
