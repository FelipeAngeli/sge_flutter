import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import '../core/services/caixa_service.dart';
import '../core/services/produto_service.dart';
import '../models/movimento_caixa_model.dart';
import '../models/produto_model.dart';
import '../modules/auth/auth_module.dart';
import '../modules/caixa/caixa_module.dart';
import '../modules/estoque/estoque_module.dart';
import '../modules/produto/produto_module.dart';
import '../modules/relatorio/relatorio_module.dart';
import '../modules/home/home_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ProdutoService>(
        () => ProdutoService(Hive.box<ProdutoModel>('produtos')));
    i.addSingleton<CaixaService>(
        () => CaixaService(Hive.box<MovimentoCaixaModel>('movimentos')));
  }

  @override
  void routes(r) {
    r.module('/', module: HomeModule()); // ATENÇÃO: agora é módulo Home
    r.module('/auth/', module: AuthModule());
    r.module('/produtos/', module: ProdutoModule());
    r.module('/caixa/', module: CaixaModule());
    r.module('/estoque/', module: EstoqueModule());
    r.module('/relatorios/', module: RelatorioModule());
  }
}
