import 'package:hive/hive.dart';
import '../../models/produto_model.dart';

class ProdutoService {
  final Box<ProdutoModel> _box;

  ProdutoService(this._box);

  Future<void> salvarProduto(ProdutoModel produto) async {
    await _box.put(produto.id, produto);
  }

  Future<List<ProdutoModel>> listarProdutos() async {
    return _box.values.toList();
  }

  Future<ProdutoModel?> buscarProduto(String id) async {
    return _box.get(id);
  }

  Future<void> atualizarProduto(ProdutoModel produto) async {
    await _box.put(produto.id, produto);
  }

  Future<void> removerProduto(String id) async {
    await _box.delete(id);
  }
}
