// lib/services/path_service.dart

import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/path_model.dart';
import '../models/lesson_model.dart';
import '../services/local_storage_service.dart';
import 'lesson_service.dart' as lesson;
import '../providers/ff_logging_service_provider.dart';

/// A service that manages both system-defined and user-created [Path] objects.
class PathService {
  final Ref ref;
  final lesson.LessonService lessonService;
  final LocalStorageService localStorageService;
  final LoggingService loggingService;

  // In-memory storage for system (predefined) paths
  final List<Path> _paths = [];

  // In-memory storage for user-created paths
  final List<Path> _userPaths = [];

  PathService({
    required this.ref,
    required this.lessonService,
    required this.localStorageService,
    required this.loggingService,
  });

  // --------------------------------------------------------------------------
  // GETTERS
  // --------------------------------------------------------------------------

  /// Returns *both* system and user paths in memory.
  List<Path> getAllPaths() {
    loggingService.logWarning('[PathService] getAllPaths() called.');
    return [..._paths, ..._userPaths];
  }

  /// Retrieve a path by its [pathId]. Checks system paths first, then user paths.
  Path? getPathById(String pathId) {
    loggingService.logWarning('[PathService] getPathById($pathId) -> Attempting retrieval');

    // 1) Check system-defined
    final sysMatch = _paths.where((p) => p.id == pathId);
    if (sysMatch.isNotEmpty) {
      loggingService.logWarning('[PathService] Found pathId=$pathId in system paths.');
      return sysMatch.first;
    }

    // 2) Check user-defined
    final userMatch = _userPaths.where((p) => p.id == pathId);
    if (userMatch.isNotEmpty) {
      loggingService.logWarning('[PathService] Found pathId=$pathId in user paths.');
      return userMatch.first;
    }

    loggingService.logWarning('[PathService] getPathById($pathId) -> NOT found in memory.');
    return null;
  }

  /// Filter by [themeId] in both system & user paths.
  List<Path> getPathsByThemeId(String themeId) {
    loggingService.logWarning('[PathService] getPathsByThemeId($themeId) -> filtering by themeIds');
    final allPaths = getAllPaths();
    final filtered = allPaths.where((p) => p.themeIds.contains(themeId)).toList();
    loggingService.logWarning('[PathService] getPathsByThemeId($themeId) -> found ${filtered.length} paths.');
    return filtered;
  }

  /// Return a list of pathIds that contain the given [lessonId].
  List<String> getPathsContainingLesson(String lessonId) {
    loggingService.logWarning('[PathService] getPathsContainingLesson($lessonId)');
    final pathIds = <String>[];

    // Check system-defined
    for (final p in _paths) {
      if (p.lessons.any((ls) => ls.id == lessonId)) {
        pathIds.add(p.id);
      }
    }

    // Check user-defined
    for (final p in _userPaths) {
      if (p.lessons.any((ls) => ls.id == lessonId)) {
        pathIds.add(p.id);
      }
    }

    loggingService.logWarning('[PathService] getPathsContainingLesson($lessonId) -> Found ${pathIds.length} matching paths.');
    return pathIds;
  }

  // --------------------------------------------------------------------------
  // NEW: Searching by Surah
  // --------------------------------------------------------------------------

  /// Returns all paths (system or user) that have at least one lesson with [surahId].
  List<Path> findPathsBySurahId(int surahId) {
    loggingService.logWarning('[PathService] findPathsBySurahId($surahId) => searching memory');
    final all = getAllPaths();
    final matching = <Path>[];
    for (final path in all) {
      if (path.lessons.any((ls) => ls.surahId == surahId)) {
        matching.add(path);
      }
    }
    loggingService.logWarning('[PathService] findPathsBySurahId($surahId) => found ${matching.length} matches');
    return matching;
  }

  /// Returns a single path that exactly matches [surahId] and optionally [startAyah..endAyah].
  /// If no path is found or if range doesn't match any existing path, returns null.
  Path? findPathBySurahRange(int surahId, {int? startAyah, int? endAyah}) {
    loggingService.logWarning('[PathService] findPathBySurahRange(surah=$surahId, start=$startAyah, end=$endAyah)');
    for (final path in getAllPaths()) {
      if (path.lessons.isEmpty) {
        continue;
      }
      // We'll assume all lessons in a path are from the same surah range,
      // or at least check the first & last lesson for matching surah & range.
      final firstLesson = path.lessons.first;
      final lastLesson = path.lessons.last;

      // Confirm both the first & last lesson have the same surah as required
      if (firstLesson.surahId == surahId && lastLesson.surahId == surahId) {
        if (startAyah == null || endAyah == null) {
          // If user didn't specify range, we treat 'surah match' as good enough
          return path;
        } else {
          // If range is specified, check if it matches exactly
          if (firstLesson.startAyah == startAyah && lastLesson.endAyah == endAyah) {
            return path;
          }
        }
      }
    }
    loggingService.logWarning('[PathService] findPathBySurahRange => no exact match found.');
    return null;
  }

  // --------------------------------------------------------------------------
  // INITIALIZATION
  // --------------------------------------------------------------------------

  /// Called on startup to load system paths (if any) + user paths from disk.
  Future<void> initializePredefinedPaths() async {
    try {
      loggingService.logWarning('[PathService] initializePredefinedPaths -> Start');

      // ------------------------------------------------------------------
      // 1) Generate lessons for Surah Fatiha
      // ------------------------------------------------------------------
      final newLessons = await lessonService.generateLessons(
        1,
        1, // or 2, or any chunk size you want
        startAyah: 1,
        endAyah: 7,
        pathId: 'path_fatihah',
        themeIds: ['theme_core_recitation'], // <-- added here
      );

      // (Optional) If you need to be able to retrieve these lessons from Hive,
      // store them in localStorage as well:
      for (final ls in newLessons) {
        await localStorageService.saveLesson(ls);
      }

      // ------------------------------------------------------------------
      // 2) Create a system path for Al-Fatiha
      // ------------------------------------------------------------------
      final fatihaPath = Path(
        id: 'path_fatihah',
        name: 'Surah Al-Fatiha',
        description: 'Surah Fatiha path for new users',
        lessons: newLessons,
        themeIds: ['theme_core_recitation'],
        tracksProgress: true,
        currentStep: 0,
        isUserGenerated: false,
      );

      // ------------------------------------------------------------------
      // 3) Add the system path to the in-memory _paths list
      // ------------------------------------------------------------------
      await addPredefinedPath(fatihaPath);

      // ------------------------------------------------------------------
      // 4) Load all user-defined paths from local storage
      // ------------------------------------------------------------------
      await loadUserPaths();

      loggingService.logWarning('[PathService] done loading user + system paths.');
    } catch (e, stackTrace) {
      loggingService.logWarning('[PathService] initializePredefinedPaths -> ERROR: $e\n$stackTrace');
    }
  }

  // --------------------------------------------------------------------------
  // ADD / UPDATE / REMOVE PATHS
  // --------------------------------------------------------------------------

  /// Add a system path in memory. DOES NOT compute total steps automatically.
  Future<void> addPredefinedPath(Path newPath) async {
    loggingService.logWarning('[PathService] addPredefinedPath -> pathId=${newPath.id}');

    final existing = getPathById(newPath.id);
    if (existing != null) {
      loggingService.logWarning('[PathService] addPredefinedPath -> pathId=${newPath.id} already exists => skip');
      return;
    }

    _paths.add(newPath);
    loggingService.logWarning('[PathService] added system path => ${newPath.id}, totalSteps=${newPath.totalSteps}');
  }

  /// Add a user path (does not re-compute total steps automatically).
  /// Saves the single path individually in local storage.
  Future<void> addUserPath(Path newUserPath) async {
    loggingService.logWarning('[PathService] addUserPath -> pathId=${newUserPath.id}');

    if (newUserPath.id.isEmpty) {
      loggingService.logWarning('[PathService] addUserPath -> Error: missing pathId');
      return;
    }

    try {
      // 1) Save each lesson in local storage (if needed)
      for (final ls in newUserPath.lessons) {
        await localStorageService.saveLesson(ls);
        loggingService.logWarning('[PathService] addUserPath -> saved lessonId=${ls.id}');
      }

      // 2) Add to in-memory list
      _userPaths.add(newUserPath);

      // 3) Persist just this single path to disk
      await localStorageService.saveUserPath(newUserPath);

      loggingService.logWarning('[PathService] added user path => ${newUserPath.id}');
    } catch (e) {
      loggingService.logWarning('[PathService] addUserPath -> ERROR: $e');
    }
  }

  /// Update an existing path. Only overwrites that one path in local storage if it is user-generated.
  Future<void> updatePath(Path updatedPath) async {
    loggingService.logWarning('[PathService] updatePath -> pathId=${updatedPath.id}');

    // Check if it was system-defined
    final idxSys = _paths.indexWhere((p) => p.id == updatedPath.id);
    if (idxSys != -1) {
      _paths[idxSys] = updatedPath;
      loggingService.logWarning('[PathService] updated system path => ${updatedPath.id}');
      // System paths are not stored in local storage (by design).
      return;
    }

    // Otherwise, check user
    final idxUser = _userPaths.indexWhere((p) => p.id == updatedPath.id);
    if (idxUser != -1) {
      _userPaths[idxUser] = updatedPath;

      // Save only this single path
      await localStorageService.saveUserPath(updatedPath);

      loggingService.logWarning('[PathService] updated user path => ${updatedPath.id}');
      return;
    }

    loggingService.logWarning('[PathService] path not found => ${updatedPath.id}');
  }

  /// Remove a user path from in-memory and from local storage.
  Future<void> removeUserPath(String pathId) async {
    loggingService.logWarning('[PathService] removeUserPath($pathId)');
    _userPaths.removeWhere((p) => p.id == pathId);
    await localStorageService.removeUserPath(pathId);
  }

  /// Clear out both system and user paths in memory
  Future<void> resetPaths() async {
    loggingService.logWarning('[PathService] resetPaths -> clearing all in-memory paths');
    _paths.clear();
    _userPaths.clear();
  }

  // --------------------------------------------------------------------------
  // SAVE / LOAD USER PATHS
  // --------------------------------------------------------------------------

  /// Loads user-defined paths individually from local storage and populates _userPaths.
  Future<void> loadUserPaths() async {
    loggingService.logWarning('[PathService] loadUserPaths -> start');
    _userPaths.clear();

    // 1) MIGRATION STEP: if there is an old "paths" array, we import it and remove it
    final migratedCount = await localStorageService.migrateOldArrayPathsIfAny();
    if (migratedCount > 0) {
      loggingService.logWarning('[PathService] loadUserPaths -> migrated $migratedCount old array-based paths to single entries.');
    }

    // 2) Now load all single stored paths
    final loaded = await localStorageService.getUserPaths();
    _userPaths.addAll(loaded);
    loggingService.logWarning('[PathService] loadUserPaths -> loaded ${loaded.length} user paths (single-path entries).');
  }

  // --------------------------------------------------------------------------
  // PROGRESS / STEPS
  // --------------------------------------------------------------------------

  /// Recompute total steps for a path by summing each lesson's steps.
  Future<int> calculateTotalStepsForPath(List<String> lessonIds, String pathId) async {
    loggingService.logWarning('[PathService] calculateTotalStepsForPath($lessonIds, path=$pathId)');
    int total = 0;
    for (final lessonId in lessonIds) {
      final steps = await lessonService.getTotalStepsForLesson(lessonId, pathId);
      total += steps;
      loggingService.logWarning('[PathService] Lesson $lessonId -> $steps steps');
    }
    loggingService.logWarning('[PathService] totalSteps => $total for path=$pathId');
    return total;
  }

  // --------------------------------------------------------------------------
  // VALIDATION
  // --------------------------------------------------------------------------

  /// Checks if a path exists. If not in memory, tries to load from disk.
  /// Then if found but has 0 lessons, calls it "valid" (0 steps).
  /// If it has lessons, each lesson is validated in [lessonService].
  Future<bool> isValidPath(String pathId) async {
    loggingService.logWarning('[PathService] isValidPath($pathId)');

    // 1) Try in-memory first
    var path = getPathById(pathId);
    if (path == null) {
      // 2) Attempt to load from local storage (if user path was never loaded)
      final loadedPath = await localStorageService.getPathById(pathId);
      if (loadedPath != null) {
        loggingService.logWarning('[PathService] isValidPath($pathId) -> loaded from disk, adding as user path.');
        await addUserPath(loadedPath); // adds to _userPaths
        path = loadedPath;
      }
    }

    // 3) If still null => invalid
    if (path == null) {
      loggingService.logWarning('Path $pathId not found => invalid');
      return false;
    }

    // 4) If no lessons => treat it as valid (0 steps).
    if (path.lessons.isEmpty) {
      loggingService.logWarning('Path $pathId has no lessons => calling it valid (0 steps).');
      return true;
    }

    // 5) Validate each lesson
    for (final ls in path.lessons) {
      final ok = await lessonService.validateLesson(
        lessonId: ls.id,
        surahId: ls.surahId,
        pathId: pathId,
      );
      if (!ok) {
        loggingService.logWarning('[PathService] lessonId=${ls.id} is invalid => path=$pathId not valid');
        return false;
      }
    }
    loggingService.logWarning('[PathService] pathId=$pathId is valid (has lessons).');
    return true;
  }

  /// Example helper if you want to fetch the “active path” from local storage
  Future<Path?> getActivePath() async {
    // A possible implementation:
    // final lastActivePathId = await localStorageService.getLastActivePath();
    // if (lastActivePathId != null) return getPathById(lastActivePathId);
    return null;
  }
}
