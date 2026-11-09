import 'package:flutter/material.dart';
import '../providers/ff_logging_service_provider.dart';

// NEW import for ScoreService
import '../services/scoring_service.dart';

/// SimilarityService handles all similarity-based calculations,
/// such as Levenshtein distance, Jaccard similarity, and provides feedback colors.
///
/// New behavior:
///   - If the user typed ANY real harakat (excluding the automatically-inserted Shadda),
///     we compare with harakat.
///   - If the user typed no diacritics (or only Shadda), we remove them from both
///     userWord & correctWord.
///
/// Now also adds logic for awarding points based on similarity:
///   - Red => +2
///   - Yellow => +5
///   - Green => +10
///   The lesson screen can call [getPointsForSimilarity] or [getPointsLabel].
class SimilarityService {
  final LoggingService loggingService;

  SimilarityService({required this.loggingService});

  // ---------------------------------------------------------------------------
  // Main Similarity with Conditional Harakat Removal
  // ---------------------------------------------------------------------------
  /// Calculates similarity between userWord and correctWord using Levenshtein distance.
  ///  - If [userWord] contains any diacritical marks (excluding auto-inserted Shadda),
  ///    we leave both words as-is.
  ///  - If [userWord] has no diacritical marks, we remove them from both words
  ///    for a lenient match.
  ///  - Then convert both to lowercase.
  ///  - Then use Levenshtein distance => similarity ratio in [0..1].
  double calculateSimilarity(String userWord, String correctWord) {
    // ADDED LOG FOR DEBUG:
    loggingService.logInfo(
      '[SimilarityService] calculateSimilarity => userWord="$userWord", correctWord="$correctWord"',
    );

    // 1) Check if user typed any real harakat (excluding Shadda)
    final userHasHarakat = _containsHarakat(userWord);

    // 2) Preprocess with lowercase
    String processedUser = userWord.toLowerCase();
    String processedCorrect = correctWord.toLowerCase();

    // 3) If the user typed NO harakat => remove from both
    if (!userHasHarakat) {
      processedUser = removeTashkeel(processedUser);
      processedCorrect = removeTashkeel(processedCorrect);
    }

    // 4) If identical, return 1.0
    if (processedUser == processedCorrect) {
      // ADDED LOG FOR DEBUG:
      loggingService.logInfo(
        '[SimilarityService] Words identical after processing => similarity=1.0',
      );
      return 1.0;
    }

    final longerLength = processedCorrect.length;
    if (longerLength == 0) {
      // Edge case: correctWord is empty => similarity=1.0
      loggingService.logInfo(
        '[SimilarityService] Correct word is empty => similarity=1.0',
      );
      return 1.0;
    }

    // 5) Levenshtein distance => similarity ratio
    final distance = calculateLevenshteinDistance(processedUser, processedCorrect);
    final similarity = (longerLength - distance) / longerLength;

    // ADDED LOG FOR DEBUG:
    loggingService.logInfo(
      '[SimilarityService] Calculated similarity=$similarity (distance=$distance)',
    );
    return similarity;
  }

  // ---------------------------------------------------------------------------
  // NEW METHOD (added without removing/changing the existing code):
  // This helper calculates similarity AND logs the result in ScoreService,
  // awarding points for green/yellow/red automatically.
  // You can call this instead of plain calculateSimilarity() if you want to
  // automatically update the user’s daily points in Hive.
  // ---------------------------------------------------------------------------
  Future<double> calculateSimilarityAndLog({
    required String userWord,
    required String correctWord,
    required DateTime date,
    required int surahId,
    required int verseId,
    required ScoreService scoreService,
  }) async {
    // ADDED LOG FOR DEBUG:
    loggingService.logInfo(
      '[SimilarityService] calculateSimilarityAndLog => userWord="$userWord", correctWord="$correctWord", '
          'date="$date", surahId=$surahId, verseId=$verseId',
    );

    final sim = calculateSimilarity(userWord, correctWord);

    // Decide color category
    final String color;
    if (sim >= 0.9) {
      color = 'green';
    } else if (sim >= 0.5) {
      color = 'yellow';
    } else {
      color = 'red';
    }

    // Award points
    final points = getPointsForSimilarity(sim);

    // ADDED LOG FOR DEBUG:
    loggingService.logInfo(
      '[SimilarityService] color="$color", awarding points=$points; now calling ScoreService.logMistake...',
    );

    // Log the result to ScoreService
    try {
      await scoreService.logMistake(
        date: date,
        surahId: surahId,
        verseId: verseId,
        word: userWord,
        color: color,
        points: points,
      );
    } catch (e, st) {
      // ADDED LOG FOR DEBUG:
      loggingService.logError(
        '[SimilarityService] ERROR calling scoreService.logMistake => $e\n$st',
      );
    }

    // ADDED LOG FOR DEBUG:
    loggingService.logInfo(
      '[SimilarityService] calculateSimilarityAndLog => DONE logging. similarity=$sim',
    );

    return sim;
  }

  // ---------------------------------------------------------------------------
  // Diacritic & Text Utility
  // ---------------------------------------------------------------------------
  /// Returns true if [text] has at least one Arabic diacritical mark (harakat),
  /// EXCLUDING the Shadda (\u0651).
  bool _containsHarakat(String text) {
    // Typical Arabic diacritic ranges, but skipping \u0651 specifically.
    final RegExp harakatExcludingShadda = RegExp(
      r'[\u0617-\u061A\u064B-\u0650\u0652\u0657-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E8\u06EA-\u06ED]',
    );
    return harakatExcludingShadda.hasMatch(text);
  }

  /// Removes diacritical marks (tashkeel) from Arabic text to improve matching.
  /// This includes Shadda (\u0651) as well.
  String removeTashkeel(String text) {
    // ADDED LOG FOR DEBUG:
    loggingService.logInfo('[SimilarityService] removeTashkeel => input="$text"');
    final RegExp tashkeelRegex = RegExp(
      r'[\u0617-\u061A\u064B-\u0652\u0657-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E8\u06EA-\u06ED]',
    );
    final cleaned = text.replaceAll(tashkeelRegex, '');
    // ADDED LOG FOR DEBUG:
    loggingService.logInfo('[SimilarityService] removeTashkeel => cleaned="$cleaned"');
    return cleaned;
  }

  /// Preprocess text with optional diacritic removal/lowercase.
  String preprocessText(String text, {bool removeTashkeel = true, bool toLowerCase = true}) {
    // ADDED LOG FOR DEBUG:
    loggingService.logInfo(
      '[SimilarityService] preprocessText => removeTashkeel=$removeTashkeel, toLowerCase=$toLowerCase, text="$text"',
    );
    var result = text;
    if (toLowerCase) {
      result = result.toLowerCase();
    }
    if (removeTashkeel) {
      result = this.removeTashkeel(result);
    }
    // ADDED LOG FOR DEBUG:
    loggingService.logInfo(
      '[SimilarityService] preprocessText => result="$result"',
    );
    return result;
  }

  // ---------------------------------------------------------------------------
  // Levenshtein Distance
  // ---------------------------------------------------------------------------
  /// Minimum number of single-character edits (insert, delete, substitute)
  /// to transform [s] into [t].
  int calculateLevenshteinDistance(String s, String t) {
    // ADDED LOG FOR DEBUG:
    loggingService.logInfo(
      '[SimilarityService] calculateLevenshteinDistance => s="$s", t="$t"',
    );

    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    final m = s.length;
    final n = t.length;
    final dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));

    // Base init
    for (int i = 0; i <= m; i++) {
      dp[i][0] = i;
    }
    for (int j = 0; j <= n; j++) {
      dp[0][j] = j;
    }

    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        final cost = (s[i - 1] == t[j - 1]) ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1,       // deletion
          dp[i][j - 1] + 1,       // insertion
          dp[i - 1][j - 1] + cost // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    final distance = dp[m][n];
    // ADDED LOG FOR DEBUG:
    loggingService.logInfo(
      '[SimilarityService] calculateLevenshteinDistance => distance=$distance',
    );
    return distance;
  }

  // ---------------------------------------------------------------------------
  // Feedback Color
  // ---------------------------------------------------------------------------
  /// Return color for similarity: green if >=0.9, yellow if >=0.5, else red.
  Color getFeedbackColor(double similarity) {
    if (similarity >= 0.9) {
      return Colors.green;
    } else if (similarity >= 0.5) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  // ---------------------------------------------------------------------------
  // Point Awarding
  // ---------------------------------------------------------------------------
  /// Return the point value for this similarity:
  /// - green => +10
  /// - yellow => +5
  /// - red => +2
  int getPointsForSimilarity(double similarity) {
    if (similarity >= 0.9) {
      return 10;
    } else if (similarity >= 0.5) {
      return 5;
    } else {
      return 2;
    }
  }

  /// Return the label string "+10", "+5", or "+2" for display
  String getPointsLabel(double similarity) {
    final pts = getPointsForSimilarity(similarity);
    return '+$pts';
  }

  // ---------------------------------------------------------------------------
  // Jaccard-based or other advanced methods if you want them
  // ---------------------------------------------------------------------------
  /// Tokenizes a string into a set of "words" by splitting on whitespace.
  /// Optionally remove Tashkeel first.
  Set<String> tokenize(String sentence) {
    loggingService.logInfo('[SimilarityService] tokenize => sentence="$sentence"');
    final lower = sentence.toLowerCase();
    final noHarakat = removeTashkeel(lower);
    final tokens = noHarakat.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toSet();
    loggingService.logInfo('[SimilarityService] tokenize => tokens=$tokens');
    return tokens;
  }

  /// Jaccard Similarity => intersection/union of sets. Possibly for multi-word lines.
  double calculateJaccardSimilarity(Set<String> set1, Set<String> set2) {
    loggingService.logInfo(
      '[SimilarityService] calculateJaccardSimilarity => set1=$set1, set2=$set2',
    );
    final intersection = set1.intersection(set2);
    final union = set1.union(set2);
    final jaccard = intersection.length / union.length;
    loggingService.logInfo('[SimilarityService] Jaccard => $jaccard');
    return jaccard;
  }

  /// Adaptive similarity => e.g. apply threshold logic
  double adaptiveSimilarity(String userWord, String correctWord, {double threshold = 0.8}) {
    loggingService.logInfo(
      '[SimilarityService] adaptiveSimilarity => userWord="$userWord", correctWord="$correctWord", threshold=$threshold',
    );
    final sim = calculateSimilarity(userWord, correctWord);
    if (sim >= threshold) {
      loggingService.logInfo('[SimilarityService] Similarity $sim >= $threshold => pass');
    } else {
      loggingService.logWarning('[SimilarityService] Similarity $sim < $threshold => fail');
    }
    return sim;
  }
}
