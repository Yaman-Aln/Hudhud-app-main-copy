import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import 'onboarding_coordinator.dart';

// Import all the individual onboarding screens:
import 'screens/language_selection_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/hudhud_info_screen.dart';
import 'screens/name_entry_screen.dart';
import 'screens/goal_selection_screen.dart';
import 'screens/subscription_tier_screen.dart';
import 'screens/level_selection_screen.dart';
import 'screens/onboarding_completion_screen.dart';

// (NEW) Import your difficulty-choosing onboarding screen:
import 'screens/difficulty_choosing_screen.dart';

// Also import your model for enum references:
import '../z_onboarding/models/unique_test_model.dart';

// NEW: import your AnalyticsService provider
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

/// A widget that displays a multi-step onboarding flow based on the [OnboardingCoordinator].
/// Uses Riverpod's ConsumerStatefulWidget so we can read/watch [onboardingCoordinatorProvider].
class OnboardingFlow extends ConsumerStatefulWidget {
  final bool enableAnimations;

  const OnboardingFlow({
    Key? key,
    this.enableAnimations = true,
  }) : super(key: key);

  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  bool _didLogStart = false;

  @override
  void initState() {
    super.initState();
    debugPrint('OnboardingFlow: initState() called');

    // Instead of calling coordinator.initialize() here synchronously,
    // we queue it after build so it won't modify providers mid-build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('OnboardingFlow: addPostFrameCallback => ensuring coordinator.initialize()');
      final coordinator = ref.read(onboardingCoordinatorProvider);
      if (!coordinator.isInitialized) {
        debugPrint('OnboardingFlow: coordinator not initialized => calling initialize() now');
        coordinator.initialize();
      } else {
        debugPrint('OnboardingFlow: coordinator was already initialized');
      }

      // If we haven't already logged "onboarding_started", do so once.
      if (!_didLogStart) {
        _didLogStart = true;
        final analytics = ref.read(analyticsServiceProvider);
        debugPrint('OnboardingFlow: logging onboarding_started event');
        analytics.logEvent(
          'onboarding_started',
          parameters: {
            'source': 'direct', // or something relevant
          },
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('OnboardingFlow: didChangeDependencies() called');
  }

  @override
  void didUpdateWidget(covariant OnboardingFlow oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('OnboardingFlow: didUpdateWidget() called');
  }

  @override
  void dispose() {
    debugPrint('OnboardingFlow: dispose() called (Flow is being removed)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('OnboardingFlow: build() called');
    final coordinator = ref.watch(onboardingCoordinatorProvider);

    debugPrint('OnboardingFlow: coordinator.isInitialized => ${coordinator.isInitialized}');
    debugPrint('OnboardingFlow: coordinator.currentStepIndex => ${coordinator.currentStepIndex}');

    // Until [initialize()] is done, show a loading spinner.
    if (!coordinator.isInitialized) {
      debugPrint('OnboardingFlow: coordinator not initialized yet => showing spinner');
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Build content for the current step
    final stepContent = _buildStep(coordinator.currentStepIndex);

    return Scaffold(
      body: SafeArea(
        child: widget.enableAnimations
            ? AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Semantics(
            key: ValueKey<int>(coordinator.currentStepIndex),
            label: 'Onboarding step '
                '${coordinator.currentStepIndex + 1} of ${coordinator.totalSteps}.',
            child: stepContent,
          ),
        )
            : Semantics(
          label: 'Onboarding step '
              '${coordinator.currentStepIndex + 1} of ${coordinator.totalSteps}.',
          child: stepContent,
        ),
      ),
    );
  }

  /// Determines which screen to show based on [stepIndex].
  Widget _buildStep(int stepIndex) {
    debugPrint('OnboardingFlow: _buildStep() => stepIndex=$stepIndex');
    final coordinator = ref.read(onboardingCoordinatorProvider);

    // Log the user's current profile each time we build a step:
    final currentProfile = coordinator.userProfile;
    debugPrint('OnboardingFlow: current userProfile => $currentProfile');

    switch (stepIndex) {
      case 0: // Step 0: Language Selection
        return LanguageSelectionScreen(
          onNext: (Language selectedLanguage) {
            debugPrint(
              'OnboardingFlow: LanguageSelectionScreen.onNext => $selectedLanguage',
            );
            final updatedProfile = coordinator.userProfile.copyWith(
              languagePreference: selectedLanguage,
            );
            coordinator.updateUniqueTestModel(updatedProfile);
            coordinator.nextStep();
            debugPrint(
              'OnboardingFlow: Called nextStep(), new currentStepIndex => ${coordinator.currentStepIndex}',
            );
          },
          onSkip: () {
            debugPrint('OnboardingFlow: LanguageSelectionScreen.onSkip called');
            coordinator.skip();
          },
        );

      case 1: // Step 1: Welcome
        return WelcomeScreen(
          onNext: () {
            debugPrint('OnboardingFlow: WelcomeScreen.onNext called');
            coordinator.nextStep();
            debugPrint(
              'OnboardingFlow: Called nextStep(), new currentStepIndex => ${coordinator.currentStepIndex}',
            );
          },
          onSkip: () {
            debugPrint('OnboardingFlow: WelcomeScreen.onSkip called');
            coordinator.skip();
          },
        );

      case 2: // Step 2: Name Entry
        return NameEntryScreen(
          onNext: (String newName, String frequency) {
            debugPrint(
              'OnboardingFlow: NameEntryScreen.onNext => newName=$newName, freq=$frequency',
            );
            final updatedProfile = coordinator.userProfile.copyWith(
              name: newName,
              // The new field in UniqueTestModel
              notificationFrequency: frequency,
            );
            coordinator.updateUniqueTestModel(updatedProfile);
            coordinator.nextStep();
            debugPrint(
              'OnboardingFlow: Called nextStep(), new currentStepIndex => ${coordinator.currentStepIndex}',
            );
          },
        );

      case 3: // Step 3: Goal Selection
        return GoalSelectionScreen(
          onNext: (selectedGoals) {
            debugPrint(
              'OnboardingFlow: GoalSelectionScreen.onNext => $selectedGoals',
            );
            final updatedProfile =
            coordinator.userProfile.copyWith(goals: selectedGoals);
            coordinator.updateUniqueTestModel(updatedProfile);
            coordinator.nextStep();
            debugPrint(
              'OnboardingFlow: Called nextStep(), new currentStepIndex => ${coordinator.currentStepIndex}',
            );
          },
          onSkip: () {
            debugPrint('OnboardingFlow: GoalSelectionScreen.onSkip called');
            coordinator.skip();
          },
        );

      case 4: // Step 4: Subscription Tier
        return SubscriptionTierScreen(
          onNext: (tier) {
            debugPrint('OnboardingFlow: SubscriptionTierScreen.onNext => $tier');
            final updatedProfile = coordinator.userProfile.copyWith(
              subscriptionTier: tier,
            );
            coordinator.updateUniqueTestModel(updatedProfile);
            coordinator.nextStep();
            debugPrint(
              'OnboardingFlow: Called nextStep(), new currentStepIndex => ${coordinator.currentStepIndex}',
            );
          },
          onSkip: () {
            debugPrint('OnboardingFlow: SubscriptionTierScreen.onSkip called');
            coordinator.skip();
          },
        );

      case 5: // Step 5: Difficulty & Repeat Onboarding
        debugPrint('OnboardingFlow: Step 5 => DiffcultyChoosingScreen');
        return DiffcultyChoosingScreen(
          onSkip: () {
            debugPrint('OnboardingFlow: DiffcultyChoosingScreen.onSkip called');
            coordinator.skip();
          },
          // For example, if your screen calls onNext with (difficulty, repeat, audioRepeat).
          onNext: (diff, repeatCount) {
            debugPrint(
              'OnboardingFlow: DiffcultyChoosingScreen.onNext => difficulty=$diff, repeat=$repeatCount',
            );
            final updatedProfile = coordinator.userProfile.copyWith(
              defaultDifficulty: diff,
              defaultRepeatCount: repeatCount,
            );
            coordinator.updateUniqueTestModel(updatedProfile);
            coordinator.nextStep();
            debugPrint(
              'OnboardingFlow: Called nextStep(), new currentStepIndex => ${coordinator.currentStepIndex}',
            );
          },
        );

      default:
      // Step >=6 => Onboarding Completion
        debugPrint('OnboardingFlow: Step >=6 => show OnboardingCompletionScreen');
        return OnboardingCompletionScreen(
          onFinish: () {
            debugPrint('OnboardingFlow: OnboardingCompletionScreen.onFinish called');
            coordinator.completeOnboarding();
          },
        );
    }
  }
}
