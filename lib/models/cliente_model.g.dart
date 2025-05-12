// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClienteModelAdapter extends TypeAdapter<ClienteModel> {
  @override
  final int typeId = 3;

  @override
  ClienteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClienteModel(
      id: fields[0] as String,
      nome: fields[1] as String,
      telefone: fields[2] as String,
      cpfCnpj: fields[3] as String,
      endereco: fields[4] as String,
      email: fields[5] as String,
      ativo: fields[6] as bool,
      cep: fields[7] as String,
      cidade: fields[8] as String,
      estado: fields[9] as String,
      historicoCompras: (fields[10] as List?)?.cast<CompraModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ClienteModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.telefone)
      ..writeByte(3)
      ..write(obj.cpfCnpj)
      ..writeByte(4)
      ..write(obj.endereco)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.ativo)
      ..writeByte(7)
      ..write(obj.cep)
      ..writeByte(8)
      ..write(obj.cidade)
      ..writeByte(9)
      ..write(obj.estado)
      ..writeByte(10)
      ..write(obj.historicoCompras);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClienteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
