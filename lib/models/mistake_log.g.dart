// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mistake_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MistakeLogAdapter extends TypeAdapter<MistakeLog> {
  @override
  final int typeId = 11;

  @override
  MistakeLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MistakeLog(
      surahId: fields[0] as int,
      verseId: fields[1] as int,
      word: fields[2] as String,
      color: fields[3] as String,
      timestamp: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MistakeLog obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.surahId)
      ..writeByte(1)
      ..write(obj.verseId)
      ..writeByte(2)
      ..write(obj.word)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MistakeLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
