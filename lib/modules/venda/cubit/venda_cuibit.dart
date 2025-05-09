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
    emit(const VendaLoading());
    try {
      final produtos = await _produtoService.listarProdutos();
      final clientes = await _clienteService.listarClientes();
      emit(VendaLoaded(produtos: produtos, clientes: clientes));
    } catch (e) {
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
    final currentState = state;

    if (currentState is VendaLoaded &&
        currentState.produtoSelecionado != null &&
        currentState.clienteSelecionado != null) {
      emit(const VendaLoading());

      final produto = currentState.produtoSelecionado!;
      final cliente = currentState.clienteSelecionado!;
      final quantidade = currentState.quantidade;

      if (!cliente.ativo) {
        emit(const VendaFailure('Cliente inativo não pode realizar compras.'));
        return;
      }

      if (quantidade <= 0) {
        emit(const VendaFailure('A quantidade deve ser maior que zero.'));
        return;
      }

      if (produto.estoque < quantidade) {
        emit(const VendaFailure('Estoque insuficiente.'));
        return;
      }

      try {
        produto.estoque -= quantidade;
        produto.vendas += quantidade;
        await _produtoService.atualizarProduto(produto);

        cliente.historicoCompras;
        cliente.historicoCompras.add(CompraModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          clienteId: cliente.id,
          produtoNome: produto.nome,
          quantidade: quantidade,
          precoUnitario: produto.preco,
          data: DateTime.now(),
        ));
        await _clienteService.atualizarCliente(cliente);

        await _vendaService.finalizarVenda(
          cliente: cliente,
          produto: produto,
          quantidade: quantidade,
          valorTotal: produto.preco * quantidade,
        );

        final produtosAtualizados = await _produtoService.listarProdutos();
        final clientesAtualizados = await _clienteService.listarClientes();

        emit(VendaLoaded(
          produtos: produtosAtualizados,
          clientes: clientesAtualizados,
        ));

        emit(const VendaSuccess('Venda finalizada com sucesso!'));
      } catch (e) {
        emit(VendaFailure('Erro ao registrar venda: $e'));
      }
    } else {
      emit(const VendaFailure(
          'Selecione o produto e o cliente antes de finalizar.'));
    }
  }
}
