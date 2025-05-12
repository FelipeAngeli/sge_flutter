// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lancamento_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LancamentoModelAdapter extends TypeAdapter<LancamentoModel> {
  @override
  final int typeId = 5;

  @override
  LancamentoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LancamentoModel(
      id: fields[0] as String,
      descricao: fields[1] as String,
      valor: fields[2] as double,
      dataVencimento: fields[3] as DateTime,
      pago: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LancamentoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.valor)
      ..writeByte(3)
      ..write(obj.dataVencimento)
      ..writeByte(4)
      ..write(obj.pago);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LancamentoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
