import 'package:hive/hive.dart';

part 'produto_model.g.dart';

@HiveType(typeId: 1)
class ProdutoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String nome;

  @HiveField(2)
  final String descricao;

  @HiveField(3)
  final double preco;

  @HiveField(4)
  final int quantidade;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.quantidade,
  });
}
