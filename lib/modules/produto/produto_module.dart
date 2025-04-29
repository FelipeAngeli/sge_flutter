import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import '../produto/cubit/produto_cubit.dart';
import '../produto/pages/produto_list_page.dart';
import '../produto/pages/produto_form_page.dart';

class ProdutoModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ProdutoService>(ProdutoService.new);
    i.addLazySingleton(
        () => ProdutoCubit(produtoService: i.get<ProdutoService>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<ProdutoCubit>(),
        child: const ProdutoListPage(),
      ),
    );
    r.child(
      '/form',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<ProdutoCubit>(),
        child: const ProdutoFormPage(),
      ),
    );
  }
}
