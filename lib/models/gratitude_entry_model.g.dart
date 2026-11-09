// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gratitude_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GratitudeEntryAdapter extends TypeAdapter<GratitudeEntry> {
  @override
  final int typeId = 0;

  @override
  GratitudeEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GratitudeEntry(
      date: fields[0] as DateTime,
      entries: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, GratitudeEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.entries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GratitudeEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
