import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/caixa_service.dart';
import '../../models/movimento_caixa_model.dart';

class RelatorioCubit extends Cubit<List<MovimentoCaixaModel>> {
  final CaixaService _service;

  RelatorioCubit(this._service) : super([]);

  Future<void> loadMovimentos() async {
    final movimentos = _service.listarMovimentos();
    emit(movimentos);
  }
}
