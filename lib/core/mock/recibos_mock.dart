// lib/core/mock/recibos_mock.dart

import '../../models/recibo_model.dart';

class RecibosMock {
  static ReciboModel gerarMock() {
    return ReciboModel(
      id: 'mock-id-123',
      nomeEmpresa: 'Minha Empresa',
      nomeCliente: 'João Silva',
      produto: 'Camiseta Azul',
      quantidade: 2,
      valor: 100.00,
      data: '01/01/2025 12:00',
      qrLink: 'https://meusite.com/recibo/mock-id-123',
    );
  }
}
