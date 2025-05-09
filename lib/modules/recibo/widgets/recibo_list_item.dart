import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../models/recibo_model.dart';
import '../cubit/recibo_cubit.dart';
import '../cubit/recibo_state.dart';

class ReciboListItem extends StatelessWidget {
  final ReciboModel recibo;

  const ReciboListItem({super.key, required this.recibo});

  @override
  Widget build(BuildContext context) {
    final reciboCubit = BlocProvider.of<ReciboCubit>(context);

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
              await reciboCubit.gerarPdf(recibo);
              final state = reciboCubit.state;
              if (state is ReciboPdfGerado) {
                await Printing.layoutPdf(onLayout: (_) async => state.pdfBytes);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              await reciboCubit.gerarPdf(recibo);
              final state = reciboCubit.state;
              if (state is ReciboPdfGerado) {
                final tempDir = await getTemporaryDirectory();
                final pdfFile = File('${tempDir.path}/${recibo.id}.pdf');
                await pdfFile.writeAsBytes(state.pdfBytes);
                await Share.shareXFiles([XFile(pdfFile.path)],
                    text: 'Confira o recibo!');
              }
            },
          ),
        ],
      ),
    );
  }
}
