// lib/z_onboarding/screens/navigation_info_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import your analytics provider
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// note: NOT Localized *****
/// Offers basic instructions on navigating the app:
///  - Where to find the main reading/learning screen
///  - How to record daily gratitude
///  - How to track progress and access profile/settings
///
/// [onNext] is triggered when user presses the Next button.
/// [onSkip] is optional if skipping is allowed.
class NavigationInfoScreen extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const NavigationInfoScreen({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.read(analyticsServiceProvider);

    // 1) Log "viewed"
    analytics.logEvent('navigation_info_screen_viewed');

    return Semantics(
      label: 'Navigation Information Screen',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('App Navigation Tips'),
          actions: [
            TextButton(
              onPressed: () {
                // 2) If skip
                analytics.logEvent('navigation_info_skipped');
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Here are a few navigation tips to help you get the most out of our app:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              _buildBulletPoint(
                'Reading and Learning Screen',
                'Access the main Quran reading and learning screen through the Home tab. '
                    'Here, you can choose a surah or ayah to study in depth.',
              ),
              _buildBulletPoint(
                'Daily Gratitude Screen',
                'Record your daily gratitude in the Gratitude tab, which allows you '
                    'to log new entries and reflect on past gratitude notes.',
              ),
              _buildBulletPoint(
                'Progress Tracking',
                'Track your progress by visiting the Progress section, '
                    'where you can see how consistent you’ve been and celebrate milestones.',
              ),
              _buildBulletPoint(
                'Profile Settings',
                'Customize your profile or change app settings by tapping the Profile icon in the toolbar. '
                    'You can update your name, language preferences, and more.',
              ),
              const SizedBox(height: 32),

              Semantics(
                button: true,
                label: 'Proceed to next section',
                child: ElevatedButton(
                  onPressed: () {
                    // 3) If user proceeds
                    analytics.logEvent('navigation_info_next');
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

  /// Helper for displaying bullet points with consistent styling.
  Widget _buildBulletPoint(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$title\n',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: body,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
