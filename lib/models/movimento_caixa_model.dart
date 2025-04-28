import 'package:hive/hive.dart';

part 'movimento_caixa_model.g.dart';

@HiveType(typeId: 1)
class MovimentoCaixaModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime data;

  @HiveField(2)
  final double valor;

  @HiveField(3)
  final String tipo; // "entrada" ou "saida"

  @HiveField(4)
  final String descricao;

  MovimentoCaixaModel({
    required this.id,
    required this.data,
    required this.valor,
    required this.tipo,
    required this.descricao,
  });
}
