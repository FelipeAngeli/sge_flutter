import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_cubit.dart';
import 'package:sge_flutter/modules/clientes/cubits/cliente_state.dart';
import '../widgets/cliente_card.dart';

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
