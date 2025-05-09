import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? errorText;
  final String mask;
  final TextInputType keyboardType;

  const MaskedTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.mask,
    this.validator,
    this.enabled = true,
    this.errorText,
    this.keyboardType = TextInputType.number,
  });

  String _applyMask(String value) {
    final result = StringBuffer();
    var valueIndex = 0;

    for (var i = 0; i < mask.length; i++) {
      if (valueIndex >= value.length) break;

      if (mask[i] == '#') {
        result.write(value[valueIndex]);
        valueIndex++;
      } else {
        result.write(mask[i]);
        if (value[valueIndex] == mask[i]) {
          valueIndex++;
        }
      }
    }

    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        enabled: enabled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: enabled
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.surface.withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      keyboardType: keyboardType,
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
          final masked = _applyMask(text);
          return TextEditingValue(
            text: masked,
            selection: TextSelection.collapsed(offset: masked.length),
          );
        }),
      ],
      validator: validator,
    );
  }
}
