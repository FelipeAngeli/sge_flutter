// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recibo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReciboModelAdapter extends TypeAdapter<ReciboModel> {
  @override
  final int typeId = 7;

  @override
  ReciboModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReciboModel(
      id: fields[0] as String,
      nomeEmpresa: fields[1] as String,
      nomeCliente: fields[2] as String,
      produto: fields[3] as String,
      quantidade: fields[4] as int,
      valor: fields[5] as double,
      data: fields[6] as String,
      qrLink: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReciboModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nomeEmpresa)
      ..writeByte(2)
      ..write(obj.nomeCliente)
      ..writeByte(3)
      ..write(obj.produto)
      ..writeByte(4)
      ..write(obj.quantidade)
      ..writeByte(5)
      ..write(obj.valor)
      ..writeByte(6)
      ..write(obj.data)
      ..writeByte(7)
      ..write(obj.qrLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReciboModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
