import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1) Import your generated localization class
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Import analytics provider to log events
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// The model containing all goal enums (e.g., connectQuran, memorizeQuran, etc.)
import 'package:hudhud_quran_app_new/z_onboarding/models/unique_test_model.dart';

/// Allows the user to select multiple [Goal] items.
/// [onNext] receives the final list of selected [Goal]s.
/// [onSkip] allows the user to skip goal selection entirely.
class GoalSelectionScreen extends ConsumerStatefulWidget {
  final ValueChanged<List<Goal>> onNext;
  final VoidCallback onSkip;

  const GoalSelectionScreen({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  ConsumerState<GoalSelectionScreen> createState() =>
      _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends ConsumerState<GoalSelectionScreen> {
  /// Holds the currently selected goals.
  final List<Goal> _selectedGoals = [];

  @override
  Widget build(BuildContext context) {
    final analytics = ref.read(analyticsServiceProvider);
    final loc = AppLocalizations.of(context)!;

    // 1) Log "goal_selection_screen_viewed"
    analytics.logEvent('goal_selection_screen_viewed');

    return Semantics(
      // Localized semantics for the entire screen
      label: loc.goalSelectionScreenSemantic,
      child: Scaffold(
        backgroundColor: Colors.blue[50], // Match the styling
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          // Localized title
          title: Text(
            loc.goalSelectionScreenAppBarTitle,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            Semantics(
              // Localized skip semantics
              label: loc.goalSelectionScreenSkipSemantic,
              button: true,

            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Introductory text
              Text(
                loc.goalSelectionScreenIntroText,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // Checkboxes for each goal (localized), each wrapped in a styled container
              _buildGoalCard(
                child: _buildCheckboxTile(
                  goal: Goal.connectQuran,
                  title: loc.goalConnectQuranTitle,
                  //description: loc.goalConnectQuranDesc,
                ),
              ),
              const SizedBox(height: 8),

              _buildGoalCard(
                child: _buildCheckboxTile(
                  goal: Goal.memorizeQuran,
                  title: loc.goalMemorizeQuranTitle,
                  //description: loc.goalMemorizeQuranDesc,
                ),
              ),
              const SizedBox(height: 8),

              _buildGoalCard(
                child: _buildCheckboxTile(
                  goal: Goal.beMoreGrateful,
                  title: loc.goalBeMoreGratefulTitle,
                  //description: loc.goalBeMoreGratefulDesc,
                ),
              ),
              const SizedBox(height: 8),

              _buildGoalCard(
                child: _buildCheckboxTile(
                  goal: Goal.buildConsistency,
                  title: loc.goalBuildConsistencyTitle,
                  //description: loc.goalBuildConsistencyDesc,
                ),
              ),
              const SizedBox(height: 8),

              _buildGoalCard(
                child: _buildCheckboxTile(
                  goal: Goal.improveArabic,
                  title: loc.goalImproveArabicTitle,
                  //description: loc.goalImproveArabicDesc,
                ),
              ),
              const SizedBox(height: 8),

              _buildGoalCard(
                child: _buildCheckboxTile(
                  goal: Goal.deepenTafsir,
                  title: loc.goalDeepenTafsirTitle,
                  //description: loc.goalDeepenTafsirDesc,
                ),
              ),
              const SizedBox(height: 8),

              _buildGoalCard(
                child: _buildCheckboxTile(
                  goal: Goal.other,
                  title: loc.goalOtherTitle,
                  //description: loc.goalOtherDesc,
                ),
              ),

              const SizedBox(height: 40),

              // Next Button
              Semantics(
                button: true,
                // Localized semantics label
                label: loc.goalSelectionScreenNextSemantic,
                child: ElevatedButton(
                  onPressed: () {
                    // 3) Log the selected goals
                    if (_selectedGoals.isNotEmpty) {
                      final goalsAsStrings =
                      _selectedGoals.map((g) => g.name).toList();
                      analytics.logEvent(
                        'goal_selected',
                        parameters: {
                          'goals': goalsAsStrings, // array of selected goals
                          'count': _selectedGoals.length,
                        },
                      );
                    } else {
                      analytics.logEvent(
                        'goal_selected',
                        parameters: {
                          'goals': [], // empty array
                          'count': 0,
                        },
                      );
                    }

                    // 4) Call parent callback
                    widget.onNext(_selectedGoals);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2,
                  ),
                  // Localized "Next" label
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Text(
                      loc.goalSelectionScreenNextLabel,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a reusable checkbox tile for each goal with [title] and [description].
  Widget _buildCheckboxTile({
    required Goal goal,
    required String title,
    String? description,
  }) {
    final isSelected = _selectedGoals.contains(goal);
    final loc = AppLocalizations.of(context)!;

    return Semantics(
      // Localized dynamic semantics for each checkbox item
      label: loc.goalSelectionTileSemantic(title),
      hint: description,
      child: CheckboxListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        // Uncomment if you want to show the description
        // subtitle: Text(
        //   description ?? '',
        //   style: const TextStyle(fontSize: 14, color: Colors.black54),
        // ),
        activeColor: Colors.blue[800],
        value: isSelected,
        onChanged: (checked) {
          setState(() {
            if (checked == true && !_selectedGoals.contains(goal)) {
              _selectedGoals.add(goal);
            } else if (checked == false && _selectedGoals.contains(goal)) {
              _selectedGoals.remove(goal);
            }
          });
        },
      ),
    );
  }

  /// Wrap each checkbox tile in a card-like container to match the look & feel
  Widget _buildGoalCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
