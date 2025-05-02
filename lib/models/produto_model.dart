import 'package:hive/hive.dart';

part 'produto_model.g.dart';

@HiveType(typeId: 0)
class ProdutoModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nome;

  @HiveField(2)
  double preco;

  @HiveField(3)
  int estoque;

  @HiveField(4)
  String descricao;

  @HiveField(5)
  String categoria;

  @HiveField(6)
  int vendas;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.preco,
    required this.estoque,
    required this.descricao,
    required this.categoria,
    this.vendas = 0,
  });
}
