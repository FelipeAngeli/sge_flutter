import 'package:equatable/equatable.dart';
import 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  const AuthSuccess();
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthValidationError extends AuthState {
  final Map<String, ValidationErrorType> errors;

  const AuthValidationError(this.errors);

  @override
  List<Object?> get props => [errors];
}
