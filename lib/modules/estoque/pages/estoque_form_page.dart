import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';

class EstoqueFormPage extends StatefulWidget {
  const EstoqueFormPage({super.key});

  @override
  State<EstoqueFormPage> createState() => _EstoqueFormPageState();
}

class _EstoqueFormPageState extends State<EstoqueFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _produtoIdController = TextEditingController();
  final _quantidadeController = TextEditingController();

  @override
  void dispose() {
    _produtoIdController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estoqueCubit = BlocProvider.of<EstoqueCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Estoque'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _produtoIdController,
                decoration: const InputDecoration(labelText: 'ID do Produto'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantidadeController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final produtoId = _produtoIdController.text;
                    final quantidade = int.parse(_quantidadeController.text);
                    estoqueCubit.adicionarProdutoAoEstoque(
                        produtoId, quantidade);
                    Modular.to.pop();
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
