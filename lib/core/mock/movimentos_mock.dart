import 'package:sge_flutter/models/movimento_financeiro_model.dart';

class MovimentosMock {
  static List<MovimentoFinanceiroModel> gerarMovimentacoes() {
    final timestamp = DateTime.now();

    return [
      MovimentoFinanceiroModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        descricao: 'Venda Produto A',
        valor: 150.00,
        tipo: 'entrada',
        data: timestamp,
      ),
      MovimentoFinanceiroModel(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        descricao: 'Compra de Insumos',
        valor: 80.00,
        tipo: 'saida',
        data: timestamp.subtract(const Duration(days: 1)),
      ),
    ];
  }
}
