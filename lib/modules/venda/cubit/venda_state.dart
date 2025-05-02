import 'package:equatable/equatable.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/models/cliente_model.dart';

abstract class VendaState extends Equatable {
  const VendaState();

  @override
  List<Object?> get props => [];
}

class VendaInitial extends VendaState {
  const VendaInitial();
}

class VendaLoading extends VendaState {
  const VendaLoading();
}

class VendaLoaded extends VendaState {
  final List<ProdutoModel> produtos;
  final List<ClienteModel> clientes;
  final ProdutoModel? produtoSelecionado;
  final ClienteModel? clienteSelecionado;
  final int quantidade;

  const VendaLoaded({
    required this.produtos,
    required this.clientes,
    this.produtoSelecionado,
    this.clienteSelecionado,
    this.quantidade = 1,
  });

  double get subtotal {
    if (produtoSelecionado != null) {
      return produtoSelecionado!.preco * quantidade;
    }
    return 0.0;
  }

  VendaLoaded copyWith({
    List<ProdutoModel>? produtos,
    List<ClienteModel>? clientes,
    ProdutoModel? produtoSelecionado,
    ClienteModel? clienteSelecionado,
    int? quantidade,
  }) {
    return VendaLoaded(
      produtos: produtos ?? this.produtos,
      clientes: clientes ?? this.clientes,
      produtoSelecionado: produtoSelecionado ?? this.produtoSelecionado,
      clienteSelecionado: clienteSelecionado ?? this.clienteSelecionado,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  @override
  List<Object?> get props => [
        produtos,
        clientes,
        produtoSelecionado,
        clienteSelecionado,
        quantidade,
      ];
}

class VendaFailure extends VendaState {
  final String message;

  const VendaFailure(this.message);

  @override
  List<Object?> get props => [message];
}
