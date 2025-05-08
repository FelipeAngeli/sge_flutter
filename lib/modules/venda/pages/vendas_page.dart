import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_cuibit.dart';
import 'package:sge_flutter/modules/venda/cubit/venda_state.dart';
import 'package:sge_flutter/shared/widgets/primary_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

class VendaPage extends StatefulWidget {
  const VendaPage({super.key});

  @override
  State<VendaPage> createState() => _VendaPageState();
}

class _VendaPageState extends State<VendaPage> {
  final _quantidadeController = TextEditingController();

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }

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
        body: BlocBuilder<VendaCubit, VendaState>(
          builder: (context, state) {
            if (state is VendaLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is VendaLoaded) {
              final clienteSelecionado = state.clienteSelecionado;
              final clienteInativo =
                  clienteSelecionado != null && !clienteSelecionado.ativo;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Produto',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
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
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _quantidadeController,
                              label: 'Quantidade',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                final quantidade = int.tryParse(value);
                                if (quantidade == null || quantidade <= 0) {
                                  return 'Quantidade inválida';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                final quantidade = int.tryParse(value) ?? 0;
                                BlocProvider.of<VendaCubit>(context)
                                    .atualizarQuantidade(quantidade);
                              },
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Subtotal:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'R\$ ${state.subtotal.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Cliente',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<ClienteModel>(
                              value: state.clienteSelecionado,
                              items: state.clientes
                                  .where((c) => c.ativo)
                                  .map((cliente) {
                                return DropdownMenuItem(
                                  value: cliente,
                                  child: Text(cliente.nome),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  BlocProvider.of<VendaCubit>(context)
                                      .selecionarCliente(value);
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            if (clienteInativo) ...[
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Cliente inativo não pode realizar compras.',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: 'Finalizar Venda',
                        enabled: state.produtoSelecionado != null &&
                            state.quantidade > 0 &&
                            clienteSelecionado != null &&
                            clienteSelecionado.ativo,
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
                ),
              );
            }

            return const Center(child: Text('Erro ao carregar produtos.'));
          },
        ),
      ),
    );
  }
}
