// lib/modules/relatorio/cubit/relatorio_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/produto_service.dart';
import '../../../models/produto_model.dart';
import 'relatorio_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RelatorioCubit extends Cubit<RelatorioState> {
  final ProdutoService _service = Modular.get<ProdutoService>();

  RelatorioCubit() : super(RelatorioInitial());

  Future<void> gerarRelatorio() async {
    emit(RelatorioLoading());
    final produtos = await _service.listarProdutos();
    emit(RelatorioLoaded(produtos));
  }
}
