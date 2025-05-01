import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_cubit.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_state.dart';

class ClientListPage extends StatelessWidget {
  const ClientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.navigate('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Modular.to.pushNamed('/clientes/form/'),
          ),
        ],
      ),
      body: BlocBuilder<ClienteCubit, ClienteState>(
        builder: (context, state) {
          if (state is ClienteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ClienteLoaded) {
            if (state.clientes.isEmpty) {
              return const Center(child: Text('Nenhum cliente cadastrado.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.clientes.length,
              itemBuilder: (context, index) {
                final cliente = state.clientes[index];
                return ClienteCard(cliente: cliente);
              },
            );
          }

          if (state is ClienteFailure) {
            return Center(child: Text('Erro: ${state.message}'));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class ClienteCard extends StatelessWidget {
  final ClienteModel cliente;

  const ClienteCard({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ClienteCubit>(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cliente.nome,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Telefone: ${cliente.telefone}'),
            Text('Email: ${cliente.email}'),
            Text('Status: ${cliente.ativo ? 'Ativo' : 'Inativo'}',
                style: TextStyle(
                    color: cliente.ativo ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Modular.to.pushNamed('/clientes/form/', arguments: cliente);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Excluir Cliente'),
                        content: Text(
                            'Tem certeza que deseja excluir ${cliente.nome}?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              cubit.excluirCliente(cliente.id);
                              Navigator.pop(ctx);
                            },
                            child: const Text('Confirmar'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
