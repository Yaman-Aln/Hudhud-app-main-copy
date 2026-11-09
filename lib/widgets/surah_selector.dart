import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;

// Localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Analytics provider
import '../providers/analytics_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

// For user language & quran service
import 'package:hudhud_quran_app_new/z_onboarding/providers/user_profile_provider.dart';
import '../services/quran_service.dart';

class SurahSelector extends ConsumerStatefulWidget {
  final Function(int) onSurahSelected;

  const SurahSelector({
    Key? key,
    required this.onSurahSelected,
  }) : super(key: key);

  @override
  ConsumerState<SurahSelector> createState() => _SurahSelectorState();
}

class _SurahSelectorState extends ConsumerState<SurahSelector> {
  int _selectedSurahId = 1;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);

    // Access your custom QuranService with user language logic
    final quranService = ref.read(quranServiceProvider);

    return Semantics(
      label: loc.surahSelectorSemanticLabel, // e.g. "Select a Surah"
      container: true,
      child: DropdownButton<int>(
        value: _selectedSurahId,
        items: List.generate(114, (index) {
          final surahId = index + 1;
          // Grab the user’s "preferred" surah name from QuranService:
          final surahName = quranService.getSurahNamePreferred(surahId);

          return DropdownMenuItem<int>(
            value: surahId,
            child: Text('$surahId. $surahName'),
          );
        }),
        onChanged: (value) {
          if (value == null) return;
          setState(() {
            _selectedSurahId = value;
          });

          // Log analytics event
          analytics.logEvent(
            'surah_selector_changed',
            parameters: {
              'selected_surah_id': value,
            },
          );

          // Possibly set user property
          analytics.setUserProperty(
            'last_selected_surah_id',
            value.toString(),
          );

          // Callback to parent screen
          widget.onSurahSelected(_selectedSurahId);
        },
      ),
    );
  }
}
