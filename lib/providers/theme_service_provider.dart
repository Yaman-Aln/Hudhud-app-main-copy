// lib/providers/theme_service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/theme_service.dart';
import '../providers/local_storage_service_provider.dart';
import '../providers/lesson_service_provider.dart';
import '../providers/path_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

/// The ThemeService provider, returning a singleton ThemeService instance.
final themeServiceProviderRef = Provider<ThemeService>((ref) {
  final localStorageService = ref.read(localStorageServiceProvider);
  final loggingService = ref.read(ffLoggingServiceProvider);
  final lessonService = ref.read(lessonServiceProviderRef);
  final pathService = ref.read(pathServiceProviderRef);

  // Provide the renamed AppStrings instance as the required 'strings' argument.
  return ThemeService(
    localStorageService: localStorageService,
    loggingService: loggingService,
    lessonService: lessonService,
    pathService: pathService,
    strings: AppStrings(),
  );
});

/// A FutureProvider that asynchronously initializes the system themes,
/// then returns the final list of ThemeDataQ items.
final asyncThemesProvider = FutureProvider((ref) async {
  final themeService = ref.read(themeServiceProviderRef);
  await themeService.initializeSystemThemes();
  return themeService.allThemes;
});
