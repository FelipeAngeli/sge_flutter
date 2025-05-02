import 'package:hive_flutter/hive_flutter.dart';
import 'package:sge_flutter/models/movimento_financeiro_model.dart';
import 'package:sge_flutter/core/storage/hive_config.dart';
import 'package:uuid/uuid.dart';

class FinanceiroService {
  final Box<MovimentoFinanceiroModel> _movimentoBox = HiveConfig.movimentoBox;
  final _uuid = const Uuid();

  FinanceiroService();

  List<MovimentoFinanceiroModel> listarMovimentacoes() {
    return _movimentoBox.values.toList();
  }

  Future<void> adicionarMovimentacao(MovimentoFinanceiroModel movimento) async {
    await _movimentoBox.put(movimento.id, movimento);
  }

  Future<void> registrarEntradaVenda({
    required double valor,
    required String descricao,
  }) async {
    final movimento = MovimentoFinanceiroModel(
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
    final movimento = MovimentoFinanceiroModel(
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

  List<MovimentoFinanceiroModel> listarMovimentacoesUltimosDias(int dias) {
    final agora = DateTime.now();
    return _movimentoBox.values
        .where((mov) => agora.difference(mov.data).inDays <= dias)
        .toList();
  }
}
