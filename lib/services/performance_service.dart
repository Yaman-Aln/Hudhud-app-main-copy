// lib/services/performance_service.dart

import 'package:flutter/foundation.dart';
import '../providers/ff_logging_service_provider.dart';


class PerformanceService {
  // Example method to measure execution time
  Future<T> measureExecutionTime<T>(Future<T> Function() function, String description) async {
    final Stopwatch stopwatch = Stopwatch()..start();
    T result = await function();
    stopwatch.stop();
    if (kDebugMode) {
      print('$description executed in ${stopwatch.elapsedMilliseconds} ms');
    }
    return result;
  }
}
