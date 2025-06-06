import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> loadHomeData() async {
    try {
      emit(HomeLoading());

      await Future.delayed(const Duration(seconds: 1));

      emit(HomeLoaded());
    } catch (e) {
      emit(HomeError('Erro ao carregar dados da Home.'));
    }
  }
}
