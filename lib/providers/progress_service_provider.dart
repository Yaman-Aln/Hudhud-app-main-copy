// lib/providers/progress_service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/progress_service.dart';
import '../providers/local_storage_service_provider.dart';
import '../providers/lesson_service_provider.dart';
import '../providers/path_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

/// A Riverpod provider that instantiates ProgressService.
final progressServiceProvider = Provider<ProgressService>((ref) {
  final pathService = ref.read(pathServiceProviderRef);
  final localStorageService = ref.read(localStorageServiceProvider);
  final lessonService = ref.read(lessonServiceProviderRef);

  // Not specifically logging here, but we could read logger if needed:
  // final logger = ref.read(ffLoggingServiceProvider);

  return ProgressService(
    pathService: pathService,
    storageService: localStorageService,
    lessonService: lessonService,
  );
});
