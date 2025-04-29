import 'package:hive/hive.dart';

part 'movimento_caixa_model.g.dart';

@HiveType(typeId: 1)
class MovimentoCaixaModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late DateTime data;

  @HiveField(2)
  late double valor;

  @HiveField(3)
  late String tipo; // entrada ou saída

  @HiveField(4)
  late String descricao;

  MovimentoCaixaModel({
    required this.id,
    required this.data,
    required this.valor,
    required this.tipo,
    required this.descricao,
  });
}
