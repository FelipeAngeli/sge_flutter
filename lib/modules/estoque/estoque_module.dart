import 'package:flutter_modular/flutter_modular.dart';
import 'estoque_page.dart';
import 'estoque_cubit.dart';

class EstoqueModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const EstoquePage());
  }

  @override
  void binds(Injector i) {
    i.addSingleton(EstoqueCubit.new);
  }
}
