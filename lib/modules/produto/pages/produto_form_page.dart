import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/shared/widgets/categodia_dropdown.dart';
import 'package:sge_flutter/shared/widgets/currency_text_field.dart';
import 'package:sge_flutter/shared/widgets/custom_text_form_field.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';
import '../../../models/produto_model.dart';
import '../cubit/produto_cubit.dart';

class ProdutoFormPage extends StatefulWidget {
  const ProdutoFormPage({super.key});

  @override
  State<ProdutoFormPage> createState() => _ProdutoFormPageState();
}

class _ProdutoFormPageState extends State<ProdutoFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _categoriaController = TextEditingController();

  ProdutoModel? produto;
  bool _formValid = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    produto = Modular.args.data;
    if (produto != null) {
      _idController.text = produto!.id;
      _nomeController.text = produto!.nome;
      _precoController.text = produto!.preco.toStringAsFixed(2);
      _quantidadeController.text = produto!.estoque.toString();
      _descricaoController.text = produto!.descricao;
      _categoriaController.text = produto!.categoria;
    }
  }

  void _onFormChanged() {
    setState(() {
      _formValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _nomeController.dispose();
    _precoController.dispose();
    _quantidadeController.dispose();
    _descricaoController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<ProdutoCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(produto == null ? 'Novo Produto' : 'Editar Produto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          onChanged: _onFormChanged,
          child: ListView(
            children: [
              CustomTextField(
                label: 'ID do Produto',
                controller: _idController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Nome',
                controller: _nomeController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              CurrencyTextField(
                label: 'Preço (R\$)',
                controller: _precoController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Quantidade',
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Descrição',
                controller: _descricaoController,
              ),
              const SizedBox(height: 16),
              CategoriaDropdown(controller: _categoriaController),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Salvar Produto',
                enabled: _formValid,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final novoProduto = ProdutoModel(
                      id: _idController.text,
                      nome: _nomeController.text,
                      preco: double.tryParse(_precoController.text
                              .replaceAll(RegExp(r'[^0-9.]'), '')) ??
                          0.0,
                      estoque: int.tryParse(_quantidadeController.text) ?? 0,
                      descricao: _descricaoController.text,
                      categoria: _categoriaController.text,
                    );

                    if (produto == null) {
                      cubit.adicionarProduto(novoProduto);
                    } else {
                      cubit.atualizarProduto(novoProduto);
                    }

                    Modular.to.pop();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
