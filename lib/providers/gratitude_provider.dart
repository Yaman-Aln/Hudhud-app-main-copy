// lib/providers/gratitude_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/gratitude_entry_model.dart';
import '../services/gratitude_service.dart';
import 'dart:developer'; // for log(...) if needed
import '../providers/ff_logging_service_provider.dart';

/// Provider to fetch all gratitude entries.
final gratitudeEntriesProvider =
StateNotifierProvider<GratitudeEntriesNotifier, List<GratitudeEntry>>(
      (ref) => GratitudeEntriesNotifier(ref),
);

/// Notifier for managing gratitude entries.
class GratitudeEntriesNotifier extends StateNotifier<List<GratitudeEntry>> {
  final Ref ref;

  GratitudeEntriesNotifier(this.ref) : super([]) {
    _loadEntries();
  }

  /// Load entries from the service.
  Future<void> _loadEntries() async {
    final loggingService = ref.read(ffLoggingServiceProvider);

    try {
      final entries = await GratitudeService.getAllGratitudeEntries();
      loggingService.logWarning(
        '[GratitudeEntriesNotifier] Entries fetched: $entries',
      );

      final formattedEntries = entries.entries
          .map(
            (entry) => GratitudeEntry(
          date: DateTime.parse(entry.key),
          entries: entry.value,
        ),
      )
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date)); // Sort descending by date.

      state = formattedEntries;
      loggingService.logWarning(
        '[GratitudeEntriesNotifier] Loaded ${formattedEntries.length} gratitude entries (distinct days).',
      );
    } catch (error) {
      loggingService.logWarning(
        '[GratitudeEntriesNotifier] Error loading entries: $error',
      );
    }
  }

  /// Add a new gratitude entry.
  Future<void> addEntry(String date, List<String> gratitudes) async {
    final loggingService = ref.read(ffLoggingServiceProvider);
    try {
      await GratitudeService.addGratitudeEntries(date, gratitudes);
      loggingService.logWarning(
        '[GratitudeEntriesNotifier] Added gratitude entries for date $date: $gratitudes',
      );

      // Refresh the state
      await _loadEntries();
    } catch (error) {
      loggingService.logWarning(
        '[GratitudeEntriesNotifier] Error adding entries for date $date: $error',
      );
      rethrow;
    }
  }

  /// Clear all gratitude entries.
  Future<void> clearEntries() async {
    final loggingService = ref.read(ffLoggingServiceProvider);
    try {
      await GratitudeService.clearAllData();
      state = [];
      loggingService.logWarning(
        '[GratitudeEntriesNotifier] Cleared all gratitude entries.',
      );
    } catch (error) {
      loggingService.logWarning(
        '[GratitudeEntriesNotifier] Error clearing entries: $error',
      );
    }
  }

  /// Returns the total number of gratitude items across all days.
  Future<int> getTotalGratitudeCount() async {
    final loggingService = ref.read(ffLoggingServiceProvider);

    try {
      final entriesMap = await GratitudeService.getAllGratitudeEntries();
      int total = 0;
      entriesMap.forEach((dateKey, listOfTexts) {
        total += listOfTexts.length;
      });

      loggingService.logWarning(
        '[GratitudeEntriesNotifier] Calculated total gratitude count: $total',
      );
      return total;
    } catch (error) {
      loggingService.logWarning(
        '[GratitudeEntriesNotifier] Error in getTotalGratitudeCount: $error',
      );
      rethrow;
    }
  }
}

/// Model for combined gratitude data (includes total days, streak, and total count of gratitudes).
class GratitudeData {
  final int totalGratitudeDays;
  final int consecutiveGratitudeDays;
  final int totalGratitudeCount; // <--- new field

  GratitudeData({
    required this.totalGratitudeDays,
    required this.consecutiveGratitudeDays,
    required this.totalGratitudeCount,
  });
}

/// Provider for combined gratitude data (total days, streak, and total count).
final gratitudeDataProvider = FutureProvider<GratitudeData>((ref) async {
  final loggingService = ref.read(ffLoggingServiceProvider);

  // 1) Watch gratitudeEntriesProvider to establish dependency
  final gratitudeEntries = ref.watch(gratitudeEntriesProvider);

  try {
    // 2) Calculate the streak from gratitude entries
    final streak = _calculateStreak(gratitudeEntries, loggingService);

    // 3) Fetch the total distinct days from the service
    final allEntries = await GratitudeService.getAllGratitudeEntries();
    final totalGratitudeDays = allEntries.keys.length; // # of distinct days

    // 4) Calculate total gratitude count
    int totalGratitudeCount = 0;
    for (final kvp in allEntries.entries) {
      totalGratitudeCount += kvp.value.length;
    }

    loggingService.logWarning(
      '[GratitudeDataProvider] Gratitude data fetched: '
          'Total Days - $totalGratitudeDays, Streak - $streak, '
          'Count - $totalGratitudeCount',
    );

    return GratitudeData(
      totalGratitudeDays: totalGratitudeDays,
      consecutiveGratitudeDays: streak,
      totalGratitudeCount: totalGratitudeCount, // pass new field
    );
  } catch (error) {
    loggingService.logWarning(
      '[GratitudeDataProvider] Error fetching gratitude data: $error',
    );
    rethrow;
  }
});

/// Helper method to calculate the streak based on gratitude entries.
/// We inject [loggingService] as a parameter for logs.
int _calculateStreak(
    List<GratitudeEntry>? gratitudeEntries,
    LoggingService loggingService,
    ) {
  if (gratitudeEntries == null || gratitudeEntries.isEmpty) {
    loggingService.logWarning(
      '[GratitudeDataProvider] No gratitude entries available to calculate streak.',
    );
    return 0;
  }

  // Extract and sort dates ascending
  final dates = gratitudeEntries
      .map((entry) => entry.date)
      .whereType<DateTime>()
      .toList()
    ..sort();

  if (dates.isEmpty) {
    loggingService.logWarning(
      '[GratitudeDataProvider] No valid dates available to calculate streak.',
    );
    return 0;
  }

  // Start streak at 1 if there's at least one date
  int streak = 1;
  for (int i = dates.length - 1; i > 0; i--) {
    final current = dates[i];
    final expectedPrevious = current.subtract(const Duration(days: 1));

    loggingService.logWarning(
      '[GratitudeDataProvider] Comparing $current to $expectedPrevious.',
    );

    if (dates[i - 1] != expectedPrevious) {
      loggingService.logWarning(
        '[GratitudeDataProvider] Streak broken at $current.',
      );
      break;
    }
    streak++;
  }

  loggingService.logWarning(
    '[GratitudeDataProvider] Final calculated streak: $streak',
  );
  return streak;
}
