import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_state.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstoqueListPage extends StatelessWidget {
  const EstoqueListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EstoqueCubit>(context)..loadEstoque();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.navigate('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Modular.to.pushNamed('/estoque/form'),
          ),
        ],
      ),
      body: BlocBuilder<EstoqueCubit, EstoqueState>(
        builder: (context, state) {
          if (state is EstoqueLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EstoqueLoaded) {
            return ListView.builder(
              itemCount: state.produtos.length,
              itemBuilder: (context, index) {
                final ProdutoModel produto = state.produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text('Estoque: ${produto.estoque} unidades'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => cubit.removerProduto(produto.id),
                  ),
                );
              },
            );
          } else if (state is EstoqueError) {
            return Center(child: Text('Erro: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
