import 'package:hive/hive.dart';

part 'produto_model.g.dart';

@HiveType(typeId: 0)
class ProdutoModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String nome;

  @HiveField(2)
  late double preco;

  @HiveField(3)
  late int estoque;

  @HiveField(4)
  late String descricao;

  @HiveField(5)
  late String categoria;

  @HiveField(6)
  late int vendas;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.preco,
    required this.estoque,
    required this.descricao,
    required this.categoria,
    required this.vendas,
  });

  factory ProdutoModel.create({required String nome, required double preco}) {
    return ProdutoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: nome,
      preco: preco,
      estoque: 0,
      descricao: '',
      categoria: '',
      vendas: 0,
    );
  }
}
