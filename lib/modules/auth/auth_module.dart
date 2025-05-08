import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/auth/cubit/auth_cubit.dart';

import '../../core/services/auth/auth_repository.dart';
import 'pages/signin_page.dart';
import 'pages/signup_page.dart';
import 'pages/splash_page.dart';
import 'pages/forgot_password_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AuthRepository>(AuthRepository.new);
    i.addLazySingleton<AuthCubit>(() => AuthCubit(i.get<AuthRepository>()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const SplashPage());
    r.child('/login',
        child: (_) => BlocProvider(
              create: (_) => Modular.get<AuthCubit>(),
              child: const SignInPage(),
            ));
    r.child('/signup',
        child: (_) => BlocProvider(
              create: (_) => Modular.get<AuthCubit>(),
              child: const SignUpPage(),
            ));
    r.child('/forgot-password',
        child: (_) => BlocProvider(
              create: (_) => Modular.get<AuthCubit>(),
              child: const ForgotPasswordPage(),
            ));
  }
}
