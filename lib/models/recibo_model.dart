import 'package:hive/hive.dart';

part 'recibo_model.g.dart';

@HiveType(typeId: 7)
class ReciboModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nomeEmpresa;

  @HiveField(2)
  String nomeCliente;

  @HiveField(3)
  String produto;

  @HiveField(4)
  int quantidade;

  @HiveField(5)
  double valor;

  @HiveField(6)
  String data;

  @HiveField(7)
  String qrLink;

  ReciboModel({
    required this.id,
    required this.nomeEmpresa,
    required this.nomeCliente,
    required this.produto,
    required this.quantidade,
    required this.valor,
    required this.data,
    required this.qrLink,
  });
}
