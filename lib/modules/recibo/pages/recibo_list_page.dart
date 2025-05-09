import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/recibo/cubit/recibo_cubit.dart';
import 'package:sge_flutter/modules/recibo/cubit/recibo_state.dart';

import '../widgets/recibo_list_item.dart';

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
