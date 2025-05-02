import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/models/compra_model.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/core/mock/cliente_mock.dart';
import 'package:sge_flutter/core/mock/movimentos_mock.dart';
import 'package:sge_flutter/core/mock/produtos_mock.dart';

import '../../models/movimento_financeiro_model.dart';

class HiveConfig {
  static Future<void> start() async {
    await Hive.initFlutter();

    // ⚠️ Limpeza temporária: REMOVE ISSO DEPOIS DE TESTAR
    await Hive.deleteBoxFromDisk('produtos');
    await Hive.deleteBoxFromDisk('movimentos');
    await Hive.deleteBoxFromDisk('clientes');
    await Hive.deleteBoxFromDisk('compras');

    _registerAdapters();
    await _openBoxes();
    await _populateMockData();
  }

  static void _registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProdutoModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MovimentoFinanceiroModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ClienteModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(CompraModelAdapter());
    }
  }

  static Future<void> _openBoxes() async {
    await Hive.openBox<ProdutoModel>('produtos');
    await Hive.openBox<MovimentoFinanceiroModel>('movimentos');
    await Hive.openBox<ClienteModel>('clientes');
    await Hive.openBox<CompraModel>('compras');
  }

  static Box<ProdutoModel> get produtoBox => Hive.box<ProdutoModel>('produtos');
  static Box<MovimentoFinanceiroModel> get movimentoBox =>
      Hive.box<MovimentoFinanceiroModel>('movimentos');
  static Box<ClienteModel> get clienteBox => Hive.box<ClienteModel>('clientes');
  static Box<CompraModel> get compraBox => Hive.box<CompraModel>('compras');

  static Future<void> _populateMockData() async {
    await _popularProdutosMock();
    await _popularMovimentacoesMock();
    await _popularClientesMock();
  }

  static Future<void> _popularProdutosMock() async {
    if (produtoBox.isEmpty) {
      final produtos = ProdutosMock.gerarProdutos();
      for (var produto in produtos) {
        await produtoBox.put(produto.id, produto);
      }
      print('✅ Mock de produtos criado!');
    }
  }

  static Future<void> _popularMovimentacoesMock() async {
    if (movimentoBox.isEmpty) {
      final movimentos = MovimentosMock.gerarMovimentacoes();
      for (var movimento in movimentos) {
        await movimentoBox.put(movimento.id, movimento);
      }
      print('✅ Mock de movimentações criado!');
    }
  }

  static Future<void> _popularClientesMock() async {
    if (clienteBox.isEmpty) {
      final clientes = ClientesMock.gerarClientes();
      for (var cliente in clientes) {
        await clienteBox.put(cliente.id, cliente);
      }
      print('✅ Mock de clientes criado!');
    }
  }
}
