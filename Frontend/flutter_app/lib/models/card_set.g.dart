// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardSetAdapter extends TypeAdapter<CardSet> {
  @override
  final int typeId = 1;

  @override
  CardSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardSet(
      id: fields[0] as String?,
      setName: fields[1] as String?,
      setCode: fields[2] as String?,
      numOfCards: fields[3] as int?,
      tcgDate: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardSet obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.setName)
      ..writeByte(2)
      ..write(obj.setCode)
      ..writeByte(3)
      ..write(obj.numOfCards)
      ..writeByte(4)
      ..write(obj.tcgDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
