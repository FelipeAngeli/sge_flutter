// lib/shared/widgets/custom_text_form_field.dart
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? prefixText;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefixText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
