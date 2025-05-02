import 'package:hive/hive.dart';
import 'compra_model.dart';

part 'cliente_model.g.dart';

@HiveType(typeId: 2)
class ClienteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nome;

  @HiveField(2)
  String telefone;

  @HiveField(3)
  String cpfCnpj;

  @HiveField(4)
  String endereco;

  @HiveField(5)
  String email;

  @HiveField(6)
  bool ativo;

  @HiveField(7)
  List<CompraModel> historicoCompras;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.cpfCnpj,
    required this.endereco,
    required this.email,
    this.ativo = true,
    List<CompraModel>? historicoCompras,
  }) : historicoCompras = historicoCompras ?? [];
}
