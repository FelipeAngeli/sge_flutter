import 'regex.dart';

class RegexHelpers {
  static bool isValidEmail(String value) {
    return RegexPatterns.email.hasMatch(value);
  }

  static bool isValidTelefone(String value) {
    return RegexPatterns.telefone.hasMatch(value);
  }

  static bool isValidCpfCnpj(String value) {
    return RegexPatterns.cpfCnpj.hasMatch(value);
  }

  static bool isValidCep(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length == 8;
  }
}
