import 'package:hive/hive.dart';

part 'venda_model.g.dart';

@HiveType(typeId: 8)
class VendaModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String produto;

  @HiveField(2)
  int quantidade;

  @HiveField(3)
  double valorTotal;

  @HiveField(4)
  String cliente;

  @HiveField(5)
  String data;

  VendaModel({
    required this.id,
    required this.produto,
    required this.quantidade,
    required this.valorTotal,
    required this.cliente,
    required this.data,
  });
}
