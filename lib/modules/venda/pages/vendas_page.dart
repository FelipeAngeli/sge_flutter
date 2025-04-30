import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_cuibit.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_state.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';

class VendaPage extends StatelessWidget {
  const VendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<VendaCubit>()..carregarProdutos(),
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
          child: VendaFormWidget(),
        ),
      ),
    );
  }
}

class VendaFormWidget extends StatelessWidget {
  const VendaFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendaCubit, VendaState>(
      builder: (context, state) {
        if (state is VendaLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is VendaLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<ProdutoModel>(
                value: state.produtoSelecionado,
                items: state.produtos.map((produto) {
                  return DropdownMenuItem(
                    value: produto,
                    child: Text(produto.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    BlocProvider.of<VendaCubit>(context)
                        .selecionarProduto(value);
                  }
                },
                decoration: const InputDecoration(labelText: 'Produto'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue:
                    state.quantidade > 0 ? state.quantidade.toString() : '',
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                onChanged: (value) {
                  final quantidade = int.tryParse(value) ?? 0;
                  BlocProvider.of<VendaCubit>(context)
                      .atualizarQuantidade(quantidade);
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Subtotal: R\$ ${state.subtotal.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Finalizar Venda',
                  enabled:
                      state.produtoSelecionado != null && state.quantidade > 0,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: const Text('Confirmar Venda'),
                        content: Text(
                          'Deseja confirmar a venda de ${state.quantidade}x "${state.produtoSelecionado?.nome}" por R\$ ${state.subtotal.toStringAsFixed(2)}?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancelar'),
                          ),
                          FilledButton(
                            onPressed: () {
                              BlocProvider.of<VendaCubit>(context)
                                  .finalizarVenda();
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Venda registrada com sucesso!')),
                              );
                            },
                            child: const Text('Confirmar'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const Center(child: Text('Erro ao carregar produtos.'));
      },
    );
  }
}
