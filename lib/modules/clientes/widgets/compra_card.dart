import 'package:flutter/material.dart';
import 'package:sge_flutter/models/compra_model.dart';

class CompraCard extends StatelessWidget {
  final CompraModel compra;

  const CompraCard({super.key, required this.compra});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      child: ListTile(
        leading: const Icon(Icons.shopping_cart),
        title: Text(compra.produtoNome),
        subtitle: Text(
            'Qtd: ${compra.quantidade} • Preço: R\$${compra.precoUnitario.toStringAsFixed(2)}'),
        trailing: Text(
          '${compra.data.day}/${compra.data.month}/${compra.data.year}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
