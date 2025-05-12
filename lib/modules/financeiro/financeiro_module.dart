import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/financeiro_service.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/modules/financeiro/cubit/financeiro_cubit.dart';
import 'package:sge_flutter/modules/financeiro/pages/contas_form_page.dart';
import 'package:sge_flutter/modules/financeiro/pages/contas_list_page.dart';
import 'package:sge_flutter/modules/financeiro/pages/financeiro_list_page.dart';

class FinanceiroModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<FinanceiroService>(FinanceiroService.new);
    i.addSingleton<ProdutoService>(ProdutoService.new);
    i.addLazySingleton<FinanceiroCubit>(() => FinanceiroCubit(
          financeiroService: Modular.get<FinanceiroService>(),
          produtoService: Modular.get<ProdutoService>(),
        ));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<FinanceiroCubit>(),
        child: const FinanceiroListPage(),
      ),
    );
    r.child(
      '/contas',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<FinanceiroCubit>(),
        child: const ContasListPage(),
      ),
    );
    r.child(
      '/conta-form',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<FinanceiroCubit>(),
        child: const ContaFormPage(),
      ),
    );
  }
}
