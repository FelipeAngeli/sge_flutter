import 'package:flutter/material.dart';
import 'package:sge_flutter/models/produto_model.dart';

class ProdutoVendido {
  final ProdutoModel produto;
  final int vendas;

  ProdutoVendido({
    required this.produto,
    required this.vendas,
  });
}

class TopProdutosVendidosCard extends StatelessWidget {
  final List<ProdutoVendido> produtosMaisVendidos;

  const TopProdutosVendidosCard({
    super.key,
    required this.produtosMaisVendidos,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top 3 Produtos Mais Vendidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...produtosMaisVendidos.map(
              (entry) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(child: Text(entry.produto.nome[0])),
                title: Text(entry.produto.nome),
                subtitle: Text('Vendas: ${entry.vendas} unidades'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
