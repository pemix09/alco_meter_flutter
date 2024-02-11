// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrinkTypeAdapter extends TypeAdapter<DrinkType> {
  @override
  final int typeId = 3;

  @override
  DrinkType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DrinkType.beer;
      case 1:
        return DrinkType.wine;
      case 2:
        return DrinkType.vodka;
      default:
        return DrinkType.beer;
    }
  }

  @override
  void write(BinaryWriter writer, DrinkType obj) {
    switch (obj) {
      case DrinkType.beer:
        writer.writeByte(0);
        break;
      case DrinkType.wine:
        writer.writeByte(1);
        break;
      case DrinkType.vodka:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrinkTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
