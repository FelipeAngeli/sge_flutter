import 'package:sge_flutter/models/produto_model.dart';

class ProdutosMock {
  static List<ProdutoModel> gerarProdutos() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    return [
      ProdutoModel(
        id: timestamp.toString(),
        nome: 'Camiseta Básica',
        preco: 49.90,
        estoque: 20,
        descricao: 'Camiseta básica de algodão',
        categoria: 'Roupas',
      ),
      ProdutoModel(
        id: (timestamp + 1).toString(),
        nome: 'Calça Jeans',
        preco: 139.90,
        estoque: 15,
        descricao: 'Calça jeans azul tradicional',
        categoria: 'Roupas',
      ),
      ProdutoModel(
        id: (timestamp + 2).toString(),
        nome: 'Tênis Esportivo',
        preco: 299.90,
        estoque: 10,
        descricao: 'Tênis confortável para corrida',
        categoria: 'Calçados',
      ),
    ];
  }
}
