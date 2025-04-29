import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/modules/estoque/pages/estoque_list_page.dart';
import 'package:sge_flutter/modules/estoque/pages/estoque_form_page.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/core/services/caixa_service.dart';

class EstoqueModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ProdutoService>(ProdutoService.new);
    i.addSingleton<CaixaService>(CaixaService.new);
    i.addLazySingleton<EstoqueCubit>(() => EstoqueCubit(
          produtoService: Modular.get<ProdutoService>(),
          caixaService: Modular.get<CaixaService>(),
        ));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<EstoqueCubit>(),
        child: const EstoqueListPage(),
      ),
    );
    r.child(
      '/form',
      child: (context) => BlocProvider.value(
        value: Modular.get<EstoqueCubit>(),
        child: const EstoqueFormPage(),
      ),
    );
  }
}
