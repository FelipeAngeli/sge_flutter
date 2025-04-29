import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_cubit.dart';
import 'package:sge_flutter/modules/produto/pages/produto_list_page.dart';
import 'package:sge_flutter/modules/produto/pages/produto_form_page.dart';

class ProdutoModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(ProdutoService.new);
    i.addLazySingleton(
      () => ProdutoCubit(produtoService: i.get<ProdutoService>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => BlocProvider(
        create: (_) => Modular.get<ProdutoCubit>(),
        child: const ProdutoListPage(),
      ),
    );
    r.child(
      '/adicionarProduto', // rota corrigida aqui
      child: (_) => BlocProvider(
        create: (_) => Modular.get<ProdutoCubit>(),
        child: const ProdutoFormPage(),
      ),
    );
  }
}
