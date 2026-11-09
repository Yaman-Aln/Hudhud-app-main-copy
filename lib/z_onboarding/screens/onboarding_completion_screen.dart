import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1) Import your generated localization class
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Import logging provider
import 'package:hudhud_quran_app_new/providers/ff_logging_service_provider.dart';
// Import local storage or coordinator logic if needed
import 'package:hudhud_quran_app_new/providers/local_storage_service_provider.dart';

/// The final screen of the onboarding flow.
/// After the user taps "Let's Begin," we:
///   1) Mark onboarding done in the coordinator
///   2) Navigate back to main.dart (root) with pushNamedAndRemoveUntil('/'),
///      so main.dart's logic can check forced-first-lesson, etc.
class OnboardingCompletionScreen extends ConsumerWidget {
  final VoidCallback onFinish;

  const OnboardingCompletionScreen({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logger = ref.read(ffLoggingServiceProvider);
    final loc = AppLocalizations.of(context)!;

    return Semantics(
      // Localized semantics label describing this screen
      label: loc.onboardingCompletionScreenSemantic,
      child: Scaffold(
        appBar: AppBar(
          // Localized app bar title
          title: Text(loc.onboardingCompletionScreenAppBarTitle),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Semantics(
                // Localized semantics for the image
                label: loc.onboardingCompletionScreenImageSemantic,
                image: true,
                child: Image.asset(
                  'assets/icons/hudhud_quran.png',
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              const SizedBox(height: 16),

              // First paragraph
              Text(
                loc.onboardingCompletionScreenBody1,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // Second paragraph
    /*          Text(
                loc.onboardingCompletionScreenBody2,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
*/
              // Third paragraph
              Text(
                loc.onboardingCompletionScreenBody3,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 40),

              Semantics(
                button: true,
                // Localized semantics label for the "Begin" button
                label: loc.onboardingCompletionScreenBeginSemantic,
                child: ElevatedButton(
                  onPressed: () async {
                    logger.logInfo(
                      '[OnboardingCompletionScreen] user tapped "Begin" => calling onFinish()',
                    );
                    // 1) Mark onboarding done (via coordinator or local storage if needed)
                    onFinish();

                    // 2) Return to main.dart (root), so it can handle forced-first-lesson
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  // Localized text for the button
                  child: Text(loc.onboardingCompletionScreenBeginLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
