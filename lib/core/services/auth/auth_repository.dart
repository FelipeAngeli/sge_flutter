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
      print('📧 Tentando cadastrar usuário:');
      print('   Email: $email');
      print('   Senha: ${'*' * password.length}');
      print('   Nome: $name');
      print('   CPF: $cpf');
      print('   Telefone: $phone');

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

      print('✅ Resposta do cadastro: ${response.user?.email}');

      if (response.user == null) {
        throw Exception('Erro ao cadastrar usuário');
      }

      print('✅ Usuário cadastrado com sucesso: ${response.user?.email}');
    } on AuthException catch (e) {
      print('❌ Erro de autenticação: ${e.message}');
      switch (e.message) {
        case 'User already registered':
          throw Exception('Este e-mail já está cadastrado');
        case 'Password should be at least 6 characters':
          throw Exception('A senha deve ter pelo menos 6 caracteres');
        default:
          throw Exception('Erro ao cadastrar: ${e.message}');
      }
    } catch (e) {
      print('❌ Erro inesperado: $e');
      throw Exception('Erro ao cadastrar: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      print('📧 Tentando fazer login:');
      print('   Email: $email');
      print('   Senha: ${'*' * password.length}');

      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      print('✅ Resposta do login: ${response.user?.email}');

      if (response.user == null) {
        throw Exception('Erro ao fazer login');
      }

      print('✅ Login realizado com sucesso: ${response.user?.email}');
    } on AuthException catch (e) {
      print('❌ Erro de autenticação: ${e.message}');
      switch (e.message) {
        case 'Invalid login credentials':
          throw Exception('E-mail ou senha inválidos');
        case 'Email not confirmed':
          throw Exception('E-mail não confirmado');
        default:
          throw Exception('Erro ao fazer login: ${e.message}');
      }
    } catch (e) {
      print('❌ Erro inesperado: $e');
      throw Exception('Erro ao fazer login: $e');
    }
  }

  Future<void> signOut() async {
    try {
      print('🚪 Tentando fazer logout');
      await supabase.auth.signOut();
      print('✅ Logout realizado com sucesso');
    } catch (e) {
      print('❌ Erro ao fazer logout: $e');
      throw Exception('Erro ao fazer logout: $e');
    }
  }

  Future<void> resendConfirmationEmail(String email) async {
    try {
      print('📧 Tentando reenviar email de confirmação para: $email');
      await supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      print('✅ Email de confirmação reenviado com sucesso');
    } catch (e) {
      print('❌ Erro ao reenviar email de confirmação: $e');
      throw Exception('Erro ao reenviar email de confirmação: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      print('📧 Tentando enviar email de recuperação para: $email');
      await supabase.auth.resetPasswordForEmail(email);
      print('✅ Email de recuperação enviado com sucesso');
    } catch (e) {
      print('❌ Erro ao enviar email de recuperação: $e');
      throw Exception('Erro ao enviar email de recuperação: $e');
    }
  }

  bool isAuthenticated() {
    return supabase.auth.currentSession != null;
  }
}
