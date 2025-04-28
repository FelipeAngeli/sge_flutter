// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movimento_caixa_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovimentoCaixaModelAdapter extends TypeAdapter<MovimentoCaixaModel> {
  @override
  final int typeId = 2;

  @override
  MovimentoCaixaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovimentoCaixaModel(
      id: fields[0] as String,
      data: fields[1] as DateTime,
      valor: fields[2] as double,
      tipo: fields[3] as String,
      descricao: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovimentoCaixaModel obj) {
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
      other is MovimentoCaixaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
