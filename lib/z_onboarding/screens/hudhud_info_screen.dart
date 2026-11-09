import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1) Import your generated localization class
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Import your analytics provider
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

/// An informational screen introducing Hudhud:
///   - Who he is
///   - Significance to Prophet Suleiman [AS]
///   - Possibly an image or illustration
///
/// [onNext] is triggered when the user taps Next.
/// [onSkip] allows skipping entirely.
class HudhudInfoScreen extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const HudhudInfoScreen({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.read(analyticsServiceProvider);
    final loc = AppLocalizations.of(context)!;

    // 1) Log a "viewed" event
    analytics.logEvent('hudhud_info_screen_viewed');

    return Semantics(
      // Localized semantics for the entire screen
      label: loc.hudhudInfoSemantic,
      child: Scaffold(
        appBar: AppBar(
          // Localized app bar title
          title: Text(loc.hudhudInfoAppBarTitle),
          actions: [
            Semantics(
              // Localized skip button semantics
              label: loc.hudhudInfoSkipSemantic,
              button: true,
              child: TextButton(
                onPressed: () {
                  // 2) If user skips
                  analytics.logEvent('hudhud_info_skipped');
                  onSkip();
                },
                // Reuse the generic skip label, or you can use a dedicated label if desired
                child: Text(
                  loc.skipLabel,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Semantics(
                // Localized illustration semantics
                label: loc.hudhudInfoIllustrationSemantic,
                image: true,
                child: Image.asset(
                  'assets/icons/hudhud_quran.png', // Adjust path as needed
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              const SizedBox(height: 16),

              // Paragraph #1
              Text(
                loc.hudhudInfoBody1,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // Paragraph #2
              Text(
                loc.hudhudInfoBody2,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // Paragraph #3
              Text(
                loc.hudhudInfoBody3,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 40),

              // "Next" button
              Semantics(
                button: true,
                // Localized semantics for the next button
                label: loc.hudhudInfoNextSemantic,
                child: ElevatedButton(
                  onPressed: () {
                    // 3) If user proceeds
                    analytics.logEvent('hudhud_info_next');
                    onNext();
                  },
                  // Localized text for the button
                  child: Text(loc.hudhudInfoNextLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
