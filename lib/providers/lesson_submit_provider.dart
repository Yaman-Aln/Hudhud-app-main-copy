import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/lesson_submit_service.dart';
import '../providers/ff_logging_service_provider.dart';

/// A StateNotifier that keeps track of all lesson submission dates (day-level).
/// Under the hood, it uses LessonSubmitService, which stores data in Hive.
class LessonSubmitNotifier extends StateNotifier<List<DateTime>> {
  LessonSubmitNotifier() : super([]) {
    _loadSubmissionDates();
  }

  /// Fetches all existing submission days from Hive.
  Future<void> _loadSubmissionDates() async {
    final dates = await LessonSubmitService.getAllSubmissionDays();
    // Sort them if desired (ascending)
    dates.sort();
    state = dates;
  }

  /// Adds a new submission date (only if not already added), then reloads state.
  Future<void> addSubmissionDate(DateTime date) async {
    await LessonSubmitService.addSubmissionDate(date);
    await _loadSubmissionDates();
  }

  /// Clears all recorded submission data in Hive, then resets state to an empty list.
  Future<void> clearAllSubmissions() async {
    await LessonSubmitService.clearAllData();
    state = [];
  }
}

/// The provider that your UI can watch to get the current list of submission days.
final lessonSubmitProvider =
StateNotifierProvider<LessonSubmitNotifier, List<DateTime>>((ref) {
  return LessonSubmitNotifier();
});
