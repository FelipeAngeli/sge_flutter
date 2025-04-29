import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/shared/widgets/custom_text_form_field.dart';

class EstoqueFormPage extends StatefulWidget {
  const EstoqueFormPage({super.key});

  @override
  State<EstoqueFormPage> createState() => _EstoqueFormPageState();
}

class _EstoqueFormPageState extends State<EstoqueFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final _estoqueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EstoqueCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Produto no Estoque'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                label: 'Nome do Produto',
                controller: _nomeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Valor',
                controller: _valorController,
                prefixText: 'R\$ ',
                keyboardType: TextInputType.number,
                validator: (value) {
                  final regex = RegExp(r'^\d+(\,\d{1,2})?$');
                  if (value == null || value.isEmpty) {
                    return 'Informe o valor';
                  }
                  if (!regex.hasMatch(value)) {
                    return 'Informe um valor válido (ex: 10,00)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Quantidade em Estoque',
                controller: _estoqueController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a quantidade';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Informe um número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final produto = ProdutoModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      nome: _nomeController.text,
                      preco: double.tryParse(
                              _valorController.text.replaceAll(',', '.')) ??
                          0,
                      estoque: int.parse(_estoqueController.text),
                      descricao: '',
                      categoria: '',
                    );
                    cubit.adicionarProduto(produto);
                    Modular.to.pop();
                  }
                },
                child: const Text('Salvar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
