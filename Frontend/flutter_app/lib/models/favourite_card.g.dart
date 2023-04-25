// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteCardAdapter extends TypeAdapter<FavouriteCard> {
  @override
  final int typeId = 9;

  @override
  FavouriteCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteCard(
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteCard obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cardId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
