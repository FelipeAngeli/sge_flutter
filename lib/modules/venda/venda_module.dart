// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sge_flutter/core/services/produto_service.dart';
// import 'package:sge_flutter/core/services/cliente_service.dart';
// import 'package:sge_flutter/core/services/recibo_service.dart';
// import 'package:sge_flutter/core/services/venda_service.dart'; // <<< ADICIONA ISSO!
// import 'package:sge_flutter/modules/venda/cubit/venda_cuibit.dart';
// import 'package:sge_flutter/modules/recibo/cubit/recibo_cubit.dart';
// import 'package:sge_flutter/modules/venda/pages/vendas_page.dart';
// import 'package:sge_flutter/modules/recibo/pages/recibo_list_page.dart';
// import 'package:sge_flutter/core/storage/hive_config.dart';

// class VendaModule extends Module {
//   @override
//   void binds(Injector i) {
//     i.addSingleton<ProdutoService>(ProdutoService.new);
//     i.addSingleton<ClienteService>(ClienteService.new);
//     i.addSingleton<ReciboService>(ReciboService.new);
//     i.addSingleton<VendaService>(VendaService.new); // <<< ADICIONA ISSO!

//     i.addLazySingleton<VendaCubit>(() => VendaCubit(
//           i.get<ProdutoService>(),
//           i.get<ClienteService>(),
//           i.get<VendaService>(),
//         ));

//     i.addLazySingleton<ReciboCubit>(() => ReciboCubit(
//           HiveConfig.reciboBox,
//           i.get<ReciboService>(),
//         ));
//   }

//   @override
//   void routes(RouteManager r) {
//     r.child(
//       '/',
//       child: (context) => BlocProvider(
//         create: (_) => Modular.get<VendaCubit>()..carregarProdutosEClientes(),
//         child: const VendaPage(),
//       ),
//     );
//     r.child(
//       '/recibos',
//       child: (context) => BlocProvider(
//         create: (_) => Modular.get<ReciboCubit>()..carregarRecibos(),
//         child: const ReciboListPage(),
//       ),
//     );
//   }
// }

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/produto_service.dart';
import 'package:sge_flutter/core/services/cliente_service.dart';
import 'package:sge_flutter/core/services/recibo_service.dart';
import 'package:sge_flutter/core/services/venda_service.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_cuibit.dart';
import 'package:sge_flutter/modules/recibo/cubit/recibo_cubit.dart';
import 'package:sge_flutter/modules/venda/pages/vendas_page.dart';
import 'package:sge_flutter/modules/recibo/pages/recibo_list_page.dart';
import 'package:sge_flutter/core/storage/hive_config.dart';

class VendaModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ProdutoService>(ProdutoService.new);
    i.addSingleton<ClienteService>(ClienteService.new);
    i.addSingleton<ReciboService>(ReciboService.new);
    i.addSingleton<VendaService>(VendaService.new);

    i.addLazySingleton<VendaCubit>(() => VendaCubit(
          i.get<ProdutoService>(),
          i.get<ClienteService>(),
          i.get<VendaService>(), // ✅ agora passa VendaService
        ));

    i.addLazySingleton<ReciboCubit>(() => ReciboCubit(
          HiveConfig.reciboBox,
          i.get<ReciboService>(), // ✅ passa ReciboService corretamente
        ));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<VendaCubit>()..carregarProdutosEClientes(),
        child: const VendaPage(),
      ),
    );
    r.child(
      '/recibos',
      child: (context) => BlocProvider(
        create: (_) => Modular.get<ReciboCubit>()..carregarRecibos(),
        child: const ReciboListPage(),
      ),
    );
  }
}
