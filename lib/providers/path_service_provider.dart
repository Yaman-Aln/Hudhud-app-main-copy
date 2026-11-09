// lib/providers/path_service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';

import '../services/path_service.dart';
import '../services/progress_service.dart';
import '../providers/progress_service_provider.dart';
import '../providers/lesson_service_provider.dart';
import '../providers/local_storage_service_provider.dart';
import '../services/lesson_service.dart' as lessonService;
import '../services/local_storage_service.dart';
import '../models/path_model.dart';
import '../models/lesson_model.dart'; // If you need the Lesson model
import '../providers/ff_logging_service_provider.dart';

/// A simple model combining a Path + progress + a validity boolean.
class PathWithProgress {
  final Path path;
  final double progress;
  final bool isValid;

  PathWithProgress({
    required this.path,
    required this.progress,
    required this.isValid,
  });
}

/// Provides a single instance of [PathService].
final pathServiceProviderRef = Provider<PathService>((ref) {
  final lessonSvc = ref.read(lessonServiceProviderRef);
  final localStorage = ref.read(localStorageServiceProvider);
  // Now read from ffLogging
  final logger = ref.read(ffLoggingServiceProvider);

  return PathService(
    ref: ref,
    lessonService: lessonSvc,
    localStorageService: localStorage,
    loggingService: logger,
  );
});

/// A Riverpod [FutureProvider] that loads *all* paths from memory,
/// calculates each path’s progress + validity, and returns them as a list
/// of [PathWithProgress].
final asyncPathsWithProgressProvider = FutureProvider<List<PathWithProgress>>((ref) async {
  final pathService = ref.read(pathServiceProviderRef);
  final progressService = ref.read(progressServiceProvider);
  final logger = ref.read(ffLoggingServiceProvider);

  logger.logInfo('[asyncPathsWithProgressProvider] Loading all paths...');

  // 1) Get all paths
  final allPaths = pathService.getAllPaths();
  if (allPaths.isEmpty) {
    logger.logWarning('[asyncPathsWithProgressProvider] No paths found.');
    return [];
  }

  // 2) For each path, check validity + progress
  final results = <PathWithProgress>[];
  for (final p in allPaths) {
    try {
      final valid = await pathService.isValidPath(p.id);

      double prog = 0.0;
      if (valid && p.tracksProgress) {
        prog = await progressService.getPathProgress(p.id);
      }

      results.add(PathWithProgress(path: p, progress: prog, isValid: valid));
      logger.logInfo('Loaded path=${p.id}, progress=$prog');
    } catch (e) {
      logger.logError('Error loading pathId=${p.id} => $e');
      results.add(PathWithProgress(path: p, progress: -1, isValid: false));
    }
  }

  logger.logInfo('[asyncPathsWithProgressProvider] Completed loading all paths.');
  return results;
});
