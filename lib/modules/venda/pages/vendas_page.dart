import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_cuibit.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_state.dart';

import '../widgets/venda_cliente_card.dart';
import '../widgets/venda_produto_card.dart';
import '../widgets/venda_resumo_footer.dart';

class VendaPage extends StatelessWidget {
  const VendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VendaCubit, VendaState>(
      listener: (context, state) {
        if (state is VendaSuccess) {
          Modular.to.pushNamed('/recibo');
        } else if (state is VendaFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar Venda'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Modular.to.navigate('/'),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: _VendaContent(),
        ),
      ),
    );
  }
}

class _VendaContent extends StatelessWidget {
  const _VendaContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendaCubit, VendaState>(
      builder: (context, state) {
        if (state is VendaLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is VendaLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                VendaProdutoCard(
                  produtoSelecionado: state.produtoSelecionado,
                  produtos: state.produtos,
                  quantidade: state.quantidade,
                ),
                const SizedBox(height: 16),
                VendaClienteCard(
                  clienteSelecionado: state.clienteSelecionado,
                  clientes: state.clientes,
                ),
                const SizedBox(height: 32),
                VendaResumoFooter(state: state),
              ],
            ),
          );
        }

        return const Center(child: Text('Erro ao carregar produtos.'));
      },
    );
  }
}
