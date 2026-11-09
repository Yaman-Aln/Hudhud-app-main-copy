// lib/providers/lesson_data_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'lesson_submit_provider.dart';
import 'ff_logging_service_provider.dart';

/// Model for distinct lesson data (total lesson days, lesson streak).
class LessonData {
  final int totalLessonDays;
  final int lessonStreak;

  LessonData({
    required this.totalLessonDays,
    required this.lessonStreak,
  });
}

/// A provider that calculates:
/// 1) total distinct days a user has lesson submissions
/// 2) consecutive-day streak for lessons only
final lessonDataProvider = FutureProvider<LessonData>((ref) async {
  final loggingService = ref.read(ffLoggingServiceProvider);

  // 1) watch lessonSubmitProvider for distinct submission days
  final submissionDays = ref.watch(lessonSubmitProvider);

  // 2) distinct days => totalLessonDays
  final distinctDays = submissionDays.map(_toStartOfDay).toSet();
  final totalLessonDays = distinctDays.length;

  // 3) sort ascending
  final sorted = distinctDays.toList()..sort();

  // 4) compute streak
  final streak = _calculateStreak(sorted);

  loggingService.logWarning(
    '[lessonDataProvider] totalLessonDays=$totalLessonDays, lessonStreak=$streak',
  );

  return LessonData(totalLessonDays: totalLessonDays, lessonStreak: streak);
});

DateTime _toStartOfDay(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

int _calculateStreak(List<DateTime> sortedDays) {
  if (sortedDays.isEmpty) return 0;

  int streak = 1;
  for (int i = sortedDays.length - 1; i > 0; i--) {
    final current = sortedDays[i];
    final prevExpected = current.subtract(const Duration(days: 1));
    if (sortedDays[i - 1] != prevExpected) {
      break;
    }
    streak++;
  }
  return streak;
}
