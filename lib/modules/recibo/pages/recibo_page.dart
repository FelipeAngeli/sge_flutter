import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/services/recibo_service.dart';
import '../../../core/mock/recibos_mock.dart'; // Importante para o mock
import '../../../shared/widgets/primary_button.dart';

class ReciboPage extends StatelessWidget {
  const ReciboPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reciboService = Modular.get<ReciboService>();
    final reciboMock = RecibosMock.gerarMock(); // Aqui chamamos o mock gerado

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recibo Gerado'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.navigate('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Modular.to.navigate('/'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: reciboService.gerarReciboPdfMock(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final pdfBytes = snapshot.data as Uint8List;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'RECIBO',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(),
                        _buildRow('Empresa', reciboMock.nomeEmpresa),
                        _buildRow('Cliente', reciboMock.nomeCliente),
                        _buildRow('Produto', reciboMock.produto),
                        _buildRow(
                            'Quantidade', reciboMock.quantidade.toString()),
                        _buildRow('Total',
                            'R\$ ${reciboMock.valor.toStringAsFixed(2)}'),
                        _buildRow('Data', reciboMock.data),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  label: 'Imprimir',
                  onPressed: () async {
                    await Printing.layoutPdf(onLayout: (_) => pdfBytes);
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Compartilhar',
                  onPressed: () async {
                    final tempDir = await getTemporaryDirectory();
                    final pdfFile = File('${tempDir.path}/recibo_mock.pdf');
                    await pdfFile.writeAsBytes(pdfBytes);

                    await Share.shareXFiles(
                      [XFile(pdfFile.path)],
                      text: '📄 Confira o recibo gerado! ✅',
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
