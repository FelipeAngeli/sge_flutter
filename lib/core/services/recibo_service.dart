import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import '../../models/recibo_model.dart';
import '../mock/recibos_mock.dart';

class ReciboService {
  final Box<ReciboModel> reciboBox = Hive.box<ReciboModel>('recibos');

  Future<ReciboModel> gerarRecibo({
    required String nomeEmpresa,
    required String nomeCliente,
    required String produto,
    required int quantidade,
    required double valorTotal,
  }) async {
    final recibo = ReciboModel(
      id: const Uuid().v4(),
      nomeEmpresa: nomeEmpresa,
      nomeCliente: nomeCliente,
      produto: produto,
      quantidade: quantidade,
      valor: valorTotal,
      data: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
      qrLink: 'https://meusite.com/recibo/${const Uuid().v4()}',
    );
    await reciboBox.put(recibo.id, recibo);
    return recibo;
  }

  Future<Uint8List> gerarReciboPdf({
    required String nomeEmpresa,
    required String nomeCliente,
    required String produto,
    required int quantidade,
    required double valorTotal,
  }) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(
            '$nomeEmpresa\n'
            'Cliente: $nomeCliente\n'
            'Produto: $produto\n'
            'Quantidade: $quantidade\n'
            'Valor Total: R\$ ${valorTotal.toStringAsFixed(2)}',
          ),
        ),
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> gerarReciboPdfMock() async {
    final mock = RecibosMock.gerarMock();
    return gerarReciboPdf(
      nomeEmpresa: mock.nomeEmpresa,
      nomeCliente: mock.nomeCliente,
      produto: mock.produto,
      quantidade: mock.quantidade,
      valorTotal: mock.valor,
    );
  }
}
