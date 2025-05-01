import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_cubit.dart';

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
      _ativo = cliente!.ativo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<ClienteCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(cliente == null ? 'Novo Cliente' : 'Editar Cliente'),
      ),
      body: Padding(
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
                controller: _enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final novoCliente = ClienteModel(
                      id: cliente?.id ??
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      nome: _nomeController.text,
                      telefone: _telefoneController.text,
                      cpfCnpj: _cpfCnpjController.text,
                      endereco: _enderecoController.text,
                      email: _emailController.text,
                      ativo: _ativo,
                    );
                    if (cliente == null) {
                      cubit.adicionarCliente(novoCliente);
                    } else {
                      cubit.atualizarCliente(novoCliente);
                    }
                    Modular.to.pop();
                  }
                },
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
