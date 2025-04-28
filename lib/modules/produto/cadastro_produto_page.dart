// lib/modules/produto/cadastro_produto_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cadastro_produto_cubit.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/custom_button.dart';

class CadastroProdutoPage extends StatefulWidget {
  const CadastroProdutoPage({super.key});

  @override
  State<CadastroProdutoPage> createState() => _CadastroProdutoPageState();
}

class _CadastroProdutoPageState extends State<CadastroProdutoPage> {
  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final precoController = TextEditingController();
  final quantidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CadastroProdutoCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CustomTextField(
              label: 'Nome',
              controller: nomeController,
            ),
            CustomTextField(
              label: 'Descrição',
              controller: descricaoController,
            ),
            CustomTextField(
              label: 'Preço',
              controller: precoController,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              label: 'Quantidade',
              controller: quantidadeController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Salvar Produto',
              onPressed: () {
                cubit.adicionarProduto(
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                  preco: double.tryParse(precoController.text) ?? 0.0,
                  quantidade: int.tryParse(quantidadeController.text) ?? 0,
                );
                nomeController.clear();
                descricaoController.clear();
                precoController.clear();
                quantidadeController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Produto adicionado!')),
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text('Produtos cadastrados:', style: TextStyle(fontSize: 18)),
            ...cubit.state.map((produto) => ListTile(
                  title: Text(produto.nome),
                  subtitle:
                      Text('Qtd: ${produto.quantidade} | R\$${produto.preco}'),
                )),
          ],
        ),
      ),
    );
  }
}
