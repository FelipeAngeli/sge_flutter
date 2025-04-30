import 'package:equatable/equatable.dart';
import 'package:sge_flutter/models/produto_model.dart';

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
  final ProdutoModel? produtoSelecionado;
  final int quantidade;

  const VendaLoaded({
    required this.produtos,
    this.produtoSelecionado,
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
    ProdutoModel? produtoSelecionado,
    int? quantidade,
  }) {
    return VendaLoaded(
      produtos: produtos ?? this.produtos,
      produtoSelecionado: produtoSelecionado ?? this.produtoSelecionado,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  @override
  List<Object?> get props => [produtos, produtoSelecionado, quantidade];
}

class VendaFailure extends VendaState {
  final String message;

  const VendaFailure(this.message);

  @override
  List<Object?> get props => [message];
}
