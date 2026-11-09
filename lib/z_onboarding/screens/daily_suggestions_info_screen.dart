// lib/z_onboarding/screens/daily_suggestions_info_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import your analytics provider
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// note: NOT Localized *****
/// Explains recommended daily practices (gratitudes, consistency, etc.).
/// [onNext] is called when the user taps the Next button.
/// [onSkip] can skip these suggestions entirely.
class DailySuggestionsInfoScreen extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const DailySuggestionsInfoScreen({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1) Log a "viewed" event each time this screen is built
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('daily_suggestions_screen_viewed');

    return Semantics(
      label: 'Daily Suggestions Information Screen',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daily Practice Suggestions'),
          actions: [
            TextButton(
              onPressed: () {
                // 2) If user skips, log an event
                analytics.logEvent('daily_suggestions_skipped');
                onSkip();
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "It's easy to get overwhelmed and do long study sprints. "
                    "But the Prophet Muhammad (ﷺ) taught us that the most beloved actions "
                    "are those done consistently, even if small. "
                    "Spending 5–10 minutes a day building your Quranic connection "
                    "can yield more lasting benefits than intense but sporadic sessions.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                "We also encourage practicing gratitude in tandem with your Quran study. "
                    "Try writing down three things you are grateful for each day, "
                    "ideally connecting them to the ayah or theme you're learning. "
                    "For example, if the ayah discusses mercy, reflect on ways "
                    "you've felt Allah's mercy recently.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 40),
              Semantics(
                button: true,
                label: 'Proceed to next section',
                child: ElevatedButton(
                  onPressed: () {
                    // 3) If user proceeds, log an event
                    analytics.logEvent('daily_suggestions_next');
                    onNext();
                  },
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
