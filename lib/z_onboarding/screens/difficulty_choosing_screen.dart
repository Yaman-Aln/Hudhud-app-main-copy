import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async'; // For Timer or post-frame

// 1) Import your DifficultyLevel enum (with 4 values: multipleChoice, beginner, learned, qari)
import '../../../models/difficulty_level_model.dart';

// 2) Import your UniqueTestModel for optional references:
import '../../z_onboarding/models/unique_test_model.dart';

// 3) Coordinator for calling .nextStep(), skip(), etc.
import '../onboarding_coordinator.dart';

// 4) Localizations from lesson screen or global .arb
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

/// An onboarding screen that only picks:
///  - Difficulty (multipleChoice or fill-in)
///  - Step Repeat (how many times the user sees each step)
///
/// When user taps "Next," we call [onNext(difficulty, stepRepeat)].
class DiffcultyChoosingScreen extends ConsumerStatefulWidget {
  /// If the user taps "Skip."
  final VoidCallback? onSkip;

  /// If the user taps "Next," we call this with the chosen difficulty + repeat count.
  final void Function(DifficultyLevel difficulty, int stepRepeat)? onNext;

  const DiffcultyChoosingScreen({
    Key? key,
    this.onSkip,
    this.onNext,
  }) : super(key: key);

  @override
  ConsumerState<DiffcultyChoosingScreen> createState() =>
      _DiffcultyChoosingScreenState();
}

class _DiffcultyChoosingScreenState extends ConsumerState<DiffcultyChoosingScreen> {
  /// We allow `null` for the "fillInTheBlanks" divider row in the dropdown
  DifficultyLevel? _selectedDifficulty;
  int _selectedRepeatCount = 2;

  /// **Optional**: A GlobalKey for simulating a tap on the dropdown
  final GlobalKey _difficultyDropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    final coordinator = ref.read(onboardingCoordinatorProvider);
    final profile = coordinator.userProfile;

    // (A) PRE-SELECT multipleChoice if userProfile.defaultDifficulty is null
    _selectedDifficulty =
        profile.defaultDifficulty ?? DifficultyLevel.multipleChoice;

    // (B) PRE-SELECT "2" repeats if userProfile.defaultRepeatCount is null
    _selectedRepeatCount = profile.defaultRepeatCount ?? 2;

    // (C) Attempt to auto-open the difficulty dropdown in a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openDifficultyDropdown();
    });
  }

  /// Hack: Programmatically open the difficulty dropdown by simulating a tap.
  /// There's no official Flutter API for this; it's a trick that may break in the future.
  void _openDifficultyDropdown() {
    // If the dropdown or its render object is null, skip
    final box = _difficultyDropdownKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    // We simulate a tap at the center of the dropdown
    final offset = box.localToGlobal(box.size.center(Offset.zero));
    final tapDown = PointerDownEvent(position: offset);
    final tapUp = PointerUpEvent(position: offset);

    // Pump the pointer events to the binding pipeline
    WidgetsBinding.instance.handlePointerEvent(tapDown);
    WidgetsBinding.instance.handlePointerEvent(tapUp);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.lessonScreenAppBarTitle), // e.g. "Lesson"
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ---------------------------------------------------------
                // Intro Text (localized)
                // ---------------------------------------------------------
                Text(
                  loc.difficultyChoosingScreenIntro, // <-- You added this key in your .arb
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 16),

                // ---------------------------------------------------------
                // Row: (A) Difficulty + (B) Step Repeat
                // ---------------------------------------------------------
                Row(
                  children: [
                    // -----------------------
                    // (A) Difficulty
                    // -----------------------
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              loc.difficultyLabel, // e.g. "Difficulty"
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            DropdownButton<DifficultyLevel?>(
                              key: _difficultyDropdownKey, // For auto-open hack
                              isExpanded: true,
                              value: _selectedDifficulty,
                              onChanged: (val) {
                                if (val == null) return; // The divider row
                                setState(() => _selectedDifficulty = val);
                              },
                              items: DifficultyLevel.values.expand((dl) {
                                if (dl == DifficultyLevel.multipleChoice) {
                                  // Return [MC item, non-selectable divider]
                                  return [
                                    DropdownMenuItem<DifficultyLevel?>(
                                      value: DifficultyLevel.multipleChoice,
                                      child: Text(dl.displayName(context)),
                                    ),
                                    DropdownMenuItem<DifficultyLevel?>(
                                      value: null,
                                      enabled: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Divider(thickness: 1, color: Colors.grey),
                                          Text(
                                            loc.fillInTheBlanksLabel,
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ];
                                } else {
                                  // Normal item for beginner, learned, qari
                                  return [
                                    DropdownMenuItem<DifficultyLevel?>(
                                      value: dl,
                                      child: Text(dl.displayName(context)),
                                    ),
                                  ];
                                }
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // -----------------------
                    // (B) Step Repeat
                    // -----------------------
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              loc.repeatCountLabel, // e.g. "# of Repeats"
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            DropdownButton<int>(
                              isExpanded: true,
                              value: _selectedRepeatCount,
                              onChanged: (val) {
                                if (val == null) return;
                                setState(() => _selectedRepeatCount = val);
                              },
                              items: [1, 2, 3, 5, 10].map((count) {
                                return DropdownMenuItem<int>(
                                  value: count,
                                  child: Text(count.toString()),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ---------------------------------------------------------
                // Bottom Row => SKIP & NEXT
                // ---------------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.onSkip != null)
                      TextButton(
                        onPressed: widget.onSkip,
                        child: Text(loc.skipLabel), // e.g. "Skip"
                      ),
                    ElevatedButton(
                      onPressed: () {
                        // When user taps Next => call user callback
                        if (widget.onNext != null) {
                          widget.onNext!(
                            _selectedDifficulty ?? DifficultyLevel.multipleChoice,
                            _selectedRepeatCount,
                          );
                        }
                      },
                      child: Text(loc.nextLabel), // e.g. "Next"
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
