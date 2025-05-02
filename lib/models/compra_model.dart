import 'package:hive/hive.dart';

part 'compra_model.g.dart';

@HiveType(typeId: 3)
class CompraModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String clienteId;

  @HiveField(2)
  String produtoNome;

  @HiveField(3)
  int quantidade;

  @HiveField(4)
  double precoUnitario;

  @HiveField(5)
  DateTime data;

  CompraModel({
    required this.id,
    required this.clienteId,
    required this.produtoNome,
    required this.quantidade,
    required this.precoUnitario,
    required this.data,
  });
}
