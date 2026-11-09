import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';

import '../providers/gratitude_provider.dart';
import '../providers/lesson_submit_provider.dart';
import '../models/gratitude_entry_model.dart';
import '../providers/ff_logging_service_provider.dart';

/// A data model that holds:
///   - totalActiveDays: the total # of distinct days user did an activity
///   - consecutiveDays: the daily streak count
///   - allActiveDays: the set of all days user has an activity (gratitude or lesson)
class CombinedStreakData {
  final int totalActiveDays;
  final int consecutiveDays;

  /// NEW: The union of all distinct “active” days (gratitude + lesson submissions)
  final Set<DateTime> allActiveDays;

  CombinedStreakData({
    required this.totalActiveDays,
    required this.consecutiveDays,
    required this.allActiveDays,
  });

  /// Helper: checks if there's any activity on [day].
  /// e.g. combinedStreak.userHasActivityOnDay(DateTime.now())
  bool userHasActivityOnDay(DateTime day) {
    final dayStart = DateTime(day.year, day.month, day.day);
    return allActiveDays.contains(dayStart);
  }

  @override
  String toString() =>
      'CombinedStreakData('
          'totalActiveDays=$totalActiveDays, '
          'consecutiveDays=$consecutiveDays, '
          'allActiveDays=$allActiveDays)';
}

/// A Riverpod provider that merges the days from gratitude logs and lesson
/// submissions, returning a combined daily streak plus total distinct days.
/// Additionally, we store [allActiveDays] for quick checks of user activity on a given day.
///
/// Usage:
/// ```dart
/// final combinedStreak = ref.watch(combinedStreakProvider);
/// final totalActiveDays = combinedStreak.totalActiveDays;
/// final combinedConsecutiveDays = combinedStreak.consecutiveDays;
/// final didActivityToday = combinedStreak.userHasActivityOnDay(DateTime.now());
/// ```
final combinedStreakProvider = Provider<CombinedStreakData>((ref) {
  // 1) Watch all gratitude entries.
  final gratitudeEntries = ref.watch(gratitudeEntriesProvider);

  // 2) Watch all lesson submission days.
  final lessonSubmitDays = ref.watch(lessonSubmitProvider);

  // Logging service
  final loggingService = ref.read(ffLoggingServiceProvider);

  // 3) Build a set of distinct gratitude days.
  final gratitudeDays = <DateTime>{};
  for (final entry in gratitudeEntries) {
    if (entry.date != null) {
      gratitudeDays.add(_toStartOfDay(entry.date));
    }
  }

  // 4) Build a set of distinct lesson submit days.
  final submitDays = lessonSubmitDays
      .map((d) => _toStartOfDay(d))
      .toSet();

  // 5) Union the sets => all distinct “active” days.
  final allActiveDays = <DateTime>{}
    ..addAll(gratitudeDays)
    ..addAll(submitDays);

  // 6) Sort them ascending to compute streak easily.
  final sortedDays = allActiveDays.toList()..sort();

  // 7) Calculate consecutive day streak.
  final streak = _calculateConsecutiveStreak(sortedDays);

  // 8) Build the final data object, now including allActiveDays.
  final data = CombinedStreakData(
    totalActiveDays: allActiveDays.length,
    consecutiveDays: streak,
    allActiveDays: allActiveDays, // NEW: store union set here.
  );

  // Log with new logger
  loggingService.logWarning(
    '[combinedStreakProvider] totalActiveDays=${data.totalActiveDays}, '
        'consecutiveDays=${data.consecutiveDays}, '
        'allActiveDaysCount=${data.allActiveDays.length}',
  );

  return data;
});

/// Helper: normalizes DateTime to the "start of day"
DateTime _toStartOfDay(DateTime dt) {
  return DateTime(dt.year, dt.month, dt.day);
}

/// Helper: calculates the consecutive day streak from the end of [sortedDays].
int _calculateConsecutiveStreak(List<DateTime> sortedDays) {
  if (sortedDays.isEmpty) {
    return 0;
  }

  // Start streak at 1 if there's at least one date
  int streak = 1;

  // Traverse from latest day backward
  for (int i = sortedDays.length - 1; i > 0; i--) {
    final current = sortedDays[i];
    final expectedPrevious = current.subtract(const Duration(days: 1));

    // If the next-earlier day is not exactly "expectedPrevious", streak breaks
    if (sortedDays[i - 1] != expectedPrevious) {
      break;
    }
    streak++;
  }

  return streak;
}
