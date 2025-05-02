import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_cubit.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_state.dart';

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
    if (_cepController.text.length == 8) {
      cubit.buscarCep(_cepController.text);
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
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                  TextFormField(
                    controller: _telefoneController,
                    decoration: const InputDecoration(labelText: 'Telefone'),
                  ),
                  TextFormField(
                    controller: _cpfCnpjController,
                    decoration: const InputDecoration(labelText: 'CPF/CNPJ'),
                  ),
                  TextFormField(
                    controller: _cepController,
                    decoration: const InputDecoration(labelText: 'CEP'),
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_) => _onBuscarCep(),
                  ),
                  if (loadingCep)
                    const Center(child: CircularProgressIndicator()),
                  TextFormField(
                    controller: _enderecoController,
                    decoration: const InputDecoration(labelText: 'Endereço'),
                  ),
                  TextFormField(
                    controller: _cidadeController,
                    decoration: const InputDecoration(labelText: 'Cidade'),
                  ),
                  TextFormField(
                    controller: _estadoController,
                    decoration: const InputDecoration(labelText: 'Estado'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  SwitchListTile(
                    value: _ativo,
                    onChanged: (val) => setState(() => _ativo = val),
                    title: const Text('Ativo'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _onSalvarCliente,
                    child: const Text('Salvar'),
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
