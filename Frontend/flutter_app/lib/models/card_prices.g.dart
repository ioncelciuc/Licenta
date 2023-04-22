// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_prices.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardPricesAdapter extends TypeAdapter<CardPrices> {
  @override
  final int typeId = 7;

  @override
  CardPrices read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardPrices(
      cardmarketPrice: fields[0] as String?,
      tcgplayerPrice: fields[1] as String?,
      ebayPrice: fields[2] as String?,
      amazonPrice: fields[3] as String?,
      coolstuffincPrice: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardPrices obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardmarketPrice)
      ..writeByte(1)
      ..write(obj.tcgplayerPrice)
      ..writeByte(2)
      ..write(obj.ebayPrice)
      ..writeByte(3)
      ..write(obj.amazonPrice)
      ..writeByte(4)
      ..write(obj.coolstuffincPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardPricesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
