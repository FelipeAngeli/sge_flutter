import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/models/fornecedor_model.dart';
import 'package:sge_flutter/core/services/fornecedor_service.dart';
import 'package:sge_flutter/shared/widgets/custom_text_form_field.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';
import 'package:sge_flutter/shared/widgets/categodia_dropdown.dart';
import 'package:sge_flutter/shared/utils/regex_helpers.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/utils/cnpj_input_formatter.dart';
import '../../../shared/utils/telefone_input_formatter.dart';

class FornecedorFormPage extends StatefulWidget {
  const FornecedorFormPage({super.key});

  @override
  State<FornecedorFormPage> createState() => _FornecedorFormPageState();
}

class _FornecedorFormPageState extends State<FornecedorFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeEmpresaController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _nomeFornecedorController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _categoriaController = TextEditingController();

  bool _formValid = false;

  void _onFormChanged() {
    setState(() {
      _formValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void dispose() {
    _nomeEmpresaController.dispose();
    _cnpjController.dispose();
    _nomeFornecedorController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _descricaoController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fornecedorService = Modular.get<FornecedorService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Fornecedor'),
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
                label: 'Nome da Empresa',
                controller: _nomeEmpresaController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'CNPJ',
                controller: _cnpjController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CnpjInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!RegexHelpers.isValidCpfCnpj(value)) {
                    return 'CNPJ inválido (14 dígitos)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Nome do Fornecedor',
                controller: _nomeFornecedorController,
                validator: (value) => value != null && value.length < 3
                    ? 'Mínimo 3 caracteres'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Telefone',
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!RegexHelpers.isValidTelefone(value)) {
                    return 'Telefone inválido (Ex.: 48999999999)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!RegexHelpers.isValidEmail(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Descrição (opcional)',
                controller: _descricaoController,
              ),
              const SizedBox(height: 16),
              CategoriaDropdown(controller: _categoriaController),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Salvar Fornecedor',
                enabled: _formValid,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final novoFornecedor = FornecedorModel(
                      id: const Uuid().v4(),
                      nomeEmpresa: _nomeEmpresaController.text,
                      cnpj: _cnpjController.text,
                      nomeFornecedor: _nomeFornecedorController.text,
                      telefone: _telefoneController.text,
                      email: _emailController.text,
                      descricao: _descricaoController.text,
                      categoria: _categoriaController.text,
                    );
                    fornecedorService.salvarFornecedor(novoFornecedor);
                    Modular.to.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
