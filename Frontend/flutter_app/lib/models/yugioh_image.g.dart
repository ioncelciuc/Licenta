// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yugioh_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YuGiOhImageAdapter extends TypeAdapter<YuGiOhImage> {
  @override
  final int typeId = 8;

  @override
  YuGiOhImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return YuGiOhImage(
      id: fields[0] as String?,
      cardId: fields[1] as String?,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, YuGiOhImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cardId)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YuGiOhImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
