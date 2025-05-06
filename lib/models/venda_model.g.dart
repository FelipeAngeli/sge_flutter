// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venda_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VendaModelAdapter extends TypeAdapter<VendaModel> {
  @override
  final int typeId = 8;

  @override
  VendaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VendaModel(
      id: fields[0] as String,
      produto: fields[1] as String,
      quantidade: fields[2] as int,
      valorTotal: fields[3] as double,
      cliente: fields[4] as String,
      data: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VendaModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.produto)
      ..writeByte(2)
      ..write(obj.quantidade)
      ..writeByte(3)
      ..write(obj.valorTotal)
      ..writeByte(4)
      ..write(obj.cliente)
      ..writeByte(5)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
