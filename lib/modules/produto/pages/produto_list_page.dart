import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_cubit.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_state.dart';

class ProdutoListPage extends StatelessWidget {
  const ProdutoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.navigate('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Modular.to.pushNamed('/produtos/form');
            },
          ),
        ],
      ),
      body: BlocBuilder<ProdutoCubit, ProdutoState>(
        builder: (context, state) {
          final cubit = context.read<ProdutoCubit>();

          if (state is ProdutoInitial) {
            cubit.loadProdutos();
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProdutoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProdutoLoaded) {
            final produtos = state.produtos;
            if (produtos.isEmpty) {
              return const Center(child: Text('Nenhum produto cadastrado.'));
            }
            return ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
                  onTap: () {
                    Modular.to.pushNamed('/produtos/form', arguments: produto);
                  },
                );
              },
            );
          } else if (state is ProdutoError) {
            return Center(child: Text('Erro: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
