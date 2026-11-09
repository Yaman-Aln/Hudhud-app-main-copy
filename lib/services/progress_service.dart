// lib/services/progress_service.dart

import 'dart:developer';
import 'package:hive/hive.dart';

import '../services/local_storage_service.dart';
import '../models/lesson_model.dart';
import '../models/path_model.dart';
import '../services/path_service.dart' as path;
import '../services/lesson_service.dart' as lesson;
import '../providers/ff_logging_service_provider.dart';

/// We define a top-level fallback logger
final loggingService = LoggingService();

/// The ProgressService class manages lesson & path progress in Hive and memory.
/// In this updated version, we do a single "lesson + path" progress update
/// at final submit time (rather than after every step).
class ProgressService {
  final LocalStorageService _storageService;
  final path.PathService _pathService;
  final lesson.LessonService _lessonService;

  ProgressService({
    required path.PathService pathService,
    required LocalStorageService storageService,
    required lesson.LessonService lessonService,
  })  : _pathService = pathService,
        _storageService = storageService,
        _lessonService = lessonService;

  /// Simple helper: calculates an integer percentage from [currentStepIndex] and [totalSteps].
  int calculateProgress(int currentStepIndex, int totalSteps) {
    if (totalSteps == 0) return 0;
    final progress = (currentStepIndex / totalSteps) * 100;
    return progress.ceil().clamp(0, 100);
  }

  // -------------------------------------------------------------------------
  // NEW SINGLE-SHOT FINAL SUBMIT METHOD
  // -------------------------------------------------------------------------
  /// Called once when the user completes/submits the lesson.
  /// 1) Calculates final lesson progress
  /// 2) Stores that lesson progress in Hive/local storage
  /// 3) Recalculates the path's overall progress
  /// 4) Saves path progress in Hive/local storage
  Future<void> saveProgressOnLessonSubmit(
      String lessonId,
      int currentStep,
      int totalSteps, {
        String? pathId,
        int currentRepeatCount = 0,
        int repeatTarget = 1,
      }) async {
    loggingService.logWarning('[ProgressService] saveProgressOnLessonSubmit() -> '
        'lessonId: $lessonId, currentStep: $currentStep, '
        'currentRepeatCount: $currentRepeatCount, totalSteps: $totalSteps, pathId: $pathId');

    pathId ??= 'path1';
    if (pathId.isEmpty) {
      loggingService.logWarning('[ProgressService] Invalid or missing pathId => skip');
      return;
    }

    // -- A) Calculate final lesson-level progress:
    // If the user repeated enough times, treat it as one more step:
    final effectiveStep = (currentRepeatCount >= repeatTarget) ? currentStep + 1 : currentStep;
    final lessonProgress = calculateProgress(effectiveStep, totalSteps);

    // -- B) Save lesson-level progress:
    try {
      final box = await Hive.openBox('lessonProgressBox');
      final key = '${lessonId}_$pathId';
      await box.put(key, {
        'progress': lessonProgress,
        'currentStep': currentStep,
        'currentRepeatCount': currentRepeatCount,
        'repeatTarget': repeatTarget,
      });
      loggingService.logWarning('[ProgressService] [LessonSubmit] Saved lesson progress -> '
          'lessonId=$lessonId, pathId=$pathId, progress=$lessonProgress');

      // Also store via the LocalStorageService
      await _storageService.updateLessonProgress(
        lessonId,
        lessonProgress,
        currentStep: currentStep,
        pathId: pathId,
        currentRepeatCount: currentRepeatCount,
      );

      // -- C) Recalculate the path's overall progress:
      await _recalcAndSavePathProgress(pathId);

      loggingService.logWarning('[ProgressService] Completed saveProgressOnLessonSubmit -> lessonId: $lessonId');
    } catch (e) {
      loggingService.logWarning('[ProgressService] Error in saveProgressOnLessonSubmit: $e');
    }
  }

  // -------------------------------------------------------------------------
  // HELPER: Recalc path progress from all lessons, then store it
  // -------------------------------------------------------------------------
  Future<void> _recalcAndSavePathProgress(String pathId) async {
    loggingService.logWarning('[ProgressService] _recalcAndSavePathProgress() -> pathId=$pathId');
    try {
      final pathObj = _pathService.getPathById(pathId);
      if (pathObj == null) {
        loggingService.logWarning('[ProgressService] No path found for pathId=$pathId');
        return;
      }

      final lessonsInPath = pathObj.lessons;
      final lessonCount = lessonsInPath.length;
      if (lessonCount == 0) {
        // If no lessons, set path progress=0
        pathObj.progress = 0;
        await _pathService.updatePath(pathObj);
        await _storageService.savePathProgress(pathId, 0.0);
        loggingService.logWarning('[ProgressService] Path has no lessons -> set progress=0');
        return;
      }

      int totalLessonProgress = 0;
      for (final ls in lessonsInPath) {
        final lpData = await getLessonProgress(ls.id, pathId: pathId);
        final int lp = (lpData['progress'] ?? 0) as int;
        totalLessonProgress += lp;
      }

      final newPathProgress = (totalLessonProgress / lessonCount).ceil().clamp(0, 100);
      pathObj.progress = newPathProgress;

      // 1) Update path object in memory
      await _pathService.updatePath(pathObj);

      // 2) Save to pathProgressBox
      await _storageService.savePathProgress(pathId, newPathProgress.toDouble());

      loggingService.logWarning('[ProgressService] Recalculated path progress for pathId=$pathId -> $newPathProgress%');
    } catch (e) {
      loggingService.logWarning('[ProgressService] Error in _recalcAndSavePathProgress => $e');
    }
  }

  // -------------------------------------------------------------------------
  // LEGACY / OPTIONAL METHODS
  // (We leave them for reference, but they no longer get called automatically
  // on each step or each partial update.)
  // -------------------------------------------------------------------------

  /// A convenience method if you ever want to manually recalc from outside:
  Future<void> calculateAndSavePathProgress(String pathId) async {
    loggingService.logWarning('[ProgressService] calculateAndSavePathProgress() -> pathId=$pathId');
    try {
      await _recalcAndSavePathProgress(pathId);
    } catch (e) {
      loggingService.logWarning('[ProgressService] Error in calculateAndSavePathProgress: $e');
    }
  }

  /// A minimal method to do lesson progress only, without path recalc.
  /// Not automatically called anymore, but you can keep it if you want partial updates.
  Future<void> updateLessonProgress(
      String lessonId,
      int progress, {
        int currentStep = 0,
        String? pathId,
        // We intentionally removed the path recalc from this method
      }) async {
    loggingService.logWarning('[ProgressService] updateLessonProgress() -> '
        'lessonId=$lessonId, progress=$progress, currentStep=$currentStep, pathId=$pathId');

    pathId ??= 'path1';
    if (pathId.isEmpty) {
      loggingService.logWarning('[ProgressService] Invalid or missing pathId => cannot update lesson');
      return;
    }
    if (lessonId.isEmpty) {
      loggingService.logWarning('[ProgressService] Invalid lessonId => cannot update lesson');
      return;
    }

    try {
      // Just clamp and write to lessonProgress
      final box = await Hive.openBox('lessonProgressBox');
      final key = '${lessonId}_$pathId';
      final safeProg = progress.clamp(0, 100);

      await box.put(key, {
        'progress': safeProg,
        'currentStep': currentStep,
      });
      loggingService.logWarning('[ProgressService] updateLessonProgress => lessonId=$lessonId, stored progress=$safeProg');

      // Also store via LocalStorageService
      await _storageService.updateLessonProgress(
        lessonId,
        safeProg,
        currentStep: currentStep,
        pathId: pathId,
      );
    } catch (e) {
      loggingService.logWarning('[ProgressService] Error updating lesson progress => $e');
    }
  }

  /// If you wanted to do partial "sync" logic, no path recalc is done here by default.
  Future<void> synchronizeProgress(
      String lessonId,
      int progress, {
        String? pathId,
      }) async {
    loggingService.logWarning('[ProgressService] synchronizeProgress() -> lessonId=$lessonId, pathId=$pathId, progress=$progress');
    pathId ??= 'path1';
    if (pathId.isEmpty) {
      loggingService.logWarning('[ProgressService] Invalid or missing pathId => cannot sync');
      return;
    }
    try {
      final pathIds = _pathService.getPathsContainingLesson(lessonId);
      for (final pid in pathIds) {
        final pathObj = _pathService.getPathById(pid);
        if (pathObj != null) {
          // Minimal approach: e.g. re-save the path object
          await _pathService.updatePath(pathObj);
          loggingService.logWarning('[ProgressService] Synchronized minimal path data for pathId=$pid');
        }
      }
    } catch (e) {
      loggingService.logWarning('[ProgressService] Error in synchronizeProgress => $e');
    }
  }

  // -------------------------------------------------------------------------
  // GETTERS
  // -------------------------------------------------------------------------
  /// Return a Map of lesson progress data for a single lesson within a path.
  Future<Map<String, dynamic>> getLessonProgress(String lessonId, {String? pathId}) async {
    loggingService.logWarning('[ProgressService] getLessonProgress() -> lessonId=$lessonId, pathId=$pathId');
    pathId ??= 'path1';
    if (pathId.isEmpty) {
      loggingService.logWarning('[ProgressService] Invalid pathId => return default');
      return {'progress': 0, 'currentStep': 0, 'currentRepeatCount': 0};
    }

    final box = await Hive.openBox('lessonProgressBox');
    final key = '${lessonId}_$pathId';
    final lessonProgress = box.get(key) ??
        {
          'progress': 0,
          'currentStep': 0,
          'currentRepeatCount': 0,
        };

    loggingService.logWarning('[ProgressService] Lesson $lessonId progress -> ${lessonProgress['progress']}% '
        '(Step=${lessonProgress['currentStep']}, Repeat=${lessonProgress['currentRepeatCount']})');
    return Map<String, dynamic>.from(lessonProgress);
  }

  /// Returns the (already-saved) path-level progress from Hive
  /// rather than recalculating every time.
  Future<double> getPathProgress(String pathId) async {
    loggingService.logWarning('[ProgressService] getPathProgress() -> pathId=$pathId');
    if (pathId.isEmpty) {
      loggingService.logWarning('[ProgressService] Invalid pathId => return 0');
      return 0.0;
    }

    // Just read from pathProgressBox
    final storedProgress = await _storageService.getPathProgress(pathId);
    return storedProgress; // might be 0 if not found
  }

  /// If you want path-level progress details from the lessonProgress approach
  Future<Map<String, dynamic>> getPathProgressDetails(String pathId) async {
    loggingService.logWarning('[ProgressService] getPathProgressDetails() -> pathId=$pathId');
    if (pathId.isEmpty) {
      loggingService.logWarning('[ProgressService] Invalid pathId => default');
      return {'progress': 0, 'currentStep': 0};
    }
    try {
      final progressData = await _storageService.getLessonProgress(pathId, pathId: pathId);
      loggingService.logWarning('[ProgressService] Retrieved path progress data => $progressData');
      return progressData;
    } catch (e) {
      loggingService.logWarning('[ProgressService] Error retrieving path progress => $e');
      return {'progress': 0, 'currentStep': 0};
    }
  }

  // -------------------------------------------------------------------------
  // EXTRA UTILS
  // -------------------------------------------------------------------------
  Future<Map<String, dynamic>> ensureAndRetrieveLessonProgress(String lessonId, {String? pathId}) async {
    pathId ??= 'path1';
    if (pathId.isEmpty) {
      loggingService.logWarning('[ProgressService] Invalid or missing pathId => default');
      return {'progress': 0, 'currentStep': 0};
    }
    final pd = await getLessonProgress(lessonId, pathId: pathId);
    if (pd.isEmpty) {
      loggingService.logWarning('[ProgressService] No existing lesson progress => initializing...');
      await updateLessonProgress(lessonId, 0, currentStep: 0, pathId: pathId);
    }
    return pd;
  }

  /// Sometimes you need to verify that the totalSteps for a path are correct
  /// after modifications. This method can recalc them.
  Future<void> validateAndAdjustPathSteps(String pathId) async {
    loggingService.logWarning('[ProgressService] validateAndAdjustPathSteps() -> pathId=$pathId');
    if (pathId.isEmpty) {
      loggingService.logWarning('[ProgressService] Invalid pathId => skip');
      return;
    }
    final pathObj = _pathService.getPathById(pathId);
    if (pathObj == null) {
      loggingService.logWarning('[ProgressService] Path not found => skip');
      return;
    }

    // e.g., ask pathService for total steps across all lessons
    final lessonIds = pathObj.lessons.map((ls) => ls.id).toList();
    final totalSteps = await _pathService.calculateTotalStepsForPath(lessonIds, pathId);
    if (pathObj.totalSteps != totalSteps) {
      loggingService.logWarning('[ProgressService] Updating totalSteps for pathId=$pathId from ${pathObj.totalSteps} to $totalSteps');
      pathObj.totalSteps = totalSteps;
      await _pathService.updatePath(pathObj);
    }
  }
}
