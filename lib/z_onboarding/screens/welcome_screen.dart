// lib/z_onboarding/screens/welcome_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';
// 1) Import your generated localization class
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  final VoidCallback onSkip; // Kept for compatibility with main/parent code
  final VoidCallback onNext;

  const WelcomeScreen({
    Key? key,
    required this.onSkip,
    required this.onNext,
  }) : super(key: key);

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  late final AudioPlayer _audioPlayer;
  bool _hasPlayedSound = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Delay playing sound until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playHoopoeSound();
    });
  }

  Future<void> _playHoopoeSound() async {
    if (!_hasPlayedSound) {
      _hasPlayedSound = true;
      try {
        // 'audio/hudhud_chirp.mp3' must exist in your assets
        await _audioPlayer.play(AssetSource('audio/hudhud_chirp.mp3'));
      } catch (e) {
        debugPrint('Failed to play hoopoe sound: $e');
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final analytics = ref.read(analyticsServiceProvider);
    final loc = AppLocalizations.of(context)!; // localizations

    // 1) Log "welcome_screen_viewed" once displayed
    analytics.logEvent('welcome_screen_viewed');

    return Semantics(
      label: loc.welcomeScreenSemantic, // e.g. "Onboarding Welcome Screen"
      child: Scaffold(
        appBar: AppBar(
          // Use localizations for the AppBar title
          title: Text(loc.appBarTitleWelcome),
          // Skip button removed to avoid showing "Skip" in the UI
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Logo or illustration
                Semantics(
                  label: loc.welcomeScreenLogoSemantic, // e.g. "Hudhud Quran illustration"
                  image: true,
                  child: Image.asset(
                    'assets/icons/hudhud_quran.png',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),

                // Localized "Welcome to Quran with Hudhud!"
                Text(
                  loc.welcomeHeadline,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Localized body text
                Text(
                  loc.welcomeBody,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 40),

                // "Get Started" button
                Semantics(
                  button: true,
                  label: loc.welcomeScreenNextSemantic, // e.g. "Proceed to next onboarding step"
                  child: ElevatedButton(
                    onPressed: () {
                      analytics.logEvent('welcome_screen_next');
                      widget.onNext();
                    },
                    // Localized "Get Started"
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                      child: Text(
                        loc.getStartedLabel,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
