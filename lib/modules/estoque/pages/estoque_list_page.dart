import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_state.dart';

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
            onPressed: () {
              Modular.to.pushNamed('/estoque/form');
            },
          ),
        ],
      ),
      body: BlocBuilder<EstoqueCubit, EstoqueState>(
        builder: (context, state) {
          if (state is EstoqueLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EstoqueLoaded) {
            final produtos = state.produtos;
            return ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text('Estoque: ${produto.estoque} unidades'),
                  trailing: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      _confirmarVenda(context, cubit, produto.id, produto.nome);
                    },
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

  void _confirmarVenda(BuildContext context, EstoqueCubit cubit,
      String produtoId, String nomeProduto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Venda'),
        content: Text('Deseja vender 1 unidade de "$nomeProduto"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              cubit.venderProduto(produtoId);
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
