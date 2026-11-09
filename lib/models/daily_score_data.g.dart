// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_score_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyScoreDataAdapter extends TypeAdapter<DailyScoreData> {
  @override
  final int typeId = 10;

  @override
  DailyScoreData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyScoreData(
      date: fields[0] as String,
      totalPoints: fields[1] as int,
      redCount: fields[2] as int,
      yellowCount: fields[3] as int,
      greenCount: fields[4] as int,
      mistakes: (fields[5] as List).cast<MistakeLog>(),
      gratitudeCount: fields[6] as int,
      gratitudeEntries: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DailyScoreData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.totalPoints)
      ..writeByte(2)
      ..write(obj.redCount)
      ..writeByte(3)
      ..write(obj.yellowCount)
      ..writeByte(4)
      ..write(obj.greenCount)
      ..writeByte(5)
      ..write(obj.mistakes)
      ..writeByte(6)
      ..write(obj.gratitudeCount)
      ..writeByte(7)
      ..write(obj.gratitudeEntries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyScoreDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
