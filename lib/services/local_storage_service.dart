// lib/services/local_storage_service.dart

import 'package:hive/hive.dart';
import 'dart:developer'; // For logging
import '../models/path_model.dart';
import '../models/lesson_model.dart';
import '../models/difficulty_level_model.dart';
import '../providers/ff_logging_service_provider.dart';

class LocalStorageService {
  // ---------------------------------------------------------------------------
  // BOX NAMES
  // ---------------------------------------------------------------------------
  static const String userPathsBox = 'user_paths';
  static const String lessonProgressBox = 'lesson_progress';
  static const String lessonsBox = 'lessons';
  static const String lastLessonBox = 'last_lesson';
  static const String userPreferencesBox = 'userPreferences';
  static const String streakBox = 'streakBox'; // Hive box for streaks

  // NEW: dedicated path progress box
  static const String pathProgressBox = 'path_progress';

  final LoggingService loggingService;

  // For difficulty & repeats
  final String _difficultyKeyPrefix = 'difficultyLevel_';
  final String _repeatKeyPrefix = 'repeatCount_';
  final String _streakKeyPrefix = 'streak_';

  LocalStorageService({required this.loggingService});

  // ---------------------------------------------------------------------------
  // HIVE INIT
  // ---------------------------------------------------------------------------
  Future<void> init() async {
    try {
      loggingService.logWarning('[LocalStorageService] Opening Hive boxes...');
      await Hive.openBox(userPathsBox);
      await Hive.openBox(lessonProgressBox);
      await Hive.openBox(lessonsBox);
      await Hive.openBox(lastLessonBox);
      await Hive.openBox(userPreferencesBox);
      await Hive.openBox(streakBox);

      // NEW: Open the pathProgressBox
      await Hive.openBox(pathProgressBox);

      loggingService.logWarning('[LocalStorageService] Hive boxes initialized successfully.');
    } catch (e) {
      loggingService.logWarning('[LocalStorageService] Error initializing Hive boxes: $e');
      loggingService.logError('Error initializing Hive boxes: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Simple Int / String / Bool Storage in userPreferencesBox
  // ---------------------------------------------------------------------------
  Future<void> saveInt(String key, int value) async {
    var box = Hive.box(userPreferencesBox);
    await box.put(key, value);
    loggingService.logWarning('[LocalStorageService] (Hive) Saved integer value $value with key: $key');
  }

  Future<int?> getInt(String key) async {
    var box = Hive.box(userPreferencesBox);
    int? value = box.get(key) as int?;
    loggingService.logWarning('[LocalStorageService] (Hive) Retrieved int for key="$key": ${value ?? 0}');
    return value;
  }

  Future<void> saveString(String key, String value) async {
    var box = Hive.box(userPreferencesBox);
    await box.put(key, value);
    loggingService.logWarning('[LocalStorageService] (Hive) Saved string: "$key" => "$value"');
  }

  Future<String?> getHiveString(String key) async {
    var box = Hive.box(userPreferencesBox);
    final val = box.get(key);
    if (val is String) return val;
    return null;
  }

  // NEW: Generic bool getters/setters
  Future<void> saveBool(String key, bool value) async {
    var box = Hive.box(userPreferencesBox);
    await box.put(key, value);
    loggingService.logWarning('[LocalStorageService] (Hive) Saved bool: "$key" => "$value"');
  }

  Future<bool?> getBool(String key) async {
    var box = Hive.box(userPreferencesBox);
    final val = box.get(key);
    if (val is bool) return val;
    return null;
  }

  // ---------------------------------------------------------------------------
  // Difficulty & Repeat
  // ---------------------------------------------------------------------------
  Future<void> saveDifficultyLevel(String lessonId, DifficultyLevel difficulty) async {
    var box = Hive.box(userPreferencesBox);
    await box.put('$_difficultyKeyPrefix$lessonId', difficulty.toString());
    loggingService.logWarning('[LocalStorageService] Saved difficulty for lessonId=$lessonId as $difficulty');
  }

  Future<DifficultyLevel?> getDifficultyLevel(String lessonId) async {
    var box = Hive.box(userPreferencesBox);
    String? difficultyStr = box.get('$_difficultyKeyPrefix$lessonId');
    if (difficultyStr != null) {
      try {
        DifficultyLevel difficulty = DifficultyLevel.values.firstWhere(
              (e) => e.toString() == difficultyStr,
        );
        return difficulty;
      } catch (e) {
        loggingService.logWarning('[LocalStorageService] Invalid difficulty level stored: $difficultyStr');
        loggingService.logError('Invalid difficulty level for $lessonId: $difficultyStr');
        return null;
      }
    }
    return null;
  }

  Future<void> saveRepeatCount(String lessonId, int repeatCount) async {
    var box = Hive.box(userPreferencesBox);
    await box.put('$_repeatKeyPrefix$lessonId', repeatCount);
    loggingService.logWarning('[LocalStorageService] Saved repeatCount=$repeatCount for lessonId=$lessonId');
  }

  Future<int?> getRepeatCount(String lessonId) async {
    var box = Hive.box(userPreferencesBox);
    int? repeatCount = box.get('$_repeatKeyPrefix$lessonId') as int?;
    loggingService.logWarning('[LocalStorageService] Retrieved repeatCount=$repeatCount for lessonId=$lessonId');
    return repeatCount;
  }

  // ---------------------------------------------------------------------------
  // USER PATHS: Single-Path Storage
  // ---------------------------------------------------------------------------
  /// Saves a single user path using path.id as the key. This replaces the old
  /// "entire array" approach.
  Future<void> saveUserPath(Path path) async {
    var box = Hive.box(userPathsBox);
    final pathId = path.id;
    await box.put(pathId, path.toJson());
    loggingService.logWarning('[LocalStorageService] Single path saved with pathId=$pathId');
  }

  /// Return all user paths by enumerating the box keys.
  Future<List<Path>> getUserPaths() async {
    var box = Hive.box(userPathsBox);
    final keys = box.keys;
    loggingService.logWarning('[LocalStorageService] getUserPaths() -> enumerating ${keys.length} keys in box=$userPathsBox');

    final results = <Path>[];
    for (final key in keys) {
      final raw = box.get(key);
      if (raw is Map) {
        try {
          final path = Path.fromJson(Map<String, dynamic>.from(raw));
          results.add(path);
        } catch (e) {
          loggingService.logError('Error parsing path from key=$key => $e');
        }
      }
    }
    loggingService.logWarning('[LocalStorageService] getUserPaths() -> loaded ${results.length} paths total.');
    return results;
  }

  /// Removes a single path by key= pathId
  Future<void> removeUserPath(String pathId) async {
    var box = Hive.box(userPathsBox);
    if (box.containsKey(pathId)) {
      await box.delete(pathId);
      loggingService.logWarning('[LocalStorageService] removeUserPath -> removed pathId=$pathId');
    } else {
      loggingService.logWarning('[LocalStorageService] removeUserPath -> pathId=$pathId not found');
    }
  }

  /// Clears the entire userPaths box if needed
  Future<void> clearUserPaths() async {
    var box = Hive.box(userPathsBox);
    await box.clear();
    loggingService.logWarning('[LocalStorageService] All user paths cleared from box=$userPathsBox');
  }

  /// Load a single path if needed
  Future<Path?> getPathById(String pathId) async {
    var box = Hive.box(userPathsBox);
    final raw = box.get(pathId);
    if (raw is Map) {
      try {
        return Path.fromJson(Map<String, dynamic>.from(raw));
      } catch (e) {
        loggingService.logError('Error parsing single pathId=$pathId => $e');
        return null;
      }
    }
    return null;
  }

  /// Migration: If we have an old `'paths' => [ ... ]` array, convert each to single entries
  Future<int> migrateOldArrayPathsIfAny() async {
    var box = Hive.box(userPathsBox);
    final maybeArray = box.get('paths'); // old approach
    if (maybeArray is List) {
      final oldList = maybeArray;
      loggingService.logWarning('[LocalStorageService] MIGRATION => found old array-based ${oldList.length} paths.');

      int migratedCount = 0;
      for (final rawPath in oldList) {
        if (rawPath is Map) {
          try {
            final p = Path.fromJson(Map<String, dynamic>.from(rawPath));
            await saveUserPath(p);
            migratedCount++;
          } catch (e) {
            loggingService.logError('Error migrating old array path => $e');
          }
        }
      }
      // Remove the old "paths" key so it won't be read again
      await box.delete('paths');
      return migratedCount;
    }
    // No old array => no migration
    return 0;
  }

  // ---------------------------------------------------------------------------
  // LESSON STORAGE
  // ---------------------------------------------------------------------------
  Future<Lesson?> getLesson(String lessonId) async {
    loggingService.logWarning('[LocalStorageService] getLesson($lessonId) called');
    var box = Hive.box(lessonsBox);
    try {
      var lessonDataRaw = box.get(lessonId);
      if (lessonDataRaw is Map) {
        loggingService.logWarning('[LocalStorageService] getLesson($lessonId) => null (not found in Hive)');
        Map<String, dynamic> lessonData = Map<String, dynamic>.from(lessonDataRaw);
        return Lesson.fromJson(lessonData);
      }
    } catch (e) {
      loggingService.logError('Error fetching lesson data for $lessonId: $e');
    }
    return null;
  }

  Future<void> saveLesson(Lesson lesson) async {
    var box = Hive.box(lessonsBox);
    loggingService.logWarning('[LocalStorageService] Saving lesson with id=${lesson.id}');
    await box.put(lesson.id, lesson.toJson());
  }

  Future<void> saveLessons(List<Lesson> lessons) async {
    var box = Hive.box(lessonsBox);
    Map<String, Map<String, dynamic>> lessonsMap = {
      for (var lesson in lessons) lesson.id: lesson.toJson()
    };
    loggingService.logWarning('[LocalStorageService] Saving ${lessons.length} lessons.');
    await box.putAll(lessonsMap);
  }

  Future<List<Lesson>> getAllLessons() async {
    var box = Hive.box(lessonsBox);
    loggingService.logWarning('[LocalStorageService] getAllLessons() from $lessonsBox');

    List<Lesson> result = [];
    for (final key in box.keys) {
      final raw = box.get(key);
      if (raw is Map) {
        try {
          final lesson = Lesson.fromJson(Map<String, dynamic>.from(raw));
          result.add(lesson);
        } catch (e) {
          loggingService.logError('Error parsing lesson with key=$key: $e');
        }
      }
    }
    loggingService.logWarning('[LocalStorageService] getAllLessons() -> found ${result.length} lessons total.');
    return result;
  }

  // ---------------------------------------------------------------------------
  // LESSON PROGRESS
  // ---------------------------------------------------------------------------
  Future<void> updateLessonProgress(
      String lessonId,
      int progress, {
        int currentStep = 0,
        String? pathId,
        int currentRepeatCount = 0,
      }) async {
    var box = Hive.box(lessonProgressBox);
    String key = '${lessonId}_${pathId ?? 'default'}';

    loggingService.logWarning('[LocalStorageService] Updating progress for lessonId=$lessonId, pathId=$pathId => progress=$progress.');

    await box.put(key, {
      'progress': progress,
      'currentStep': currentStep,
      'currentRepeatCount': currentRepeatCount,
    });

    // If progress is 100%, store last lesson submit if needed
    if (progress >= 100) {
      await saveLastLessonSubmit(lessonId, pathId ?? 'default');
    }
  }

  Future<Map<String, dynamic>> getLessonProgress(String lessonId, {String? pathId}) async {
    var box = Hive.box(lessonProgressBox);
    String key = '${lessonId}_${pathId ?? 'default'}';

    Map<dynamic, dynamic>? rawProgressData = box.get(
      key,
      defaultValue: {'progress': 0, 'currentStep': 0},
    ) as Map<dynamic, dynamic>?;

    if (rawProgressData == null) {
      // Return default if nothing found
      return {
        'progress': 0,
        'currentStep': 0,
        'pathId': pathId ?? 'default',
      };
    }

    Map<String, dynamic> progressData =
    rawProgressData.map((k, v) => MapEntry(k.toString(), v));
    progressData['pathId'] = pathId ?? 'default';
    return progressData;
  }

  // ---------------------------------------------------------------------------
  // LAST LESSON
  // ---------------------------------------------------------------------------
  Future<void> saveLastLesson(String lessonId, int surahId, {String? pathId}) async {
    var box = Hive.box(lastLessonBox);
    await box.put('last_lesson', {
      'lessonId': lessonId,
      'surahId': surahId,
      'pathId': pathId,
    });
  }

  Future<Map<String, dynamic>?> getLastLesson() async {
    var box = Hive.box(lastLessonBox);
    final lesson = box.get('last_lesson');
    if (lesson != null && lesson is Map) {
      return lesson.map((k, v) => MapEntry(k.toString(), v));
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // LAST LESSON SUBMIT
  // ---------------------------------------------------------------------------
  Future<void> saveLastLessonSubmit(String lessonId, String pathId) async {
    var box = Hive.box(userPreferencesBox);
    await box.put('lastLessonSubmit', {
      'lessonId': lessonId,
      'pathId': pathId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>?> getLastLessonSubmit() async {
    var box = Hive.box(userPreferencesBox);
    var data = box.get('lastLessonSubmit');
    if (data is Map) {
      final submitData = Map<String, dynamic>.from(data);
      if (submitData['timestamp'] != null) {
        try {
          submitData['timestamp'] = DateTime.parse(submitData['timestamp']);
        } catch (_) {
          submitData['timestamp'] = null;
        }
      }
      return submitData;
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // STREAK
  // ---------------------------------------------------------------------------
  Future<void> saveStreak(String activityKey, int streakCount) async {
    var box = Hive.box(streakBox);
    String key = '$_streakKeyPrefix$activityKey';
    await box.put(key, streakCount);
  }

  Future<int> getStreak(String activityKey) async {
    var box = Hive.box(streakBox);
    String key = '$_streakKeyPrefix$activityKey';
    int? streakCount = box.get(key, defaultValue: 0) as int?;
    return streakCount ?? 0;
  }

  Future<void> resetStreak(String activityKey) async {
    var box = Hive.box(streakBox);
    String key = '$_streakKeyPrefix$activityKey';
    await box.put(key, 0);
  }

  // ---------------------------------------------------------------------------
  // LAST ACTIVE PATH
  // ---------------------------------------------------------------------------
  Future<void> saveLastActivePath(String pathId) async {
    loggingService.logWarning('[LocalStorageService] saveLastActivePath($pathId) called');
    var box = Hive.box(userPreferencesBox);
    box.put('lastActivePath', pathId);
    loggingService.logWarning('[LocalStorageService] saved lastActivePath=$pathId');
  }

  Future<String?> getLastActivePath() async {
    loggingService.logWarning('[LocalStorageService] getLastActivePath() called');
    var box = Hive.box(userPreferencesBox);
    final pathId = box.get('lastActivePath') as String?;
    loggingService.logWarning('[LocalStorageService] getLastActivePath() => $pathId');
    return pathId;
  }

  // ---------------------------------------------------------------------------
  // PATH PROGRESS
  // ---------------------------------------------------------------------------
  Future<void> savePathProgress(String pathId, double progress) async {
    final box = Hive.box(pathProgressBox);
    await box.put(pathId, progress);
    loggingService.logWarning(
      '[LocalStorageService] Saved path progress for "$pathId" => $progress%',
    );
  }

  Future<double> getPathProgress(String pathId) async {
    final box = Hive.box(pathProgressBox);
    final stored = box.get(pathId, defaultValue: 0.0);
    if (stored is double) {
      return stored;
    }
    return 0.0;
  }

  // ---------------------------------------------------------------------------
  // ADDED: DID SHOW LESSON ONE LOGIC
  // ---------------------------------------------------------------------------
  Future<void> setDidShowLessonOneImmediately(bool value) async {
    var box = Hive.box(userPreferencesBox);
    await box.put('didShowLessonOneImmediately', value);
    loggingService.logWarning(
      '[LocalStorageService] setDidShowLessonOneImmediately => $value',
    );
  }

  Future<bool> getDidShowLessonOneImmediately() async {
    var box = Hive.box(userPreferencesBox);
    final stored = box.get('didShowLessonOneImmediately', defaultValue: false);
    if (stored is bool) {
      return stored;
    }
    return false;
  }
}
