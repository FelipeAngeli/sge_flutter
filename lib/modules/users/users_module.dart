import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/users_cubit.dart';
import 'repositories/users_repository.dart';
import 'pages/users_list_page.dart';
import 'pages/user_form_page.dart';

class UsersModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<UsersRepository>(UsersRepository.new);
    i.addLazySingleton<UsersCubit>(() => UsersCubit(i.get<UsersRepository>()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (_) => BlocProvider(
              create: (_) => Modular.get<UsersCubit>(),
              child: const UsersListPage(),
            ));
    r.child('/new',
        child: (_) => BlocProvider(
              create: (_) => Modular.get<UsersCubit>(),
              child: const UserFormPage(),
            ));
    r.child('/edit/:id',
        child: (_) => BlocProvider(
              create: (_) => Modular.get<UsersCubit>(),
              child: const UserFormPage(),
            ));
  }
}
