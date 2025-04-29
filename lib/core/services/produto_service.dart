import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/core/storage/hive_config.dart';

class ProdutoService {
  final Box<ProdutoModel> _produtoBox = HiveConfig.produtoBox;

  ProdutoService();

  Future<List<ProdutoModel>> listarProdutos() async {
    return _produtoBox.values.toList();
  }

  Future<void> adicionarProduto(ProdutoModel produto) async {
    await _produtoBox.put(produto.id, produto);
  }

  Future<ProdutoModel?> buscarProduto(String id) async {
    return _produtoBox.get(id);
  }

  Future<void> atualizarProduto(ProdutoModel produto) async {
    await _produtoBox.put(produto.id, produto);
  }

  Future<void> removerProduto(String id) async {
    await _produtoBox.delete(id);
  }

  Future<void> adicionarEstoque(String produtoId, int quantidade) async {
    final produto = _produtoBox.get(produtoId);
    if (produto != null) {
      produto.estoque += quantidade;
      await _produtoBox.put(produto.id, produto);
    }
  }

  Future<void> removerEstoque(String produtoId, int quantidade) async {
    final produto = _produtoBox.get(produtoId);
    if (produto != null && produto.estoque >= quantidade) {
      produto.estoque -= quantidade;
      await _produtoBox.put(produto.id, produto);
    }
  }
}
