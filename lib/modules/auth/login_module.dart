import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_page.dart';
import 'login_cubit.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(LoginCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (context) => BlocProvider(
              create: (context) => Modular.get<LoginCubit>(),
              child: const LoginPage(),
            ));
  }
}
