// auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/auth/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  bool _isClosed = false;

  AuthCubit(this.authRepository) : super(AuthInitial());

  void _safeEmit(AuthState state) {
    if (!_isClosed) {
      emit(state);
    }
  }

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  bool _validateCPF(String cpf) {
    // Remove caracteres não numéricos
    final numbers = cpf.replaceAll(RegExp(r'[^\d]'), '');

    // Verifica se tem 11 dígitos
    if (numbers.length != 11) return false;

    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(\d)\1{10}$').hasMatch(numbers)) return false;

    // Validação do primeiro dígito verificador
    var sum = 0;
    for (var i = 0; i < 9; i++) {
      sum += int.parse(numbers[i]) * (10 - i);
    }
    var digit = 11 - (sum % 11);
    if (digit > 9) digit = 0;
    if (digit != int.parse(numbers[9])) return false;

    // Validação do segundo dígito verificador
    sum = 0;
    for (var i = 0; i < 10; i++) {
      sum += int.parse(numbers[i]) * (11 - i);
    }
    digit = 11 - (sum % 11);
    if (digit > 9) digit = 0;
    if (digit != int.parse(numbers[10])) return false;

    return true;
  }

  bool _validatePhone(String phone) {
    // Remove caracteres não numéricos
    final numbers = phone.replaceAll(RegExp(r'[^\d]'), '');
    // Verifica se tem 11 dígitos (com DDD)
    return numbers.length == 11;
  }

  Map<String, String> _validateSignUpForm({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String cpf,
    required String phone,
  }) {
    final errors = <String, String>{};

    if (name.isEmpty) {
      errors['name'] = 'Nome é obrigatório';
    }

    if (email.isEmpty) {
      errors['email'] = 'E-mail é obrigatório';
    } else if (!_validateEmail(email)) {
      errors['email'] = 'E-mail inválido';
    }

    if (password.isEmpty) {
      errors['password'] = 'Senha é obrigatória';
    } else if (!_validatePassword(password)) {
      errors['password'] =
          'A senha deve ter no mínimo 8 caracteres, uma letra maiúscula, uma minúscula e um número';
    }

    if (confirmPassword.isEmpty) {
      errors['confirmPassword'] = 'Confirmação de senha é obrigatória';
    } else if (password != confirmPassword) {
      errors['confirmPassword'] = 'As senhas não conferem';
    }

    if (cpf.isEmpty) {
      errors['cpf'] = 'CPF é obrigatório';
    } else if (!_validateCPF(cpf)) {
      errors['cpf'] = 'CPF inválido';
    }

    if (phone.isEmpty) {
      errors['phone'] = 'Telefone é obrigatório';
    } else if (!_validatePhone(phone)) {
      errors['phone'] = 'Telefone inválido';
    }

    return errors;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String cpf,
    required String phone,
  }) async {
    // Valida o formulário
    final errors = _validateSignUpForm(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      cpf: cpf,
      phone: phone,
    );

    if (errors.isNotEmpty) {
      _safeEmit(AuthValidationError(errors));
      return;
    }

    _safeEmit(AuthLoading());
    try {
      await authRepository.signUp(email, password);
      _safeEmit(AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    _safeEmit(AuthLoading());
    try {
      await authRepository.signIn(email, password);
      _safeEmit(AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> resendConfirmationEmail(String email) async {
    _safeEmit(AuthLoading());
    try {
      await authRepository.resendConfirmationEmail(email);
      _safeEmit(AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    _safeEmit(AuthLoading());
    try {
      await authRepository.signOut();
      _safeEmit(AuthInitial());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  void reset() => _safeEmit(AuthInitial());

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await authRepository.resetPassword(email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
