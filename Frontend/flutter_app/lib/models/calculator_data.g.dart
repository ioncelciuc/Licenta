// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculatorDataAdapter extends TypeAdapter<CalculatorData> {
  @override
  final int typeId = 21;

  @override
  CalculatorData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculatorData(
      lp1Evo: (fields[0] as List).cast<int>(),
      lp2Evo: (fields[1] as List).cast<int>(),
      lp1: fields[2] as int,
      lp2: fields[3] as int,
      lp1Selected: fields[4] as bool,
      counters: (fields[5] as List).cast<Counter>(),
    );
  }

  @override
  void write(BinaryWriter writer, CalculatorData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.lp1Evo)
      ..writeByte(1)
      ..write(obj.lp2Evo)
      ..writeByte(2)
      ..write(obj.lp1)
      ..writeByte(3)
      ..write(obj.lp2)
      ..writeByte(4)
      ..write(obj.lp1Selected)
      ..writeByte(5)
      ..write(obj.counters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculatorDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
