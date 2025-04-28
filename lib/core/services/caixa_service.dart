import 'package:hive/hive.dart';
import '../../models/movimento_caixa_model.dart';

class CaixaService {
  final _box = Hive.box<MovimentoCaixaModel>('movimentos');

  Future<void> salvarMovimento(MovimentoCaixaModel movimento) async {
    await _box.put(movimento.id, movimento);
  }

  List<MovimentoCaixaModel> listarMovimentos() {
    return _box.values.toList();
  }
}
