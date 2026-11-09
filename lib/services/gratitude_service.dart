import 'package:hive/hive.dart';
import 'dart:developer'; // for log(...)
import '../providers/ff_logging_service_provider.dart';

// <-- NEW import for ScoreService -->
import '../services/scoring_service.dart';
import 'package:intl/intl.dart';

/// Because this is a static class, we cannot read from ffLoggingServiceProvider
/// directly via ref. Instead, we define a global fallback:
final loggingService = LoggingService();

/// A static class for storing/fetching gratitude entries from a Hive box.
class GratitudeService {
  static const String _gratitudeBox = 'gratitudeLog'; // Hive box name

  /// Adds gratitude entries for the specified date.
  /// Appends new entries without any limit and prevents duplicates.
  static Future<void> addGratitudeEntries(String date, List<String> newEntries) async {
    // ADDED LOG:
    loggingService.logWarning('[GratitudeService] addGratitudeEntries called => date=$date, newEntries=$newEntries');

    final box = await Hive.openBox(_gratitudeBox);

    // Fetch existing entries for the date
    final existingEntry = box.get(date);
    final currentEntries = existingEntry != null
        ? List<String>.from(existingEntry)
        : <String>[];

    // Filter out duplicates
    final uniqueNewEntries = newEntries.where((entry) => !currentEntries.contains(entry)).toList();
    if (uniqueNewEntries.isEmpty) {
      loggingService.logWarning('[GratitudeService] No unique entries to add for $date.');
      return;
    }

    // Append
    currentEntries.addAll(uniqueNewEntries);

    // Save back to Hive
    await box.put(date, currentEntries);

    loggingService.logWarning(
      '[GratitudeService] Added entries for $date: $uniqueNewEntries. '
          'Total entries: ${currentEntries.length}',
    );

    // ---------------------------------------------------------------------
    // NEW: Award points for each new gratitude via ScoreService
    // We assume `date` is in "YYYY-MM-DD" or an ISO format parseable by DateTime.
    // If your format is guaranteed to be "YYYY-MM-DD", you can parse it manually or
    // rely on DateTime.parse(date).
    // ---------------------------------------------------------------------
    try {
      final parsedDate = _parseDateOrToday(date);
      final scoreService = ScoreService();

      // Each new entry => +10 points
      // So we pass the uniqueNewEntries
      await scoreService.logGratitudes(
        date: parsedDate,
        newEntries: uniqueNewEntries,
      );
      loggingService.logInfo(
        '[GratitudeService] Awarded +10 each for ${uniqueNewEntries.length} new gratitudes on $date',
      );
    } catch (e) {
      loggingService.logWarning(
        '[GratitudeService] Unable to parse date "$date" for ScoreService => $e',
      );
    }
  }

  /// Retrieves gratitude entries for a given date.
  static Future<List<String>?> getEntriesForDate(String date) async {
    // ADDED LOG:
    loggingService.logWarning('[GratitudeService] getEntriesForDate => date=$date');

    final box = await Hive.openBox(_gratitudeBox);
    final entry = box.get(date);
    if (entry != null) {
      return List<String>.from(entry);
    }
    return null;
  }

  /// Retrieves all gratitude entries, grouped by date (string => list of strings).
  static Future<Map<String, List<String>>> getAllGratitudeEntries() async {
    // ADDED LOG:
    loggingService.logWarning('[GratitudeService] getAllGratitudeEntries called');

    final box = await Hive.openBox(_gratitudeBox);
    final Map<String, List<String>> entries = {};

    for (final key in box.keys) {
      final entry = box.get(key);
      loggingService.logWarning('Key: $key, Entry: $entry, Type: ${entry.runtimeType}');
      if (entry != null && entry is List<dynamic>) {
        entries[key as String] = List<String>.from(entry);
      } else {
        loggingService.logWarning(
          '[GratitudeService] Invalid entry type for key $key: ${entry.runtimeType}',
        );
      }
    }

    return entries;
  }

  /// Returns how many distinct days have gratitude data.
  static Future<int> getTotalGratitudeDays() async {
    // ADDED LOG:
    loggingService.logWarning('[GratitudeService] getTotalGratitudeDays called');

    final box = await Hive.openBox(_gratitudeBox);
    return box.keys.length;
  }

  /// Clears all gratitude data.
  static Future<void> clearAllData() async {
    // ADDED LOG:
    loggingService.logWarning('[GratitudeService] clearAllData called');

    final box = await Hive.openBox(_gratitudeBox);
    await box.clear();
    loggingService.logWarning('[GratitudeService] Cleared all gratitude entries.');
  }

  /// Debugging method to see what's stored in the Hive box.
  static Future<void> inspectHiveData() async {
    // ADDED LOG:
    loggingService.logWarning('[GratitudeService] inspectHiveData called');

    final box = await Hive.openBox(_gratitudeBox);
    for (final key in box.keys) {
      final entry = box.get(key);
      loggingService.logWarning('Key: $key, Value: $entry, Type: ${entry.runtimeType}');
    }
  }

  // -----------------------------------------------------------------------
  // Helper: parse "YYYY-MM-DD" or an ISO date to a DateTime.
  // If parsing fails, fallback to "today".
  // -----------------------------------------------------------------------
  static DateTime _parseDateOrToday(String raw) {
    try {
      // If the input is "YYYY-MM-DD" or something parseable by DateTime.parse
      return DateTime.parse(raw);
    } catch (_) {
      // If it fails, just return today's date (local).
      final now = DateTime.now();
      loggingService.logWarning(
        '[GratitudeService] Could not parse "$raw". Using current date: $now',
      );
      return now;
    }
  }
}
