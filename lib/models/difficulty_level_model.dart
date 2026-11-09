import 'package:flutter/widgets.dart';
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';
import 'package:hive/hive.dart';

import '../providers/ff_logging_service_provider.dart';

part 'difficulty_level_model.g.dart';

/// Enum to represent the various difficulty levels available in the application.
@HiveType(typeId: 14) // Ensure this typeId does not collide with others
enum DifficultyLevel {
  /// New difficulty mode for single- and two-word multiple-choice logic.
  @HiveField(0)
  multipleChoice,

  @HiveField(1)
  beginner,

  @HiveField(2)
  learned,

  @HiveField(3)
  qari,
}

/// Extension on DifficultyLevel to provide additional properties/methods.
extension DifficultyLevelExtensions on DifficultyLevel {
  /// Returns a localized user-facing display name for each level.
  /// Example usage: `someLevel.displayName(context)`
  String displayName(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case DifficultyLevel.multipleChoice:
        return loc.levelMultipleChoiceLabel; // e.g. "Multiple Choice"
      case DifficultyLevel.beginner:
        return loc.levelBeginnerLabel;       // e.g. "Starter"
      case DifficultyLevel.learned:
        return loc.levelAdvancedLabel;       // e.g. "Advanced"
      case DifficultyLevel.qari:
        return loc.levelQariLabel;           // e.g. "Qari"
    }
  }

  /// Returns a localized descriptive text for each difficulty level.
  /// Example usage: `someLevel.description(context)`
  String description(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case DifficultyLevel.multipleChoice:
        return loc.levelMultipleChoiceDescription;
      case DifficultyLevel.beginner:
        return loc.levelBeginnerDescription;
      case DifficultyLevel.learned:
        return loc.levelAdvancedDescription;
      case DifficultyLevel.qari:
        return loc.levelQariDescription;
    }
  }

  /// Provides step logic specific to each difficulty level.
  int get stepRequirement {
    switch (this) {
      case DifficultyLevel.beginner:
        return 1;
      case DifficultyLevel.learned:
        return 1;
      case DifficultyLevel.qari:
        return 0;
      case DifficultyLevel.multipleChoice:
      // You can adjust this if needed;
      // for now, we return 1 like the single-word approach.
        return 1;
    }
  }

  /// Logs the details for the selected difficulty level using LoggingService.
  void logLevelDetails() {
    // Because there's no Riverpod ref here, we instantiate a fallback:
    final logger = LoggingService();
    logger.logInfo(
      '[DifficultyLevel] Selected level: $this with step requirement: $stepRequirement',
    );
  }

  /// Custom color coding for each difficulty level.
  String get colorCode {
    switch (this) {
      case DifficultyLevel.beginner:
        return '#4CAF50'; // Green
      case DifficultyLevel.learned:
        return '#FFC107'; // Amber
      case DifficultyLevel.qari:
        return '#F44336'; // Red
      case DifficultyLevel.multipleChoice:
        return '#2196F3'; // Blue
    }
  }

  /// Generates the appropriate removal sequence based on difficulty level.
  ///
  /// For [multipleChoice], we return an empty list because we generally do not
  /// remove words in the text UI (we only show multiple-choice options).
  List<int> getRemovalIndices(List<String> words) {
    switch (this) {
      case DifficultyLevel.beginner:
        return _generateLevelOneSequence(words.length)
            .expand((indices) => indices)
            .toList();
      case DifficultyLevel.learned:
      // One word at a time
        return List<int>.generate(words.length, (index) => index);
      case DifficultyLevel.qari:
      // Removes all words in the Ayah
        return List<int>.generate(words.length, (index) => index);
      case DifficultyLevel.multipleChoice:
      // Typically no removal in the text, so return []
        return [];
    }
  }

  /// Example: progressive group sequence for "beginner" logic.
  List<List<int>> _generateLevelOneSequence(int totalWords) {
    final sequence = <List<int>>[];

    for (int i = 0; i < totalWords; i++) {
      // remove one word at index i
      sequence.add([i]);

      // then remove 2..(i+1) words as a group, for a "progressive" pattern
      for (int j = 2; j <= i + 1; j++) {
        final indices = <int>[];
        for (int k = i; k >= i - j + 1 && k >= 0; k--) {
          indices.add(k);
        }
        sequence.add(List.from(indices));
      }
    }
    return sequence;
  }

  /// Provide an icon path if relevant
  String get icon {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'assets/icons/beginner.png';
      case DifficultyLevel.learned:
        return 'assets/icons/learned.png';
      case DifficultyLevel.qari:
        return 'assets/icons/qari.png';
      case DifficultyLevel.multipleChoice:
        return 'assets/icons/multiple_choice.png';
    }
  }
}
