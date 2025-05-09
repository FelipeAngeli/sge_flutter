import 'package:flutter/material.dart';
import 'package:sge_flutter/models/cliente_model.dart';

class ClienteHeaderCard extends StatelessWidget {
  final ClienteModel cliente;

  const ClienteHeaderCard({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
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
}
