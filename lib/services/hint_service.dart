// lib/services/hint_service.dart

import 'package:logger/logger.dart';
import '../providers/ff_logging_service_provider.dart';

/// A service that provides "hints" for removed words in a memorization exercise.
class HintService {
  // If you still want the `logger` from the `logger` package, keep this:
  final Logger debugLogger = Logger();

  // If you want your own LoggingService fallback:
  final LoggingService loggingService = LoggingService();

  // Maximum hint level
  final int maxHintLevel;

  HintService({this.maxHintLevel = 3});

  /// Provide a hint for [word] based on the [hintLevel].
  /// For example, show the first N letters.
  String getHint(String word, int hintLevel) {
    if (hintLevel <= 0 || hintLevel > maxHintLevel) {
      // No hint => return the full word
      return word;
    }

    // For a basic example, if hintLevel=1 => show first 2 letters
    // if hintLevel=2 => show first 5 letters, etc.
    int hintLetters = hintLevel == 1 ? 2 : 5;
    if (hintLetters > word.length) hintLetters = word.length;

    final partial = word.substring(0, hintLetters);
    final displayed = '$partial...';

    // We log via our fallback loggingService:
    loggingService.logInfo(
      '[HintService] getHint() => hintLevel=$hintLevel, word="$word", displayed="$displayed"',
    );

    return displayed;
  }

  /// Resets hint level to zero. Possibly call this each time the user proceeds or restarts.
  int resetHintLevel() {
    debugLogger.d('[HintService] resetHintLevel() called => returning 0');
    return 0;
  }

  /// Increments the hint level by one, up to [maxHintLevel].
  int incrementHintLevel(int currentHintLevel) {
    final newLevel = currentHintLevel < maxHintLevel
        ? currentHintLevel + 1
        : maxHintLevel;

    loggingService.logWarning(
      '[HintService] incrementHintLevel() => from $currentHintLevel to $newLevel',
    );
    return newLevel;
  }

  /// Removes the current hint by resetting to 0
  int removeHint(int currentHintLevel) {
    final reset = resetHintLevel();
    debugLogger.d('[HintService] removeHint() => old=$currentHintLevel, new=$reset');
    return reset;
  }
}
