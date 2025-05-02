import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_cubit.dart';
import 'package:sge_flutter/modules/clientes/pages/client_form_page.dart';
import 'package:sge_flutter/modules/clientes/pages/client_list_page.dart';
import 'package:sge_flutter/modules/clientes/pages/client_relatorio_page.dart';
import 'package:sge_flutter/core/services/cliente_service.dart';
import 'package:sge_flutter/core/services/cep/cep_service.dart';
import 'package:sge_flutter/core/services/cep/http_client_dio_impl.dart';
import '../../core/services/cep/ i_http_client.dart';

class ClientesModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<ClienteService>(ClienteService.new);
    i.addLazySingleton<IHttpClient>(HttpClientDioImpl.new);
    i.addLazySingleton<CepService>(() => CepService(i.get<IHttpClient>()));
    i.addLazySingleton<ClienteCubit>(
      () => ClienteCubit(i.get<ClienteService>(), i.get<CepService>()),
    );
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
      child: (context) => BlocProvider.value(
        value: Modular.get<ClienteCubit>(),
        child: const ClienteFormPage(),
      ),
    );
    r.child(
      '/form/:id',
      child: (context) => BlocProvider.value(
        value: Modular.get<ClienteCubit>(),
        child: const ClienteFormPage(),
      ),
    );
    r.child(
      '/relatorio/:id',
      child: (context) {
        final id = Modular.args.params['id'];
        return ClientRelatorioPage(clienteId: id!);
      },
    );
  }
}
