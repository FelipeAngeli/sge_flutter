// lib/modules/produto/pages/produto_form_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/produto_cubit.dart';
import '../../../models/produto_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoFormPage extends StatefulWidget {
  const ProdutoFormPage({super.key});

  @override
  State<ProdutoFormPage> createState() => _ProdutoFormPageState();
}

class _ProdutoFormPageState extends State<ProdutoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  ProdutoModel? produto;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    produto = Modular.args.data;
    if (produto != null) {
      _nomeController.text = produto!.nome;
      _precoController.text = produto!.preco.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProdutoCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(produto == null ? 'Novo Produto' : 'Editar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final novoProduto = ProdutoModel(
                      id: produto?.id ??
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      nome: _nomeController.text,
                      preco: double.parse(_precoController.text),
                      estoque: produto?.estoque ?? 0,
                      descricao: produto?.descricao ?? '',
                      categoria: produto?.categoria ?? '',
                    );
                    if (produto == null) {
                      cubit.adicionarProduto(novoProduto);
                    } else {
                      cubit.atualizarProduto(novoProduto);
                    }
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
