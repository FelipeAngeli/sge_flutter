import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_cubit.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_state.dart';
import 'package:sge_flutter/shared/widgets/produto_card.dart';

class EstoqueListPage extends StatelessWidget {
  const EstoqueListPage({super.key});

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
            switch (state) {
              case ProdutoLoading():
                return const Center(child: CircularProgressIndicator());

              case ProdutoSuccess(:final produtos):
                if (produtos.isEmpty) {
                  return const Center(
                      child: Text('Nenhum produto cadastrado.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    final produto = produtos[index];
                    return ProdutoCard(
                      produto: produto,
                      onEdit: () {
                        Modular.to.pushNamed('/produtos/adicionarProduto',
                            arguments: produto);
                      },
                      onDelete: () {
                        BlocProvider.of<ProdutoCubit>(context)
                            .removerProduto(produto.id);
                      },
                    );
                  },
                );

              case ProdutoFailure(:final error):
                return Center(child: Text('Erro ao carregar produtos: $error'));

              case ProdutoInitial():
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
