// lib/modules/home/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/home/cubit/home_cubit.dart';
import 'package:sge_flutter/modules/home/cubit/home_state.dart';
import 'package:sge_flutter/shared/widgets/custom_loading_indicator.dart';
import 'package:sge_flutter/shared/widgets/home_card_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    homeCubit = Modular.get<HomeCubit>(); // <-- Correção importante aqui
    homeCubit.loadHomeData(); // Carrega ao abrir a primeira vez
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pode usar isso para recarregar se quiser
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>.value(
      value: homeCubit,
      child: Scaffold(
        appBar: const _HomeAppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const CustomLoadingIndicator();
            } else if (state is HomeLoaded) {
              return const _HomeGrid();
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Sistema de Gestão Empresarial'),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeGrid extends StatelessWidget {
  const _HomeGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      children: const [
        HomeCardButton(
          title: 'Produtos',
          icon: Icons.inventory_2,
          route: '/produtos/',
        ),
        HomeCardButton(
          title: 'Estoque',
          icon: Icons.warehouse,
          route: '/estoque/',
        ),
        HomeCardButton(
          title: 'Caixa',
          icon: Icons.point_of_sale,
          route: '/caixa/',
        ),
        HomeCardButton(
          title: 'Relatórios',
          icon: Icons.assessment,
          route: '/relatorios/',
        ),
      ],
    );
  }
}
