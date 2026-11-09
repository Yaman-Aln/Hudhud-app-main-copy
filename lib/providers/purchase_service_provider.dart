// providers/purchase_service_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hudhud_quran_app_new/services/purchase_service.dart';
import 'package:hudhud_quran_app_new/providers/ff_logging_service_provider.dart';

final purchaseServiceProvider = Provider<PurchaseService>((ref) {
  final logging = ref.read(ffLoggingServiceProvider);
  // The PurchaseService is the constructor-based version from your snippet
  return PurchaseService(loggingService: logging, ref: ref);
});
