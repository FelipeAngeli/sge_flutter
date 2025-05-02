import 'package:hive/hive.dart';
import 'package:sge_flutter/models/cliente_model.dart';

class ClienteService {
  final Box<ClienteModel> _clienteBox = Hive.box<ClienteModel>('clientes');

  Future<List<ClienteModel>> listarClientes() async {
    return _clienteBox.values.toList();
  }

  Future<void> adicionarCliente(ClienteModel cliente) async {
    await _clienteBox.put(cliente.id, cliente);
  }

  Future<void> atualizarCliente(ClienteModel cliente) async {
    await _clienteBox.put(cliente.id, cliente);
  }

  Future<void> excluirCliente(String id) async {
    await _clienteBox.delete(id);
  }

  ClienteModel? buscarClientePorId(String id) {
    return _clienteBox.get(id);
  }
}
