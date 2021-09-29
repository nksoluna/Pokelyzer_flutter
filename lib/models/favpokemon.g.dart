// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favpokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavpokemonAdapter extends TypeAdapter<Favpokemon> {
  @override
  final int typeId = 1;

  @override
  Favpokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favpokemon(
      fields[4] as int,
      fields[2] as String,
      (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Favpokemon obj) {
    writer
      ..writeByte(3)
      ..writeByte(4)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.types);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavpokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
