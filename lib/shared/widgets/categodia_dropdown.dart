import 'package:flutter/material.dart';

class CategoriaDropdown extends StatelessWidget {
  final TextEditingController controller;
  final List<String> categorias;

  const CategoriaDropdown({
    super.key,
    required this.controller,
    this.categorias = const [
      'Tecnologia',
      'Comida',
      'Vestuário',
      'Higiene',
      'Casa',
      'Outros',
    ],
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      items: categorias
          .map((categoria) => DropdownMenuItem(
                value: categoria,
                child: Text(categoria),
              ))
          .toList(),
      onChanged: (value) {
        controller.text = value ?? '';
      },
      decoration: const InputDecoration(
        labelText: 'Categoria',
        border: OutlineInputBorder(),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Campo obrigatório' : null,
    );
  }
}
