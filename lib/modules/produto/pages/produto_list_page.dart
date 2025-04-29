// lib/modules/produto/pages/produto_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_cubit.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_state.dart';
import 'package:sge_flutter/models/produto_model.dart';

class ProdutoListPage extends StatelessWidget {
  const ProdutoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProdutoCubit>(context)..loadProdutos();

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
              Modular.to
                  .pushNamed('/estoque/form'); // Agora vai para EstoqueFormPage
            },
          ),
        ],
      ),
      body: BlocBuilder<ProdutoCubit, ProdutoState>(
        builder: (context, state) {
          if (state is ProdutoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProdutoLoaded) {
            if (state.produtos.isEmpty) {
              return const Center(child: Text('Nenhum produto encontrado.'));
            }
            return ListView.builder(
              itemCount: state.produtos.length,
              itemBuilder: (context, index) {
                final ProdutoModel produto = state.produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle:
                      Text('Preço: R\$ ${produto.preco.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      cubit.removerProduto(
                          produto.id); // Supondo que 'id' seja String
                    },
                  ),
                  onTap: () {
                    // Opcional: Editar produto
                    Modular.to.pushNamed('/estoque/form', arguments: produto);
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
