import 'dart:developer'; // For logging

// Required for using Ref in a Riverpod provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/lesson_model.dart';
import '../models/path_model.dart';
import '../services/quran_service.dart';
import '../services/progress_service.dart';
import '../services/local_storage_service.dart';
import '../providers/local_storage_service_provider.dart';
import '../providers/progress_service_provider.dart' as progress_service;
import '../providers/path_service_provider.dart' as path_service_provider;
import '../providers/ff_logging_service_provider.dart'; // for ffLoggingServiceProvider

// For referencing the PathService via "pathService" getter
import '../services/path_service.dart' as path_service;

/// A Riverpod provider for LessonService
final lessonServiceProvider = Provider<LessonService>((ref) {
  final localStorageService = ref.read(localStorageServiceProvider);
  final loggingService = ref.read(ffLoggingServiceProvider);

  return LessonService(
    ref: ref,
    localStorageService: localStorageService,
    loggingService: loggingService,
  );
});

class LessonService {
  final Ref ref;
  final LocalStorageService localStorageService;
  final LoggingService loggingService;

  LessonService({
    required this.ref,
    required this.localStorageService,
    required this.loggingService,
  });

  /// Access PathService via Riverpod
  path_service.PathService get pathService =>
      ref.read(path_service_provider.pathServiceProviderRef);

  /// Access the updated QuranService from quran_service.dart
  QuranService get quranService => ref.read(quranServiceProvider);

  /// Access ProgressService if needed
  ProgressService get progressService =>
      ref.read(progress_service.progressServiceProvider);

  // ----------------------------------------------------------------------------
  // 0) getLessonDetails
  // ----------------------------------------------------------------------------

  /// Retrieve minimal lesson info (startAyah, endAyah, pathId) for the lesson.
  Future<Map<String, dynamic>> getLessonDetails(String lessonId) async {
    loggingService.logWarning('[LessonService] getLessonDetails() -> lessonId=$lessonId');

    // Attempt to load the lesson from local storage
    final lesson = await localStorageService.getLesson(lessonId);
    if (lesson == null) {
      final msg = 'Lesson $lessonId not found in localStorage.';
      loggingService.logError(msg);
      throw Exception(msg);
    }
    if (lesson.pathIds.isEmpty) {
      final msg = 'Lesson $lessonId has no pathIds => cannot determine path.';
      loggingService.logWarning(msg);
      throw Exception(msg);
    }

    return {
      'startAyah': lesson.startAyah,
      'endAyah': lesson.endAyah,
      'pathId': lesson.pathIds.first,
    };
  }

  // ----------------------------------------------------------------------------
  // 1) Let ProgressService call lessonService.getTotalStepsForLesson(...)
  // ----------------------------------------------------------------------------

  Future<int> getTotalStepsForLesson(String lessonId, String pathId) async {
    loggingService.logWarning(
      '[LessonService] getTotalStepsForLesson() -> lessonId=$lessonId, pathId=$pathId',
    );

    // Retrieve the lesson from local storage
    final lesson = await getLessonById(lessonId, pathId: pathId);
    if (lesson == null) {
      loggingService.logWarning(
        '[LessonService] Lesson not found or path mismatch => returning 0 steps.',
      );
      return 0;
    }

    // Usually we rely on lesson.totalSteps (generated earlier).
    return lesson.totalSteps;
  }

  // ----------------------------------------------------------------------------
  // 2) If you want to generate lessons for a surah+path with wordsPerLesson
  // ----------------------------------------------------------------------------

  /// Updated to accept `themeIds` without causing a named-parameter error.
  Future<List<Lesson>> generateLessons(
      int surahId,
      int wordsPerLesson, {
        int? startAyah,
        int? endAyah,
        required String pathId,
        List<String> themeIds = const [], // <-- Added here
      }) async {
    loggingService.logWarning(
        '[LessonService] generateLessons() -> '
            'surahId=$surahId, wordsPerLesson=$wordsPerLesson, '
            'pathId=$pathId, themeIds=$themeIds'
    );

    final lessons = <Lesson>[];
    final ayahCount = quranService.getVerseCount(surahId);

    int currentAyah = startAyah ?? 1;
    final lastAyah = endAyah ?? ayahCount;
    int lessonIndex = 1;

    while (currentAyah <= lastAyah) {
      // Up to 'wordsPerLesson' worth of verses
      final selectedVerses = quranService.getVersesWithMaxWords(
        surahId,
        currentAyah,
        wordsPerLesson,
      );
      if (selectedVerses.isEmpty) break;

      final startLessonAyah = selectedVerses.first['id'];
      final endLessonAyah = selectedVerses.last['id'];

      final lessonId = 'lesson_${pathId}_$lessonIndex';

      final totalSteps = await calculateTotalSteps(
        surahId: surahId,
        startAyah: startLessonAyah,
        endAyah: endLessonAyah,
      );

      final newLesson = Lesson(
        id: lessonId,
        surahId: surahId,
        startAyah: startLessonAyah,
        endAyah: endLessonAyah,
        pathIds: [pathId],
        totalSteps: totalSteps,
        progress: 0,
      );

      // Initialize progress at 0
      await localStorageService.updateLessonProgress(
        lessonId,
        0,
        currentStep: 0,
        pathId: pathId,
      );
      await localStorageService.saveLesson(newLesson);

      loggingService.logWarning('[LessonService] Saved lesson: $lessonId');

      lessons.add(newLesson);
      lessonIndex++;
      currentAyah = endLessonAyah + 1;
    }

    return lessons;
  }

  // ----------------------------------------------------------------------------
  // 3) Utility method to compute total steps for a range of Ayahs
  // ----------------------------------------------------------------------------

  Future<int> calculateTotalSteps({
    required int surahId,
    required int startAyah,
    required int endAyah,
  }) async {
    final totalWords = quranService.getTotalWords(surahId, startAyah, endAyah);
    loggingService.logWarning(
        '[LessonService] calculateTotalSteps() -> '
            'Found $totalWords words between ayahs $startAyah-$endAyah'
    );

    // Example approach: sum(1..N) = N*(N+1)/2
    final totalSteps = (totalWords * (totalWords + 1)) ~/ 2;
    loggingService.logWarning(
        '[LessonService] calculateTotalSteps() -> totalSteps=$totalSteps'
    );
    return totalSteps;
  }

  // ----------------------------------------------------------------------------
  // 4) getLessonById / validateLesson / getLessonsByPathId, etc.
  // ----------------------------------------------------------------------------

  Future<Lesson?> getLessonById(
      String lessonId, {
        required String pathId,
      }) async {
    loggingService.logWarning(
        '[LessonService] getLessonById() -> '
            'lessonId=$lessonId, pathId=$pathId'
    );

    try {
      final lesson = await localStorageService.getLesson(lessonId);
      if (lesson != null && lesson.pathIds.contains(pathId)) {
        // Merge progress
        final pd = await localStorageService.getLessonProgress(lessonId, pathId: pathId);
        if (pd.containsKey('progress')) {
          return lesson.copyWith(progress: pd['progress'] ?? 0);
        }
        return lesson;
      } else {
        loggingService.logWarning(
            '[LessonService] Lesson not found or path mismatch => returning null'
        );
        return null;
      }
    } catch (e) {
      loggingService.logError('Error in getLessonById($lessonId): $e');
      return null;
    }
  }

  Future<bool> validateLesson({
    required String lessonId,
    required int surahId,
    required String pathId,
  }) async {
    loggingService.logWarning(
        '[LessonService] validateLesson() -> '
            'lessonId=$lessonId, surahId=$surahId, pathId=$pathId'
    );

    final lesson = await getLessonById(lessonId, pathId: pathId);
    if (lesson != null && lesson.surahId == surahId) {
      loggingService.logWarning('[LessonService] Lesson is valid: $lessonId');
      return true;
    }
    loggingService.logWarning('[LessonService] Lesson is invalid: $lessonId');
    return false;
  }

  Future<List<Lesson>> getLessonsByPathId(String pathId) async {
    loggingService.logWarning('[LessonService] getLessonsByPathId() -> pathId=$pathId');
    final allLessons = await localStorageService.getAllLessons();
    return allLessons.where((ls) => ls.pathIds.contains(pathId)).toList();
  }

  /// Save the last opened lesson
  Future<void> saveLastOpenedLesson(String lessonId, int surahId, String pathId) async {
    loggingService.logWarning(
        '[LessonService] saveLastOpenedLesson() -> '
            '$lessonId, $surahId, $pathId'
    );
    await localStorageService.saveLastLesson(lessonId, surahId, pathId: pathId);
  }

  /// Retrieve last opened lesson details
  Future<Map<String, dynamic>?> getLastOpenedLesson() async {
    loggingService.logWarning('[LessonService] getLastOpenedLesson()');
    final data = await localStorageService.getLastLesson();
    if (data != null) {
      final lessonId = data['lessonId'];
      final pathId = data['pathId'];
      final pd = await localStorageService.getLessonProgress(lessonId, pathId: pathId);
      data['progress'] = pd['progress'];
      data['currentStep'] = pd['currentStep'];
    }
    return data;
  }

  /// If a new lesson is created, recalc the path steps & progress
  Future<void> updatePathProgressOnLessonCreation(
      String lessonId,
      List<String> pathIds,
      ) async {
    loggingService.logWarning(
        '[LessonService] updatePathProgressOnLessonCreation() -> '
            'lessonId=$lessonId, pathIds=$pathIds'
    );

    for (final pId in pathIds) {
      final path = await localStorageService.getPathById(pId);
      if (path == null) continue;

      final allLessonIds = path.lessons.map((l) => l.id).toList();
      final totalSteps = await pathService.calculateTotalStepsForPath(allLessonIds, pId);
      path.totalSteps = totalSteps;

      // Recalc progress: sum each lesson's progress
      int combined = 0;
      for (var l in path.lessons) {
        final pd = await localStorageService.getLessonProgress(l.id, pathId: pId);
        combined += (pd['progress'] ?? 0) as int;
      }
      if (path.lessons.isNotEmpty) {
        path.progress = (combined / path.lessons.length).ceil();
      }

      // Instead of path_service.updatePath(path), we call the instance method:
      await pathService.updatePath(path);

      loggingService.logWarning(
          '[LessonService] Path $pId updated with totalSteps=$totalSteps'
      );
    }
  }
}
