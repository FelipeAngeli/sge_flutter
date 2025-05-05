import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/core/storage/hive_config.dart';
import 'package:uuid/uuid.dart';
import '../../models/fornecedor_model.dart';

class FornecedorService {
  final Box<FornecedorModel> _fornecedorBox = HiveConfig.fornecedorBox;
  final _uuid = const Uuid();

  FornecedorService();

  /// Listar todos os fornecedores
  List<FornecedorModel> listarFornecedores() {
    return _fornecedorBox.values.toList();
  }

  /// Adicionar ou atualizar um fornecedor
  Future<void> salvarFornecedor(FornecedorModel fornecedor) async {
    if (fornecedor.id.isEmpty) {
      fornecedor.id = _uuid.v4();
    }
    await _fornecedorBox.put(fornecedor.id, fornecedor);
  }

  /// Deletar fornecedor pelo ID
  Future<void> deletarFornecedor(String id) async {
    await _fornecedorBox.delete(id);
  }

  /// Associar produto a fornecedor
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

  /// Remover produto de fornecedor
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

  /// Buscar fornecedores por produto
  List<FornecedorModel> buscarFornecedoresPorProduto(String produtoId) {
    return _fornecedorBox.values
        .where((f) => f.produtos.contains(produtoId))
        .toList();
  }

  /// Buscar fornecedor pelo ID
  FornecedorModel? buscarFornecedorPorId(String fornecedorId) {
    return _fornecedorBox.get(fornecedorId);
  }

  /// [NOVO] Resetar todos os fornecedores (útil para testes)
  Future<void> resetarFornecedores(
      List<FornecedorModel> novosFornecedores) async {
    await _fornecedorBox.clear();
    for (var fornecedor in novosFornecedores) {
      await _fornecedorBox.put(fornecedor.id, fornecedor);
    }
  }
}
