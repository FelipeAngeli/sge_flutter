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
import 'package:sge_flutter/models/recibo_model.dart';
import 'package:sge_flutter/models/venda_model.dart';

class HiveConfig {
  static Future<void> start() async {
    print('🔧 Inicializando Hive...');
    await Hive.initFlutter();

    _registerAdapters();
    await _openBoxes();
    await _populateMockData();
    print('✅ Hive pronto!');
  }

  static Future<void> _clearBoxes() async {
    final boxes = [
      'produtos',
      'movimentos',
      'clientes',
      'compras',
      'lancamentos',
      'fornecedores',
      'recibos',
      'vendas',
    ];
    for (final box in boxes) {
      await Hive.deleteBoxFromDisk(box);
      print('🗑 Box $box limpo');
    }
  }

  static void _registerAdapters() {
    print('📦 Registrando adapters...');
    if (!Hive.isAdapterRegistered(0))
      Hive.registerAdapter(ProdutoModelAdapter());
    if (!Hive.isAdapterRegistered(1))
      Hive.registerAdapter(MovimentoFinanceiroModelAdapter());
    if (!Hive.isAdapterRegistered(2))
      Hive.registerAdapter(ClienteModelAdapter());
    if (!Hive.isAdapterRegistered(9))
      Hive.registerAdapter(CompraModelAdapter());
    if (!Hive.isAdapterRegistered(4))
      Hive.registerAdapter(LancamentoModelAdapter());
    if (!Hive.isAdapterRegistered(6))
      Hive.registerAdapter(FornecedorModelAdapter());
    if (!Hive.isAdapterRegistered(7))
      Hive.registerAdapter(ReciboModelAdapter());
    if (!Hive.isAdapterRegistered(8)) Hive.registerAdapter(VendaModelAdapter());
  }

  static Future<void> _openBoxes() async {
    print('📦 Abrindo boxes...');
    await Hive.openBox<ProdutoModel>('produtos');
    await Hive.openBox<MovimentoFinanceiroModel>('movimentos');
    await Hive.openBox<ClienteModel>('clientes');
    await Hive.openBox<CompraModel>('compras');
    await Hive.openBox<LancamentoModel>('lancamentos');
    await Hive.openBox<FornecedorModel>('fornecedores');
    await Hive.openBox<ReciboModel>('recibos');
    await Hive.openBox<VendaModel>('vendas');
    print('✔ Todos os boxes foram abertos');

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
  static Box<ReciboModel> get reciboBox => Hive.box<ReciboModel>('recibos');
  static Box<VendaModel> get vendaBox => Hive.box<VendaModel>('vendas');

  static Future<void> _populateMockData() async {
    print('📦 Populando dados mock...');
    await _popularProdutosMock();
    await _popularMovimentacoesMock();
    await _popularClientesMock();
    await _popularLancamentosMock();
    await _popularFornecedoresMock();
    await _popularVendasMock();
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
      print('ℹ️ Produtos já estão populados');
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
      print('ℹ️ Movimentações já estão populadas');
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
      print('ℹ️ Clientes já estão populados');
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
      print('ℹ️ Lançamentos já estão populados');
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
      print('✅ Mock de fornecedores criado!');
    } else {
      print('ℹ️ Fornecedores já estão populados');
    }
  }

  static Future<void> _popularVendasMock() async {
    if (vendaBox.isEmpty) {
      final clientes = clienteBox.values.toList();
      final produtos = produtoBox.values.toList();
      if (clientes.isEmpty || produtos.isEmpty) {
        print('⚠️ Clientes ou produtos vazios para gerar vendas mock');
        return;
      }

      for (int i = 0; i < 5; i++) {
        final cliente = clientes[i % clientes.length];
        final produto = produtos[i % produtos.length];
        final venda = VendaModel(
          id: 'venda_$i',
          cliente: cliente.nome, // ✅ nome do cliente
          produto: produto.nome, // ✅ nome do produto
          quantidade: i + 1,
          valorTotal: produto.preco * (i + 1),
          data: DateTime.now().toIso8601String(),
        );
        await vendaBox.put(venda.id, venda);
      }
      print('✅ Mock de vendas criado!');
    } else {
      print('ℹ️ Vendas já estão populadas');
    }
  }

  static Future<void> _migrarFornecedoresAntigos() async {
    print('🔄 Migrando fornecedores antigos...');
    for (var fornecedor in fornecedorBox.values) {
      if (fornecedor.cnpj == null) {
        fornecedor.cnpj = '';
        await fornecedor.save();
      }
    }
    print('✅ Migração concluída!');
  }
}
