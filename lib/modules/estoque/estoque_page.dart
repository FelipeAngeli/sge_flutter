import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'estoque_cubit.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  @override
  void initState() {
    super.initState();
    context.read<EstoqueCubit>().loadProdutos();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<EstoqueCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Movimentação de Estoque')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Produtos:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            if (cubit.state.isEmpty)
              const Center(child: Text('Nenhum produto cadastrado.')),
            ...cubit.state.map((produto) => Card(
                  child: ListTile(
                    title: Text(produto.nome),
                    subtitle: Text('Qtd atual: ${produto.quantidade}'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'add') {
                          cubit.adicionarQuantidade(produto.id, 1);
                        } else {
                          cubit.removerQuantidade(produto.id, 1);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                            value: 'add', child: Text('Adicionar 1')),
                        const PopupMenuItem(
                            value: 'remove', child: Text('Remover 1')),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
