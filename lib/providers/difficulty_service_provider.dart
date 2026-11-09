// lib/providers/difficulty_service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/difficulty_service.dart';
import '../models/difficulty_level_model.dart';
import '../providers/lesson_service_provider.dart'; // Ensure lessonService dependency
import '../providers/ff_logging_service_provider.dart';

// This line was originally referencing a global LoggingService.
// We'll keep it to avoid removals, but it's unused in the updated approach.
final loggingService = LoggingService();

/// Provides a [DifficultyService] that depends on [LessonService].
final difficultyServiceProvider = Provider<DifficultyService>((ref) {
  final lessonService = ref.read(lessonServiceProviderRef);
  return DifficultyService(lessonService); // Pass the LessonService as needed
});

/// A StateNotifier for user’s current [DifficultyLevel].
final difficultyProvider =
StateNotifierProvider<DifficultyNotifier, DifficultyLevel>((ref) {
  return DifficultyNotifier(ref);
});

class DifficultyNotifier extends StateNotifier<DifficultyLevel> {
  final DifficultyService _difficultyService;
  final Ref ref;

  DifficultyNotifier(this.ref)
      : _difficultyService = ref.read(difficultyServiceProvider),
        super(DifficultyLevel.beginner);

  /// Updates the difficulty level to [level].
  void setDifficulty(DifficultyLevel level) {
    // Now we log via ffLoggingServiceProvider
    ref.read(ffLoggingServiceProvider).logInfo('Setting difficulty to: $level');
    state = level;
  }

  /// Returns the removal indices for the current difficulty [state].
  /// This leverages _difficultyService.getRemovalIndices(...)
  List<int> getCurrentLevelIndices(List<String> words) {
    ref
        .read(ffLoggingServiceProvider)
        .logInfo('Fetching removal indices for current difficulty level: $state');

    // Example step usage or ayahCount if your logic needs them:
    int step = 0;
    int ayahCount = 1;

    // Use the difficulty service
    List<int> indices = _difficultyService.getRemovalIndices(
      state,       // current DifficultyLevel
      step,        // integer step
      words,       // list of words
      ayahCount,   // or a realistic ayah count
    );

    ref.read(ffLoggingServiceProvider).logInfo(
      state == DifficultyLevel.beginner
          ? "Beginner mode retrieved for $state"
          : state == DifficultyLevel.multipleChoice
          ? "Multiple-choice mode retrieved for $state"
          : "Indices retrieved for $state",
    );
    return indices;
  }

  /// Logs the current difficulty.
  void logCurrentDifficulty() {
    ref
        .read(ffLoggingServiceProvider)
        .logInfo('Current difficulty level: $state');
  }

  /// Resets the difficulty to [DifficultyLevel.beginner].
  void resetDifficulty() {
    ref
        .read(ffLoggingServiceProvider)
        .logInfo('Resetting difficulty to default (beginner)');
    state = DifficultyLevel.learned;
  }
}
