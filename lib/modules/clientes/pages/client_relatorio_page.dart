import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/core/services/cliente_service.dart';
import '../widgets/cliente_header_card.dart';
import '../widgets/compra_card.dart';

class ClientRelatorioPage extends StatelessWidget {
  final String clienteId;

  const ClientRelatorioPage({super.key, required this.clienteId});

  @override
  Widget build(BuildContext context) {
    final clienteService = Modular.get<ClienteService>();
    final cliente = clienteService.obterClientePorId(clienteId);

    if (cliente == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Relatório do Cliente'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Modular.to.pop(),
          ),
        ),
        body: const Center(child: Text('Cliente não encontrado')),
      );
    }

    final compras = cliente.historicoCompras;

    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório: ${cliente.nome}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClienteHeaderCard(cliente: cliente),
            const SizedBox(height: 20),
            const Text(
              'Histórico de Compras',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: compras.isEmpty
                  ? const Center(child: Text('Nenhuma compra registrada.'))
                  : ListView.builder(
                      itemCount: compras.length,
                      itemBuilder: (context, index) =>
                          CompraCard(compra: compras[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
