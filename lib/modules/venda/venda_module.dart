import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_cuibit.dart';
import 'package:sge_flutter/modules/venda/pages/vendas_page.dart';

class VendaModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ProdutoService>(ProdutoService.new);
    i.addLazySingleton<VendaCubit>(() => VendaCubit(i.get<ProdutoService>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<VendaCubit>()..carregarProdutos(),
        child: const VendaPage(),
      ),
    );
  }
}
