// lib/services/difficulty_service.dart

import '../models/difficulty_level_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/lesson_service.dart';
import '../providers/ff_logging_service_provider.dart';

final loggingService = LoggingService();

final difficultyServiceProvider = Provider<DifficultyService>((ref) {
  final lessonService = ref.read(lessonServiceProvider);
  return DifficultyService(lessonService);
});

class DifficultyService {
  final LessonService lessonService;

  DifficultyService(this.lessonService);

  // Main method to get removal indices based on the difficulty level and effective step index
  //
  // IMPORTANT FOR MULTIPLE CHOICE:
  //   Now we return an empty list here and let the lesson screen
  //   handle which word(s) to remove per question. That ensures
  //   the text blank matches the MC question’s correct word(s).
  //
  List<int> getRemovalIndices(
      DifficultyLevel level,
      int effectiveStepIndex,
      List<String> words,
      int ayahCount, {
        List<Map<String, dynamic>>? displayedVerses,
      }) {
    loggingService.logInfo(
      'Getting removal indices for $level at effective step $effectiveStepIndex',
    );

    switch (level) {
      case DifficultyLevel.beginner:
        return _generateBeginnerSequence(words.length)[effectiveStepIndex];

      case DifficultyLevel.learned:
        return _generateLearnedSequence(words.length, effectiveStepIndex);

      case DifficultyLevel.qari:
        if (displayedVerses == null) {
          loggingService.logError('displayedVerses is required for Qari level');
          return [];
        }
        return _generateQariSequence(displayedVerses, effectiveStepIndex);

      case DifficultyLevel.multipleChoice:
      // Instead of calling _generateMultipleChoiceIndices(...) here,
      // we simply return an empty list. We handle the removal in the lesson screen.
        return [];

      default:
        loggingService.logError('Unknown difficulty level: $level');
        throw UnimplementedError('Difficulty level not implemented');
    }
  }

  // ---------------------------------------------------------------------------
  // Beginner Level: Removes words cumulatively:
  // Step 0 => remove index [0]
  // Step 1 => remove indices [0,1]
  // Step 2 => remove indices [0,1,2], etc.
  // ---------------------------------------------------------------------------
  List<List<int>> _generateBeginnerSequence(int wordCount) {
    final sequence = <List<int>>[];
    for (int i = 0; i < wordCount; i++) {
      // Generate a list of indices [0..i]
      sequence.add(List<int>.generate(i + 1, (idx) => idx));
    }
    return sequence;
  }

  // Learned Level: Cumulatively removes two words at a time
  List<int> _generateLearnedSequence(int wordCount, int effectiveStepIndex) {
    // Remove words in pairs, keeping previous words removed
    int wordsToRemove = (effectiveStepIndex + 1) * 2;
    if (wordsToRemove > wordCount) {
      wordsToRemove = wordCount;
    }
    return List<int>.generate(wordsToRemove, (index) => index);
  }

  // Qari Level: Removes entire Ayah at each step, using displayedVerses
  // Each displayedVerse must have: 'startGlobalWordIndex' & 'endGlobalWordIndex'
  List<int> _generateQariSequence(
      List<Map<String, dynamic>> displayedVerses,
      int effectiveStepIndex,
      ) {
    List<int> indicesToRemove = [];

    // Remove Ayahs up to the current effective step index
    for (int i = 0; i <= effectiveStepIndex && i < displayedVerses.length; i++) {
      var verse = displayedVerses[i];

      // These must not be null or you get a type cast error
      int start = verse['startGlobalWordIndex'] as int;
      int end = verse['endGlobalWordIndex'] as int;

      // Now remove indices from start..end (inclusive)
      indicesToRemove.addAll(
        List<int>.generate(end - start + 1, (idx) => start + idx),
      );
    }

    return indicesToRemove;
  }

  // ---------------------------------------------------------------------------
  // Multiple Choice (LEGACY method, no longer called in getRemovalIndices):
  //  - First 'wordCount' steps remove single-word index i
  //  - Next '(wordCount - 1)' steps remove two adjacent indices
  //  - totalSteps = 2*wordCount - 1
  // ---------------------------------------------------------------------------
  List<int> _generateMultipleChoiceIndices(int wordCount, int stepIndex) {
    if (wordCount <= 0) {
      return [];
    }
    if (wordCount == 1) {
      // If there's only one word, stepIndex=0 => remove [0], else => nothing
      return (stepIndex == 0) ? [0] : [];
    }

    final singleWordSteps = wordCount;
    if (stepIndex < singleWordSteps) {
      // Remove that single word
      return [stepIndex];
    } else {
      // Remove pair
      final pairIndex = stepIndex - singleWordSteps;
      if (pairIndex >= 0 && pairIndex < (wordCount - 1)) {
        return [pairIndex, pairIndex + 1];
      }
      return [];
    }
  }

  // Method to calculate total steps per cycle (without repeats) based on difficulty level
  int getTotalStepsPerCycle(List<Map<String, dynamic>> verses, DifficultyLevel level) {
    int totalSteps;
    switch (level) {
      case DifficultyLevel.beginner:
        int totalWords = verses.fold<int>(0, (sum, verse) {
          final text = verse['text'] as String?;
          final wordCount = text?.split(' ').length ?? 0;
          return sum + wordCount;
        });
        totalSteps = totalWords;
        break;

      case DifficultyLevel.learned:
        final totalWords = verses.fold<int>(0, (sum, verse) {
          final text = verse['text'] as String?;
          final wordCount = text?.split(' ').length ?? 0;
          return sum + wordCount;
        });
        totalSteps = (totalWords / 2).ceil();
        break;

      case DifficultyLevel.qari:
        totalSteps = verses.length;
        break;

      case DifficultyLevel.multipleChoice:
      // Single words => totalWords
      // Adjacent pairs => totalWords - 1
        final totalWords = verses.fold<int>(0, (sum, verse) {
          final text = verse['text'] as String?;
          final wordCount = text?.split(' ').length ?? 0;
          return sum + wordCount;
        });
        if (totalWords <= 1) {
          totalSteps = totalWords; // 0 or 1
        } else {
          totalSteps = totalWords + (totalWords - 1); // e.g. 2N - 1
        }
        break;

      default:
        loggingService.logError('Unknown difficulty level: $level');
        throw UnimplementedError('Difficulty level not implemented');
    }
    return totalSteps;
  }
}
