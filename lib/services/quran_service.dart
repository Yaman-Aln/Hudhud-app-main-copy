import 'package:flutter/services.dart' show rootBundle; // [ADDED FOR TRANSLITERATION]
import 'dart:convert';                                  // [ADDED FOR TRANSLITERATION]
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran/quran.dart' show Translation;

import '../models/lesson_model.dart';
import '../models/path_model.dart';
import 'package:hudhud_quran_app_new/z_onboarding/models/unique_test_model.dart';
import 'package:hudhud_quran_app_new/z_onboarding/providers/user_profile_provider.dart';
import '../providers/ff_logging_service_provider.dart';

/// Fallback logger if needed (though we mainly use ffLoggingServiceProvider).
final loggingService = LoggingService();

/// A Riverpod provider for QuranService, injecting [Ref] so we can read userProfile.
final quranServiceProvider = Provider<QuranService>((ref) {
  return QuranService(ref);
});

/// Model for Surah info, used by getAllSurahs() to return a complete list of surahs.
class SurahInfo {
  final int surahId;
  final String nameArabic;
  final String nameEnglish;

  SurahInfo({
    required this.surahId,
    required this.nameArabic,
    required this.nameEnglish,
  });
}

class QuranService {
  final Ref _ref;

  // [ADDED FOR TRANSLITERATION] Holds all transliterated text from a JSON file.
  // Keyed by "surah:verse", e.g. "1:1" => "Bismillah..."
  final Map<String, String> _translitMap = {};

  QuranService(this._ref);

  // ---------------------------------------------------------------------------
  // (NEW) Return a list of all 114 Surahs with both Arabic & English names.
  // This can be used for autocomplete or other surah listing features.
  // ---------------------------------------------------------------------------
  List<SurahInfo> getAllSurahs() {
    final surahs = <SurahInfo>[];
    for (int i = 1; i <= 114; i++) {
      final arabic = getSurahNameArabic(i);
      final english = getSurahNameEnglish(i);
      surahs.add(SurahInfo(
        surahId: i,
        nameArabic: arabic,
        nameEnglish: english,
      ));
    }
    return surahs;
  }

  // ---------------------------------------------------------------------------
  // [ADDED FOR TRANSLITERATION]
  // Call this once (e.g. at app startup) to load the transliteration JSON.
  // We assume you placed "transliteration.json" in assets and declared it in pubspec.
  // ---------------------------------------------------------------------------
  Future<void> loadTransliterationJson() async {
    if (_translitMap.isNotEmpty) {
      loggingService.logWarning(
        '[quran_service.dart] transliteration JSON already loaded; skipping',
      );
      return;
    }
    try {
      loggingService.logWarning('[quran_service.dart] loading transliteration JSON...');

      // 1) Read the entire file
      final jsonString = await rootBundle.loadString('assets/quran/transliteration.json');

      // 2) Your file is a top-level Map with keys like "1:1", "1:2", etc.
      //    Each value is { "t": "Bismi Allahi arrahmani arraheem" }.
      final Map<String, dynamic> rawMap = jsonDecode(jsonString);

      int totalRecords = 0;

      // 3) Iterate through each entry
      rawMap.forEach((key, value) {
        // key is something like "1:1", value is { "t": "..." }
        if (value is Map<String, dynamic>) {
          final text = value['t'];
          if (text != null) {
            // Store into _translitMap
            _translitMap[key] = text;
            totalRecords++;
          }
        }
      });

      loggingService.logWarning(
        '[quran_service.dart] loaded transliteration for $totalRecords ayahs',
      );
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] error loading transliteration JSON => $e',
      );
      // Decide how to handle: throw or just log
    }
  }

  // ---------------------------------------------------------------------------
  // [ADDED FOR TRANSLITERATION]
  // Returns the transliterated text, or null if not found/loaded.
  // ---------------------------------------------------------------------------
  String? getTransliteration(int surah, int ayah) {
    final key = '$surah:$ayah';
    final translit = _translitMap[key];
    loggingService.logWarning('[quran_service.dart] getTransliteration($surah, $ayah) => $translit');
    return translit;
  }

  // ---------------------------------------------------------------------------
  // [ADDED FOR TRANSLITERATION]
  // Convenience method to get Arabic text from quran.getVerse(...)
  // ---------------------------------------------------------------------------
  String getVerse(int surahNumber, int verseNumber, {bool verseEndSymbol = false}) {
    try {
      final text = quran.getVerse(
        surahNumber,
        verseNumber,
        verseEndSymbol: verseEndSymbol,
      );
      loggingService.logWarning(
        '[quran_service.dart] getVerse($surahNumber, $verseNumber, endSymbol=$verseEndSymbol) => "$text"',
      );
      return text;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getVerse($surahNumber, $verseNumber) => error: $e',
      );
      return '';
    }
  }

  // ---------------------------------------------------------------------------
  // Surah Name Methods (Built-in for Arabic / English / French / Turkish)
  // ---------------------------------------------------------------------------
  /// Returns the surah name in ARABIC
  String getSurahNameArabic(int surahNumber) {
    try {
      final name = quran.getSurahNameArabic(surahNumber);
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameArabic($surahNumber) => "$name"',
      );
      return name;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameArabic($surahNumber) => error: $e',
      );
      return 'Unknown Surah';
    }
  }

  /// Returns the surah name in ENGLISH
  String getSurahNameEnglish(int surahNumber) {
    try {
      final name = quran.getSurahNameEnglish(surahNumber);
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameEnglish($surahNumber) => "$name"',
      );
      return name;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameEnglish($surahNumber) => error: $e',
      );
      return 'Unknown Surah';
    }
  }

  /// Returns the surah name in TURKISH
  String getSurahNameTurkish(int surahNumber) {
    try {
      final name = quran.getSurahNameTurkish(surahNumber);
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameTurkish($surahNumber) => "$name"',
      );
      return name;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameTurkish($surahNumber) => error: $e',
      );
      return 'Unknown Surah';
    }
  }

  /// Returns the surah name in FRENCH
  String getSurahNameFrench(int surahNumber) {
    try {
      final name = quran.getSurahNameFrench(surahNumber);
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameFrench($surahNumber) => "$name"',
      );
      return name;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameFrench($surahNumber) => error: $e',
      );
      return 'Unknown Surah';
    }
  }

  /// Fallback returns "default" library name (English transliteration).
  String getSurahNameDefault(int surahNumber) {
    try {
      final name = quran.getSurahName(surahNumber);
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameDefault($surahNumber) => "$name"',
      );
      return name;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getSurahNameDefault($surahNumber) => error: $e',
      );
      return 'Unknown Surah';
    }
  }

  /// Decide surah name based on user’s selected language.
  /// Fallback strategy:
  /// - Farsi => Arabic surah name
  /// - Spanish => English surah name
  /// - Indonesian & Malaysian => English surah name
  /// - Everything else => normal logic or fallback to default
  String getSurahNamePreferred(int surahNumber) {
    final userProfile = _ref.read(userProfileProvider);
    final lang = userProfile.languagePreference;

    switch (lang) {
      case Language.arabic:
        return getSurahNameArabic(surahNumber);
      case Language.english:
        return getSurahNameEnglish(surahNumber);
      case Language.french:
        return getSurahNameFrench(surahNumber);
      case Language.turkish:
        return getSurahNameTurkish(surahNumber);

      case Language.farsi:
      // Fallback to Arabic
        return getSurahNameArabic(surahNumber);

      case Language.spanish:
      // Fallback to English
        return getSurahNameEnglish(surahNumber);

      case Language.indonesian:
      case Language.malaysian:
      // Both fallback to English
        return getSurahNameEnglish(surahNumber);

      case Language.urdu:
      // If the library doesn't have a method, fallback or custom logic
        return getSurahNameEnglish(surahNumber);

      default:
      // e.g. no direct method => fallback to the default transliteration
        return getSurahNameDefault(surahNumber);
    }
  }

  /// Legacy method used by older code: getSurahName( surahId, isArabic: false )
  /// If isArabic => returns Arabic name, else => English.
  String getSurahName(int surahNumber, {bool isArabic = false}) {
    if (isArabic) {
      return getSurahNameArabic(surahNumber);
    } else {
      return getSurahNameEnglish(surahNumber);
    }
  }

  // ---------------------------------------------------------------------------
  // Place of Revelation (Makkah / Madinah)
  // ---------------------------------------------------------------------------
  String getPlaceOfRevelation(int surahNumber) {
    try {
      final place = quran.getPlaceOfRevelation(surahNumber);
      loggingService.logWarning(
        '[quran_service.dart] getPlaceOfRevelation($surahNumber) => "$place"',
      );
      return place;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getPlaceOfRevelation($surahNumber) => error: $e',
      );
      return 'Unknown';
    }
  }

  // ---------------------------------------------------------------------------
  // Verse Count
  // ---------------------------------------------------------------------------
  int getVerseCount(int surahNumber) {
    try {
      final count = quran.getVerseCount(surahNumber);
      loggingService.logWarning(
        '[quran_service.dart] getVerseCount($surahNumber) => $count',
      );
      return count;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getVerseCount($surahNumber) => error: $e',
      );
      return 0;
    }
  }

  // ---------------------------------------------------------------------------
  // getArabicVerse(...) just in case you want a dedicated function
  // ---------------------------------------------------------------------------
  /// Returns Arabic text of [surahNumber, verseNumber], optionally with the verse-end symbol.
  String getArabicVerse(
      int surahNumber,
      int verseNumber, {
        bool verseEndSymbol = false,
      }) {
    try {
      final text = quran.getVerse(
        surahNumber,
        verseNumber,
        verseEndSymbol: verseEndSymbol,
      );
      loggingService.logWarning(
        '[quran_service.dart] getArabicVerse($surahNumber, $verseNumber, endSymbol=$verseEndSymbol) => "$text"',
      );
      return text;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getArabicVerse($surahNumber, $verseNumber) => error: $e',
      );
      return '';
    }
  }

  // ---------------------------------------------------------------------------
  // getVerseEndSymbol(...), isSajdahVerse(...), etc.
  // ---------------------------------------------------------------------------
  String getArabicVerseEndSymbol(int verseNumber, {bool arabicNumeral = false}) {
    try {
      final symbol = quran.getVerseEndSymbol(
        verseNumber,
        arabicNumeral: arabicNumeral,
      );
      loggingService.logWarning(
        '[quran_service.dart] getArabicVerseEndSymbol($verseNumber, arabicNumeral=$arabicNumeral) => "$symbol"',
      );
      return symbol;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getArabicVerseEndSymbol($verseNumber) => error: $e',
      );
      return '';
    }
  }

  bool isSajdahVerse(int surahNumber, int verseNumber) {
    try {
      final sajdah = quran.isSajdahVerse(surahNumber, verseNumber);
      loggingService.logWarning(
        '[quran_service.dart] isSajdahVerse($surahNumber, $verseNumber) => $sajdah',
      );
      return sajdah;
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] isSajdahVerse($surahNumber, $verseNumber) => error: $e',
      );
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // getVerseTranslation(...) with user-chosen language fallback
  // ---------------------------------------------------------------------------
  String getVerseTranslationPreferred(int surahNumber, int verseNumber) {
    final translationEnum = _mapToTranslationForVerses();
    try {
      final rawText = quran.getVerseTranslation(
        surahNumber,
        verseNumber,
        translation: translationEnum,
      );
      return _cleanTranslation(rawText);
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] getVerseTranslationPreferred($surahNumber, $verseNumber) => error: $e => fallback=English',
      );
      try {
        final fallbackRaw = quran.getVerseTranslation(
          surahNumber,
          verseNumber,
          translation: Translation.enClearQuran,
        );
        return _cleanTranslation(fallbackRaw);
      } catch (fallbackErr) {
        loggingService.logWarning(
          '[quran_service.dart] fallback also failed => $fallbackErr',
        );
        return '';
      }
    }
  }

  /// Decide which `Translation` to use for verses (the actual Quran text).
  Translation _mapToTranslationForVerses() {
    final userProfile = _ref.read(userProfileProvider);
    switch (userProfile.languagePreference) {
      case Language.arabic:
      // No direct Arabic translation => fallback to English
        return Translation.enClearQuran;
      case Language.english:
        return Translation.enClearQuran;
      case Language.turkish:
        return Translation.trSaheeh;
      case Language.french:
        return Translation.frHamidullah;
      case Language.farsi:
        return Translation.faHusseinDari;
      case Language.spanish:
        return Translation.spanish;
      case Language.urdu:
        return Translation.urdu;
      case Language.malaysian:
        return Translation.mlAbdulHameed;
      case Language.indonesian:
        return Translation.indonesian;
      default:
        return Translation.enClearQuran;
    }
  }

  // ---------------------------------------------------------------------------
  // "Original" methods for chunking by words & counting words (Needed by lesson_service)
  // ---------------------------------------------------------------------------
  /// Retrieves verses in a specified range as a list of { 'id','text','ayahEnd' }.
  /// The text is Arabic by default.
  List<Map<String, dynamic>> getVersesInRange(
      int surahId,
      int startAyah,
      int endAyah,
      ) {
    loggingService.logWarning(
      '[quran_service.dart] getVersesInRange() -> surahId=$surahId, startAyah=$startAyah, endAyah=$endAyah',
    );

    final verses = <Map<String, dynamic>>[];
    final verseCount = getVerseCount(surahId);

    for (int i = startAyah; i <= endAyah && i <= verseCount; i++) {
      final verseText = quran.getVerse(surahId, i);
      final ayahEnd = quran.getVerseEndSymbol(i);

      verses.add({
        'id': i,
        'text': verseText.trim(),
        'ayahEnd': ayahEnd,
      });
    }
    loggingService.logWarning(
      '[quran_service.dart] getVersesInRange() -> Retrieved ${verses.length} verses',
    );
    return verses;
  }

  /// Retrieves up to [maxWords] worth of verses, starting from [startAyah].
  /// Summation of word counts across consecutive ayahs in Arabic text.
  List<Map<String, dynamic>> getVersesWithMaxWords(
      int surahId,
      int startAyah,
      int maxWords,
      ) {
    loggingService.logWarning(
      '[quran_service.dart] getVersesWithMaxWords() -> surahId=$surahId, startAyah=$startAyah, maxWords=$maxWords',
    );

    final selectedVerses = <Map<String, dynamic>>[];
    int totalWords = 0;

    final verseCount = getVerseCount(surahId);
    for (int i = startAyah; i <= verseCount; i++) {
      final verseText = quran.getVerse(surahId, i);
      final ayahEnd = quran.getVerseEndSymbol(i);

      final words = verseText.split(' ').where((w) => w.trim().isNotEmpty).toList();
      final wordCount = words.length;

      loggingService.logWarning(
        '[getVersesWithMaxWords] Ayah $i wordCount: $wordCount',
      );

      if (totalWords + wordCount <= maxWords) {
        selectedVerses.add({
          'id': i,
          'text': '$verseText $ayahEnd',
        });
        totalWords += wordCount;
        loggingService.logWarning(
          '[getVersesWithMaxWords] Added Ayah $i, totalWords so far: $totalWords',
        );
      } else if (selectedVerses.isEmpty) {
        // Add at least one verse even if it alone exceeds maxWords
        selectedVerses.add({
          'id': i,
          'text': '$verseText $ayahEnd',
        });
        totalWords += wordCount;
        loggingService.logWarning(
          '[getVersesWithMaxWords] Added first Ayah $i despite exceeding maxWords: $totalWords',
        );
        break;
      } else {
        loggingService.logWarning(
          '[getVersesWithMaxWords] Stopped at Ayah $i, totalWords=$totalWords, wordCount=$wordCount',
        );
        break;
      }
    }

    loggingService.logWarning(
      '[quran_service.dart] getVersesWithMaxWords() -> Selected Ayahs: '
          '${selectedVerses.map((v) => v["id"]).toList()} totalWords=$totalWords',
    );
    return selectedVerses;
  }

  /// Returns total words in [startAyah..endAyah] for surah [surahId].
  /// Summation of Arabic word counts from each verse's text.
  int getTotalWords(int surahId, int startAyah, int endAyah) {
    loggingService.logWarning(
      '[quran_service.dart] getTotalWords() -> surahId=$surahId, startAyah=$startAyah, endAyah=$endAyah',
    );

    int totalWords = 0;
    final verses = getVersesInRange(surahId, startAyah, endAyah);
    for (final verse in verses) {
      final verseText = verse['text'] as String;
      final words = verseText.split(' ').where((w) => w.trim().isNotEmpty).toList();
      totalWords += words.length;
    }

    loggingService.logWarning(
      '[quran_service.dart] getTotalWords() -> totalWords=$totalWords',
    );
    return totalWords;
  }

  // ---------------------------------------------------------------------------
  // getTranslationsInRange(...)
  // ---------------------------------------------------------------------------
  /// Returns a list of { 'id','text' } for the specified surah range, using
  /// the user-chosen translation or fallback English if not found.
  Future<List<Map<String, dynamic>>> getTranslationsInRange(
      int surahId,
      int startAyah,
      int endAyah,
      ) async {
    loggingService.logWarning(
      '[quran_service.dart] getTranslationsInRange($surahId, $startAyah..$endAyah)',
    );

    final translationEnum = _mapToTranslationForVerses();
    final results = <Map<String, dynamic>>[];

    final verseCount = getVerseCount(surahId);
    for (int i = startAyah; i <= endAyah && i <= verseCount; i++) {
      String text;
      try {
        final raw = quran.getVerseTranslation(
          surahId,
          i,
          translation: translationEnum,
        );
        text = _cleanTranslation(raw);
      } catch (e) {
        loggingService.logWarning(
          '[quran_service.dart] getTranslationsInRange => fallback enClearQuran => $e',
        );
        try {
          final fallbackRaw = quran.getVerseTranslation(
            surahId,
            i,
            translation: Translation.enClearQuran,
          );
          text = _cleanTranslation(fallbackRaw);
        } catch (err2) {
          text = '';
        }
      }
      results.add({
        'id': i,
        'text': text,
      });
    }

    loggingService.logWarning(
      '[quran_service.dart] getTranslationsInRange() => retrieved ${results.length} translations',
    );
    return results;
  }

  // ---------------------------------------------------------------------------
  // getVersesWithTranslations(...)
  // ---------------------------------------------------------------------------
  /// A side-by-side approach returning list of { 'id','text','ayahEnd','translation' }
  /// if you want the Arabic text AND the translation in one pass.
  Future<List<Map<String, dynamic>>> getVersesWithTranslations(
      int surahId,
      int startAyah,
      int endAyah,
      ) async {
    loggingService.logWarning(
      '[quran_service.dart] getVersesWithTranslations() -> surah=$surahId, start=$startAyah..$endAyah',
    );

    final translationEnum = _mapToTranslationForVerses();
    final combined = <Map<String, dynamic>>[];

    final verseCount = getVerseCount(surahId);
    for (int i = startAyah; i <= endAyah && i <= verseCount; i++) {
      final arabicText = quran.getVerse(surahId, i);
      final ayahEnd = quran.getVerseEndSymbol(i);

      String trans;
      try {
        final raw = quran.getVerseTranslation(
          surahId,
          i,
          translation: translationEnum,
        );
        trans = _cleanTranslation(raw);
      } catch (e) {
        loggingService.logWarning(
          '[quran_service.dart] getVersesWithTranslations => fallback enClearQuran => $e',
        );
        try {
          final fallbackRaw = quran.getVerseTranslation(
            surahId,
            i,
            translation: Translation.enClearQuran,
          );
          trans = _cleanTranslation(fallbackRaw);
        } catch (err2) {
          trans = '';
        }
      }

      combined.add({
        'id': i,
        'text': arabicText,
        'ayahEnd': ayahEnd,
        'translation': trans,
      });
    }

    loggingService.logWarning(
      '[quran_service.dart] getVersesWithTranslations() => retrieved ${combined.length} items',
    );
    return combined;
  }

  // ---------------------------------------------------------------------------
  // Random Verse
  // ---------------------------------------------------------------------------
  Map<String, dynamic> getRandomVerse() {
    final randomVerse = quran.RandomVerse();
    return {
      'surahNumber': randomVerse.surahNumber,
      'verseNumber': randomVerse.verseNumber,
      'verseArabic': randomVerse.verse,
      'verseTranslation': _getRandomVerseTranslation(randomVerse),
    };
  }

  String _getRandomVerseTranslation(quran.RandomVerse randomVerse) {
    final translationEnum = _mapToTranslationForVerses();
    try {
      final raw = quran.getVerseTranslation(
        randomVerse.surahNumber,
        randomVerse.verseNumber,
        translation: translationEnum,
      );
      return _cleanTranslation(raw);
    } catch (e) {
      loggingService.logWarning(
        '[quran_service.dart] randomVerse => fallback enClearQuran => $e',
      );
      try {
        final fallbackRaw = quran.getVerseTranslation(
          randomVerse.surahNumber,
          randomVerse.verseNumber,
          translation: Translation.enClearQuran,
        );
        return _cleanTranslation(fallbackRaw);
      } catch (err2) {
        return '';
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Private Helper: Clean up bracketed text + capitalization
  // ---------------------------------------------------------------------------
  /// Removes bracket characters `[ ]` from the translation, or you can remove
  /// entire bracketed segments if you prefer. Then it capitalizes the first letter
  /// if it's in the Latin alphabet (A–Z).
  String _cleanTranslation(String raw) {
    if (raw.isEmpty) return raw;

    // Option A: remove entire bracketed phrases:
    // raw = raw.replaceAll(RegExp(r'\[.*?\]'), '');

    // Option B: remove just bracket characters but keep what's inside:
    raw = raw.replaceAll('[', '').replaceAll(']', '');

    // Trim leftover spacing
    raw = raw.trim();

    // If first char is a letter (English a-z), capitalize it
    if (raw.isNotEmpty && RegExp(r'[a-zA-Z]').hasMatch(raw[0])) {
      raw = raw[0].toUpperCase() + raw.substring(1);
    }

    return raw;
  }
}
