import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/quran_distractor_service.dart';

/// A global Riverpod provider returning a (blank) QuranDistractorService.
/// We'll override it in main.dart with a fully loaded instance.
final quranDistractorServiceProvider = Provider<QuranDistractorService>((ref) {
  return QuranDistractorService();
});

/// Optional FutureProvider for async init if you want it.
/// Right now it's empty, but you can expand it if needed.
final distractorInitProvider = FutureProvider<void>((ref) async {
  // Example: if you had some method you needed to call:
  // await ref.read(quranDistractorServiceProvider).init();
});
