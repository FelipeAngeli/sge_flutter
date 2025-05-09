import '../../../models/produto_model.dart';

sealed class ProdutoState {}

class ProdutoInitial extends ProdutoState {}

class ProdutoLoading extends ProdutoState {}

class ProdutoSuccess extends ProdutoState {
  final List<ProdutoModel> produtos;
  ProdutoSuccess(this.produtos);
}

class ProdutoFailure extends ProdutoState {
  final String error;
  ProdutoFailure(this.error);
}
