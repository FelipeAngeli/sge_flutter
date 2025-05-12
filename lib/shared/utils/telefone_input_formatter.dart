import 'package:flutter/services.dart';

class TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 11) digits = digits.substring(0, 11);

    String formatted;
    if (digits.length >= 11) {
      formatted =
          '${digits.substring(0, 2)} ${digits.substring(2, 7)}-${digits.substring(7)}';
    } else if (digits.length >= 7) {
      formatted =
          '${digits.substring(0, 2)} ${digits.substring(2, 6)}-${digits.substring(6)}';
    } else {
      formatted = digits;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
