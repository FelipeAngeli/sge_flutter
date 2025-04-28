import 'package:hive_flutter/hive_flutter.dart';
import '../../models/produto_model.dart';
import '../../models/movimento_caixa_model.dart';

class HiveConfig {
  static Future<void> start() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProdutoModelAdapter());
    Hive.registerAdapter(MovimentoCaixaModelAdapter());

    await Hive.openBox<ProdutoModel>('produtos');
    await Hive.openBox<MovimentoCaixaModel>('movimentos');
  }
}
