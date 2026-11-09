// lib/providers/lesson_service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/lesson_service.dart';
import '../providers/local_storage_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

/// A Riverpod provider for LessonService, using the name "lessonServiceProviderRef"
final lessonServiceProviderRef = Provider<LessonService>((ref) {
  final localStorageService = ref.read(localStorageServiceProvider);
  // Changed: read the new ffLoggingServiceProvider
  final loggingService = ref.read(ffLoggingServiceProvider);

  return LessonService(
    ref: ref,
    localStorageService: localStorageService,
    loggingService: loggingService,
  );
});
