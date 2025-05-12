import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required String phone,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null,
        data: {
          'name': name,
          'cpf': cpf,
          'phone': phone,
          'email_confirmed': true,
        },
      );

      if (response.user == null) {
        throw Exception('Erro ao cadastrar usuário');
      }
    } on AuthException catch (e) {
      switch (e.message) {
        case 'User already registered':
          throw Exception('Este e-mail já está cadastrado');
        case 'Password should be at least 6 characters':
          throw Exception('A senha deve ter pelo menos 6 caracteres');
        default:
          throw Exception('Erro ao cadastrar: ${e.message}');
      }
    } catch (e) {
      throw Exception('Erro ao cadastrar: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Erro ao fazer login');
      }
    } on AuthException catch (e) {
      switch (e.message) {
        case 'Invalid login credentials':
          throw Exception('E-mail ou senha inválidos');
        case 'Email not confirmed':
          throw Exception('E-mail não confirmado');
        default:
          throw Exception('Erro ao fazer login: ${e.message}');
      }
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception('Erro ao fazer logout: $e');
    }
  }

  Future<void> resendConfirmationEmail(String email) async {
    try {
      await supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
    } catch (e) {
      throw Exception('Erro ao reenviar email de confirmação: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Erro ao enviar email de recuperação: $e');
    }
  }

  bool isAuthenticated() {
    return supabase.auth.currentSession != null;
  }
}
