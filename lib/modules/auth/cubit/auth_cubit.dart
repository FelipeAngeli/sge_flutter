import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/auth/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  bool _isClosed = false;

  AuthCubit(this._authRepository) : super(AuthInitial());

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  void _safeEmit(AuthState state) {
    if (!_isClosed) emit(state);
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String cpf,
    required String phone,
  }) async {
    emit(AuthLoading());

    final errors = _validateSignUpForm(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      cpf: cpf,
      phone: phone,
    );

    if (errors.isNotEmpty) {
      _safeEmit(AuthValidationError(errors.values.first));
      return;
    }

    try {
      await _authRepository.signUp(
        email: email,
        password: password,
        name: name,
        cpf: cpf,
        phone: phone,
      );
      _safeEmit(AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());

    if (email.isEmpty || password.isEmpty) {
      _safeEmit(AuthValidationError('Por favor, preencha todos os campos'));
      return;
    }

    try {
      await _authRepository.signIn(email, password);
      _safeEmit(AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> resendConfirmationEmail(String email) async {
    emit(AuthLoading());

    try {
      await _authRepository.resendConfirmationEmail(email);
      _safeEmit(AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());

    try {
      await _authRepository.signOut();
      _safeEmit(AuthInitial());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());

    try {
      await _authRepository.resetPassword(email);
      _safeEmit(AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  void reset() => _safeEmit(AuthInitial());

  Map<String, String> _validateSignUpForm({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String cpf,
    required String phone,
  }) {
    final Map<String, String> errors = {};

    if (name.trim().isEmpty) errors['name'] = 'Nome é obrigatório';

    if (email.trim().isEmpty) {
      errors['email'] = 'E-mail é obrigatório';
    } else if (!_isValidEmail(email)) {
      errors['email'] = 'E-mail inválido';
    }

    if (password.isEmpty) {
      errors['password'] = 'Senha é obrigatória';
    } else if (!_isValidPassword(password)) {
      errors['password'] =
          'A senha deve ter ao menos 8 caracteres, 1 maiúscula, 1 minúscula e 1 número';
    }

    if (confirmPassword.isEmpty) {
      errors['confirmPassword'] = 'Confirmação de senha é obrigatória';
    } else if (confirmPassword != password) {
      errors['confirmPassword'] = 'As senhas não conferem';
    }

    if (cpf.isEmpty) {
      errors['cpf'] = 'CPF é obrigatório';
    } else if (!_isValidCPF(cpf)) {
      errors['cpf'] = 'CPF inválido';
    }

    if (phone.isEmpty) {
      errors['phone'] = 'Telefone é obrigatório';
    } else if (!_isValidPhone(phone)) {
      errors['phone'] = 'Telefone inválido';
    }

    return errors;
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return regex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    return regex.hasMatch(password);
  }

  bool _isValidPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    return cleaned.length == 11;
  }

  bool _isValidCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    if (cpf.length != 11 || RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) return false;

    for (int i = 9; i < 11; i++) {
      int sum = 0;
      for (int j = 0; j < i; j++) {
        sum += int.parse(cpf[j]) * ((i + 1) - j);
      }
      int digit = (sum * 10) % 11;
      if (digit == 10) digit = 0;
      if (digit != int.parse(cpf[i])) return false;
    }

    return true;
  }
}
