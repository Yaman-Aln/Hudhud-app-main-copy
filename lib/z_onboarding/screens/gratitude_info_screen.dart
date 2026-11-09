// lib/z_onboarding/screens/gratitude_info_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import your analytics provider
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// note: NOT Localized *****
/// Presents the importance of gratitude in Islam.
/// [onNext] triggers when the user presses Next.
/// [onSkip] allows skipping this info entirely.
class GratitudeInfoScreen extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const GratitudeInfoScreen({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.read(analyticsServiceProvider);

    // 1) Log a "viewed" event
    analytics.logEvent('gratitude_info_screen_viewed');

    return Semantics(
      label: 'Gratitude Information Screen',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Importance of Gratitude'),
          actions: [
            TextButton(
              onPressed: () {
                // 2) If skip
                analytics.logEvent('gratitude_info_skipped');
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
              Semantics(
                label: 'Gratitude concept illustration',
                child: Image.asset(
                  'assets/images/gratitude.png', // Replace with your actual asset path
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Alhamdulillah—praise and thanks to Allah—is repeated in every rak'ah of prayer, "
                    "reminding us to be grateful. Yet, we often say it mindlessly. "
                    "Reflecting on each Alhamdulillah can deepen our connection with Allah, "
                    "enhance mindfulness, and bring greater peace to our daily life.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                "By actively practicing gratitude, we become more aware of the blessings "
                    "that surround us. It fosters a positive mindset, helps us cope with challenges, "
                    "and keeps us spiritually grounded.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 40),
              Semantics(
                button: true,
                label: 'Proceed to next section',
                child: ElevatedButton(
                  onPressed: () {
                    // 3) If next
                    analytics.logEvent('gratitude_info_next');
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
