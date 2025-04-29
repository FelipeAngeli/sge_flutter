import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/caixa_service.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/modules/caixa/cubit/caixa_cubit.dart';
import 'package:sge_flutter/modules/caixa/pages/caixa_list_page.dart';

class CaixaModule extends Module {
  @override
  void binds(Injector i) {
    // Registre os dois serviços necessários
    i.addSingleton<CaixaService>(CaixaService.new);
    i.addSingleton<ProdutoService>(ProdutoService.new);

    i.addLazySingleton<CaixaCubit>(() => CaixaCubit(
          caixaService: Modular.get<CaixaService>(),
          produtoService: Modular.get<ProdutoService>(),
        ));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<CaixaCubit>(),
        child: const CaixaListPage(),
      ),
    );
  }
}
