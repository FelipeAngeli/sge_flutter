import 'package:flutter_modular/flutter_modular.dart';
import '../../core/services/recibo_service.dart';
import 'pages/recibo_page.dart';
import 'pages/recibo_list_page.dart';

class ReciboModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<ReciboService>(ReciboService.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const ReciboPage());
    r.child('/lista', child: (_) => const ReciboListPage());
  }
}
