// lib/modules/home/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/home/cubit/home_cubit.dart';
import 'package:sge_flutter/modules/home/cubit/home_state.dart';
import 'package:sge_flutter/modules/home/widgets/custom_loading_indicator.dart';
import 'package:sge_flutter/modules/home/widgets/home_card_button.dart';
import 'package:sge_flutter/modules/auth/cubit/auth_cubit.dart';
import 'package:sge_flutter/modules/auth/cubit/auth_state.dart';

import '../../../shared/widgets/app_logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late HomeCubit homeCubit;
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    homeCubit = Modular.get<HomeCubit>();
    authCubit = Modular.get<AuthCubit>();
    homeCubit.loadHomeData();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>.value(value: homeCubit),
        BlocProvider<AuthCubit>.value(value: authCubit),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Modular.to.navigate('/login');
          }
        },
        child: Scaffold(
          appBar: const _HomeAppBar(),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const CustomLoadingIndicator();
              } else if (state is HomeLoaded) {
                return const _HomeContent();
              } else if (state is HomeError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
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
      elevation: 0,
      backgroundColor: const Color(0xFF1A237E),
      iconTheme: const IconThemeData(color: Colors.white),
      title: Row(
        children: [
          const AppLogo(
            size: 40,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SGE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Sistema de Gestão Empresarial',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              tooltip: 'Sair',
              onPressed: state is AuthLoading
                  ? null
                  : () async {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Sair'),
                          content:
                              const Text('Deseja realmente sair do sistema?'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Sair'),
                            ),
                          ],
                        ),
                      );

                      if (shouldLogout == true) {
                        BlocProvider.of<AuthCubit>(context).signOut();
                      }
                    },
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(context),
          _buildModuleSection(
            context,
            'Operações',
            [
              const HomeCardButton(
                title: 'Registrar Venda',
                icon: Icons.point_of_sale,
                route: '/venda',
                color: Color(0xFF3949AB),
              ),
              const HomeCardButton(
                title: 'Produtos',
                icon: Icons.inventory_2,
                route: '/produtos',
                color: Color(0xFF5C6BC0),
              ),
              const HomeCardButton(
                title: 'Estoque',
                icon: Icons.warehouse,
                route: '/estoque',
                color: Color(0xFF7986CB),
              ),
            ],
          ),
          _buildModuleSection(
            context,
            'Gestão',
            [
              const HomeCardButton(
                title: 'Financeiro',
                icon: Icons.point_of_sale,
                route: '/financeiro',
                color: Color(0xFF3F51B5),
              ),
              const HomeCardButton(
                title: 'Relatórios',
                icon: Icons.assessment,
                route: '/relatorios',
                color: Color(0xFF303F9F),
              ),
              const HomeCardButton(
                title: 'Clientes',
                icon: Icons.person,
                route: '/clientes',
                color: Color(0xFF283593),
              ),
            ],
          ),
          _buildModuleSection(
            context,
            'Documentos',
            [
              const HomeCardButton(
                title: 'Recibos',
                icon: Icons.receipt_long,
                route: '/recibo',
                color: Color(0xFF1A237E),
              ),
              const HomeCardButton(
                title: 'Usuários',
                icon: Icons.people,
                route: '/users',
                color: Color(0xFF0D47A1),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1A237E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bem-vindo ao SGE',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gerencie sua empresa de forma eficiente',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleSection(
    BuildContext context,
    String title,
    List<Widget> cards,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: cards,
          ),
        ],
      ),
    );
  }
}
