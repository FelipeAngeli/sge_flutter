import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_cubit.dart';
import 'package:sge_flutter/modules/produto/cubit/produto_state.dart';
import 'package:sge_flutter/modules/estoque/widgets/produto_card.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';

class EstoqueListPage extends StatefulWidget {
  const EstoqueListPage({super.key});

  @override
  State<EstoqueListPage> createState() => _EstoqueListPageState();
}

class _EstoqueListPageState extends State<EstoqueListPage> {
  @override
  void initState() {
    super.initState();
    Modular.get<ProdutoCubit>().loadProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<ProdutoCubit>(),
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
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: PrimaryButton(
                        label: 'Associar Fornecedor (Geral)',
                        onPressed: () {
                          Modular.to.pushNamed('/estoque/associarFornecedor');
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
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
                            trailing: IconButton(
                              icon: const Icon(Icons.store,
                                  color: Colors.blueAccent),
                              tooltip: 'Fornecedores',
                              onPressed: () {
                                Modular.to.pushNamed('/estoque/fornecedores',
                                    arguments: produto.id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
