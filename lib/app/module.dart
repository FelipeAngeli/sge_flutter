import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void routes(RouteManager r) {
    // r.module('/', module: AuthModule());
    // r.module('/produtos', module: ProdutoModule());
    // r.module('/caixa', module: CaixaModule());
    // r.module('/estoque', module: EstoqueModule());
    // r.module('/relatorios', module: RelatorioModule());
  }
}
