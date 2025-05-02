import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/core/mock/cliente_mock.dart';
import 'package:sge_flutter/core/mock/contas_mock.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/models/compra_model.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/models/movimento_financeiro_model.dart';
import 'package:sge_flutter/models/lancamento_model.dart';
import 'package:sge_flutter/core/mock/movimentos_mock.dart';
import 'package:sge_flutter/core/mock/produtos_mock.dart';

class HiveConfig {
  static Future<void> start() async {
    await Hive.initFlutter();

    // ⚠️ Só usar durante desenvolvimento (limpa tudo)
    // await _clearBoxes();

    _registerAdapters();
    await _openBoxes();
    await _populateMockData();
  }

  static Future<void> _clearBoxes() async {
    await Hive.deleteBoxFromDisk('produtos');
    await Hive.deleteBoxFromDisk('movimentos');
    await Hive.deleteBoxFromDisk('clientes');
    await Hive.deleteBoxFromDisk('compras');
    await Hive.deleteBoxFromDisk('lancamentos');
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
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(LancamentoModelAdapter());
    }
  }

  static Future<void> _openBoxes() async {
    await Hive.openBox<ProdutoModel>('produtos');
    await Hive.openBox<MovimentoFinanceiroModel>('movimentos');
    await Hive.openBox<ClienteModel>('clientes');
    await Hive.openBox<CompraModel>('compras');
    await Hive.openBox<LancamentoModel>('lancamentos');
  }

  static Box<ProdutoModel> get produtoBox => Hive.box<ProdutoModel>('produtos');
  static Box<MovimentoFinanceiroModel> get movimentoBox =>
      Hive.box<MovimentoFinanceiroModel>('movimentos');
  static Box<ClienteModel> get clienteBox => Hive.box<ClienteModel>('clientes');
  static Box<CompraModel> get compraBox => Hive.box<CompraModel>('compras');
  static Box<LancamentoModel> get lancamentoBox =>
      Hive.box<LancamentoModel>('lancamentos');

  static Future<void> _populateMockData() async {
    await _popularProdutosMock();
    await _popularMovimentacoesMock();
    await _popularClientesMock();
    await _popularLancamentosMock();
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

  static Future<void> _popularLancamentosMock() async {
    if (lancamentoBox.isEmpty) {
      final lancamentos = LancamentoMock.gerarLancamentos();
      for (var lancamento in lancamentos) {
        await lancamentoBox.put(lancamento.id, lancamento);
      }
      print('✅ Mock de lançamentos criado!');
    }
  }
}
