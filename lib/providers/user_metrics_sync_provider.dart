// lib/providers/user_metrics_sync_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

import 'package:hudhud_quran_app_new/providers/gratitude_provider.dart';
import 'package:hudhud_quran_app_new/providers/combined_streak_provider.dart';
import 'package:hudhud_quran_app_new/providers/lesson_data_provider.dart';

/// A provider that sets user properties (streaks, totals) each time
/// relevant data changes. We rely on `ref.listen(...)` inside the provider
/// to watch for updates, then call analytics.setUserProperty(...) again.
///
/// Usage:
///   1) Just `ref.read(userMetricsSyncProvider);` in your main or top-level widget.
///   2) This triggers the effect once, setting up the listeners.
final userMetricsSyncProvider = Provider<void>((ref) {
  final analytics = ref.read(analyticsServiceProvider);

  // 1) Listen to gratitudeDataProvider => AsyncValue<GratitudeData>
  ref.listen<AsyncValue<GratitudeData>>(gratitudeDataProvider, (previous, next) async {
    // 'next' is an AsyncValue<GratitudeData>
    next.whenData((gData) async {
      // total distinct gratitude days
      await analytics.setUserProperty(
        'gratitude_days',
        gData.totalGratitudeDays.toString(),
      );
      // gratitude streak
      await analytics.setUserProperty(
        'gratitude_streak',
        gData.consecutiveGratitudeDays.toString(),
      );

      // Also fetch total # of gratitude items
      final totalItems = await ref
          .read(gratitudeEntriesProvider.notifier)
          .getTotalGratitudeCount();
      await analytics.setUserProperty(
        'total_gratitude_items',
        totalItems.toString(),
      );
    });
  });

  // 2) Listen to lessonDataProvider => AsyncValue<LessonData>
  ref.listen<AsyncValue<LessonData>>(lessonDataProvider, (previous, next) async {
    // 'next' is an AsyncValue<LessonData>
    next.whenData((lData) async {
      await analytics.setUserProperty(
        'lesson_days',
        lData.totalLessonDays.toString(),
      );
      await analytics.setUserProperty(
        'lesson_streak',
        lData.lessonStreak.toString(),
      );
    });
  });

  // 3) Listen to combinedStreakProvider => CombinedStreakData (synchronous)
  ref.listen<CombinedStreakData>(combinedStreakProvider, (previous, next) async {
    // 'next' is a CombinedStreakData, not an AsyncValue.
    await analytics.setUserProperty(
      'combined_total_active_days',
      next.totalActiveDays.toString(),
    );
    await analytics.setUserProperty(
      'combined_streak',
      next.consecutiveDays.toString(),
    );
  });

  // Return nothing; we only set up the effect watchers
  return;
});
