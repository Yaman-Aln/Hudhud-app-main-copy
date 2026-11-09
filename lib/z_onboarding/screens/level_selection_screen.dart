/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1) Import your generated localization class
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Import analytics provider to log events
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

import '../models/unique_test_model.dart';

/// A screen allowing the user to pick their self-assessed [Level].
/// [onNext] is called with the chosen level.
/// [onSkip] is invoked if the user taps the skip button.
class LevelSelectionScreen extends ConsumerStatefulWidget {
  final ValueChanged<Level> onNext;
  final VoidCallback onSkip;

  const LevelSelectionScreen({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  ConsumerState<LevelSelectionScreen> createState() =>
      _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends ConsumerState<LevelSelectionScreen> {
  /// Tracks which level is currently selected. Defaults to [Level.starter].
  Level _selectedLevel = Level.starter;

  @override
  Widget build(BuildContext context) {
    final analytics = ref.read(analyticsServiceProvider);
    final loc = AppLocalizations.of(context)!;

    // 1) Log "viewed" event
    analytics.logEvent('level_selection_screen_viewed');

    return Semantics(
      // Localized semantics for the entire screen
      label: loc.levelSelectionScreenSemantic,
      child: Scaffold(
        appBar: AppBar(
          // Localized title
          title: Text(loc.levelSelectionScreenAppBarTitle),
          actions: [
            Semantics(
              // Localized skip semantics
              label: loc.levelSelectionScreenSkipSemantic,
              button: true,
              child: TextButton(
                onPressed: () {
                  // 2) If user skips
                  analytics.logEvent('level_selection_skipped');
                  widget.onSkip();
                },
                // Reuse the generic skip label from ARB
                child: Text(
                  loc.skipLabel,
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
              // Intro text
              Text(
                loc.levelSelectionScreenIntroText,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // Starter
              _buildOptionTile(
                level: Level.starter,
                title: loc.levelStarterLabel,
                description: loc.levelStarterDescription,
              ),
              const SizedBox(height: 8),

              // Advanced
              _buildOptionTile(
                level: Level.advanced,
                title: loc.levelAdvancedLabel,
                description: loc.levelAdvancedDescription,
              ),
              const SizedBox(height: 8),

              // Qari
              _buildOptionTile(
                level: Level.qari,
                title: loc.levelQariLabel,
                description: loc.levelQariDescription,
              ),

              const SizedBox(height: 40),

              // Next Button
              Semantics(
                button: true,
                // Localized semantics label
                label: loc.levelSelectionNextSemantic,
                child: ElevatedButton(
                  onPressed: () {
                    // 3) When user confirms
                    analytics.logEvent(
                      'level_selection_next',
                      parameters: {
                        'selected_level': _selectedLevel.name,
                      },
                    );
                    widget.onNext(_selectedLevel);
                  },
                  // Localized text
                  child: Text(loc.levelSelectionNextLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a reusable tile for each level option.
  Widget _buildOptionTile({
    required Level level,
    required String title,
    required String description,
  }) {
    final isSelected = _selectedLevel == level;
    final loc = AppLocalizations.of(context)!;

    return Semantics(
      // Localized dynamic semantics for each radio tile
      label: loc.levelSelectionTileSemantic(title),
      hint: description,
      child: RadioListTile<Level>(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
        value: level,
        groupValue: _selectedLevel,
        onChanged: (value) {
          setState(() {
            _selectedLevel = value ?? Level.starter;
          });
        },
      ),
    );
  }
}
*/