import 'package:flutter_modular/flutter_modular.dart';
import '../../core/services/recibo_service.dart';
import 'pages/recibo_page.dart';
import 'pages/recibo_list_page.dart';

class ReciboModule extends Module {
  @override
  void binds(i) {
    // Se necessário no futuro:
    i.addLazySingleton<ReciboService>(ReciboService.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const ReciboPage(),
    );
    r.child(
      '/lista',
      child: (_) => const ReciboListPage(),
    );
  }
}
