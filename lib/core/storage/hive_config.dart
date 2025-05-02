import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/models/compra_model.dart';
import 'package:sge_flutter/models/movimento_caixa_model.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/core/mock/cliente_mock.dart';
import 'package:sge_flutter/core/mock/movimentos_mock.dart';
import 'package:sge_flutter/core/mock/produtos_mock.dart';

class HiveConfig {
  static Future<void> start() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0))
      Hive.registerAdapter(ProdutoModelAdapter());
    if (!Hive.isAdapterRegistered(1))
      Hive.registerAdapter(MovimentoCaixaModelAdapter());
    if (!Hive.isAdapterRegistered(2))
      Hive.registerAdapter(ClienteModelAdapter());
    if (!Hive.isAdapterRegistered(3))
      Hive.registerAdapter(CompraModelAdapter());

    await Hive.openBox<ProdutoModel>('produtos');
    await Hive.openBox<MovimentoCaixaModel>('movimentos');
    await Hive.openBox<ClienteModel>('clientes');
    await Hive.openBox<CompraModel>('compras');

    await _popularProdutosMock();
    await _popularMovimentacoesMock();
    await _popularClientesMock();
  }

  static Box<ProdutoModel> get produtoBox => Hive.box<ProdutoModel>('produtos');
  static Box<MovimentoCaixaModel> get movimentoBox =>
      Hive.box<MovimentoCaixaModel>('movimentos');
  static Box<ClienteModel> get clienteBox => Hive.box<ClienteModel>('clientes');
  static Box<CompraModel> get compraBox => Hive.box<CompraModel>('compras');

  static Future<void> _popularProdutosMock() async {
    final box = produtoBox;
    if (box.isEmpty) {
      final produtos = ProdutosMock.gerarProdutos();
      for (var item in produtos) {
        await box.put(item.id, item);
      }
      print('✅ Mock de produtos criado!');
    }
  }

  static Future<void> _popularMovimentacoesMock() async {
    final box = movimentoBox;
    if (box.isEmpty) {
      final movimentos = MovimentosMock.gerarMovimentacoes();
      for (var item in movimentos) {
        await box.put(item.id, item);
      }
      print('✅ Mock de movimentações criado!');
    }
  }

  static Future<void> _popularClientesMock() async {
    final box = clienteBox;
    if (box.isEmpty) {
      final clientes = ClientesMock.gerarClientes();
      for (var item in clientes) {
        await box.put(item.id, item);
      }
      print('✅ Mock de clientes criado!');
    }
  }
}
