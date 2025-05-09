import 'package:flutter/services.dart';

class CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 14) digits = digits.substring(0, 14);

    String formatted;
    if (digits.length >= 12) {
      formatted =
          '${digits.substring(0, 2)}.${digits.substring(2, 5)}.${digits.substring(5, 8)}/${digits.substring(8, 12)}-${digits.substring(12)}';
    } else if (digits.length >= 8) {
      formatted =
          '${digits.substring(0, 2)}.${digits.substring(2, 5)}.${digits.substring(5, 8)}/${digits.substring(8)}';
    } else if (digits.length >= 5) {
      formatted =
          '${digits.substring(0, 2)}.${digits.substring(2, 5)}.${digits.substring(5)}';
    } else if (digits.length >= 2) {
      formatted = '${digits.substring(0, 2)}.${digits.substring(2)}';
    } else {
      formatted = digits;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
