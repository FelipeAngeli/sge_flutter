import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/services/recibo_service.dart';
import '../../../core/storage/hive_config.dart';

class ReciboListPage extends StatelessWidget {
  const ReciboListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recibos = HiveConfig.reciboBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Recibos')),
      body: recibos.isEmpty
          ? const Center(child: Text('Nenhum recibo gerado.'))
          : _ReciboList(recibos: recibos),
    );
  }
}

class _ReciboList extends StatelessWidget {
  final List recibos;

  const _ReciboList({required this.recibos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recibos.length,
      itemBuilder: (context, index) {
        return _ReciboListItem(recibo: recibos[index]);
      },
    );
  }
}

class _ReciboListItem extends StatelessWidget {
  final recibo;

  const _ReciboListItem({required this.recibo});

  @override
  Widget build(BuildContext context) {
    final reciboService = Modular.get<ReciboService>();

    return ListTile(
      title: Text('${recibo.nomeEmpresa} - ${recibo.produto}'),
      subtitle: Text(
          'Valor: R\$ ${recibo.valor.toStringAsFixed(2)} | ${recibo.data}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdfBytes = await reciboService.gerarReciboPdf(
                nomeEmpresa: recibo.nomeEmpresa,
                nomeCliente: recibo.nomeCliente,
                produto: recibo.produto,
                quantidade: recibo.quantidade,
                valorTotal: recibo.valor,
              );
              await Printing.layoutPdf(onLayout: (_) => pdfBytes);
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final pdfBytes = await reciboService.gerarReciboPdf(
                nomeEmpresa: recibo.nomeEmpresa,
                nomeCliente: recibo.nomeCliente,
                produto: recibo.produto,
                quantidade: recibo.quantidade,
                valorTotal: recibo.valor,
              );
              final tempDir = await getTemporaryDirectory();
              final pdfFile = File('${tempDir.path}/${recibo.id}.pdf');
              await pdfFile.writeAsBytes(pdfBytes);

              await Share.shareXFiles(
                [XFile(pdfFile.path)],
                text:
                    'Confira o recibo de ${recibo.produto} para ${recibo.nomeCliente}, valor R\$ ${recibo.valor.toStringAsFixed(2)}.',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () async {
              final message =
                  '📄 Recibo de ${recibo.produto}\nCliente: ${recibo.nomeCliente}\nEmpresa: ${recibo.nomeEmpresa}\nValor: R\$ ${recibo.valor.toStringAsFixed(2)}\nData: ${recibo.data}\n🔗 ${recibo.qrLink}';
              final url = Uri.parse(
                  'https://wa.me/?text=${Uri.encodeComponent(message)}');

              if (await canLaunch(url.toString())) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Não foi possível abrir o WhatsApp')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
