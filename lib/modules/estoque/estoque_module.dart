import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/modules/estoque/pages/estoque_list_page.dart';
import 'package:sge_flutter/core/services/financeiro_service.dart';
import 'package:sge_flutter/modules/produto/produto_module.dart';

class EstoqueModule extends Module {
  @override
  List<Module> get imports => [
        ProdutoModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton<FinanceiroService>(FinanceiroService.new);
    i.addLazySingleton<EstoqueCubit>(() => EstoqueCubit(
          produtoService: i.get(),
          financeiroService: i.get(),
        ));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<EstoqueCubit>()..loadEstoque(),
        child: const EstoqueListPage(),
      ),
    );
  }
}
