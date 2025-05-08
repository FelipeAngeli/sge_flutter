import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';
import 'package:sge_flutter/shared/widgets/custom_text_field.dart';

class AssociarFornecedorPage extends StatelessWidget {
  final String produtoId;

  const AssociarFornecedorPage({super.key, required this.produtoId});

  @override
  Widget build(BuildContext context) {
    final fornecedorController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Associar Fornecedor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: fornecedorController,
              label: 'ID do Fornecedor',
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Salvar',
              onPressed: () {
                BlocProvider.of<EstoqueCubit>(context)
                    .associarFornecedor(produtoId, fornecedorController.text);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Adicionar Novo Fornecedor',
              onPressed: () => Modular.to.pushNamed(
                '/estoque/adicionar-fornecedor',
                arguments: produtoId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
