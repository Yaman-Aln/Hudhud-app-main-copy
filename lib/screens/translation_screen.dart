import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Logging & Analytics
import '../providers/ff_logging_service_provider.dart';
import '../providers/analytics_service_provider.dart';

// Services / Providers
import '../services/quran_service.dart'; // We'll read the quranServiceProvider

// NEW: localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

/// A screen showing translations for a given surah range ([startAyah..endAyah]).
/// [lessonId] and [pathId] let us tie analytics to a specific lesson & path.
class TranslationScreen extends ConsumerStatefulWidget {
  final int surahId;
  final String lessonId;
  final String pathId;
  final int startAyah;
  final int endAyah;

  const TranslationScreen({
    Key? key,
    required this.surahId,
    required this.lessonId,
    required this.pathId,
    required this.startAyah,
    required this.endAyah,
  }) : super(key: key);

  @override
  ConsumerState<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends ConsumerState<TranslationScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> translations = [];

  LoggingService get loggingService => ref.read(ffLoggingServiceProvider);

  @override
  void initState() {
    super.initState();

    // 1) Log "translation_screen_viewed"
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent(
      'translation_screen_viewed',
      parameters: {
        'surah_id': widget.surahId,
        'lesson_id': widget.lessonId,
        'path_id': widget.pathId,
        'start_ayah': widget.startAyah,
        'end_ayah': widget.endAyah,
      },
    );

    loggingService.logInfo('[TranslationScreen] Prior to _loadTranslations.');

    _loadTranslations();
  }

  // Load translations asynchronously using the QuranService
  Future<void> _loadTranslations() async {
    final analytics = ref.read(analyticsServiceProvider);

    try {
      // FIX: Use ref.read(...) to get our new QuranService
      final quranService = ref.read(quranServiceProvider);

      loggingService.logInfo(
        '[TranslationScreen] Fetching translations for surahId: ${widget.surahId}, '
            'startAyah: ${widget.startAyah}, endAyah: ${widget.endAyah}, '
            'pathId: ${widget.pathId}, lessonId: ${widget.lessonId}',
      );

      // Optionally log an event for the fetch request
      analytics.logEvent(
        'translation_fetch_requested',
        parameters: {
          'surah_id': widget.surahId,
          'start_ayah': widget.startAyah,
          'end_ayah': widget.endAyah,
          'lesson_id': widget.lessonId,
          'path_id': widget.pathId,
        },
      );

      // Call getTranslationsInRange(...) on the QuranService
      final fetchedTranslations = await quranService.getTranslationsInRange(
        widget.surahId,
        widget.startAyah,
        widget.endAyah,
      );

      // Log each translation item
      for (final t in fetchedTranslations) {
        loggingService.logError(
          '[IMPORTANT TRANSLATION ITEM] => id="${t['id']}", text="${t['text']}"',
        );
      }

      if (!mounted) return;
      setState(() {
        translations = fetchedTranslations;
        isLoading = false;
      });

      loggingService.logInfo('[TranslationScreen] Translations fetched successfully.');

      // Optionally log success
      analytics.logEvent(
        'translation_fetch_success',
        parameters: {
          'count': fetchedTranslations.length,
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);

      // Show a SnackBar if there's an error
      final loc = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${loc.translationScreenLoadError} $e'),
        ),
      );

      loggingService.logError('[TranslationScreen] Error loading translations: $e');

      // Optionally log an event for the failure
      final analytics = ref.read(analyticsServiceProvider);
      analytics.logEvent('translation_fetch_failure', parameters: {
        'error': e.toString(),
        'lesson_id': widget.lessonId,
        'path_id': widget.pathId,
      });
    }
  }

  /// Called when user taps the "Return to Lesson" button
  void _returnToLesson() {
    final analytics = ref.read(analyticsServiceProvider);
    // 2) Log "translation_return_to_lesson"
    analytics.logEvent('translation_return_to_lesson', parameters: {
      'from_screen': 'translation',
      'to_screen': 'lesson',
      'lesson_id': widget.lessonId,
      'path_id': widget.pathId,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[50],
        leading: Semantics(
          label: loc.translationScreenBackArrowSemantic, // e.g. "Return to lesson"
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // 3) Log "translation_back_pressed"
              analytics.logEvent('translation_back_pressed', parameters: {
                'from_screen': 'translation',
                'to_screen': 'lesson',
                'lesson_id': widget.lessonId,
                'path_id': widget.pathId,
              });
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          loc.translationScreenTitle, // e.g. "Translation"
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? Semantics(
        label: loc.translationScreenLoadingSemantic, // "Loading translations"
        child: const Center(child: CircularProgressIndicator()),
      )
          : (translations.isEmpty
          ? Center(
        child: Text(
          loc.translationScreenNoTranslations, // "No translations available."
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      )
          : _buildTranslationList(context, loc)),
    );
  }

  Widget _buildTranslationList(BuildContext context, AppLocalizations loc) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: translations.length,
              itemBuilder: (context, index) {
                final translation = translations[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                  ),
                  child: Text(
                    '${translation['text']}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.grey[800],
                    ),
                  ),
                );
              },
            ),
          ),
          Semantics(
            label: loc.translationScreenReturnSemantic, // e.g. "Tap to return to lesson"
            button: true,
            child: ElevatedButton(
              onPressed: _returnToLesson,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[50],
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.07,
                  vertical: screenHeight * 0.015,
                ),
              ),
              child: Text(
                loc.translationScreenReturnButton, // "Return to Lesson"
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
