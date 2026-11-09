// lib/services/lesson_submit_service.dart

import 'package:hive/hive.dart';
import 'dart:developer';
import '../providers/ff_logging_service_provider.dart';

// Global fallback logger
final loggingService = LoggingService();

/// A simple service for storing daily lesson submission flags.
class LessonSubmitService {
  static const String _lessonSubmitBox = 'lessonSubmitLog';

  /// Add a submission for a date (e.g., "2025-01-16").
  static Future<void> addSubmissionDate(DateTime date) async {
    final box = await Hive.openBox(_lessonSubmitBox);
    final dayString = _formatDate(date);

    if (box.get(dayString) == true) {
      loggingService.logWarning('[LessonSubmitService] Submission already recorded for $dayString');
      return;
    }
    await box.put(dayString, true);
    loggingService.logWarning('[LessonSubmitService] Saved submission for $dayString');
  }

  /// Returns true if a submission for [date] exists.
  static Future<bool> hasSubmissionForDate(DateTime date) async {
    final box = await Hive.openBox(_lessonSubmitBox);
    final dayString = _formatDate(date);
    return box.get(dayString) == true;
  }

  /// Number of distinct days with at least one submission.
  static Future<int> getTotalSubmissionDays() async {
    final box = await Hive.openBox(_lessonSubmitBox);
    return box.keys.length;
  }

  /// Retrieve all distinct submission days as a list of DateTimes.
  static Future<List<DateTime>> getAllSubmissionDays() async {
    final box = await Hive.openBox(_lessonSubmitBox);
    final submissionDays = <DateTime>[];

    for (var key in box.keys) {
      final storedValue = box.get(key);
      if (storedValue == true) {
        final parsed = DateTime.tryParse(key);
        if (parsed != null) submissionDays.add(parsed);
      }
    }
    submissionDays.sort();
    return submissionDays;
  }

  /// Clears all submission data from the Hive box.
  static Future<void> clearAllData() async {
    final box = await Hive.openBox(_lessonSubmitBox);
    await box.clear();
    loggingService.logWarning('[LessonSubmitService] Cleared all lesson submissions.');
  }

  /// Debug: prints out key-value pairs from the Hive box.
  static Future<void> inspectHiveData() async {
    final box = await Hive.openBox(_lessonSubmitBox);
    for (var key in box.keys) {
      final val = box.get(key);
      loggingService.logWarning('[LessonSubmitService] Key: $key => $val');
    }
  }

  /// Formats date as "yyyy-MM-dd".
  static String _formatDate(DateTime date) {
    return date.toIso8601String().split('T')[0];
  }
}
