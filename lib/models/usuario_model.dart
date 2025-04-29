import 'package:hive/hive.dart';

part 'usuario_model.g.dart';

@HiveType(typeId: 2)
class UsuarioModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String nome;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String senha;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });
}
