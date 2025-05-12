import 'package:hive/hive.dart';

part 'fornecedor_model.g.dart';

@HiveType(typeId: 6)
class FornecedorModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nomeEmpresa;

  @HiveField(2)
  String nomeFornecedor;

  @HiveField(3)
  String telefone;

  @HiveField(4)
  String email;

  @HiveField(5)
  List<String> produtos;

  @HiveField(6)
  String descricao;

  @HiveField(7)
  String categoria;

  @HiveField(8) // ✅ Novo campo CNPJ
  String cnpj;

  FornecedorModel({
    required this.id,
    required this.nomeEmpresa,
    required this.nomeFornecedor,
    required this.telefone,
    required this.email,
    List<String>? produtos,
    this.descricao = '',
    this.categoria = '',
    this.cnpj = '',
  }) : produtos = produtos ?? [];
}
