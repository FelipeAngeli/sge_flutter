import 'package:flutter/material.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/core/storage/hive_config.dart';
import 'package:sge_flutter/models/fornecedor_model.dart';

class ProdutoCard extends StatelessWidget {
  final ProdutoModel produto;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Widget? trailing;

  const ProdutoCard({
    super.key,
    required this.produto,
    required this.onEdit,
    required this.onDelete,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final fornecedor = HiveConfig.fornecedorBox.values.firstWhere(
      (f) => f.produtos.contains(produto.id),
      orElse: () => FornecedorModel(
        id: '',
        nomeEmpresa: '',
        nomeFornecedor: '',
        telefone: '',
        email: '',
      ),
    );

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              produto.nome,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text('ID: ${produto.id}'),
            Text('Preço: R\$ ${produto.preco.toStringAsFixed(2)}'),
            Text('Quantidade: ${produto.estoque}'),
            if (produto.categoria.isNotEmpty)
              Text('Categoria: ${produto.categoria}'),
            if (produto.descricao.isNotEmpty)
              Text('Descrição: ${produto.descricao}'),
            if (fornecedor.nomeEmpresa.isNotEmpty)
              Text('Empresa: ${fornecedor.nomeEmpresa}'),
            if (fornecedor.nomeFornecedor.isNotEmpty)
              Text('Contato: ${fornecedor.nomeFornecedor}'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (trailing != null) trailing!,
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: onEdit,
                  tooltip: 'Editar',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                  tooltip: 'Excluir',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
