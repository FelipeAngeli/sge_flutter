import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/app/app_widget.dart';
import 'package:sge_flutter/core/services/caixa_service.dart';
import 'package:sge_flutter/modules/home/home_module.dart';
import 'package:sge_flutter/modules/estoque/estoque_module.dart';
import 'package:sge_flutter/modules/caixa/caixa_module.dart';
import 'package:sge_flutter/modules/home/cubit/home_cubit.dart';
import 'package:sge_flutter/modules/produto/produto_module.dart';
import 'package:sge_flutter/modules/relatorio/relatorio_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<HomeCubit>(HomeCubit.new);
    i.addSingleton<CaixaService>(CaixaService.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
    r.module('/produtos', module: ProdutoModule());
    r.module('/estoque', module: EstoqueModule());
    r.module('/caixa', module: CaixaModule());
    r.module('/relatorios', module: RelatorioModule());
  }

  @override
  Widget get bootstrap => const AppWidget();
}
