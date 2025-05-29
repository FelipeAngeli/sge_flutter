import 'package:flutter/services.dart';
import 'regex.dart';

final cpfCnpjRegex = RegexPatterns.cpfCnpj;
final emailRegex = RegexPatterns.email;
final phoneRegex = RegexPatterns.telefone;

class CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
    }

    String formatted;
    if (digitsOnly.length >= 6) {
      formatted = '${digitsOnly.substring(0, 5)}-${digitsOnly.substring(5)}';
    } else {
      formatted = digitsOnly;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
