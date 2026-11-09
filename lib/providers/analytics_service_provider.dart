import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/analytics_service.dart';

/// A Riverpod provider for the AnalyticsService.
/// We'll override this in main() with the actual instance.
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  throw UnimplementedError('analyticsServiceProvider has not been overridden yet.');
});
