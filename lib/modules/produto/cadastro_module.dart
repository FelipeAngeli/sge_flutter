import 'package:flutter_modular/flutter_modular.dart';
import 'cadastro_produto_page.dart';
import 'cadastro_produto_cubit.dart';

class ProdutoModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const CadastroProdutoPage());
  }

  @override
  void binds(Injector i) {
    i.addSingleton(CadastroProdutoCubit.new);
  }
}
