// lib/modules/caixa/caixa_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/caixa/pages/caixa_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/caixa/cubit/caixa_cubit.dart';

class CaixaModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(CaixaCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<CaixaCubit>(),
        child: const CaixaListPage(),
      ),
    );
  }
}
