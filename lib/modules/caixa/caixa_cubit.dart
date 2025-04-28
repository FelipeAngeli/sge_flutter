import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/caixa_service.dart';
import '../../models/movimento_caixa_model.dart';
import 'package:uuid/uuid.dart';

class CaixaCubit extends Cubit<List<MovimentoCaixaModel>> {
  final CaixaService _service;

  CaixaCubit(this._service) : super([]);

  Future<void> loadMovimentos() async {
    final movimentos = _service.listarMovimentos();
    emit(movimentos);
  }

  Future<void> adicionarMovimento({
    required double valor,
    required String tipo,
    required String descricao,
  }) async {
    final novoMovimento = MovimentoCaixaModel(
      id: const Uuid().v4(),
      data: DateTime.now(),
      valor: valor,
      tipo: tipo,
      descricao: descricao,
    );
    await _service.salvarMovimento(novoMovimento);
    loadMovimentos();
  }
}
