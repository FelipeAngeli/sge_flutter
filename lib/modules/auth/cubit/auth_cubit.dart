import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/auth/auth_repository.dart';
import 'auth_state.dart';

// Enum para tipos de erro de validação
enum ValidationErrorType {
  nameRequired,
  emailRequired,
  emailInvalid,
  passwordRequired,
  passwordInvalid,
  confirmPasswordRequired,
  passwordsDoNotMatch,
  cpfRequired,
  cpfInvalid,
  phoneRequired,
  phoneInvalid,
}

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
    _safeEmit(const AuthLoading());

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

    try {
      await _authRepository.signUp(
        email: email,
        password: password,
        name: name,
        cpf: cpf,
        phone: phone,
      );
      _safeEmit(const AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    _safeEmit(const AuthLoading());

    if (email.isEmpty || password.isEmpty) {
      _safeEmit(AuthValidationError({
        'email': email.isEmpty
            ? ValidationErrorType.emailRequired
            : ValidationErrorType.passwordRequired,
      }));
      return;
    }

    try {
      await _authRepository.signIn(email, password);
      _safeEmit(const AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> resendConfirmationEmail(String email) async {
    _safeEmit(const AuthLoading());

    try {
      await _authRepository.resendConfirmationEmail(email);
      _safeEmit(const AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    _safeEmit(const AuthLoading());

    try {
      await _authRepository.signOut();
      _safeEmit(AuthInitial());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    _safeEmit(const AuthLoading());

    try {
      await _authRepository.resetPassword(email);
      _safeEmit(const AuthSuccess());
    } catch (e) {
      _safeEmit(AuthFailure(e.toString()));
    }
  }

  void reset() => _safeEmit(const AuthInitial());

  Map<String, ValidationErrorType> _validateSignUpForm({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String cpf,
    required String phone,
  }) {
    final Map<String, ValidationErrorType> errors = {};

    if (name.trim().isEmpty) {
      errors['name'] = ValidationErrorType.nameRequired;
    }

    if (email.trim().isEmpty) {
      errors['email'] = ValidationErrorType.emailRequired;
    } else if (!isValidEmail(email)) {
      errors['email'] = ValidationErrorType.emailInvalid;
    }

    if (password.isEmpty) {
      errors['password'] = ValidationErrorType.passwordRequired;
    } else if (!isValidPassword(password)) {
      errors['password'] = ValidationErrorType.passwordInvalid;
    }

    if (confirmPassword.isEmpty) {
      errors['confirmPassword'] = ValidationErrorType.confirmPasswordRequired;
    } else if (confirmPassword != password) {
      errors['confirmPassword'] = ValidationErrorType.passwordsDoNotMatch;
    }

    if (cpf.isEmpty) {
      errors['cpf'] = ValidationErrorType.cpfRequired;
    } else if (!isValidCPF(cpf)) {
      errors['cpf'] = ValidationErrorType.cpfInvalid;
    }

    if (phone.isEmpty) {
      errors['phone'] = ValidationErrorType.phoneRequired;
    } else if (!isValidPhone(phone)) {
      errors['phone'] = ValidationErrorType.phoneInvalid;
    }

    return errors;
  }

  // Métodos de validação
  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return regex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    return regex.hasMatch(password);
  }

  bool isValidPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    return cleaned.length == 11;
  }

  bool isValidCPF(String cpf) {
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
