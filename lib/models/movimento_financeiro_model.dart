import 'package:hive/hive.dart';

part 'movimento_financeiro_model.g.dart';

@HiveType(typeId: 1)
class MovimentoFinanceiroModel extends HiveObject {
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

  MovimentoFinanceiroModel({
    required this.id,
    required this.data,
    required this.valor,
    required this.tipo,
    required this.descricao,
  });
}
