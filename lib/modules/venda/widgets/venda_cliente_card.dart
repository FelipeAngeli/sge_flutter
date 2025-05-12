import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_cuibit.dart';

class VendaClienteCard extends StatelessWidget {
  final ClienteModel? clienteSelecionado;
  final List<ClienteModel> clientes;

  const VendaClienteCard({
    super.key,
    required this.clienteSelecionado,
    required this.clientes,
  });

  @override
  Widget build(BuildContext context) {
    final clienteInativo =
        clienteSelecionado != null && !(clienteSelecionado?.ativo ?? false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cliente',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<ClienteModel>(
              value: clienteSelecionado,
              items: clientes.where((c) => c.ativo).map((cliente) {
                return DropdownMenuItem(
                  value: cliente,
                  child: Text(cliente.nome),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<VendaCubit>().selecionarCliente(value);
                }
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            if (clienteInativo) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning,
                        color: Theme.of(context).colorScheme.error),
                    const SizedBox(width: 8),
                    Text('Cliente inativo não pode realizar compras.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
