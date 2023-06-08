// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounterAdapter extends TypeAdapter<Counter> {
  @override
  final int typeId = 20;

  @override
  Counter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Counter(
      greenCounters: fields[0] as int,
      blueCounters: fields[1] as int,
      redCounters: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Counter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.greenCounters)
      ..writeByte(1)
      ..write(obj.blueCounters)
      ..writeByte(2)
      ..write(obj.redCounters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
