import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/estoque/pages/estoque_list_page.dart';
import 'package:sge_flutter/modules/estoque/pages/estoque_form_page.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstoqueModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(EstoqueCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<EstoqueCubit>(),
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
