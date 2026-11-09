// services/repeat_service.dart

import 'package:hive/hive.dart';
import 'dart:developer';
import '../services/local_storage_service.dart';
import '../providers/ff_logging_service_provider.dart';

class RepeatService {
  final LocalStorageService localStorageService;
  final LoggingService loggingService;

  static const String repeatKeyPrefix = 'repeatCount_';
  static const String currentRepeatKeyPrefix = 'currentRepeatCount_';

  RepeatService({
    required this.localStorageService,
    required this.loggingService,
  });

  /// Save the total repeat count for a specific lesson.
  Future<void> saveRepeatCount(String lessonId, int repeatCount) async {
    await localStorageService.saveRepeatCount(lessonId, repeatCount);
    loggingService.logInfo(
      '[RepeatService] Saved repeat count $repeatCount for lessonId: $lessonId',
    );
  }

  /// Retrieve the total repeat count for a specific lesson.
  Future<int> getRepeatCount(String lessonId) async {
    final repeatCount = await localStorageService.getRepeatCount(lessonId);
    return repeatCount ?? 1; // default to 1 if none stored
  }

  /// Reset the total repeat count to the default value (1).
  Future<void> resetRepeatCount(String lessonId) async {
    await saveRepeatCount(lessonId, 1);
    loggingService.logInfo(
      '[RepeatService] Reset repeat count for lessonId: $lessonId',
    );
  }

  /// Save the current repeat count (for tracking progress within this step).
  Future<void> saveCurrentRepeat(String lessonId, int currentRepeat) async {
    await localStorageService.saveInt(
      '$currentRepeatKeyPrefix$lessonId',
      currentRepeat,
    );
    loggingService.logInfo(
      '[RepeatService] Saved current repeat count $currentRepeat for lessonId: $lessonId',
    );
  }

  /// Retrieve the current repeat count (how many times we've done this step so far).
  Future<int> getCurrentRepeat(String lessonId) async {
    final currentRepeat = await localStorageService.getInt(
      '$currentRepeatKeyPrefix$lessonId',
    );
    return currentRepeat ?? 0; // default to 0 if none stored
  }

  /// Increment the current repeat count and return whether we've hit the limit.
  /// We fix the off-by-one by treating (repeatCount - 1) as the threshold.
  Future<bool> incrementCurrentRepeat(String lessonId) async {
    int currentRepeat = await getCurrentRepeat(lessonId);
    final totalRepeats = await getRepeatCount(lessonId);

    currentRepeat += 1;
    await saveCurrentRepeat(lessonId, currentRepeat);

    // If currentRepeat >= (totalRepeats - 1), we've done N total passes.
    final hasReachedLimit = (currentRepeat >= (totalRepeats - 1));

    loggingService.logInfo(
      '[RepeatService] Incremented repeat count -> lessonId=$lessonId: '
          '$currentRepeat / $totalRepeats. Limit reached: $hasReachedLimit',
    );

    return hasReachedLimit;
  }

  /// Reset the current repeat count to 0.
  Future<void> resetCurrentRepeat(String lessonId) async {
    await saveCurrentRepeat(lessonId, 0);
    loggingService.logInfo(
      '[RepeatService] Reset current repeat count for lessonId: $lessonId',
    );
  }

  /// Check if the user has completed the required repeats.
  /// This uses >= (repeatCount - 1) so “×2” yields exactly 2 total passes.
  Future<bool> hasCompletedRepeats(String lessonId) async {
    final currentRepeat = await getCurrentRepeat(lessonId);
    final totalRepeats = await getRepeatCount(lessonId);

    final finished = (currentRepeat >= (totalRepeats - 1));
    loggingService.logInfo(
      '[RepeatService] hasCompletedRepeats -> lessonId=$lessonId: '
          'current=$currentRepeat, target=$totalRepeats => finished=$finished',
    );

    return finished;
  }
}
