import 'package:hive/hive.dart';
import '../../models/produto_model.dart';

class ProdutoService {
  final _box = Hive.box<ProdutoModel>('produtos');

  Future<void> salvarProduto(ProdutoModel produto) async {
    await _box.put(produto.id, produto);
  }

  List<ProdutoModel> listarProdutos() {
    return _box.values.toList();
  }
}
