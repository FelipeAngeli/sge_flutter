import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_cubit.dart';
import 'package:sge_flutter/modules/clientes/pages/client_form_page.dart';
import 'package:sge_flutter/modules/clientes/pages/client_list_page.dart';

class ClientesModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<ClienteCubit>(ClienteCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<ClienteCubit>()..carregarClientes(),
        child: const ClientListPage(),
      ),
    );
    r.child(
      '/form',
      child: (context) => const ClienteFormPage(),
    );
    r.child(
      '/form/:id',
      child: (context) => const ClienteFormPage(),
    );
  }
}
