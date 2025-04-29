import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/relatorio/cubit/relatorio_cubit.dart';
import 'package:sge_flutter/modules/relatorio/pages/relatorio_page.dart';

import '../../../core/services/produto_service.dart';

class RelatorioModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(ProdutoService.new);
    i.addLazySingleton(() => RelatorioCubit(i<ProdutoService>()));
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => BlocProvider(
        create: (context) =>
            RelatorioCubit(Modular.get<ProdutoService>())..gerarRelatorio(),
        child: const RelatorioPage(),
      ),
    );
  }
}
