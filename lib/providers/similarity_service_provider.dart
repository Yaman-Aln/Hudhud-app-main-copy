import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../providers/ff_logging_service_provider.dart';
import '../services/similarity_service.dart';
import '../providers/ff_logging_service_provider.dart'; // for LoggingService

/// Provide a [SimilarityService] instance app-wide.
final similarityServiceProvider = Provider<SimilarityService>((ref) {
  final logger = ref.read(ffLoggingServiceProvider);
  return SimilarityService(loggingService: logger);
});

/// A StateNotifier to hold the current similarity score and manage updates.
final similarityScoreProvider = StateNotifierProvider<SimilarityNotifier, double>((ref) {
  return SimilarityNotifier(ref);
});

class SimilarityNotifier extends StateNotifier<double> {
  final SimilarityService _similarityService;
  final LoggingService _loggingService;

  SimilarityNotifier(Ref ref)
      : _similarityService = ref.read(similarityServiceProvider),
        _loggingService = ref.read(ffLoggingServiceProvider),
        super(1.0); // default similarity = 1.0

  /// Calculate and store a new similarity score in [state].
  void calculateAndSetSimilarity(String userInput, String correctAnswer) {
    try {
      _loggingService.logInfo(
        'Calculating similarity => user="$userInput", correct="$correctAnswer"',
      );
      final simScore = _similarityService.calculateSimilarity(userInput, correctAnswer);
      state = simScore;
      _loggingService.logInfo('Similarity updated => $simScore');
    } catch (e) {
      _loggingService.logError('Error => $e => falling back to 0.0');
      state = 0.0;
    }
  }

  /// Optional threshold-based logic (like "pass/fail").
  void calculateAdaptiveSimilarity(String userInput, String correctAnswer, {double threshold = 0.8}) {
    final sim = _similarityService.adaptiveSimilarity(userInput, correctAnswer, threshold: threshold);
    state = sim;
  }

  /// Retrieve a feedback color based on the current similarity [state].
  Color getFeedbackColor() {
    return _similarityService.getFeedbackColor(state);
  }

  /// Reset similarity score to 1.0 or any default.
  void resetSimilarityScore() {
    state = 1.0;
    _loggingService.logInfo('Similarity score reset => 1.0');
  }
}
