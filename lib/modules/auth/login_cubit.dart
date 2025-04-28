import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/usuario_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final _usuarioBox = Hive.box<UsuarioModel>('usuarios');

  Future<void> login(String email, String senha) async {
    try {
      emit(LoginLoading());

      final usuario = _usuarioBox.values.firstWhere(
        (usuario) => usuario.email == email && usuario.senha == senha,
        orElse: () => throw Exception('Usuário não encontrado'),
      );

      await Future.delayed(
          const Duration(seconds: 2)); // Simulando uma chamada de API

      emit(LoginSuccess(usuario));
    } catch (e) {
      emit(LoginError('Email ou senha inválidos'));
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UsuarioModel usuario;
  LoginSuccess(this.usuario);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
