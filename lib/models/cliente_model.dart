import 'package:hive/hive.dart';

part 'cliente_model.g.dart';

@HiveType(typeId: 2)
class ClienteModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String nome;

  @HiveField(2)
  late String telefone;

  @HiveField(3)
  late String cpfCnpj;

  @HiveField(4)
  late String endereco;

  @HiveField(5)
  late String email;

  @HiveField(6)
  late bool ativo;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.cpfCnpj,
    required this.endereco,
    required this.email,
    required this.ativo,
  });
}
