// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuotesAdapter extends TypeAdapter<Quotes> {
  @override
  final int typeId = 0;

  @override
  Quotes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quotes(
      quote: fields[0] as String,
      author: fields[1] as String,
      characterCount: fields[2] as int,
      used: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Quotes obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.quote)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.characterCount)
      ..writeByte(3)
      ..write(obj.used);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuotesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
