import 'package:hive/hive.dart';

part 'usuario_model.g.dart';

@HiveType(typeId: 0)
class UsuarioModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String nome;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String senha;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });
}
