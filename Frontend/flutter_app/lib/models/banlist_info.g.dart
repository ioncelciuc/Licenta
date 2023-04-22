// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banlist_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BanlistInfoAdapter extends TypeAdapter<BanlistInfo> {
  @override
  final int typeId = 5;

  @override
  BanlistInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BanlistInfo(
      banTcg: fields[0] as String?,
      banOcg: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BanlistInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.banTcg)
      ..writeByte(1)
      ..write(obj.banOcg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BanlistInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
