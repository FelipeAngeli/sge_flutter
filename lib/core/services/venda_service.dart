import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../../core/services/recibo_service.dart';
import '../../../models/cliente_model.dart';
import '../../../models/produto_model.dart';
import '../../../models/venda_model.dart';

class VendaService {
  final ReciboService reciboService = Modular.get<ReciboService>();
  final Box<VendaModel> vendaBox = Hive.box<VendaModel>('vendas');

  Future<void> finalizarVenda({
    required ClienteModel cliente,
    required ProdutoModel produto,
    required int quantidade,
    required double valorTotal,
  }) async {
    final venda = VendaModel(
      id: const Uuid().v4(),
      produto: produto.nome,
      cliente: cliente.nome,
      quantidade: quantidade,
      valorTotal: valorTotal,
      data: DateTime.now().toIso8601String(),
    );

    await vendaBox.put(venda.id, venda);

    await reciboService.gerarRecibo(
      nomeEmpresa: 'Minha Empresa',
      nomeCliente: cliente.nome,
      produto: produto.nome,
      quantidade: quantidade,
      valorTotal: valorTotal,
    );
  }

  List<VendaModel> listarVendas() {
    return vendaBox.values.toList();
  }

  VendaModel? buscarVendaPorId(String id) {
    return vendaBox.get(id);
  }
}
