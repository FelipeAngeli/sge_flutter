import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_cuibit.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_state.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';

class VendaResumoFooter extends StatelessWidget {
  final VendaLoaded state;

  const VendaResumoFooter({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cliente = state.clienteSelecionado;
    final produto = state.produtoSelecionado;

    return PrimaryButton(
      label: 'Finalizar Venda',
      enabled: produto != null &&
          cliente != null &&
          cliente.ativo &&
          state.quantidade > 0,
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Confirmar Venda'),
            content: Text(
              'Deseja confirmar a venda de ${state.quantidade}x "${produto?.nome}" por R\$ ${state.subtotal.toStringAsFixed(2)}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () {
                  context.read<VendaCubit>().finalizarVenda();
                  Navigator.pop(ctx);
                },
                child: const Text('Confirmar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
