// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archetype.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArchetypeAdapter extends TypeAdapter<Archetype> {
  @override
  final int typeId = 2;

  @override
  Archetype read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Archetype(
      id: fields[0] as String,
      archetypeName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Archetype obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.archetypeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArchetypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
