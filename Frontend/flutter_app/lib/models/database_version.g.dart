// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_version.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatabaseVersionAdapter extends TypeAdapter<DatabaseVersion> {
  @override
  final int typeId = 0;

  @override
  DatabaseVersion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DatabaseVersion(
      id: fields[0] as String?,
      databaseVersion: fields[1] as String?,
      lastUpdate: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DatabaseVersion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.databaseVersion)
      ..writeByte(2)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseVersionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
