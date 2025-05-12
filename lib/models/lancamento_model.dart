import 'package:hive/hive.dart';

part 'lancamento_model.g.dart';

@HiveType(typeId: 5)
class LancamentoModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String descricao;

  @HiveField(2)
  double valor;

  @HiveField(3)
  DateTime dataVencimento;

  @HiveField(4)
  bool pago;

  LancamentoModel({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.dataVencimento,
    this.pago = false,
  });

  @override
  String toString() {
    return 'LancamentoModel(id: $id, descricao: $descricao, valor: $valor, '
        'dataVencimento: $dataVencimento, pago: $pago)';
  }
}
