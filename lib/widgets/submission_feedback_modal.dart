import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart'; // <-- Added for playing the chirp sound

// Localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Analytics provider
import '../providers/analytics_service_provider.dart';

// Providers & widgets
import '../providers/gratitude_provider.dart';
import '../screens/gratitude_log_screen.dart';
import '../providers/ff_logging_service_provider.dart';

/// A modal that provides feedback after user submissions (e.g., gratitudes).
class SubmissionFeedbackModal extends ConsumerStatefulWidget {
  final List<String> submittedGratitudes;

  const SubmissionFeedbackModal({
    Key? key,
    required this.submittedGratitudes,
  }) : super(key: key);

  @override
  ConsumerState<SubmissionFeedbackModal> createState() =>
      _SubmissionFeedbackModalState();
}

class _SubmissionFeedbackModalState
    extends ConsumerState<SubmissionFeedbackModal> {
  late final AudioPlayer _audioPlayer;
  bool _hasPlayedSound = false;

  @override
  void initState() {
    super.initState();

    // Initialize audio player
    _audioPlayer = AudioPlayer();

    // Play the chirp on the first frame once the modal is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playHudhudChirp();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playHudhudChirp() async {
    if (!_hasPlayedSound) {
      _hasPlayedSound = true;
      try {
        // 'audio/hudhud_chirp.mp3' must exist in your assets under /assets/audio/
        await _audioPlayer.play(AssetSource('audio/hudhud_chirp.mp3'));
      } catch (e) {
        debugPrint('Failed to play hoopoe sound: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // Access analytics
    final analytics = ref.read(analyticsServiceProvider);
    // Log "submission_feedback_modal_shown"
    analytics.logEvent(
      'submission_feedback_modal_shown',
      parameters: {
        'entries_count': widget.submittedGratitudes.length,
      },
    );

    final loggingService = ref.read(ffLoggingServiceProvider);
    loggingService.logWarning(
      '[SubmissionFeedbackModal] Building with ${widget.submittedGratitudes.length} submitted gratitudes.',
    );

    final gratitudeDataAsync = ref.watch(gratitudeDataProvider);

    return Semantics(
      label: loc.submissionFeedbackModalSemanticLabel,
      container: true,
      child: AlertDialog(
        semanticLabel: loc.submissionFeedbackModalTitle,
        title: Text(loc.submissionFeedbackModalTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.submittedGratitudes.isEmpty)
              Text(loc.submissionFeedbackModalNoNew)
            else ...[
              Text(loc.submissionFeedbackModalYouSubmitted),
              const SizedBox(height: 8),
              for (final item in widget.submittedGratitudes)
                Text('- $item', style: const TextStyle(color: Colors.black87)),

              // [ADDED POINTS LINE] Only if there's at least 1 gratitude
              const SizedBox(height: 8),
              Text(
                '+10 x ${widget.submittedGratitudes.length}',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
            ],
            gratitudeDataAsync.when(
              data: (gData) {
                final streakLine = loc.submissionFeedbackModalStreak(
                  gData.consecutiveGratitudeDays.toString(),
                );
                final totalDaysLine = loc.submissionFeedbackModalTotalDays(
                  gData.totalGratitudeDays.toString(),
                );

                // NEW: totalCountLine for total number of gratitudes
                final totalCountLine = loc.submissionFeedbackModalTotalCount(
                  gData.totalGratitudeCount.toString(),
                );

                return Text(
                  // Show all lines
                  '$streakLine\n$totalDaysLine\n$totalCountLine',
                  style: const TextStyle(fontSize: 14),
                );
              },
              loading: () => Text(loc.submissionFeedbackModalLoading),
              error: (err, st) => Text(loc.submissionFeedbackModalError),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              analytics.logEvent('submission_feedback_modal_view_log');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GratitudeLogScreen()),
              );
              loggingService.logInfo(
                '[SubmissionFeedbackModal] User tapped "View Log".',
              );
            },
            child: Text(loc.submissionFeedbackModalViewLog),
          ),
          TextButton(
            onPressed: () {
              analytics.logEvent('submission_feedback_modal_closed');
              loggingService.logInfo(
                '[SubmissionFeedbackModal] Modal dismissed.',
              );
              Navigator.pop(context);
            },
            child: Text(loc.submissionFeedbackModalClose),
          ),
        ],
      ),
    );
  }
}
