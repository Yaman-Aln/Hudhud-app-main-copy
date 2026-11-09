// lib/z_onboarding/models/unique_test_model.dart

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hive/hive.dart';

// (NEW) Import the 4-value DifficultyLevel from your other file:
import 'package:hudhud_quran_app_new/models/difficulty_level_model.dart';

/// We need a part file reference for Hive's generated code.
part 'unique_test_model.g.dart';

@HiveType(typeId: 1) // Ensure typeId is distinct from other Hive models
class UniqueTestModel extends HiveObject {
  /// The user's chosen or displayed name.
  @HiveField(0)
  String name;

  /// The user's selected language preference.
  @HiveField(1)
  Language languagePreference;

  /// The user's subscription tier (free, premium, or premiumPlus).
  @HiveField(2)
  SubscriptionTier subscriptionTier;

  /// The user's chosen reciter ID (1, 2, or 3).
  @HiveField(3)
  int reciterId;

  /// A list of user goals (multi-select).
  @HiveField(4)
  List<Goal> goals;

  /// The user's chosen reminder frequency (none, once daily, or multiple custom).
  @HiveField(5)
  ReminderFrequency reminderFrequency;

  /// Whether onboarding is complete.
  @HiveField(6)
  bool onboardingComplete;

  /// The user's preferred notification setting: "Daily", "Weekly", or "None".
  @HiveField(7)
  String notificationFrequency;

  /// The user's chosen font family (e.g. "NotoNaskh", "Amiri").
  @HiveField(8)
  String fontFamily;

  /// The user's chosen font weight (e.g., 400 or 700).
  @HiveField(9)
  int fontWeight;

  /// (A) Default lesson difficulty (4-value enum).
  @HiveField(10)
  DifficultyLevel? defaultDifficulty;

  /// (B) Default repeat count for fill-in or MC steps.
  @HiveField(11)
  int? defaultRepeatCount;

  /// (C) Default audio repeat count.
  @HiveField(12)
  int? defaultAudioRepeat;

  // -------------------------------------------------------------------------
  // Required zero-arg constructor for HiveObject classes
  // -------------------------------------------------------------------------
  UniqueTestModel()
      : name = 'Guest',
        languagePreference = Language.english,
        subscriptionTier = SubscriptionTier.free,
        reciterId = 1,
        goals = const [],
        reminderFrequency = const ReminderFrequency(),
        onboardingComplete = false,
        notificationFrequency = 'None',
        fontFamily = 'Amiri',
        fontWeight = 400,
        defaultDifficulty = null,
        defaultRepeatCount = null,
        defaultAudioRepeat = null;

  // -------------------------------------------------------------------------
  // Optional named constructor for custom initialization
  // -------------------------------------------------------------------------
  UniqueTestModel.create({
    this.name = 'Guest',
    this.languagePreference = Language.english,
    this.subscriptionTier = SubscriptionTier.free,
    this.reciterId = 1,
    this.goals = const [],
    this.reminderFrequency = const ReminderFrequency(),
    this.onboardingComplete = false,
    this.notificationFrequency = 'None',
    this.fontFamily = 'Amiri',
    this.fontWeight = 400,
    this.defaultDifficulty,
    this.defaultRepeatCount,
    this.defaultAudioRepeat,
  });

  /// Copy method for immutability patterns.
  UniqueTestModel copyWith({
    String? name,
    Language? languagePreference,
    SubscriptionTier? subscriptionTier,
    int? reciterId,
    List<Goal>? goals,
    ReminderFrequency? reminderFrequency,
    bool? onboardingComplete,
    String? notificationFrequency,
    String? fontFamily,
    int? fontWeight,
    DifficultyLevel? defaultDifficulty,
    int? defaultRepeatCount,
    int? defaultAudioRepeat,
  }) {
    return UniqueTestModel.create(
      name: name ?? this.name,
      languagePreference: languagePreference ?? this.languagePreference,
      subscriptionTier: subscriptionTier ?? this.subscriptionTier,
      reciterId: reciterId ?? this.reciterId,
      goals: goals ?? this.goals,
      reminderFrequency: reminderFrequency ?? this.reminderFrequency,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      notificationFrequency: notificationFrequency ?? this.notificationFrequency,
      fontFamily: fontFamily ?? this.fontFamily,
      fontWeight: fontWeight ?? this.fontWeight,
      defaultDifficulty: defaultDifficulty ?? this.defaultDifficulty,
      defaultRepeatCount: defaultRepeatCount ?? this.defaultRepeatCount,
      defaultAudioRepeat: defaultAudioRepeat ?? this.defaultAudioRepeat,
    );
  }
}

// -----------------------------------------------------------------------
// ENUMS
// -----------------------------------------------------------------------
@HiveType(typeId: 2)
enum Language {
  @HiveField(0)
  english,

  @HiveField(1)
  arabic,

  @HiveField(2)
  french,

  @HiveField(3)
  malaysian,

  @HiveField(4)
  indonesian,

  @HiveField(5)
  spanish,

  @HiveField(6)
  urdu,

  @HiveField(7)
  farsi,

  @HiveField(8)
  turkish,
}

@HiveType(typeId: 3)
enum SubscriptionTier {
  @HiveField(0)
  free,

  @HiveField(1)
  premium,

  @HiveField(2)
  premiumPlus,
}

/// The multi-goal enum (typeId 5). Each has a unique HiveField index.
@HiveType(typeId: 5)
enum Goal {
  @HiveField(0)
  connectQuran,

  @HiveField(1)
  memorizeQuran,

  @HiveField(2)
  buildConsistency,

  @HiveField(3)
  beMoreGrateful,

  @HiveField(4)
  improveArabic,

  @HiveField(5)
  deepenTafsir,

  @HiveField(6)
  other,
}

// -----------------------------------------------------------------------
// REMINDER FREQUENCY
// -----------------------------------------------------------------------
@HiveType(typeId: 6)
class ReminderFrequency {
  @HiveField(0)
  final bool isNone;

  @HiveField(1)
  final DateTime? onceDaily;

  @HiveField(2)
  final List<DateTime>? customTimes;

  const ReminderFrequency({
    this.isNone = true,
    this.onceDaily,
    this.customTimes,
  });

  const ReminderFrequency.none()
      : this(isNone: true, onceDaily: null, customTimes: null);

  const ReminderFrequency.onceDaily(DateTime time)
      : this(isNone: false, onceDaily: time, customTimes: null);

  const ReminderFrequency.custom(List<DateTime> times)
      : this(isNone: false, onceDaily: null, customTimes: times);

  ReminderFrequency copyWith({
    bool? isNone,
    DateTime? onceDaily,
    List<DateTime>? customTimes,
  }) {
    return ReminderFrequency(
      isNone: isNone ?? this.isNone,
      onceDaily: onceDaily ?? this.onceDaily,
      customTimes: customTimes ?? this.customTimes,
    );
  }

  @override
  String toString() {
    if (isNone) return 'ReminderFrequency.none()';
    if (onceDaily != null) return 'ReminderFrequency.onceDaily($onceDaily)';
    if (customTimes != null) return 'ReminderFrequency.custom($customTimes)';
    return 'ReminderFrequency.none()';
  }
}
