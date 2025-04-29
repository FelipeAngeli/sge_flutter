import 'package:sge_flutter/models/produto_model.dart';

abstract class EstoqueState {}

class EstoqueInitial extends EstoqueState {}

class EstoqueLoading extends EstoqueState {}

class EstoqueLoaded extends EstoqueState {
  final List<ProdutoModel> produtos;

  EstoqueLoaded(this.produtos);
}

class EstoqueError extends EstoqueState {
  final String message;

  EstoqueError(this.message);
}
