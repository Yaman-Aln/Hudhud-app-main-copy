import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Analytics provider
import '../providers/analytics_service_provider.dart';

import '../services/scoring_service.dart';
import '../widgets/top_bar.dart';
import '../screens/home_screen.dart';


// Providers & widgets
import '../widgets/submission_feedback_modal.dart';
import '../providers/gratitude_provider.dart';
import '../providers/ff_logging_service_provider.dart';

class GratitudeModal extends ConsumerStatefulWidget {
  const GratitudeModal({Key? key}) : super(key: key);

  @override
  GratitudeModalState createState() => GratitudeModalState();
}

class GratitudeModalState extends ConsumerState<GratitudeModal> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Log "gratitude_modal_opened"
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('gratitude_modal_opened');
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submitGratitudes() async {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);

    // ADDED LOG:
    final loggingService = ref.read(ffLoggingServiceProvider);
    loggingService.logWarning('[GratitudeModal] _submitGratitudes called');

    // Capture the messenger here to avoid referencing context after an async gap
    final messenger = ScaffoldMessenger.of(context);

    final gratitudes = _controllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    // If user entered no text
    if (gratitudes.isEmpty) {
      messenger.showSnackBar(
        SnackBar(content: Text(loc.gratitudeModalEmptyWarning)),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final today = DateTime.now().toIso8601String().split('T')[0];
      loggingService.logWarning('[GratitudeModal] adding entry => date=$today, gratitudes=$gratitudes');

      await ref.read(gratitudeEntriesProvider.notifier).addEntry(today, gratitudes);
      ref.invalidate(dailyScoreProvider);

      // Example: get total updated count
      final totalCount = await ref
          .read(gratitudeEntriesProvider.notifier)
          .getTotalGratitudeCount();

      // 1) Log event
      analytics.logEvent(
        'gratitude_modal_submitted',
        parameters: {
          'entries_count': gratitudes.length,
        },
      );

      // 2) Update user properties
      analytics.setUserProperty(
        'total_gratitude_entries',
        totalCount.toString(),
      );
      analytics.setUserProperty(
        'last_gratitudes_filled',
        '${gratitudes.length}_of_3',
      );

      // Clear on success
      for (var controller in _controllers) {
        controller.clear();
      }

      if (!mounted) return;
      loggingService.logWarning('[GratitudeModal] successfully added => $gratitudes');
      Navigator.of(context).pop(gratitudes);

    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });
      loggingService.logWarning('[GratitudeModal] error => $error');
      messenger.showSnackBar(
        SnackBar(content: Text(loc.gratitudeModalSubmitError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Semantics(
      // container label for screen readers
      label: loc.gratitudeModalSemantic,
      container: true,
      child: AlertDialog(
        elevation: 4.0,
        title: Text(loc.gratitudeModalTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 3 text fields
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Semantics(
                    label: loc.gratitudeModalTextFieldSemantic('${i + 1}'),
                    textField: true,
                    child: TextField(
                      controller: _controllers[i],
                      maxLength: 100,
                      decoration: InputDecoration(
                        hintText: loc.gratitudeModalHint(i + 1),
                        counterText: "",
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          if (_isSubmitting)
            Semantics(
              label: loc.gratitudeModalLoadingSemantic,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            )
          else ...[
            TextButton(
              onPressed: () {
                final analytics = ref.read(analyticsServiceProvider);
                analytics.logEvent('gratitude_modal_cancelled');
                Navigator.of(context).pop(); // Close without saving
              },
              child: Text(loc.cancelLabel),
            ),
            TextButton(
              onPressed: _submitGratitudes,
              child: Text(loc.submitLabel),
            ),
          ],
        ],
      ),
    );
  }
}

/// Displays the GratitudeModal via `showDialog`.
void showGratitudeModal(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5), // Semi-transparency
    builder: (BuildContext context) {
      return const GratitudeModal();
    },
  );
}
