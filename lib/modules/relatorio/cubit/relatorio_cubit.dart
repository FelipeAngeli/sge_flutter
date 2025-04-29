import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/produto_service.dart';
import 'relatorio_state.dart';

class RelatorioCubit extends Cubit<RelatorioState> {
  final ProdutoService _service;

  RelatorioCubit(this._service) : super(RelatorioInitial());

  Future<void> gerarRelatorio() async {
    emit(RelatorioLoading());
    final produtos = await _service.listarProdutos();
    emit(RelatorioLoaded(produtos));
  }
}
