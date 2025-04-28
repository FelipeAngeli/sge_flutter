import 'package:flutter_modular/flutter_modular.dart';
import 'login_page.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginPage());
  }
}
