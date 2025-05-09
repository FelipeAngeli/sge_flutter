import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/core/services/fornecedor_service.dart';
import 'package:sge_flutter/modules/estoque/cubit/estoque_cubit.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';

class AdicionarFornecedorPage extends StatelessWidget {
  final String produtoId;

  const AdicionarFornecedorPage({super.key, required this.produtoId});

  @override
  Widget build(BuildContext context) {
    final fornecedorService = Modular.get<FornecedorService>();
    final fornecedores = fornecedorService.listarFornecedores();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Fornecedor'),
      ),
      body: ListView.builder(
        itemCount: fornecedores.length,
        itemBuilder: (context, index) {
          final fornecedor = fornecedores[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fornecedor.nomeEmpresa, // nome da empresa
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (fornecedor.nomeFornecedor.isNotEmpty)
                    Text('Fornecedor: ${fornecedor.nomeFornecedor}'),
                  if (fornecedor.telefone.isNotEmpty)
                    Text('Telefone: ${fornecedor.telefone}'),
                  if (fornecedor.descricao.isNotEmpty)
                    Text('Descrição: ${fornecedor.descricao}'),
                  if (fornecedor.categoria.isNotEmpty)
                    Text('Categoria: ${fornecedor.categoria}'),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: 'Associar a este fornecedor',
                    onPressed: () {
                      BlocProvider.of<EstoqueCubit>(context)
                          .associarFornecedor(produtoId, fornecedor.id);
                      Modular.to.pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
