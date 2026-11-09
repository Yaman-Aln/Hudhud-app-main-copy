import 'dart:math';

/// A service that provides multiple-choice "distractors"
/// for either Arabic or transliteration text.
///
/// With Approach B, this class does NOT handle JSON parsing.
/// You do that in your main.dart (or anywhere else),
/// and simply pass the resulting single-word and two-word lists
/// via [loadBothData(...)].
class QuranDistractorService {
  // ---------------------------------------------------------------------------
  // (A) Separate lists for Arabic vs. transliteration
  // ---------------------------------------------------------------------------
  late List<String> _allSingleWordsAr;
  late List<String> _allTwoWordPairsAr;
  late List<String> _allSingleWordsTranslit;
  late List<String> _allTwoWordPairsTranslit;

  final Random _random = Random();

  /// Default constructor
  QuranDistractorService();

  // ---------------------------------------------------------------------------
  // (B) loadBothData(...)
  //
  // You parse JSON in main.dart (or some other file) and produce:
  //   singleWordsAr, twoWordPairsAr, singleWordsTranslit, twoWordPairsTranslit
  // Then call:
  //   distractorService.loadBothData(...).
  // This method just stores them internally for later use.
  // ---------------------------------------------------------------------------
  void loadBothData({
    required List<String> singleWordsAr,
    required List<String> twoWordPairsAr,
    required List<String> singleWordsTranslit,
    required List<String> twoWordPairsTranslit,
  }) {
    _allSingleWordsAr = singleWordsAr;
    _allTwoWordPairsAr = twoWordPairsAr;
    _allSingleWordsTranslit = singleWordsTranslit;
    _allTwoWordPairsTranslit = twoWordPairsTranslit;
  }

  // ---------------------------------------------------------------------------
  // (C) getSingleWordDistractors
  //
  // Return [count] distractors for a single [correctWord].
  // If [useTranslit] is true, pick from transliteration lists;
  // otherwise pick from Arabic lists. Excludes exact [correctWord],
  // ensures each distractor is unique, and if you run out, falls back to X/Y/Z.
  // ---------------------------------------------------------------------------
  List<String> getSingleWordDistractors(
      String correctWord,
      int count, {
        bool useTranslit = false,
      }) {
    // 1) Pick the correct list
    final sourceList = useTranslit
        ? _allSingleWordsTranslit
        : _allSingleWordsAr;
    final distractors = <String>[];

    // 2) Keep picking until we have [count] or run out
    while (distractors.length < count) {
      if (sourceList.isEmpty) break; // Guard if no data at all

      final candidate = sourceList[_random.nextInt(sourceList.length)];
      if (candidate != correctWord && !distractors.contains(candidate)) {
        distractors.add(candidate);
      }
    }

    // 3) Fallback placeholders (X/Y/Z) if needed
    if (distractors.length < count) {
      final needed = count - distractors.length;
      distractors.addAll(['X', 'Y', 'Z'].take(needed));
    }

    return distractors;
  }

  // ---------------------------------------------------------------------------
  // (D) getTwoWordDistractors
  //
  // Same logic as above, but now we pick from the pairs lists.
  // Excludes [correctPair], ensures uniqueness, fallback placeholders if short.
  // ---------------------------------------------------------------------------
  List<String> getTwoWordDistractors(
      String correctPair,
      int count, {
        bool useTranslit = false,
      }) {
    final sourceList = useTranslit
        ? _allTwoWordPairsTranslit
        : _allTwoWordPairsAr;
    final distractors = <String>[];

    while (distractors.length < count) {
      if (sourceList.isEmpty) break;

      final candidate = sourceList[_random.nextInt(sourceList.length)];
      if (candidate != correctPair && !distractors.contains(candidate)) {
        distractors.add(candidate);
      }
    }

    if (distractors.length < count) {
      final needed = count - distractors.length;
      distractors.addAll(['X', 'Y', 'Z'].take(needed));
    }

    return distractors;
  }
}
