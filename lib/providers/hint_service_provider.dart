// lib/providers/hint_service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/hint_service.dart';
import '../providers/ff_logging_service_provider.dart';

/// Provider for [HintService] to allow access across the app
final hintServiceProvider = Provider<HintService>((ref) {
  return HintService();
});

/// StateNotifier to handle hint level state and related actions
final hintLevelProvider = StateNotifierProvider<HintLevelNotifier, int>((ref) {
  return HintLevelNotifier(ref);
});

class HintLevelNotifier extends StateNotifier<int> {
  final HintService _hintService;
  final LoggingService _loggingService; // the logger

  HintLevelNotifier(Ref ref)
      : _hintService = ref.read(hintServiceProvider),
  // Unified: we read from ffLoggingServiceProvider
        _loggingService = ref.read(ffLoggingServiceProvider),
        super(0);

  // Getter for max hint level
  int get maxHintLevel => _hintService.maxHintLevel;

  // Method to increment hint level
  void incrementHintLevel() {
    state = _hintService.incrementHintLevel(state);
  }

  // Resets hint level to 0
  void resetHintLevel() {
    state = _hintService.resetHintLevel();
  }

  // Provides the current hint for a given word at the current hint level
  String getHint(String word) {
    final hint = _hintService.getHint(word, state);
    return hint;
  }

  // Removes hint by resetting the hint level
  void removeHint() {
    resetHintLevel();
    _loggingService.logInfo('Hint removed and level reset to $state');
  }
}
