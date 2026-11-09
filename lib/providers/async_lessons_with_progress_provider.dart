// lib/providers/async_lessons_with_progress_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lesson_model.dart';
import '../providers/progress_service_provider.dart';
import '../providers/lesson_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

final asyncLessonsWithProgressProvider =
FutureProvider.autoDispose.family<List<Lesson>, String>((ref, pathId) async {
  final lessonService = ref.read(lessonServiceProviderRef);
  final progressService = ref.read(progressServiceProvider);

  // Updated: read ffLoggingServiceProvider
  final loggingService = ref.read(ffLoggingServiceProvider);

  final lessons = await lessonService.getLessonsByPathId(pathId);
  if (lessons.isEmpty) {
    loggingService.logInfo('[async_lessons_with_progress] No lessons found for path=$pathId');
    return [];
  }

  List<Lesson> result = [];
  for (final lesson in lessons) {
    try {
      final isValid = await lessonService.validateLesson(
        lessonId: lesson.id,
        surahId: lesson.surahId,
        pathId: pathId,
      );
      if (!isValid) {
        loggingService.logWarning('[async_lessons_with_progress] invalid lessonId=${lesson.id}');
        continue;
      }

      final pd = await progressService.getLessonProgress(lesson.id, pathId: pathId);
      int prg = pd['progress'] ?? 0;
      result.add(lesson.copyWith(progress: prg, currentStep: pd['currentStep'] ?? 0));
    } catch (e) {
      loggingService.logError('[async_lessons_with_progress] error for lessonId=${lesson.id}: $e');
      result.add(lesson);
    }
  }

  return result;
});
