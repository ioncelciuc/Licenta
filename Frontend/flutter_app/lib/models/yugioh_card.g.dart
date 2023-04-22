// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yugioh_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YuGiOhCardAdapter extends TypeAdapter<YuGiOhCard> {
  @override
  final int typeId = 3;

  @override
  YuGiOhCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return YuGiOhCard(
      id: fields[0] as String?,
      cardId: fields[1] as int?,
      name: fields[2] as String?,
      type: fields[3] as String?,
      desc: fields[4] as String?,
      atk: fields[5] as int?,
      def: fields[6] as int?,
      level: fields[7] as int?,
      race: fields[8] as String?,
      attribute: fields[9] as String?,
      archetype: fields[10] as String?,
      scale: fields[11] as int?,
      linkval: fields[12] as int?,
      linkmarkers: (fields[13] as List?)?.cast<String>(),
      cardSets: (fields[14] as List?)?.cast<YuGiOhCardSet>(),
      cardImages: (fields[15] as List?)?.cast<CardImage>(),
      cardPrices: fields[16] as CardPrices?,
      banlistInfo: fields[17] as BanlistInfo?,
    );
  }

  @override
  void write(BinaryWriter writer, YuGiOhCard obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cardId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.desc)
      ..writeByte(5)
      ..write(obj.atk)
      ..writeByte(6)
      ..write(obj.def)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.race)
      ..writeByte(9)
      ..write(obj.attribute)
      ..writeByte(10)
      ..write(obj.archetype)
      ..writeByte(11)
      ..write(obj.scale)
      ..writeByte(12)
      ..write(obj.linkval)
      ..writeByte(13)
      ..write(obj.linkmarkers)
      ..writeByte(14)
      ..write(obj.cardSets)
      ..writeByte(15)
      ..write(obj.cardImages)
      ..writeByte(16)
      ..write(obj.cardPrices)
      ..writeByte(17)
      ..write(obj.banlistInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YuGiOhCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
