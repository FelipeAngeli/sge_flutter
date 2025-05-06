import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/cliente_service.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/core/services/venda_service.dart';
import 'package:sge_flutter/models/compra_model.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'venda_state.dart';

class VendaCubit extends Cubit<VendaState> {
  final ProdutoService _produtoService;
  final ClienteService _clienteService;
  final VendaService _vendaService;

  VendaCubit(
    this._produtoService,
    this._clienteService,
    this._vendaService,
  ) : super(const VendaInitial());

  Future<void> carregarProdutosEClientes() async {
    print('🔄 Iniciando carregamento de produtos e clientes...');
    emit(const VendaLoading());
    try {
      print('📦 Buscando produtos...');
      final produtos = await _produtoService.listarProdutos();
      print('✅ Produtos carregados: ${produtos.length}');

      print('👥 Buscando clientes...');
      final clientes = await _clienteService.listarClientes();
      print('✅ Clientes carregados: ${clientes.length}');

      emit(VendaLoaded(produtos: produtos, clientes: clientes));
      print('✅ Estado atualizado com sucesso');
    } catch (e) {
      print('❌ Erro ao carregar dados: $e');
      emit(VendaFailure('Erro ao carregar dados: $e'));
    }
  }

  void selecionarProduto(ProdutoModel produto) {
    final currentState = state;
    if (currentState is VendaLoaded) {
      emit(currentState.copyWith(
        produtoSelecionado: produto,
        quantidade: 1,
      ));
    }
  }

  void selecionarCliente(ClienteModel cliente) {
    final currentState = state;
    if (currentState is VendaLoaded) {
      emit(currentState.copyWith(clienteSelecionado: cliente));
    }
  }

  void atualizarQuantidade(int novaQuantidade) {
    final currentState = state;
    if (currentState is VendaLoaded) {
      emit(currentState.copyWith(quantidade: novaQuantidade));
    }
  }

  Future<void> finalizarVenda() async {
    print('🔄 Iniciando finalização da venda...');
    final currentState = state;
    print('📊 Estado atual: ${currentState.runtimeType}');

    if (currentState is VendaLoaded &&
        currentState.produtoSelecionado != null &&
        currentState.clienteSelecionado != null) {
      print('✅ Estado válido para finalização');
      print('📦 Produto selecionado: ${currentState.produtoSelecionado?.nome}');
      print('👥 Cliente selecionado: ${currentState.clienteSelecionado?.nome}');
      print('🔢 Quantidade: ${currentState.quantidade}');

      emit(const VendaLoading());
      print('🔄 Estado alterado para Loading');

      final produto = currentState.produtoSelecionado!;
      final cliente = currentState.clienteSelecionado!;
      final quantidade = currentState.quantidade;

      print('📊 Dados da venda:');
      print('- Produto: ${produto.nome}');
      print('- Cliente: ${cliente.nome}');
      print('- Quantidade: $quantidade');
      print('- Estoque atual: ${produto.estoque}');
      print('- Preço unitário: ${produto.preco}');
      print('- Valor total: ${produto.preco * quantidade}');

      if (!cliente.ativo) {
        print('❌ Cliente inativo');
        emit(const VendaFailure('Cliente inativo não pode realizar compras.'));
        return;
      }

      if (quantidade <= 0) {
        print('❌ Quantidade inválida');
        emit(const VendaFailure('A quantidade deve ser maior que zero.'));
        return;
      }

      if (produto.estoque < quantidade) {
        print('❌ Estoque insuficiente');
        emit(const VendaFailure('Estoque insuficiente.'));
        return;
      }

      try {
        print('📦 Atualizando estoque do produto...');
        print('- Estoque antes: ${produto.estoque}');
        produto.estoque -= quantidade;
        produto.vendas += quantidade;
        print('- Estoque depois: ${produto.estoque}');
        print('- Vendas incrementadas: ${produto.vendas}');

        print('🔄 Chamando atualizarProduto...');
        await _produtoService.atualizarProduto(produto);
        print('✅ Estoque atualizado');

        print('📝 Atualizando histórico do cliente...');
        cliente.historicoCompras ??= [];
        final compra = CompraModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          clienteId: cliente.id,
          produtoNome: produto.nome,
          quantidade: quantidade,
          precoUnitario: produto.preco,
          data: DateTime.now(),
        );
        print('📊 Nova compra:');
        print('- ID: ${compra.id}');
        print('- Produto: ${compra.produtoNome}');
        print('- Quantidade: ${compra.quantidade}');
        print('- Preço: ${compra.precoUnitario}');

        cliente.historicoCompras.add(compra);
        print('🔄 Chamando atualizarCliente...');
        await _clienteService.atualizarCliente(cliente);
        print('✅ Histórico atualizado');

        print('💰 Registrando venda e gerando recibo...');
        print('🔄 Chamando finalizarVenda no VendaService...');
        await _vendaService.finalizarVenda(
          cliente: cliente,
          produto: produto,
          quantidade: quantidade,
          valorTotal: produto.preco * quantidade,
        );
        print('✅ Venda registrada e recibo gerado');

        print('🔄 Atualizando lista de produtos e clientes...');
        final produtosAtualizados = await _produtoService.listarProdutos();
        final clientesAtualizados = await _clienteService.listarClientes();
        print('✅ Listas atualizadas');
        print('- Produtos atualizados: ${produtosAtualizados.length}');
        print('- Clientes atualizados: ${clientesAtualizados.length}');

        emit(VendaLoaded(
          produtos: produtosAtualizados,
          clientes: clientesAtualizados,
        ));
        print('✅ Estado atualizado com novos dados');

        emit(const VendaSuccess('Venda finalizada com sucesso!'));
        print('✅ Venda finalizada com sucesso');
      } catch (e, stackTrace) {
        print('❌ Erro ao finalizar venda: $e');
        print('📚 Stack trace: $stackTrace');
        emit(VendaFailure('Erro ao registrar venda: $e'));
      }
    } else {
      print('❌ Estado inválido para finalização');
      print('- Estado atual: ${state.runtimeType}');
      print(
          '- Produto selecionado: ${currentState is VendaLoaded ? currentState.produtoSelecionado != null : false}');
      print(
          '- Cliente selecionado: ${currentState is VendaLoaded ? currentState.clienteSelecionado != null : false}');
      emit(const VendaFailure(
          'Selecione o produto e o cliente antes de finalizar.'));
    }
  }
}
