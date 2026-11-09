// lib/services/audio_playback_service.dart

import 'package:audioplayers/audioplayers.dart';
import 'package:hudhud_quran_app_new/providers/ff_logging_service_provider.dart';

/// We use this LoggingService so you can see debug output
final loggingService = LoggingService();

/// Handles playback of Quran audio from an online source (quranaudio.pages.dev).
class AudioPlaybackService {
  /// Single audio player instance for the entire service
  final AudioPlayer _player = AudioPlayer();

  /// Streams ayat from `startAyah` up to `endAyah` in `surahId`,
  /// repeated `repeatTimes` times, using the specified `reciterNo`.
  ///
  /// Example usage:
  /// ```dart
  /// await audioPlaybackService.playVerses(
  ///   surahId: 1,
  ///   startAyah: 1,
  ///   endAyah: 7,
  ///   reciterNo: 10,       // e.g. reciter ID from user prefs
  ///   repeatTimes: 3,      // play 3 times
  /// );
  /// ```
  Future<void> playVerses({
    required int surahId,
    required int startAyah,
    required int endAyah,
    required int reciterNo,
    int repeatTimes = 1,
  }) async {
    // For surah #1, you call it "1_1.mp3", "1_2.mp3", etc.
    // This for-loop will re-play the entire range multiple times.
    for (int round = 0; round < repeatTimes; round++) {
      loggingService.logWarning(
        '[AudioPlaybackService] Starting round ${round + 1} of $repeatTimes total',
      );

      // Go through each ayah from start to end
      for (int ayah = startAyah; ayah <= endAyah; ayah++) {
        // e.g. https://quranaudio.pages.dev/10/1_1.mp3
        final audioUrl = 'https://quranaudio.pages.dev/$reciterNo/${surahId}_$ayah.mp3';

        loggingService.logWarning('[AudioPlaybackService] Playing: $audioUrl');

        // Attempt playback
        await _player.stop(); // optional: ensure we reset before each file
        await _player.play(UrlSource(audioUrl));

        // Wait until playback completes for this ayah
        await _player.onPlayerComplete.first;
      }
    }

    loggingService.logWarning('[AudioPlaybackService] Finished all repeats');
  }

  /// Stop any current playback
  Future<void> stop() async {
    loggingService.logWarning('[AudioPlaybackService] stop() called');
    await _player.stop();
  }

  /// Disposes the AudioPlayer instance
  void dispose() {
    loggingService.logWarning('[AudioPlaybackService] dispose() called');
    _player.dispose();
  }
}
