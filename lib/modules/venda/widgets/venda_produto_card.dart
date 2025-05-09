import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_cuibit.dart';
import 'package:sge_flutter/shared/widgets/custom_text_field.dart';

class VendaProdutoCard extends StatefulWidget {
  final ProdutoModel? produtoSelecionado;
  final List<ProdutoModel> produtos;
  final int quantidade;

  const VendaProdutoCard({
    super.key,
    required this.produtoSelecionado,
    required this.produtos,
    required this.quantidade,
  });

  @override
  State<VendaProdutoCard> createState() => _VendaProdutoCardState();
}

class _VendaProdutoCardState extends State<VendaProdutoCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.quantidade.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Produto',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<ProdutoModel>(
              value: widget.produtoSelecionado,
              items: widget.produtos.map((produto) {
                return DropdownMenuItem(
                  value: produto,
                  child: Text(produto.nome),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<VendaCubit>().selecionarProduto(value);
                }
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _controller,
              label: 'Quantidade',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final qtd = int.tryParse(value) ?? 0;
                context.read<VendaCubit>().atualizarQuantidade(qtd);
              },
            ),
          ],
        ),
      ),
    );
  }
}
