import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_storage_service.dart';
import '../providers/ff_logging_service_provider.dart';

// Define LocalStorageService provider using Riverpod
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  // Changed: we read ffLoggingServiceProvider
  final loggingService = ref.read(ffLoggingServiceProvider);

  // Return an instance of LocalStorageService with the LoggingService injected
  return LocalStorageService(loggingService: loggingService);
});
