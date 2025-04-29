// lib/modules/relatorio/cubit/relatorio_state.dart
import '../../../models/produto_model.dart';

abstract class RelatorioState {}

class RelatorioInitial extends RelatorioState {}

class RelatorioLoading extends RelatorioState {}

class RelatorioLoaded extends RelatorioState {
  final List<ProdutoModel> produtos;
  RelatorioLoaded(this.produtos);
}

class RelatorioError extends RelatorioState {
  final String message;
  RelatorioError(this.message);
}
