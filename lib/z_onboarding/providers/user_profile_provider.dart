// lib/z_onboarding/providers/user_profile_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import '../models/unique_test_model.dart';
import '../../../models/difficulty_level_model.dart';
import '../services/user_preferences_manager.dart';

/// A [StateNotifier] that manages the user's [UniqueTestModel].
/// We load from local storage on init, store in [state], and provide methods to update the profile.
class UserProfileNotifier extends StateNotifier<UniqueTestModel> {
  /// Whether we have finished loading from Hive/Preferences
  bool _hasLoadedFromHive = false;
  bool get hasLoadedFromHive => _hasLoadedFromHive;

  UserProfileNotifier() : super(UniqueTestModel()) {
    debugPrint('UserProfileNotifier: constructor called');
    _init();
  }

  final _prefsManager = UserPreferencesManager.instance;

  /// Load from local storage on startup
  Future<void> _init() async {
    debugPrint('UserProfileNotifier: _init() called');
    try {
      final loaded = await _prefsManager.loadUniqueTestModel();
      debugPrint('UserProfileNotifier: loaded profile => $loaded');
      state = loaded;
    } catch (e) {
      debugPrint('UserProfileNotifier: Error loading user profile => $e');
      // Fallback to default
      state = UniqueTestModel();
    }

    // Mark that we're done loading and force watchers to rebuild
    _hasLoadedFromHive = true;
    // This "copyWith()" returns a new UniqueTestModel => triggers a rebuild
    state = state.copyWith();
  }

  /// Persist the updated [UniqueTestModel] to local storage
  Future<void> _saveProfile(UniqueTestModel updated) async {
    debugPrint('UserProfileNotifier: _saveProfile() => $updated');
    try {
      await _prefsManager.saveUniqueTestModel(updated);
    } catch (e) {
      debugPrint('UserProfileNotifier: Error saving user profile => $e');
    }
  }

  /// "Replace" the entire model with a new one
  Future<void> replaceModel(UniqueTestModel newModel) async {
    debugPrint('UserProfileNotifier: replaceModel() => $newModel');
    state = newModel;
    await _saveProfile(newModel);
  }

  /// Update the user's name
  Future<void> updateName(String newName) async {
    debugPrint('UserProfileNotifier: updateName() => $newName');
    final updated = state.copyWith(name: newName);
    state = updated;
    await _saveProfile(updated);
  }

  /// Update the user's preferred language
  Future<void> updateLanguage(Language newLang) async {
    debugPrint('UserProfileNotifier: updateLanguage() => $newLang');
    final updated = state.copyWith(languagePreference: newLang);
    state = updated;
    await _saveProfile(updated);
  }

  /// Update the user's subscription tier
  Future<void> updateSubscriptionTier(SubscriptionTier newTier) async {
    debugPrint('UserProfileNotifier: updateSubscriptionTier() => $newTier');
    final updated = state.copyWith(subscriptionTier: newTier);
    state = updated;
    await _saveProfile(updated);
  }

  /// Update the user's reciter (1, 2, or 3)
  Future<void> updateReciter(int reciterId) async {
    debugPrint('UserProfileNotifier: updateReciter() => $reciterId');
    final updated = state.copyWith(reciterId: reciterId);
    state = updated;
    await _saveProfile(updated);
  }

  /// Update the user's chosen font family & weight
  Future<void> updateFontSelection(String family, int weight) async {
    debugPrint('UserProfileNotifier: updateFontSelection() => family:$family, weight:$weight');
    final updated = state.copyWith(fontFamily: family, fontWeight: weight);
    state = updated;
    await _saveProfile(updated);
  }

  /// Mark the user as having completed onboarding
  Future<void> markOnboardingComplete() async {
    debugPrint('UserProfileNotifier: markOnboardingComplete() called');
    final updated = state.copyWith(onboardingComplete: true);
    state = updated;
    await _saveProfile(updated);
  }

  /// Update the user's notification frequency (e.g., "Daily", "Weekly", or "None")
  Future<void> updateNotificationFrequency(String freq) async {
    debugPrint('UserProfileNotifier: updateNotificationFrequency() => $freq');
    final updated = state.copyWith(notificationFrequency: freq);
    state = updated;
    await _saveProfile(updated);
  }

  // --------------------------------------------------------------------------
  // Difficulty & Repeat settings
  // --------------------------------------------------------------------------
  Future<void> updateDefaultDifficulty(DifficultyLevel difficulty) async {
    debugPrint('UserProfileNotifier: updateDefaultDifficulty() => $difficulty');
    final updated = state.copyWith(defaultDifficulty: difficulty);
    state = updated;
    await _saveProfile(updated);
  }

  Future<void> updateDefaultRepeatCount(int repeatCount) async {
    debugPrint('UserProfileNotifier: updateDefaultRepeatCount() => $repeatCount');
    final updated = state.copyWith(defaultRepeatCount: repeatCount);
    state = updated;
    await _saveProfile(updated);
  }

  Future<void> updateDefaultAudioRepeat(int audioRepeat) async {
    debugPrint('UserProfileNotifier: updateDefaultAudioRepeat() => $audioRepeat');
    final updated = state.copyWith(defaultAudioRepeat: audioRepeat);
    state = updated;
    await _saveProfile(updated);
  }

  // --------------------------------------------------------------------------
  //  Helper Method for PurchaseService -> sets SubscriptionTier
  // --------------------------------------------------------------------------
  Future<void> setSubscriptionFromPurchase(String productId) async {
    debugPrint('UserProfileNotifier: setSubscriptionFromPurchase => $productId');

    // If a "premium" product (plus_monthly_1, plus_yearly_1)
    if (productId == 'plus_monthly_1' ||
        productId == 'plus_yearly_1' ||
        productId == 'my_premium_yearly') {
      final updated = state.copyWith(subscriptionTier: SubscriptionTier.premium);
      state = updated;
      await _saveProfile(updated);
    }
    // If a "premiumPlus" product (pro_monthly_1, pro_yearly_1)
    else if (productId == 'pro_monthly_1' || productId == 'pro_yearly_1') {
      final updated = state.copyWith(subscriptionTier: SubscriptionTier.premiumPlus);
      state = updated;
      await _saveProfile(updated);
    } else {
      debugPrint('UserProfileNotifier: Unrecognized productId=$productId, no change.');
    }
  }
}

/// Global provider for user profile data
final userProfileProvider =
StateNotifierProvider<UserProfileNotifier, UniqueTestModel>(
        (ref) => UserProfileNotifier());

/// Returns `true` if userProfile.onboardingComplete is true
final onboardingCheckProvider = Provider<bool>((ref) {
  final profile = ref.watch(userProfileProvider);
  final result = profile.onboardingComplete;
  debugPrint('onboardingCheckProvider => $result (profile=$profile)');
  return result;
});
