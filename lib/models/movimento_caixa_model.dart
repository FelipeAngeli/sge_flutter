import 'package:hive/hive.dart';

part 'movimento_caixa_model.g.dart';

@HiveType(typeId: 1)
class MovimentoCaixaModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime data;

  @HiveField(2)
  double valor;

  @HiveField(3)
  String tipo;

  @HiveField(4)
  String descricao;

  MovimentoCaixaModel({
    required this.id,
    required this.data,
    required this.valor,
    required this.tipo,
    required this.descricao,
  });
}
