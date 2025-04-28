import 'package:flutter_modular/flutter_modular.dart';
import 'relatorio_page.dart';
import 'relatorio_cubit.dart';

class RelatorioModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const RelatorioPage());
  }

  @override
  void binds(Injector i) {
    i.addSingleton(RelatorioCubit.new);
  }
}
