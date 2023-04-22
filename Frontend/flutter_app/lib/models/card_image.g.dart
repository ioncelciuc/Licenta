// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardImageAdapter extends TypeAdapter<CardImage> {
  @override
  final int typeId = 6;

  @override
  CardImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardImage(
      imageUrl: fields[0] as String?,
      imageUrlSmall: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardImage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.imageUrlSmall);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
