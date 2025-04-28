import 'package:flutter_modular/flutter_modular.dart';
import 'caixa_page.dart';
import 'caixa_cubit.dart';

class CaixaModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const CaixaPage());
  }

  @override
  void binds(Injector i) {
    i.addSingleton(CaixaCubit.new);
  }
}
