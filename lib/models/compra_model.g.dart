// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compra_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompraModelAdapter extends TypeAdapter<CompraModel> {
  @override
  final int typeId = 9;

  @override
  CompraModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompraModel(
      id: fields[0] as String,
      clienteId: fields[1] as String,
      produtoNome: fields[2] as String,
      quantidade: fields[3] as int,
      precoUnitario: fields[4] as double,
      data: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CompraModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.clienteId)
      ..writeByte(2)
      ..write(obj.produtoNome)
      ..writeByte(3)
      ..write(obj.quantidade)
      ..writeByte(4)
      ..write(obj.precoUnitario)
      ..writeByte(5)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompraModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
