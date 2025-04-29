import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../produto/cubit/produto_cubit.dart';
import '../produto/pages/produto_list_page.dart';
import '../produto/pages/produto_form_page.dart';

class ProdutoModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(ProdutoCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<ProdutoCubit>(),
        child: const ProdutoListPage(),
      ),
    );
    r.child(
      '/form',
      child: (context) => BlocProvider(
        create: (context) => Modular.get<ProdutoCubit>(),
        child: const ProdutoFormPage(),
      ),
    );
  }
}
