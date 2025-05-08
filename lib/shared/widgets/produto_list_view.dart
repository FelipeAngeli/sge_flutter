// // lib/modules/produto/widgets/produto_list_view.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:sge_flutter/modules/produto/cubit/produto_cubit.dart';
// import '../../../models/produto_model.dart';

// class ProdutoListView extends StatelessWidget {
//   final List<ProdutoModel> produtos;

//   const ProdutoListView({super.key, required this.produtos});

//   @override
//   Widget build(BuildContext context) {
//     if (produtos.isEmpty) {
//       return const Center(child: Text('Nenhum produto cadastrado.'));
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: produtos.length,
//       itemBuilder: (context, index) {
//         final produto = produtos[index];
//         return ProdutoListItem(produto: produto);
//       },
//     );
//   }
// }

// class ProdutoListItem extends StatelessWidget {
//   final ProdutoModel produto;

//   const ProdutoListItem({super.key, required this.produto});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = BlocProvider.of<ProdutoCubit>(context);

//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         title: Text(produto.nome),
//         subtitle: Text(
//             'Preço: R\$ ${produto.preco.toStringAsFixed(2)}\nEstoque: ${produto.estoque} unidades'),
//         isThreeLine: true,
//         trailing: IconButton(
//           icon: const Icon(Icons.delete, color: Colors.red),
//           onPressed: () => cubit.removerProduto(produto.id),
//         ),
//         onTap: () => Modular.to
//             .pushNamed('/produtos/adicionarProduto', arguments: produto),
//       ),
//     );
//   }
// }
