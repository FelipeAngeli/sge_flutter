import 'package:sge_flutter/models/movimento_caixa_model.dart';

class MovimentosMock {
  static List<MovimentoCaixaModel> gerarMovimentacoes() {
    final timestamp = DateTime.now();

    return [
      MovimentoCaixaModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        descricao: 'Venda Produto A',
        valor: 150.00,
        tipo: 'entrada',
        data: timestamp,
      ),
      MovimentoCaixaModel(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        descricao: 'Compra de Insumos',
        valor: 80.00,
        tipo: 'saida',
        data: timestamp.subtract(const Duration(days: 1)),
      ),
    ];
  }
}
