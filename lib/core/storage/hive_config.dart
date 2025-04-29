import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/models/movimento_caixa_model.dart';
import 'package:sge_flutter/core/mock/produtos_mock.dart';

class HiveConfig {
  static late Box<ProdutoModel> produtoBox;
  static late Box<MovimentoCaixaModel> movimentoBox;

  static Future<void> start() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProdutoModelAdapter());
    Hive.registerAdapter(MovimentoCaixaModelAdapter());

    produtoBox = await Hive.openBox<ProdutoModel>('produtos');
    movimentoBox = await Hive.openBox<MovimentoCaixaModel>('movimentos');

    await _popularProdutosMock();
  }

  static Future<void> _popularProdutosMock() async {
    if (produtoBox.isEmpty) {
      final produtos = ProdutosMock.gerarProdutos();
      for (var produto in produtos) {
        await produtoBox.put(produto.id, produto);
      }
      print('✅ Mock de produtos criado!');
    } else {
      print('ℹ️ Produtos já existem, mock não necessário.');
    }
  }
}
