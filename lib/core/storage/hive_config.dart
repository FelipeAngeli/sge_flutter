import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/core/mock/cliente_mock.dart';
import 'package:sge_flutter/core/mock/movimentos_mock.dart';
import 'package:sge_flutter/core/mock/produtos_mock.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/models/movimento_caixa_model.dart';
import 'package:sge_flutter/models/produto_model.dart';

class HiveConfig {
  static Future<void> start() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProdutoModelAdapter());
    Hive.registerAdapter(MovimentoCaixaModelAdapter());
    Hive.registerAdapter(ClienteModelAdapter());

    await Hive.deleteBoxFromDisk('produtos');

    await Hive.openBox<ProdutoModel>('produtos');
    await Hive.openBox<MovimentoCaixaModel>('movimentos');
    await Hive.openBox<ClienteModel>('clientes');

    await _popularProdutosMock();
    await _popularMovimentacoesMock();
    await _popularClientesMock();
  }

  static Box<ProdutoModel> get produtoBox => Hive.box<ProdutoModel>('produtos');
  static Box<MovimentoCaixaModel> get movimentoBox =>
      Hive.box<MovimentoCaixaModel>('movimentos');
  static Box<ClienteModel> get clienteBox => Hive.box<ClienteModel>('clientes');

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

  static Future<void> _popularMovimentacoesMock() async {
    final movimentoBox = Hive.box<MovimentoCaixaModel>('movimentos');
    if (movimentoBox.isEmpty) {
      final movimentos = MovimentosMock.gerarMovimentacoes();
      for (var movimento in movimentos) {
        await movimentoBox.put(movimento.id, movimento);
      }
      print('✅ Mock de movimentações de caixa criado!');
    } else {
      print('ℹ️ Movimentações já existentes, mock não necessário.');
    }
  }

  static Future<void> _popularClientesMock() async {
    final clienteBox = Hive.box<ClienteModel>('clientes');
    if (clienteBox.isEmpty) {
      final clientes = ClientesMock.gerarClientes();
      for (var cliente in clientes) {
        await clienteBox.put(cliente.id, cliente);
      }
      print('✅ Mock de clientes criado!');
    } else {
      print('ℹ️ Clientes já existentes, mock não necessário.');
    }
  }
}
