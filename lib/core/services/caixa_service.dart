import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/models/movimento_caixa_model.dart';
import 'package:sge_flutter/core/storage/hive_config.dart';
import 'package:uuid/uuid.dart';

class CaixaService {
  final Box<MovimentoCaixaModel> _movimentoBox = HiveConfig.movimentoBox;
  final _uuid = const Uuid();

  CaixaService();

  List<MovimentoCaixaModel> listarMovimentacoes() {
    return _movimentoBox.values.toList();
  }

  Future<void> adicionarMovimentacao(MovimentoCaixaModel movimento) async {
    await _movimentoBox.put(movimento.id, movimento);
  }

  Future<void> registrarEntradaVenda({
    required double valor,
    required String descricao,
  }) async {
    final movimento = MovimentoCaixaModel(
      id: _uuid.v4(),
      descricao: descricao,
      valor: valor,
      tipo: 'entrada',
      data: DateTime.now(),
    );

    await adicionarMovimentacao(movimento);
  }

  Future<void> registrarSaida({
    required double valor,
    required String descricao,
  }) async {
    final movimento = MovimentoCaixaModel(
      id: _uuid.v4(),
      descricao: descricao,
      valor: valor,
      tipo: 'saida',
      data: DateTime.now(),
    );

    await adicionarMovimentacao(movimento);
  }

  double calcularTotalEntradasUltimosDias(int dias) {
    final agora = DateTime.now();
    return _movimentoBox.values
        .where((mov) =>
            mov.tipo == 'entrada' && agora.difference(mov.data).inDays <= dias)
        .fold(0.0, (sum, mov) => sum + mov.valor);
  }

  double calcularTotalSaidasUltimosDias(int dias) {
    final agora = DateTime.now();
    return _movimentoBox.values
        .where((mov) =>
            mov.tipo == 'saida' && agora.difference(mov.data).inDays <= dias)
        .fold(0.0, (sum, mov) => sum + mov.valor);
  }

  List<MovimentoCaixaModel> listarMovimentacoesUltimosDias(int dias) {
    final agora = DateTime.now();
    return _movimentoBox.values
        .where((mov) => agora.difference(mov.data).inDays <= dias)
        .toList();
  }
}
