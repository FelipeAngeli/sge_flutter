import '../../../models/produto_model.dart';

abstract class ProdutoState {}

class ProdutoInitial extends ProdutoState {}

class ProdutoLoading extends ProdutoState {}

class ProdutoLoaded extends ProdutoState {
  final List<ProdutoModel> produtos;
  ProdutoLoaded(this.produtos);
}

class ProdutoError extends ProdutoState {
  final String message;
  ProdutoError(this.message);
}
