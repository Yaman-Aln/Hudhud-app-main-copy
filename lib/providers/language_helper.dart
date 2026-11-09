import '../z_onboarding/models/unique_test_model.dart';

/// Map each [Language] to a user-facing string in the native script.
Map<Language, String> getLanguageDisplayMap() {
  return {
    Language.english: 'English',
    Language.arabic: 'العربية',
    Language.french: 'Français',
    Language.malaysian: 'Bahasa Melayu',
    Language.indonesian: 'Bahasa Indonesia',
    Language.spanish: 'Español',
    Language.urdu: 'اردو',
    Language.farsi: 'فارسی',
    // NEW:
    Language.turkish: 'Türkçe',
  };
}
