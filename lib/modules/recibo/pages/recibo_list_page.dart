import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:sge_flutter/models/recibo_model.dart';
import 'package:sge_flutter/modules/recibo/cubit/recibo_cubit.dart';
import 'package:sge_flutter/modules/recibo/cubit/recibo_state.dart';
import 'package:share_plus/share_plus.dart';

class ReciboListPage extends StatelessWidget {
  const ReciboListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<ReciboCubit>()..carregarRecibos(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Histórico de Recibos')),
        body: BlocBuilder<ReciboCubit, ReciboState>(
          builder: (context, state) {
            if (state is ReciboLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ReciboLoaded) {
              final recibos = state.recibos;
              if (recibos.isEmpty) {
                return const Center(child: Text('Nenhum recibo gerado.'));
              }
              return ListView.builder(
                itemCount: recibos.length,
                itemBuilder: (context, index) {
                  return ReciboListItem(recibo: recibos[index]);
                },
              );
            }
            if (state is ReciboFailure) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

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
