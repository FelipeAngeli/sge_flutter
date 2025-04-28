import 'package:hive_flutter/hive_flutter.dart';
import '../../models/produto_model.dart';
import '../../models/movimento_caixa_model.dart';
import '../../models/usuario_model.dart';

class HiveConfig {
  static Future<void> start() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UsuarioModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ProdutoModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(MovimentoCaixaModelAdapter());
    }

    await Hive.openBox<ProdutoModel>('produtos');
    await Hive.openBox<MovimentoCaixaModel>('movimentos');
    await Hive.openBox<UsuarioModel>('usuarios');

    // Criar usuário de teste se não existir
    final usuarioBox = Hive.box<UsuarioModel>('usuarios');
    if (usuarioBox.isEmpty) {
      final usuarioTeste = UsuarioModel(
        id: '1',
        nome: 'Usuário Teste',
        email: 'teste@teste.com',
        senha: '123456',
      );
      await usuarioBox.add(usuarioTeste);
    }
  }
}
