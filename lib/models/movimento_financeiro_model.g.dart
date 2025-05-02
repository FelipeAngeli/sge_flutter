// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movimento_financeiro_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovimentoFinanceiroModelAdapter
    extends TypeAdapter<MovimentoFinanceiroModel> {
  @override
  final int typeId = 1;

  @override
  MovimentoFinanceiroModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovimentoFinanceiroModel(
      id: fields[0] as String,
      data: fields[1] as DateTime,
      valor: fields[2] as double,
      tipo: fields[3] as String,
      descricao: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovimentoFinanceiroModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.valor)
      ..writeByte(3)
      ..write(obj.tipo)
      ..writeByte(4)
      ..write(obj.descricao);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovimentoFinanceiroModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
