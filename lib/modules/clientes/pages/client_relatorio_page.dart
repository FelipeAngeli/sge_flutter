import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/models/compra_model.dart';
import 'package:sge_flutter/core/services/cliente_service.dart';

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
            _buildClienteHeader(cliente),
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
                      itemBuilder: (context, index) {
                        final compra = compras[index];
                        return _buildCompraCard(compra);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClienteHeader(ClienteModel cliente) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(cliente.nome[0].toUpperCase()),
        ),
        title: Text(cliente.nome),
        subtitle:
            Text('${cliente.email}\n${cliente.cidade}, ${cliente.estado}'),
        isThreeLine: true,
        trailing: Chip(
          label: Text(
            cliente.ativo ? 'Ativo' : 'Inativo',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: cliente.ativo ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  Widget _buildCompraCard(CompraModel compra) {
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
