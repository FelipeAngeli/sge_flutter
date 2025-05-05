import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/recibo_model.dart';
import '../utils/pdf_generator.dart';

class CompartilharButton extends StatelessWidget {
  final ReciboModel recibo;

  const CompartilharButton({super.key, required this.recibo});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.share),
      label: const Text('Compartilhar Recibo'),
      onPressed: () async {
        final pdfFile = await PDFGenerator.generate(recibo);
        await Share.shareXFiles(
          [XFile(pdfFile.path)],
          text: 'Aqui está seu recibo!',
          subject: 'Recibo Gerado',
        );
      },
    );
  }
}
