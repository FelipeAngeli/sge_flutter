// lib/modules/home/home_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/home/pages/home_page.dart';
import 'package:sge_flutter/modules/home/cubit/home_cubit.dart'; // <-- faltava essa importação!
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(HomeCubit.new);
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
