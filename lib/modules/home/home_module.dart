// lib/modules/home/home_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/home/pages/home_page.dart';
import 'package:sge_flutter/modules/home/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/auth/cubit/auth_cubit.dart';
import 'package:sge_flutter/core/services/auth/auth_repository.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(HomeCubit.new);
    i.addLazySingleton(AuthRepository.new);
    i.addLazySingleton(() => AuthCubit(i.get<AuthRepository>()));
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) => BlocProvider(
              create: (_) => Modular.get<HomeCubit>(),
              child: const HomePage(),
            ));
  }
}
