import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/core/mock/cliente_mock.dart';
import 'package:sge_flutter/core/mock/contas_mock.dart';
import 'package:sge_flutter/core/mock/movimentos_mock.dart';
import 'package:sge_flutter/core/mock/produtos_mock.dart';
import 'package:sge_flutter/core/mock/fornecedores_mock.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/models/compra_model.dart';
import 'package:sge_flutter/models/fornecedor_model.dart';
import 'package:sge_flutter/models/lancamento_model.dart';
import 'package:sge_flutter/models/movimento_financeiro_model.dart';
import 'package:sge_flutter/models/produto_model.dart';

class HiveConfig {
  static Future<void> start() async {
    print('🔧 Inicializando Hive...');
    await Hive.initFlutter();

    // ⚠️ Só ativa isso 1x para limpar os dados antigos se der erro!
    // await _clearBoxes();

    _registerAdapters();
    await _openBoxes();
    await _populateMockData();
    print('✅ Hive pronto!');
  }

  static Future<void> _clearBoxes() async {
    await Hive.deleteBoxFromDisk('produtos');
    await Hive.deleteBoxFromDisk('movimentos');
    await Hive.deleteBoxFromDisk('clientes');
    await Hive.deleteBoxFromDisk('compras');
    await Hive.deleteBoxFromDisk('lancamentos');
    await Hive.deleteBoxFromDisk('fornecedores');
  }

  static void _registerAdapters() {
    print('📦 Registrando adapters...');
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProdutoModelAdapter());
      print('➡ ProdutoModelAdapter registrado');
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MovimentoFinanceiroModelAdapter());
      print('➡ MovimentoFinanceiroModelAdapter registrado');
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ClienteModelAdapter());
      print('➡ ClienteModelAdapter registrado');
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(CompraModelAdapter());
      print('➡ CompraModelAdapter registrado');
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(LancamentoModelAdapter());
      print('➡ LancamentoModelAdapter registrado');
    }
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(FornecedorModelAdapter());
      print('➡ FornecedorModelAdapter registrado');
    }
  }

  static Future<void> _openBoxes() async {
    print('📦 Abrindo boxes...');
    await Hive.openBox<ProdutoModel>('produtos');
    print('✔ Box produtos aberto');
    await Hive.openBox<MovimentoFinanceiroModel>('movimentos');
    print('✔ Box movimentos aberto');
    await Hive.openBox<ClienteModel>('clientes');
    print('✔ Box clientes aberto');
    await Hive.openBox<CompraModel>('compras');
    print('✔ Box compras aberto');
    await Hive.openBox<LancamentoModel>('lancamentos');
    print('✔ Box lancamentos aberto');
    await Hive.openBox<FornecedorModel>('fornecedores');
    print('✔ Box fornecedores aberto');

    await _migrarFornecedoresAntigos();
  }

  static Box<ProdutoModel> get produtoBox => Hive.box<ProdutoModel>('produtos');
  static Box<MovimentoFinanceiroModel> get movimentoBox =>
      Hive.box<MovimentoFinanceiroModel>('movimentos');
  static Box<ClienteModel> get clienteBox => Hive.box<ClienteModel>('clientes');
  static Box<CompraModel> get compraBox => Hive.box<CompraModel>('compras');
  static Box<LancamentoModel> get lancamentoBox =>
      Hive.box<LancamentoModel>('lancamentos');
  static Box<FornecedorModel> get fornecedorBox =>
      Hive.box<FornecedorModel>('fornecedores');

  static Future<void> _populateMockData() async {
    print('📦 Populando dados mock...');
    await _popularProdutosMock();
    await _popularMovimentacoesMock();
    await _popularClientesMock();
    await _popularLancamentosMock();
    await _popularFornecedoresMock();
    print('✅ Mock data populado');
  }

  static Future<void> _popularProdutosMock() async {
    if (produtoBox.isEmpty) {
      final produtos = ProdutosMock.gerarProdutos();
      for (var produto in produtos) {
        await produtoBox.put(produto.id, produto);
      }
      print('✅ Mock de produtos criado!');
    } else {
      print('ℹ️ Produtos já populados');
    }
  }

  static Future<void> _popularMovimentacoesMock() async {
    if (movimentoBox.isEmpty) {
      final movimentos = MovimentosMock.gerarMovimentacoes();
      for (var movimento in movimentos) {
        await movimentoBox.put(movimento.id, movimento);
      }
      print('✅ Mock de movimentações criado!');
    } else {
      print('ℹ️ Movimentações já populadas');
    }
  }

  static Future<void> _popularClientesMock() async {
    if (clienteBox.isEmpty) {
      final clientes = ClientesMock.gerarClientes();
      for (var cliente in clientes) {
        await clienteBox.put(cliente.id, cliente);
      }
      print('✅ Mock de clientes criado!');
    } else {
      print('ℹ️ Clientes já populados');
    }
  }

  static Future<void> _popularLancamentosMock() async {
    if (lancamentoBox.isEmpty) {
      final lancamentos = LancamentoMock.gerarLancamentos();
      for (var lancamento in lancamentos) {
        await lancamentoBox.put(lancamento.id, lancamento);
      }
      print('✅ Mock de lançamentos criado!');
    } else {
      print('ℹ️ Lançamentos já populados');
    }
  }

  static Future<void> _popularFornecedoresMock() async {
    if (fornecedorBox.isEmpty) {
      final produtos = produtoBox.values.toList();
      if (produtos.isEmpty) {
        print('⚠️ Nenhum produto encontrado para associar aos fornecedores');
        return;
      }

      final fornecedores =
          FornecedoresMock.gerarFornecedoresComProdutos(produtos);
      for (var fornecedor in fornecedores) {
        await fornecedorBox.put(fornecedor.id, fornecedor);
      }
      print('✅ Mock de fornecedores criado e associado a produtos!');
    } else {
      print('ℹ️ Fornecedores já populados');
    }
  }

  static Future<void> _migrarFornecedoresAntigos() async {
    print('🔄 Migrando fornecedores antigos...');
    final box = fornecedorBox;
    for (var fornecedor in box.values) {
      if (fornecedor.cnpj == null) {
        fornecedor.cnpj = '';
        await fornecedor.save();
      }
    }
    print('✅ Migração concluída!');
  }
}
