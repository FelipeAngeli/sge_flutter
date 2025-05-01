import 'package:sge_flutter/models/cliente_model.dart';

class ClientesMock {
  static List<ClienteModel> gerarClientes() {
    return [
      ClienteModel(
        id: '1',
        nome: 'João Silva',
        telefone: '11999999999',
        cpfCnpj: '123.456.789-00',
        endereco: 'Rua A, 123',
        email: 'joao@exemplo.com',
        ativo: true,
      ),
      ClienteModel(
        id: '2',
        nome: 'Maria Oliveira',
        telefone: '21999999999',
        cpfCnpj: '987.654.321-00',
        endereco: 'Av. B, 456',
        email: 'maria@exemplo.com',
        ativo: true,
      ),
      ClienteModel(
        id: '3',
        nome: 'Pedro Santos',
        telefone: '31999999999',
        cpfCnpj: '111.222.333-44',
        endereco: 'Rua C, 789',
        email: 'pedro@exemplo.com',
        ativo: false,
      ),
      ClienteModel(
        id: '4',
        nome: 'Ana Souza',
        telefone: '41999999999',
        cpfCnpj: '555.666.777-88',
        endereco: 'Rua D, 101',
        email: 'ana@exemplo.com',
        ativo: true,
      ),
      ClienteModel(
        id: '5',
        nome: 'Carlos Lima',
        telefone: '51999999999',
        cpfCnpj: '999.888.777-66',
        endereco: 'Av. E, 202',
        email: 'carlos@exemplo.com',
        ativo: false,
      ),
    ];
  }
}
