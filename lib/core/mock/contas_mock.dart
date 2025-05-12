import 'package:sge_flutter/models/lancamento_model.dart';
import 'package:uuid/uuid.dart';

class LancamentoMock {
  static List<LancamentoModel> gerarLancamentos() {
    const uuid = Uuid();
    return [
      LancamentoModel(
        id: uuid.v4(),
        descricao: 'Conta de Luz',
        valor: 120.50,
        dataVencimento: DateTime.now().add(const Duration(days: 3)),
        pago: false,
      ),
      LancamentoModel(
        id: uuid.v4(),
        descricao: 'Internet',
        valor: 80.00,
        dataVencimento: DateTime.now().add(const Duration(days: 5)),
        pago: false,
      ),
      LancamentoModel(
        id: uuid.v4(),
        descricao: 'Aluguel',
        valor: 1500.00,
        dataVencimento: DateTime.now().add(const Duration(days: 1)),
        pago: false,
      ),
      LancamentoModel(
        id: uuid.v4(),
        descricao: 'Cliente X - Recebimento',
        valor: 2000.00,
        dataVencimento: DateTime.now().add(const Duration(days: 2)),
        pago: true,
      ),
    ];
  }
}
