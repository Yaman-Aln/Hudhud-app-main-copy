import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Analytics
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// Model & helper
import 'package:hudhud_quran_app_new/z_onboarding/models/unique_test_model.dart';
import 'package:hudhud_quran_app_new/providers/language_helper.dart';

// NEW: localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

/// A screen for selecting one of the supported [Language] options.
/// [onNext] is called with the selected [Language].
/// [onSkip] if user wants to skip choosing a language.
class LanguageSelectionScreen extends ConsumerStatefulWidget {
  final VoidCallback onSkip;
  final ValueChanged<Language> onNext;

  const LanguageSelectionScreen({
    Key? key,
    required this.onSkip,
    required this.onNext,
  }) : super(key: key);

  @override
  ConsumerState<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends ConsumerState<LanguageSelectionScreen> {
  Language _selectedLanguage = Language.english;

  @override
  void initState() {
    super.initState();

    // 1) Log "language_selection_screen_viewed"
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('language_selection_screen_viewed');

    // (Optionally) read userProfile or cached preference here if needed.
    // e.g.: _selectedLanguage = userProfile.languagePreference;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // localizations
    final analytics = ref.read(analyticsServiceProvider);

    // Build a map {Language => localized name}. For simplicity,
    // we could rely on an existing function, or do a small manual map.
    final languageMap = getLanguageDisplayMap(); // from language_helper

    return Semantics(
      label: loc.languageSelectionScreenSemantic, // e.g. "Language Selection Screen"
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            loc.languageSelectionTitle, // "Select Your Language"
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[50],
          leading: Semantics(
            label: loc.languageSelectionBackSemantic, // e.g. "Back"
            button: true,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // If user wants to go back, we can do a standard pop or call onSkip
                // For demonstration, let's just pop.
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: [
            Semantics(
              label: loc.languageSelectionSkipSemantic, // e.g. "Skip selection"
              button: true,
              child: TextButton(
                onPressed: () {
                  // Log "language_selection_skipped"
                  analytics.logEvent('language_selection_skipped');
                  widget.onSkip();
                },
                child: Text(
                  loc.skipLabel, // "Skip"
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                loc.languageSelectionInstructions, // "Please choose your preferred language:"
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // Dropdown for all Language enum values
              DropdownButton<Language>(
                value: _selectedLanguage,
                isExpanded: true,
                items: Language.values.map((lang) {
                  final label = languageMap[lang] ?? lang.name;
                  return DropdownMenuItem<Language>(
                    value: lang,
                    child: Text(label, style: const TextStyle(fontSize: 16)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue == null) return;
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                },
              ),

              const SizedBox(height: 40),
              Semantics(
                label: loc.languageSelectionNextSemantic, // e.g. "Tap to confirm language choice"
                button: true,
                child: ElevatedButton(
                  onPressed: () {
                    // Log "language_selection_next"
                    analytics.logEvent('language_selection_next', parameters: {
                      'selected_language': _selectedLanguage.name,
                    });
                    widget.onNext(_selectedLanguage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                    foregroundColor: Colors.black,
                  ),
                  child: Text(loc.languageSelectionNextLabel), // e.g. "Next"
                ),
              ),

              const SizedBox(height: 40),

              // The hudhud_quran.png at the bottom for a welcoming feel
              Semantics(
                label: loc.languageSelectionImageSemantic, // e.g. "Hudhud Quran illustration"
                image: true,
                child: Image.asset(
                  'assets/icons/hudhud_quran.png',
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
