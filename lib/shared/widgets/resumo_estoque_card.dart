// import 'package:flutter/material.dart';

// class ResumoEstoqueCard extends StatelessWidget {
//   final int totalEstoque;

//   const ResumoEstoqueCard({super.key, required this.totalEstoque});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Produtos em Estoque',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '$totalEstoque unidades',
//               style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
