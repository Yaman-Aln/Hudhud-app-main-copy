import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kToolbarHeight;
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1) Import your generated localization class
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Logging & Analytics
import '../providers/analytics_service_provider.dart';
import '../screens/home_screen.dart';

// Notification service (to access showImmediateNotification)
import '../services/notification_service.dart';

// ADD: dailyScoreProvider import (wherever you defined it)
// import '../providers/daily_score_provider.dart'; // Example

// ADD: subscription screen import so we can navigate there
import '../z_onboarding/screens/subscription_tier_screen.dart';

/// A custom top bar (AppBar-like) with:
/// - dynamic height (scales on phones and tablets)
/// - optional center title
/// - a streak icon (with bubble) in the middle
/// - a Hudhud icon on the right
/// - a daily score on the left
/// - thorough localization & accessibility
class TopBar extends ConsumerWidget implements PreferredSizeWidget {
  final int streakCount;
  final String title;

  /// The daily score displayed on the left side
  final int dailyScore;

  const TopBar({
    Key? key,
    required this.streakCount,
    required this.dailyScore,
    this.title = '',
  }) : super(key: key);

  // **Define preferredSize once** to satisfy PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    // Watch the daily score from your FutureProvider (asyncDailyScore)
    final asyncDailyScore = ref.watch(dailyScoreProvider);

    // Use MediaQuery to get device width, plus text scaling for future-proof text sizes.
    final deviceWidth = MediaQuery.of(context).size.width;
    final textScaler = MediaQuery.textScalerOf(context);

    // Start with a default top bar height.
    double dynamicHeight = kToolbarHeight; // e.g. 56

    // If it's a tablet, enlarge the height by 30%.
    if (deviceWidth > 600) {
      dynamicHeight = kToolbarHeight * 1.3;
    } else {
      // On smaller screens, scale the bar height by textScaler,
      // but clamp so it doesn't get too large or too small.
      final scaledHeight = textScaler.scale(kToolbarHeight);
      final minHeight = kToolbarHeight;         // 56
      final maxHeight = kToolbarHeight * 1.2;   // 67.2
      dynamicHeight = scaledHeight.clamp(minHeight, maxHeight);
    }

    return Semantics(
      label: loc.topBarSemanticLabel, // e.g. "Top navigation bar"
      container: true,
      child: Container(
        // We override the Container’s height to be dynamic
        height: dynamicHeight,
        color: Colors.blue[50], // Light blue background
        child: Stack(
          children: [
            // (A) If there's a title, center it
            if (title.isNotEmpty)
              Center(
                child: Semantics(
                  label: loc.topBarTitleSemantic(title),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

            // (B) The streak icon near the center
            // Tapping it shows a streak explanation dialog
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(analyticsServiceProvider)
                      .logEvent('top_bar_streak_clicked');
                  _showStreakDialog(context, loc);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Semantics(
                    label: loc.topBarStreakIconSemantic(
                      streakCount.toString(),
                    ),
                    child: _buildStreakIconWithBubble(
                      assetPath: 'assets/icons/grateful_closed.png',
                      streakCount: streakCount,
                      iconSize: dynamicHeight,
                      loc: loc,
                    ),
                  ),
                ),
              ),
            ),

            // (C) Daily Score on the left, unwrapped from AsyncValue<int>
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: asyncDailyScore.when(
                  data: (scoreVal) => Semantics(
                    label: loc.topBarDailyScoreSemantic(scoreVal.toString()),
                    child: Text(
                      // e.g. "Score: 42"
                      '${loc.topBarDailyScoreLabel}: $scoreVal',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  loading: () => Text(
                    '${loc.topBarDailyScoreLabel}: ...',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  error: (err, st) => Text(
                    // In case it fails to load
                    '${loc.topBarDailyScoreLabel}: --',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),

            // (D) The Hudhud icon on the right
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () async {
                  // 1) Log analytics
                  ref
                      .read(analyticsServiceProvider)
                      .logEvent('top_bar_hudhud_clicked');

                  // 2) Show the "Support & Upgrade" (Hudhud) dialog
                  _showHudhudDialog(context, loc);
                },
                child: Semantics(
                  label: loc.topBarHudhudIconSemantic, // "Hudhud icon"
                  child: SizedBox(
                    width: dynamicHeight,
                    height: dynamicHeight,
                    child: Image.asset(
                      'assets/icons/hudhud_quran.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Renders the streak icon plus the numeric bubble
  Widget _buildStreakIconWithBubble({
    required String assetPath,
    required int streakCount,
    required double iconSize,
    required AppLocalizations loc,
  }) {
    final bubbleSize = iconSize * 0.4;
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            assetPath,
            width: iconSize,
            height: iconSize,
          ),
          Positioned(
            right: -(bubbleSize * 0.3),
            top: (iconSize - bubbleSize) / 2,
            child: Material(
              shape: const CircleBorder(),
              elevation: 2,
              color: Colors.white,
              child: SizedBox(
                width: bubbleSize,
                height: bubbleSize,
                child: Center(
                  child: Text(
                    '$streakCount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: bubbleSize * 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show a streak explanation dialog
  void _showStreakDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(loc.topBarStreakDialogTitle),
        content: Text(loc.topBarStreakDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: Text(loc.okLabel),
          ),
        ],
      ),
    );
  }

  /// Show the "Support & Upgrade" (Hudhud) dialog
  void _showHudhudDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(loc.topBarHudhudDialogTitle),
        content: Text(loc.topBarHudhudDialogBody),
        actions: [
          // (1) Explore Plans => push SubscriptionTierScreen
          TextButton(
            onPressed: () {
              Navigator.pop(c); // close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubscriptionTierScreen(
                    // minimal placeholders for onNext, onSkip
                    onNext: (_) {
                      // e.g. pop until home or show a "Thanks" message
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    onSkip: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ),
              );
            },
            child: Text(loc.topBarExplorePlansLabel), // e.g. "Explore Plans"
          ),

          // (2) Back to Home => pushReplacement to HomeScreen
          TextButton(
            onPressed: () {
              Navigator.pop(c); // close the dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
            child: Text(loc.topBarBackHomeLabel), // e.g. "Back to Home"
          ),
        ],
      ),
    );
  }
}
