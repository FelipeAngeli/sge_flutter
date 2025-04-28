import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/produto_service.dart';
import '../../models/produto_model.dart';

class EstoqueCubit extends Cubit<List<ProdutoModel>> {
  final ProdutoService _service;

  EstoqueCubit(this._service) : super([]);

  Future<void> loadProdutos() async {
    final produtos = _service.listarProdutos();
    emit(produtos);
  }

  Future<void> adicionarQuantidade(String id, int quantidade) async {
    final produtos = _service.listarProdutos();
    final produto = produtos.firstWhere((p) => p.id == id);
    final atualizado = ProdutoModel(
      id: produto.id,
      nome: produto.nome,
      descricao: produto.descricao,
      preco: produto.preco,
      quantidade: produto.quantidade + quantidade,
    );
    await _service.salvarProduto(atualizado);
    loadProdutos();
  }

  Future<void> removerQuantidade(String id, int quantidade) async {
    final produtos = _service.listarProdutos();
    final produto = produtos.firstWhere((p) => p.id == id);
    final novoEstoque = (produto.quantidade - quantidade) < 0
        ? 0
        : (produto.quantidade - quantidade);
    final atualizado = ProdutoModel(
      id: produto.id,
      nome: produto.nome,
      descricao: produto.descricao,
      preco: produto.preco,
      quantidade: novoEstoque,
    );
    await _service.salvarProduto(atualizado);
    loadProdutos();
  }
}
