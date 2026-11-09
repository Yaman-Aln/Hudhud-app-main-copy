// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unique_test_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UniqueTestModelAdapter extends TypeAdapter<UniqueTestModel> {
  @override
  final int typeId = 1;

  @override
  UniqueTestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UniqueTestModel()
      ..name = fields[0] as String
      ..languagePreference = fields[1] as Language
      ..subscriptionTier = fields[2] as SubscriptionTier
      ..reciterId = fields[3] as int
      ..goals = (fields[4] as List).cast<Goal>()
      ..reminderFrequency = fields[5] as ReminderFrequency
      ..onboardingComplete = fields[6] as bool
      ..notificationFrequency = fields[7] as String
      ..fontFamily = fields[8] as String
      ..fontWeight = fields[9] as int
      ..defaultDifficulty = fields[10] as DifficultyLevel?
      ..defaultRepeatCount = fields[11] as int?
      ..defaultAudioRepeat = fields[12] as int?;
  }

  @override
  void write(BinaryWriter writer, UniqueTestModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.languagePreference)
      ..writeByte(2)
      ..write(obj.subscriptionTier)
      ..writeByte(3)
      ..write(obj.reciterId)
      ..writeByte(4)
      ..write(obj.goals)
      ..writeByte(5)
      ..write(obj.reminderFrequency)
      ..writeByte(6)
      ..write(obj.onboardingComplete)
      ..writeByte(7)
      ..write(obj.notificationFrequency)
      ..writeByte(8)
      ..write(obj.fontFamily)
      ..writeByte(9)
      ..write(obj.fontWeight)
      ..writeByte(10)
      ..write(obj.defaultDifficulty)
      ..writeByte(11)
      ..write(obj.defaultRepeatCount)
      ..writeByte(12)
      ..write(obj.defaultAudioRepeat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UniqueTestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReminderFrequencyAdapter extends TypeAdapter<ReminderFrequency> {
  @override
  final int typeId = 6;

  @override
  ReminderFrequency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderFrequency(
      isNone: fields[0] as bool,
      onceDaily: fields[1] as DateTime?,
      customTimes: (fields[2] as List?)?.cast<DateTime>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReminderFrequency obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isNone)
      ..writeByte(1)
      ..write(obj.onceDaily)
      ..writeByte(2)
      ..write(obj.customTimes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderFrequencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LanguageAdapter extends TypeAdapter<Language> {
  @override
  final int typeId = 2;

  @override
  Language read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Language.english;
      case 1:
        return Language.arabic;
      case 2:
        return Language.french;
      case 3:
        return Language.malaysian;
      case 4:
        return Language.indonesian;
      case 5:
        return Language.spanish;
      case 6:
        return Language.urdu;
      case 7:
        return Language.farsi;
      case 8:
        return Language.turkish;
      default:
        return Language.english;
    }
  }

  @override
  void write(BinaryWriter writer, Language obj) {
    switch (obj) {
      case Language.english:
        writer.writeByte(0);
        break;
      case Language.arabic:
        writer.writeByte(1);
        break;
      case Language.french:
        writer.writeByte(2);
        break;
      case Language.malaysian:
        writer.writeByte(3);
        break;
      case Language.indonesian:
        writer.writeByte(4);
        break;
      case Language.spanish:
        writer.writeByte(5);
        break;
      case Language.urdu:
        writer.writeByte(6);
        break;
      case Language.farsi:
        writer.writeByte(7);
        break;
      case Language.turkish:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubscriptionTierAdapter extends TypeAdapter<SubscriptionTier> {
  @override
  final int typeId = 3;

  @override
  SubscriptionTier read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SubscriptionTier.free;
      case 1:
        return SubscriptionTier.premium;
      case 2:
        return SubscriptionTier.premiumPlus;
      default:
        return SubscriptionTier.free;
    }
  }

  @override
  void write(BinaryWriter writer, SubscriptionTier obj) {
    switch (obj) {
      case SubscriptionTier.free:
        writer.writeByte(0);
        break;
      case SubscriptionTier.premium:
        writer.writeByte(1);
        break;
      case SubscriptionTier.premiumPlus:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionTierAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final int typeId = 5;

  @override
  Goal read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Goal.connectQuran;
      case 1:
        return Goal.memorizeQuran;
      case 2:
        return Goal.buildConsistency;
      case 3:
        return Goal.beMoreGrateful;
      case 4:
        return Goal.improveArabic;
      case 5:
        return Goal.deepenTafsir;
      case 6:
        return Goal.other;
      default:
        return Goal.connectQuran;
    }
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    switch (obj) {
      case Goal.connectQuran:
        writer.writeByte(0);
        break;
      case Goal.memorizeQuran:
        writer.writeByte(1);
        break;
      case Goal.buildConsistency:
        writer.writeByte(2);
        break;
      case Goal.beMoreGrateful:
        writer.writeByte(3);
        break;
      case Goal.improveArabic:
        writer.writeByte(4);
        break;
      case Goal.deepenTafsir:
        writer.writeByte(5);
        break;
      case Goal.other:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
