// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioModelAdapter extends TypeAdapter<UsuarioModel> {
  @override
  final int typeId = 2;

  @override
  UsuarioModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsuarioModel(
      id: fields[0] as String,
      nome: fields[1] as String,
      email: fields[2] as String,
      senha: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UsuarioModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.senha);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
