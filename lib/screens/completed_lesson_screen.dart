// lib/screens/lesson_completion_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Logging & Analytics
import '../providers/ff_logging_service_provider.dart';
import '../providers/analytics_service_provider.dart';

// Screens
import 'home_screen.dart';
import 'lesson_screen.dart';
import 'path_detail_screen.dart';

// Providers
import '../providers/progress_service_provider.dart';
import '../providers/path_service_provider.dart';
import '../providers/lesson_service_provider.dart'; // For saveLastOpenedLesson, if you have it

// NEW: Generated localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

/// This screen is shown after a user completes a lesson.
class LessonCompletionScreen extends ConsumerWidget {
  final String lessonId;
  final String pathId;
  final int surahId;
  final int totalSteps;

  const LessonCompletionScreen({
    Key? key,
    required this.lessonId,
    required this.pathId,
    required this.surahId,
    required this.totalSteps,
  }) : super(key: key);

  /// Saves the last opened lesson/path, invalidates the path, then navigates to Home.
  Future<void> _goHomeAndUpdatePath({
    required BuildContext context,
    required WidgetRef ref,
    required String ctaSource, // "app_bar_arrow" or "button_go_back_path"
  }) async {
    final nav = Navigator.of(context);
    final loggingService = ref.read(ffLoggingServiceProvider);
    final analytics = ref.read(analyticsServiceProvider);

    // Log event: user returning to home
    analytics.logEvent(
      'lesson_completion_go_home',
      parameters: {
        'lesson_id': lessonId,
        'path_id': pathId,
        'from_screen': 'lesson_completion',
        'to_screen': 'home_screen',
        'cta_source': ctaSource,
      },
    );

    // Invalidate path's lessons and home active path
    ref.invalidate(asyncLessonsWithProgressProvider(pathId));
    ref.invalidate(asyncActivePathProvider);

    // Optionally save last opened lesson
    final lessonService = ref.read(lessonServiceProviderRef);
    try {
      await lessonService.saveLastOpenedLesson(lessonId, surahId, pathId);
      loggingService.logWarning(
        '[LessonCompletion] Last opened lesson saved: $lessonId',
      );
    } catch (e) {
      loggingService.logWarning(
        '[LessonCompletion] Error saving last opened lesson: $e',
      );
    }

    // Navigate home
    nav.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
    );
  }

  /// Restarts the lesson in-place.
  Future<void> _restartLesson(BuildContext context, WidgetRef ref) async {
    final nav = Navigator.of(context);
    final loggingService = ref.read(ffLoggingServiceProvider);
    final analytics = ref.read(analyticsServiceProvider);

    // Log event: user is restarting lesson
    analytics.logEvent(
      'lesson_completion_restart',
      parameters: {
        'lesson_id': lessonId,
        'path_id': pathId,
        'surah_id': surahId,
        'from_screen': 'lesson_completion',
        'to_screen': 'lesson_screen',
        'cta_source': 'button_restart_lesson',
      },
    );

    // Invalidate path's lessons
    ref.invalidate(asyncLessonsWithProgressProvider(pathId));

    // Optionally save last opened lesson
    final lessonService = ref.read(lessonServiceProviderRef);
    try {
      await lessonService.saveLastOpenedLesson(lessonId, surahId, pathId);
      loggingService.logWarning(
        '[LessonCompletion] Last opened lesson saved before restart: $lessonId',
      );
    } catch (e) {
      loggingService.logWarning(
        '[LessonCompletion] Error saving last opened lesson (restart): $e',
      );
    }

    // Push replacement LessonScreen
    nav.pushReplacement(
      MaterialPageRoute(
        builder: (_) => LessonScreen(
          surahId: surahId,
          languageCode: 'en', // or dynamic
          lessonId: lessonId,
          pathId: pathId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!; // localizations
    final loggingService = ref.read(ffLoggingServiceProvider);
    final analytics = ref.read(analyticsServiceProvider);

    // Log "lesson_completion_screen_viewed"
    analytics.logEvent(
      'lesson_completion_screen_viewed',
      parameters: {
        'lesson_id': lessonId,
        'path_id': pathId,
        'surah_id': surahId,
        'total_steps': totalSteps,
      },
    );

    loggingService.logWarning(
      '[LessonCompletion] Screen displayed for lessonId: $lessonId, pathId: $pathId.',
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // "Lesson Completed"
        title: Text(
          loc.lessonCompletedTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[50],
        leading: Semantics(
          label: loc.lessonCompletedBackArrowSemantic, // e.g. "Back to home"
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _goHomeAndUpdatePath(
              context: context,
              ref: ref,
              ctaSource: 'app_bar_arrow',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),

                // Big green "MashaAllah!"
                Semantics(
                  label: loc.lessonCompletedMashaAllahSemantic, // e.g. "Congratulations text"
                  child: Text(
                    loc.lessonCompletedMashaAllah, // e.g. "MashaAllah!"
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // "You have completed this lesson!"
                Text(
                  loc.lessonCompletedMessage, // e.g. "You have completed this lesson!"
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),

                // Image or animation
                Semantics(
                  label: loc.lessonCompletedImageSemantic, // e.g. "Hudhud Quran illustration"
                  child: SizedBox(
                    width: screenWidth * 0.7,
                    height: screenHeight * 0.3,
                    child: Image.asset(
                      'assets/icons/hudhud_quran.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // (A) Go Back to Path
                Semantics(
                  label: loc.lessonCompletedGoBackSemantic, // e.g. "Return to the path selection"
                  button: true,
                  child: ElevatedButton(
                    onPressed: () => _goHomeAndUpdatePath(
                      context: context,
                      ref: ref,
                      ctaSource: 'button_go_back_path',
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.02,
                      ),
                    ),
                    child: Text(
                      loc.lessonCompletedGoBackButton, // "Go Back to Path"
                      style: TextStyle(fontSize: screenWidth * 0.045),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // (B) Restart Lesson
                Semantics(
                  label: loc.lessonCompletedRestartSemantic, // e.g. "Restart the lesson"
                  button: true,
                  child: ElevatedButton(
                    onPressed: () => _restartLesson(context, ref),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.02,
                      ),
                    ),
                    child: Text(
                      loc.lessonCompletedRestartButton, // "Restart Lesson"
                      style: TextStyle(fontSize: screenWidth * 0.045),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Encouraging text
                Text(
                  loc.lessonCompletedEncouragement, // e.g. "Keep up the great work!"
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
