import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/modules/estoque/pages/estoque_list_page.dart';
import 'package:sge_flutter/modules/estoque/pages/associar_fornecedor_page.dart';
import 'package:sge_flutter/modules/estoque/pages/fornecedor_form_page.dart';
import 'package:sge_flutter/modules/estoque/pages/fornecedor_produto_page.dart';
import 'package:sge_flutter/core/services/financeiro_service.dart';
import 'package:sge_flutter/core/services/fornecedor_service.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/modules/produto/produto_module.dart';

class EstoqueModule extends Module {
  @override
  List<Module> get imports => [
        ProdutoModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton<FinanceiroService>(FinanceiroService.new);
    i.addSingleton<FornecedorService>(FornecedorService.new);
    i.addSingleton<ProdutoService>(ProdutoService.new);
    i.addLazySingleton<EstoqueCubit>(() => EstoqueCubit(
          produtoService: i.get(),
          financeiroService: i.get(),
          fornecedorService: i.get(),
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

    r.child(
      '/associarFornecedor',
      child: (context) {
        final produtoId = Modular.args.data as String? ?? '';
        return BlocProvider.value(
          value: Modular.get<EstoqueCubit>(),
          child: AssociarFornecedorPage(produtoId: produtoId),
        );
      },
    );

    r.child(
      '/fornecedores',
      child: (context) {
        final produtoId = Modular.args.data as String? ?? '';
        return BlocProvider.value(
          value: Modular.get<EstoqueCubit>(),
          child: FornecedoresProdutoPage(produtoId: produtoId),
        );
      },
    );

    r.child(
      '/adicionar-fornecedor',
      child: (context) => const FornecedorFormPage(),
    );
  }
}
