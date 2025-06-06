import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/app/app_widget.dart';
import 'package:sge_flutter/core/services/financeiro_service.dart';
import 'package:sge_flutter/core/services/recibo_service.dart';
import 'package:sge_flutter/modules/auth/auth_module.dart';
import 'package:sge_flutter/modules/clientes/clientes_module.dart';
import 'package:sge_flutter/modules/estoque/estoque_module.dart';
import 'package:sge_flutter/modules/financeiro/financeiro_module.dart';
import 'package:sge_flutter/modules/home/cubit/home_cubit.dart';
import 'package:sge_flutter/modules/home/home_module.dart';
import 'package:sge_flutter/modules/produto/produto_module.dart';
import 'package:sge_flutter/modules/recibo/recibo_module.dart';
import 'package:sge_flutter/modules/relatorio/relatorio_module.dart';
import 'package:sge_flutter/modules/users/users_module.dart';
import 'package:sge_flutter/modules/venda/venda_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<HomeCubit>(HomeCubit.new);
    i.addSingleton<FinanceiroService>(FinanceiroService.new);
    i.addSingleton<ReciboService>(ReciboService.new);
  }

  @override
  void routes(RouteManager r) {
    // Começar com AuthModule
    r.module('/', module: AuthModule());
    r.module('/home', module: HomeModule());
    r.module('/produtos', module: ProdutoModule());
    r.module('/estoque', module: EstoqueModule());
    r.module('/financeiro', module: FinanceiroModule());
    r.module('/relatorios', module: RelatorioModule());
    r.module('/venda', module: VendaModule());
    r.module('/clientes', module: ClientesModule());
    r.module('/recibo', module: ReciboModule());
    r.module('/users', module: UsersModule());
  }

  Widget get bootstrap => const AppWidget();
}
