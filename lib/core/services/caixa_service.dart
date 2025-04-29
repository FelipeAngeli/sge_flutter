import 'package:hive/hive.dart';
import '../../models/movimento_caixa_model.dart';

class CaixaService {
  final Box<MovimentoCaixaModel> _box;

  CaixaService(this._box);

  Future<void> registrarMovimento(MovimentoCaixaModel movimento) async {
    await _box.put(movimento.id, movimento);
  }

  Future<List<MovimentoCaixaModel>> listarMovimentos() async {
    return _box.values.toList();
  }

  Future<double> calcularSaldo() async {
    final movimentos = _box.values.toList();
    double saldo = 0.0;
    for (var movimento in movimentos) {
      saldo += movimento.tipo == 'entrada' ? movimento.valor : -movimento.valor;
    }
    return saldo;
  }
}
