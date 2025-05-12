import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/core/services/fornecedor_service.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';

class FornecedoresProdutoPage extends StatelessWidget {
  final String produtoId;

  const FornecedoresProdutoPage({super.key, required this.produtoId});

  @override
  Widget build(BuildContext context) {
    final fornecedorService = Modular.get<FornecedorService>();
    final fornecedores =
        fornecedorService.buscarFornecedoresPorProduto(produtoId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fornecedores do Produto'),
      ),
      body: Column(
        children: [
          Expanded(
            child: fornecedores.isEmpty
                ? const Center(
                    child: Text('Nenhum fornecedor associado a este produto.'),
                  )
                : ListView.builder(
                    itemCount: fornecedores.length,
                    itemBuilder: (context, index) {
                      final fornecedor = fornecedores[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(fornecedor.nomeEmpresa),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (fornecedor.nomeFornecedor.isNotEmpty)
                                Text('Contato: ${fornecedor.nomeFornecedor}'),
                              if (fornecedor.categoria.isNotEmpty)
                                Text('Categoria: ${fornecedor.categoria}'),
                              if (fornecedor.descricao.isNotEmpty)
                                Text('Descrição: ${fornecedor.descricao}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              BlocProvider.of<EstoqueCubit>(context)
                                  .removerFornecedor(produtoId, fornecedor.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: 'Adicionar Novo Fornecedor',
              onPressed: () => Modular.to.pushNamed(
                '/estoque/adicionar-fornecedor',
                arguments: produtoId,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
