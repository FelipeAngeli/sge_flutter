import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../models/recibo_model.dart';

class PDFGenerator {
  static Future<File> generate(ReciboModel recibo) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Recibo', style: const pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 16),
            pw.Text('Empresa: ${recibo.nomeEmpresa}'),
            pw.Text('Produto: ${recibo.produto}'),
            pw.Text('Valor: R\$ ${recibo.valor.toStringAsFixed(2)}'),
            pw.Text('Data: ${recibo.data}'),
            pw.Text('Reimpressão: ${recibo.qrLink}'),
          ],
        ),
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${recibo.id}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
