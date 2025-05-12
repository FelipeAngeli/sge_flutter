import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_cubit.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_state.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';
import 'package:sge_flutter/shared/utils/input_formatters.dart';
import 'package:sge_flutter/shared/widgets/custom_text_form_field.dart';
import '../../../shared/utils/regex_helpers.dart';

class ClienteFormPage extends StatefulWidget {
  const ClienteFormPage({super.key});

  @override
  State<ClienteFormPage> createState() => _ClienteFormPageState();
}

class _ClienteFormPageState extends State<ClienteFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _emailController = TextEditingController();
  final _cepController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();

  bool _ativo = true;
  ClienteModel? cliente;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cliente = Modular.args.data;
    if (cliente != null) {
      _nomeController.text = cliente!.nome;
      _telefoneController.text = cliente!.telefone;
      _cpfCnpjController.text = cliente!.cpfCnpj;
      _enderecoController.text = cliente!.endereco;
      _emailController.text = cliente!.email;
      _cepController.text = cliente!.cep;
      _cidadeController.text = cliente!.cidade;
      _estadoController.text = cliente!.estado;
      _ativo = cliente!.ativo;
    }
  }

  void _onBuscarCep() {
    final cubit = BlocProvider.of<ClienteCubit>(context);
    final rawCep = _cepController.text.replaceAll(RegExp(r'\D'), '');
    if (rawCep.length == 8) {
      cubit.buscarCep(rawCep);
    }
  }

  void _onSalvarCliente() {
    if (_formKey.currentState!.validate()) {
      final cubit = BlocProvider.of<ClienteCubit>(context);
      final novoCliente = ClienteModel(
        id: cliente?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        cpfCnpj: _cpfCnpjController.text,
        endereco: _enderecoController.text,
        cidade: _cidadeController.text,
        estado: _estadoController.text,
        email: _emailController.text,
        cep: _cepController.text,
        ativo: _ativo,
      );
      if (cliente == null) {
        cubit.adicionarCliente(novoCliente);
      } else {
        cubit.atualizarCliente(novoCliente);
      }
      Modular.to.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cliente == null ? 'Novo Cliente' : 'Editar Cliente'),
      ),
      body: BlocConsumer<ClienteCubit, ClienteState>(
        listener: (context, state) {
          if (state is ClienteCepLoaded) {
            _enderecoController.text = state.endereco;
            _cidadeController.text = state.cidade;
            _estadoController.text = state.estado;
          }
          if (state is ClienteFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final loadingCep = state is ClienteCepLoading;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextField(
                    controller: _nomeController,
                    label: 'Nome',
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _telefoneController,
                    label: 'Telefone',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) return 'Campo obrigatório';
                      if (!RegexHelpers.isValidTelefone(value)) {
                        return 'Telefone inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _cpfCnpjController,
                    label: 'CPF/CNPJ',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) return 'Campo obrigatório';
                      if (!RegexHelpers.isValidCpfCnpj(value)) {
                        return 'CPF ou CNPJ inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'CEP',
                    controller: _cepController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [CepInputFormatter()],
                    validator: (value) => value == null || value.isEmpty
                        ? 'Campo obrigatório'
                        : null,
                    onFieldSubmitted: (_) => _onBuscarCep(),
                  ),
                  ElevatedButton(
                    onPressed: _onBuscarCep,
                    child: const Text('Buscar CEP'),
                  ),
                  if (loadingCep)
                    const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _enderecoController,
                    label: 'Endereço',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _cidadeController,
                    label: 'Cidade',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _estadoController,
                    label: 'Estado',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) return 'Campo obrigatório';
                      if (!RegexHelpers.isValidEmail(value)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    value: _ativo,
                    onChanged: (val) => setState(() => _ativo = val),
                    title: const Text('Ativo'),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: isLoading ? 'Salvando...' : 'Salvar',
                    enabled: !isLoading,
                    onPressed: _onSalvarCliente,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
