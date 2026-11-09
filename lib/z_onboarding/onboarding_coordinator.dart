import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show debugPrint;

// Adjust imports to your actual paths:
import 'models/unique_test_model.dart';
import 'services/user_preferences_manager.dart';
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// Import user_profile_provider to mark onboarding complete
import '../z_onboarding/providers/user_profile_provider.dart';

/// A [ChangeNotifier] that orchestrates the multi-step onboarding flow,
/// logs analytics, and delegates user data changes to [user_profile_provider].
class OnboardingCoordinator extends ChangeNotifier {
  /// The total number of steps in your onboarding flow.
  final int totalSteps;

  /// The current onboarding step index (0-based).
  int currentStepIndex = 0;

  /// Whether we've done any needed initialization (like loading).
  bool isInitialized = false;

  /// A Riverpod Ref, giving access to analytics, user_profile_provider, etc.
  final Ref _ref;

  /// Constructor
  OnboardingCoordinator({
    required this.totalSteps,
    required Ref ref,
    UserPreferencesManager? preferencesManager, // not used anymore, but left for reference
  }) : _ref = ref {
    debugPrint(
      'OnboardingCoordinator: constructor called => totalSteps=$totalSteps',
    );
  }

  /// Called from OnboardingFlow (initState) or main.dart to load data if needed.
  Future<void> initialize() async {
    debugPrint('OnboardingCoordinator: initialize() called');
    // If you want to ensure user_profile_provider is loaded from Hive, just read it:
    _ref.read(userProfileProvider);

    currentStepIndex = 0;
    isInitialized = true;
    debugPrint('OnboardingCoordinator: isInitialized set to true, currentStepIndex=0');
    notifyListeners();
  }

  /// A getter so screens can do `coordinator.userProfile`.
  /// This reads the current state from user_profile_provider.
  UniqueTestModel get userProfile => _ref.read(userProfileProvider);

  /// A bridging method so screens can do `coordinator.updateUniqueTestModel(updatedProfile)`.
  /// It calls into [userProfileProvider.notifier] to store the changes.
  void updateUniqueTestModel(UniqueTestModel updated) {
    debugPrint('OnboardingCoordinator: updateUniqueTestModel() => $updated');
    _ref.read(userProfileProvider.notifier).replaceModel(updated);
  }

  /// Moves to next step or completes onboarding if we're at the last step.
  void nextStep() {
    debugPrint('OnboardingCoordinator: nextStep() from currentStepIndex=$currentStepIndex');
    if (currentStepIndex < totalSteps - 1) {
      currentStepIndex++;
      debugPrint('OnboardingCoordinator: advanced to stepIndex=$currentStepIndex');
    } else {
      debugPrint('OnboardingCoordinator: last step reached => calling completeOnboarding()');
      completeOnboarding();
      return;
    }
    notifyListeners();
  }

  /// Skips all remaining steps => calls [completeOnboarding].
  void skip() {
    debugPrint('OnboardingCoordinator: skip() at stepIndex=$currentStepIndex');
    // Log skip event
    _ref.read(analyticsServiceProvider).logEvent(
      'onboarding_skipped',
      parameters: {
        'skipped_at_step': currentStepIndex,
      },
    );
    completeOnboarding();
  }

  /// Marks onboarding as complete => calls user_profile_provider to set
  /// `onboardingComplete=true`, logs analytics, and invalidates watchers
  /// so main.dart sees the updated status.
  void completeOnboarding() {
    debugPrint('OnboardingCoordinator: completeOnboarding() called');
    // 1) Mark the user as having completed onboarding in user_profile_provider
    _ref.read(userProfileProvider.notifier).markOnboardingComplete();

    // 2) Log analytics
    _ref.read(analyticsServiceProvider).logEvent(
      'onboarding_completed',
      parameters: {
        'total_steps': totalSteps,
      },
    );

    // 3) Invalidate watchers if main.dart uses onboardingCheckProvider
    debugPrint('OnboardingCoordinator: invalidating onboardingCheckProvider');
    _ref.invalidate(onboardingCheckProvider);

    // 4) Optionally set currentStepIndex to final
    currentStepIndex = totalSteps;
    debugPrint('OnboardingCoordinator: currentStepIndex set to $currentStepIndex (done)');

    notifyListeners();
  }
}

/// A [ChangeNotifierProvider] for [OnboardingCoordinator].
final onboardingCoordinatorProvider =
ChangeNotifierProvider<OnboardingCoordinator>((ref) {
  return OnboardingCoordinator(
    totalSteps: 10, // Adjust as needed
    ref: ref,
  );
});
