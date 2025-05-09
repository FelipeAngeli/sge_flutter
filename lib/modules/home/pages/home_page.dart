import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/home/cubit/home_cubit.dart';
import 'package:sge_flutter/modules/home/cubit/home_state.dart';
import 'package:sge_flutter/modules/home/widgets/custom_loading_indicator.dart';
import 'package:sge_flutter/modules/auth/cubit/auth_cubit.dart';
import 'package:sge_flutter/modules/auth/cubit/auth_state.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_contetnt.dart';

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
          appBar: const HomeAppBar(),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const CustomLoadingIndicator();
              } else if (state is HomeLoaded) {
                return const HomeContent();
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
