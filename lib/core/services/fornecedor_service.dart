import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/core/storage/hive_config.dart';
import 'package:uuid/uuid.dart';
import '../../models/fornecedor_model.dart';

class FornecedorService {
  final Box<FornecedorModel> _fornecedorBox = HiveConfig.fornecedorBox;
  final _uuid = const Uuid();

  FornecedorService();

  List<FornecedorModel> listarFornecedores() {
    return _fornecedorBox.values.toList();
  }

  Future<void> salvarFornecedor(FornecedorModel fornecedor) async {
    if (fornecedor.id.isEmpty) {
      fornecedor.id = _uuid.v4();
    }
    await _fornecedorBox.put(fornecedor.id, fornecedor);
  }

  Future<void> deletarFornecedor(String id) async {
    await _fornecedorBox.delete(id);
  }

  Future<void> associarProdutoAoFornecedor({
    required String fornecedorId,
    required String produtoId,
  }) async {
    final fornecedor = _fornecedorBox.get(fornecedorId);
    if (fornecedor != null) {
      if (!fornecedor.produtos.contains(produtoId)) {
        fornecedor.produtos.add(produtoId);
        await fornecedor.save();
      }
    }
  }

  Future<void> removerProdutoDoFornecedor({
    required String fornecedorId,
    required String produtoId,
  }) async {
    final fornecedor = _fornecedorBox.get(fornecedorId);
    if (fornecedor != null) {
      fornecedor.produtos.remove(produtoId);
      await fornecedor.save();
    }
  }

  List<FornecedorModel> buscarFornecedoresPorProduto(String produtoId) {
    return _fornecedorBox.values
        .where((f) => f.produtos.contains(produtoId))
        .toList();
  }

  FornecedorModel? buscarFornecedorPorId(String fornecedorId) {
    return _fornecedorBox.get(fornecedorId);
  }

  Future<void> resetarFornecedores(
      List<FornecedorModel> novosFornecedores) async {
    await _fornecedorBox.clear();
    for (var fornecedor in novosFornecedores) {
      await _fornecedorBox.put(fornecedor.id, fornecedor);
    }
  }
}
