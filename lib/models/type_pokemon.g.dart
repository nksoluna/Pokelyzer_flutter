// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypePokemonAdapter extends TypeAdapter<TypePokemon> {
  @override
  final int typeId = 7;

  @override
  TypePokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypePokemon(
      fields[0] as String,
      (fields[2] as List).cast<String>(),
      (fields[5] as List).cast<String>(),
      (fields[1] as List).cast<String>(),
      (fields[4] as List).cast<String>(),
      (fields[3] as List).cast<String>(),
      (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TypePokemon obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.weaknessesOffensive)
      ..writeByte(2)
      ..write(obj.immunesOffensive)
      ..writeByte(3)
      ..write(obj.strengthsOffensive)
      ..writeByte(4)
      ..write(obj.weaknessesDefensive)
      ..writeByte(5)
      ..write(obj.immunesDefensive)
      ..writeByte(6)
      ..write(obj.strengthsDefensive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypePokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
