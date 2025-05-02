import 'package:hive/hive.dart';
import 'compra_model.dart';

part 'cliente_model.g.dart';

@HiveType(typeId: 3)
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
  String cep;

  @HiveField(8)
  String cidade;

  @HiveField(9)
  String estado;

  @HiveField(10)
  List<CompraModel> historicoCompras;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.cpfCnpj,
    required this.endereco,
    required this.email,
    required this.ativo,
    required this.cep,
    required this.cidade,
    required this.estado,
    List<CompraModel>? historicoCompras,
  }) : historicoCompras = historicoCompras ?? [];
}
