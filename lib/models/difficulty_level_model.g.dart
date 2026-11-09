// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difficulty_level_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DifficultyLevelAdapter extends TypeAdapter<DifficultyLevel> {
  @override
  final int typeId = 14;

  @override
  DifficultyLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DifficultyLevel.multipleChoice;
      case 1:
        return DifficultyLevel.beginner;
      case 2:
        return DifficultyLevel.learned;
      case 3:
        return DifficultyLevel.qari;
      default:
        return DifficultyLevel.multipleChoice;
    }
  }

  @override
  void write(BinaryWriter writer, DifficultyLevel obj) {
    switch (obj) {
      case DifficultyLevel.multipleChoice:
        writer.writeByte(0);
        break;
      case DifficultyLevel.beginner:
        writer.writeByte(1);
        break;
      case DifficultyLevel.learned:
        writer.writeByte(2);
        break;
      case DifficultyLevel.qari:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DifficultyLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
