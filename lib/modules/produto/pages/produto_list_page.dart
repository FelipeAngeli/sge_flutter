import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/shared/widgets/produto_card.dart';
import '../cubit/produto_cubit.dart';
import '../cubit/produto_state.dart';

class ProdutoListPage extends StatelessWidget {
  const ProdutoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProdutoCubit>(
      create: (_) => Modular.get<ProdutoCubit>()..loadProdutos(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Produtos'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Modular.to.navigate('/'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () =>
                  Modular.to.pushNamed('/produtos/adicionarProduto'),
            ),
          ],
        ),
        body: BlocBuilder<ProdutoCubit, ProdutoState>(
          builder: (context, state) {
            if (state is ProdutoLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProdutoSuccess) {
              if (state.produtos.isEmpty) {
                return const Center(child: Text('Nenhum produto cadastrado.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.produtos.length,
                itemBuilder: (context, index) {
                  final produto = state.produtos[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(produto.nome),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${produto.id}'),
                          Text('Quantidade: ${produto.estoque}'),
                          Text(
                              'Valor: R\$ ${produto.preco.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(child: Text('Erro ao carregar produtos.'));
          },
        ),
      ),
    );
  }
}
