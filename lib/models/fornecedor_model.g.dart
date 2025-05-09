// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FornecedorModelAdapter extends TypeAdapter<FornecedorModel> {
  @override
  final int typeId = 6;

  @override
  FornecedorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FornecedorModel(
      id: fields[0] as String,
      nomeEmpresa: fields[1] as String,
      nomeFornecedor: fields[2] as String,
      telefone: fields[3] as String,
      email: fields[4] as String,
      produtos: (fields[5] as List?)?.cast<String>(),
      descricao: fields[6] as String,
      categoria: fields[7] as String,
      cnpj: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FornecedorModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nomeEmpresa)
      ..writeByte(2)
      ..write(obj.nomeFornecedor)
      ..writeByte(3)
      ..write(obj.telefone)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.produtos)
      ..writeByte(6)
      ..write(obj.descricao)
      ..writeByte(7)
      ..write(obj.categoria)
      ..writeByte(8)
      ..write(obj.cnpj);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FornecedorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
