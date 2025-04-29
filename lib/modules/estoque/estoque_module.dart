import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/modules/estoque/pages/estoque_list_page.dart';
import 'package:sge_flutter/core/services/caixa_service.dart';
import 'package:sge_flutter/modules/produto/produto_module.dart'; // Importa o módulo de produtos

class EstoqueModule extends Module {
  @override
  List<Module> get imports => [
        ProdutoModule(), // Reaproveita ProdutoCubit e ProdutoService
      ];

  @override
  void binds(Injector i) {
    i.addSingleton<CaixaService>(CaixaService.new);
    i.addLazySingleton<EstoqueCubit>(() => EstoqueCubit(
          produtoService: i.get(), // usa ProdutoService já importado
          caixaService: i.get(),
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
