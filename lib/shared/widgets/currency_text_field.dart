import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CurrencyTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        prefixText: 'R\$ ',
      ),
      onChanged: (value) {
        final sanitized = value.replaceAll(RegExp(r'[^0-9]'), '');
        final doubleValue = double.tryParse(sanitized) ?? 0.0;
        final formatted = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
            .format(doubleValue / 100);
        controller.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      },
    );
  }
}
