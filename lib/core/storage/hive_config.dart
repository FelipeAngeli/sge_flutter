// lib/core/storage/hive_config.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/models/movimento_caixa_model.dart';
import 'package:sge_flutter/core/mock/produtos_mock.dart';

class HiveConfig {
  static Future<void> start() async {
    await Hive.initFlutter();

    // Registrar Adapters
    Hive.registerAdapter(ProdutoModelAdapter());
    Hive.registerAdapter(MovimentoCaixaModelAdapter());

    // Abrir boxes
    await Hive.openBox<ProdutoModel>('produtos');
    await Hive.openBox<MovimentoCaixaModel>('movimentos');

    // Criar mocks se necessário
    await _popularProdutosMock();
  }

  static Future<void> _popularProdutosMock() async {
    final produtoBox = Hive.box<ProdutoModel>('produtos');

    if (produtoBox.isEmpty) {
      final produtos = ProdutosMock.gerarProdutos();

      for (var produto in produtos) {
        await produtoBox.put(produto.id, produto);
      }

      print('✅ Mock de produtos criado!');
    } else {
      print('ℹ️ Produtos já existentes, mock não necessário.');
    }
  }
}
