import '../cubit/auth_cubit.dart';

/// Classe utilitária para gerenciar mensagens de erro de validação
class ValidationMessages {
  /// Retorna a mensagem de erro correspondente ao tipo de erro
  static String getMessage(ValidationErrorType errorType) {
    switch (errorType) {
      case ValidationErrorType.nameRequired:
        return 'Nome é obrigatório';
      case ValidationErrorType.emailRequired:
        return 'E-mail é obrigatório';
      case ValidationErrorType.emailInvalid:
        return 'E-mail inválido';
      case ValidationErrorType.passwordRequired:
        return 'Senha é obrigatória';
      case ValidationErrorType.passwordInvalid:
        return 'A senha deve ter ao menos 8 caracteres, 1 maiúscula, 1 minúscula e 1 número';
      case ValidationErrorType.confirmPasswordRequired:
        return 'Confirmação de senha é obrigatória';
      case ValidationErrorType.passwordsDoNotMatch:
        return 'As senhas não conferem';
      case ValidationErrorType.cpfRequired:
        return 'CPF é obrigatório';
      case ValidationErrorType.cpfInvalid:
        return 'CPF inválido';
      case ValidationErrorType.phoneRequired:
        return 'Telefone é obrigatório';
      case ValidationErrorType.phoneInvalid:
        return 'Telefone inválido';
    }
  }

  /// Retorna a mensagem de erro para um campo específico
  static String? getFieldMessage(
      Map<String, ValidationErrorType> errors, String field) {
    final errorType = errors[field];
    if (errorType == null) return null;
    return getMessage(errorType);
  }
}
