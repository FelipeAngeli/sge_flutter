import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/auth/login_module.dart';
import 'package:sge_flutter/modules/caixa/caixa_module.dart';
import 'package:sge_flutter/modules/estoque/estoque_module.dart';
import 'package:sge_flutter/modules/produto/cadastro_module.dart';
import 'package:sge_flutter/modules/relatorios/relatorio_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
    r.module('/produtos', module: ProdutoModule());
    r.module('/caixa', module: CaixaModule());
    r.module('/estoque', module: EstoqueModule());
    r.module('/relatorios', module: RelatorioModule());
  }
}
