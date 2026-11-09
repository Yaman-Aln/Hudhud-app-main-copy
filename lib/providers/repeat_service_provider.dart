// Path: providers/repeat_service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/repeat_service.dart';
import '../providers/local_storage_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

final repeatServiceProvider = Provider<RepeatService>((ref) {
  final localStorageService = ref.read(localStorageServiceProvider);
  final loggingService = ref.read(ffLoggingServiceProvider);

  return RepeatService(
    localStorageService: localStorageService,
    loggingService: loggingService,
  );
});
