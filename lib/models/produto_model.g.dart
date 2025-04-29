// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProdutoModelAdapter extends TypeAdapter<ProdutoModel> {
  @override
  final int typeId = 0;

  @override
  ProdutoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProdutoModel(
      id: fields[0] as String,
      nome: fields[1] as String,
      preco: fields[2] as double,
      estoque: fields[3] as int,
      descricao: fields[4] as String,
      categoria: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProdutoModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.preco)
      ..writeByte(3)
      ..write(obj.estoque)
      ..writeByte(4)
      ..write(obj.descricao)
      ..writeByte(5)
      ..write(obj.categoria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProdutoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
