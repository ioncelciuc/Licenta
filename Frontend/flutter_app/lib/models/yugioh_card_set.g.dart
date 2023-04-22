// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yugioh_card_set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YuGiOhCardSetAdapter extends TypeAdapter<YuGiOhCardSet> {
  @override
  final int typeId = 4;

  @override
  YuGiOhCardSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return YuGiOhCardSet(
      setName: fields[0] as String?,
      setCode: fields[1] as String?,
      setRarity: fields[2] as String?,
      setRarityCode: fields[3] as String?,
      setPrice: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, YuGiOhCardSet obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.setName)
      ..writeByte(1)
      ..write(obj.setCode)
      ..writeByte(2)
      ..write(obj.setRarity)
      ..writeByte(3)
      ..write(obj.setRarityCode)
      ..writeByte(4)
      ..write(obj.setPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YuGiOhCardSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
