import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

// Models
import '../models/path_model.dart';
import '../models/lesson_model.dart';

// Providers & Services
import '../providers/ff_logging_service_provider.dart';
import '../providers/analytics_service_provider.dart';
import '../providers/path_service_provider.dart';
import '../providers/progress_service_provider.dart'; // If you want progress
import '../services/analytics_service.dart';
import '../services/quran_service.dart';
// NEW: to fix "Undefined name 'localStorageServiceProvider'"
import '../providers/local_storage_service_provider.dart';

// For user profile / reciter config
import 'package:hudhud_quran_app_new/z_onboarding/providers/user_profile_provider.dart';

// Screens
import '../screens/lesson_screen.dart';
// We originally had PathListScreen here, but we're switching to ThemeScreen:
import 'theme_screen.dart';

// Widgets
import '../widgets/gratitude_modal.dart';
import '../widgets/submission_feedback_modal.dart';

// Localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// ADDED: SurahSearchScreen if you want to open search from here
import 'surah_search_screen.dart';

/// A screen displaying all lessons for [pathId] in a “LessonScreen-like” box.
///
/// Features:
/// 1) A localized heading at the top: “Tap any ayah below to open a lesson.” (Amiri font)
/// 2) A ListView of lesson “boxes,” each with top-left icons (Play x1 + Gratitude)
///    and Arabic verses (optionally with translation).
/// 3) Tapping anywhere in a box => go to [LessonScreen].
/// 4) A “Go to Theme” button at the bottom that navigates to [ThemeScreen].
/// 5) NEW: A “Play All” button in the AppBar that plays the entire surah range.
/// 6) NEW: A transliteration toggle (Arabic vs. transliteration/English).
class PathLessonsScreen extends ConsumerStatefulWidget {
  final int surahId;
  final String surahName;
  final int startAyah;
  final int endAyah;
  final String lessonId;
  final String pathId;

  const PathLessonsScreen({
    Key? key,
    required this.surahId,
    required this.surahName,
    required this.startAyah,
    required this.endAyah,
    required this.lessonId,
    required this.pathId,
  }) : super(key: key);

  @override
  ConsumerState<PathLessonsScreen> createState() => _PathLessonsScreenState();
}

class _PathLessonsScreenState extends ConsumerState<PathLessonsScreen> {
  // ---------------------------------------------------------------------------
  // Services
  // ---------------------------------------------------------------------------
  late final LoggingService   _loggingService;
  late final AnalyticsService _analytics;
  late final QuranService     _quranService;

  // ---------------------------------------------------------------------------
  // Path & Lessons
  // ---------------------------------------------------------------------------
  Path?        _path;
  List<Lesson> _lessons = [];

  // We store verses for each lesson in this map: “lessonId -> list of verses”
  final Map<String, List<Map<String, dynamic>>> _lessonVerses = {};

  // ---------------------------------------------------------------------------
  // Audio
  // ---------------------------------------------------------------------------
  final AudioPlayer _player = AudioPlayer();
  PlayerState       _playerState = PlayerState.stopped;
  String?           _currentLessonId;
  bool get _isPlaying => _playerState == PlayerState.playing;

  // “Play All” for the entire surah
  bool _isPlayAll       = false;      // Are we currently in "play all" mode?
  bool _isPlayAllActive = false;      // If actively playing the entire range

  // We'll keep repeatCount=1 for single-lesson icons
  final int _repeatCount = 1;

  // ---------------------------------------------------------------------------
  // Show/hide translation
  // ---------------------------------------------------------------------------
  bool _showTranslation = true;

  // ---------------------------------------------------------------------------
  // Transliteration vs. Arabic
  // ---------------------------------------------------------------------------
  bool _isTransliteration = false; // false = Arabic; true = English/Transliteration

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _loggingService = ref.read(ffLoggingServiceProvider);
    _analytics      = ref.read(analyticsServiceProvider);
    _quranService   = ref.read(quranServiceProvider);

    // 1) Load the user's transliteration preference first, then load path/lessons
    _loadIsTransliteration().then((_) => _loadPathAndLessons());

    // 2) Listen for audio state changes
    // COMMENTED OUT for multi-ayah fix: onPlayerStateChanged single-subscription conflict
    /*
    _player.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _playerState = state);
      if (state == PlayerState.stopped || state == PlayerState.completed) {
        // If “Play All” was active, end that mode.
        if (_isPlayAllActive) {
          setState(() {
            _isPlayAllActive = false;
            _isPlayAll       = false;
          });
        }
        setState(() => _currentLessonId = null);
      }
    });
    */

    // Also commented out for multi-ayah fix: onPlayerComplete single-subscription conflict
    /*
    _player.onPlayerComplete.listen((_) {
      if (!mounted) return;
      setState(() {
        _playerState     = PlayerState.completed;
        _currentLessonId = null;
        if (_isPlayAllActive) {
          _isPlayAllActive = false;
          _isPlayAll       = false;
        }
      });
    });
    */
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // LOAD USER TRANSLITERATION PREFERENCE
  // ---------------------------------------------------------------------------
  Future<void> _loadIsTransliteration() async {
    final ls = ref.read(localStorageServiceProvider);
    final storedVal = await ls.getBool('prefIsTransliterationSurahView') ?? false;
    _isTransliteration = storedVal;
  }

  Future<void> _saveIsTransliteration(bool val) async {
    final ls = ref.read(localStorageServiceProvider);
    await ls.saveBool('prefIsTransliterationSurahView', val);
  }

  void _toggleTransliteration() async {
    setState(() => _isTransliteration = !_isTransliteration);
    await _saveIsTransliteration(_isTransliteration);
    // Reload everything in transliteration mode
    await _loadPathAndLessons();
  }

  // ---------------------------------------------------------------------------
  // LOAD PATH => LESSONS => VERSES
  // ---------------------------------------------------------------------------
  Future<void> _loadPathAndLessons() async {
    final pathService = ref.read(pathServiceProviderRef);
    final fetchedPath = pathService.getPathById(widget.pathId);

    if (fetchedPath == null) {
      _loggingService.logError(
        '[PathLessonsScreen] No path found for pathId=${widget.pathId}',
      );
      setState(() => _lessons = []);
      return;
    }

    _path    = fetchedPath;
    _lessons = fetchedPath.lessons;

    _loggingService.logInfo(
      '[PathLessonsScreen] loaded path=${fetchedPath.id}, totalLessons=${_lessons.length}',
    );
    _analytics.logEvent('path_lessons_screen_loaded', parameters: {
      'path_id': fetchedPath.id,
      'lesson_count': _lessons.length,
      'surah_id': widget.surahId,
    });

    // For each lesson, load verses (in Arabic or transliteration)
    for (final lesson in _lessons) {
      final verseData = await _loadVersesForLesson(lesson);
      _lessonVerses[lesson.id] = verseData;
    }

    if (mounted) setState(() {});
  }

  Future<List<Map<String, dynamic>>> _loadVersesForLesson(Lesson lesson) async {
    List<Map<String, dynamic>> rawVerses;
    if (_isTransliteration) {
      // For transliteration, build a range of lines from getTransliteration(surahId, ay)
      final tmp = <Map<String, dynamic>>[];
      for (int ay = lesson.startAyah; ay <= lesson.endAyah; ay++) {
        final trn = _quranService.getTransliteration(lesson.surahId, ay) ??
            _quranService.getVerse(lesson.surahId, ay);
        final ayahEnd = _quranService.getArabicVerseEndSymbol(ay, arabicNumeral: true);
        tmp.add({
          'id': ay,
          'text': trn,
          'ayahEnd': ayahEnd,
        });
      }
      rawVerses = tmp;
    } else {
      // Original Arabic
      rawVerses = _quranService.getVersesInRange(
        lesson.surahId,
        lesson.startAyah,
        lesson.endAyah,
      );
      // Insert 'ayahEnd' symbol the same way we do for lesson screens
      int idx = 0;
      for (int ay = lesson.startAyah; ay <= lesson.endAyah; ay++) {
        final ayahEnd = _quranService.getArabicVerseEndSymbol(ay, arabicNumeral: true);
        if (idx < rawVerses.length) {
          rawVerses[idx]['ayahEnd'] = ayahEnd;
        }
        idx++;
      }
    }

    // Then fill in translations
    final rawTranslations = await _quranService.getTranslationsInRange(
      lesson.surahId,
      lesson.startAyah,
      lesson.endAyah,
    );

    final translationMap = <String, String>{};
    for (final tv in rawTranslations) {
      final tid  = tv['id']?.toString() ?? '';
      final text = tv['text'] ?? '';
      translationMap[tid] = text;
    }

    for (final v in rawVerses) {
      final vid = v['id']?.toString() ?? '';
      v['translation'] = translationMap[vid] ?? '';
    }
    return rawVerses;
  }

  // ---------------------------------------------------------------------------
  // APP BAR ACTIONS: PLAY ALL, SEARCH, TOGGLE TRANSLATION
  // ---------------------------------------------------------------------------
  Future<void> _togglePlayAllAudio() async {
    // If currently playing all, we stop
    if (_isPlayAllActive) {
      await _player.stop();
      if (!mounted) return;
      setState(() {
        _isPlayAll       = false;
        _isPlayAllActive = false;
      });
      return;
    }

    // Otherwise, start
    setState(() {
      _isPlayAll = true;
      _isPlayAllActive = true;
    });

    final reciterNo = ref.read(userProfileProvider).reciterId;
    _analytics.logEvent('path_lessons_surah_play_all_clicked', parameters: {
      'surah_id': widget.surahId,
      'startAyah': widget.startAyah,
      'endAyah': widget.endAyah,
      'path_id': _path?.id ?? '',
    });

    try {
      for (int ay = widget.startAyah; ay <= widget.endAyah; ay++) {
        final url = 'https://quranaudio.pages.dev/$reciterNo/${widget.surahId}_$ay.mp3';
        await _player.play(UrlSource(url));
        await _player.onPlayerComplete.first;

        if (!_isPlayAllActive) break; // user canceled
      }
      if (!mounted) return;
      setState(() {
        _isPlayAllActive = false;
        _isPlayAll       = false;
      });
    } catch (e) {
      _loggingService.logError('[PathLessonsScreen] error playing entire Surah => $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing entire surah: $e')),
      );
      setState(() {
        _isPlayAllActive = false;
        _isPlayAll       = false;
      });
    }
  }

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
        centerTitle: true,
        backgroundColor: Colors.blue[50],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: _onBack,
        ),
        actions: [
          // (A) “Play All”
          IconButton(
            icon: Icon(
              (_isPlayAllActive) ? Icons.stop_circle_outlined : Icons.play_circle_filled,
              color: Colors.black,
            ),
            tooltip: loc.playAllSurahSemantic, // e.g. "Play entire surah range"
            onPressed: _togglePlayAllAudio,
          ),

          // (B) Magnifying-glass (search)
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: loc.pathLessonsSearchIconSemantic, // e.g. "Search Surahs"
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SurahSearchScreen()),
              );
            },
          ),

          // (C) Toggle translation
          IconButton(
            icon: Icon(_showTranslation ? Icons.language : Icons.language_outlined),
            color: Colors.black,
            tooltip: loc.toggleTranslationLabel,
            onPressed: () => setState(() => _showTranslation = !_showTranslation),
          ),

          // (D) Toggle transliteration vs. Arabic
          IconButton(
            icon: Icon(
              _isTransliteration ? Icons.sort_by_alpha : Icons.sort,
              color: _isTransliteration ? Colors.orange : Colors.black,
            ),
            tooltip: loc.toggleTransliterationLabel,
            onPressed: _toggleTransliteration,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // (A) heading
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Text(
                loc.clickOnAyaToOpenLesson,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Switch for Arabic <-> Transliteration
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    loc.arabicLabel,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Switch(
                    value: _isTransliteration,
                    onChanged: (val) async {
                      setState(() => _isTransliteration = val);
                      await _saveIsTransliteration(val);
                      await _loadPathAndLessons();
                    },
                  ),
                  Text(
                    loc.englishLabel,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),

            // (B) The lessons list or "No lessons" message
            Expanded(
              child: _lessons.isEmpty
                  ? Center(
                child: Text(
                  loc.verticalLessonIconsNoLessons,
                  style: const TextStyle(color: Colors.red),
                ),
              )
                  : ListView.separated(
                itemCount: _lessons.length,
                separatorBuilder: (_, __) => const Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                ),
                itemBuilder: (ctx, index) {
                  final lesson    = _lessons[index];
                  final verseData = _lessonVerses[lesson.id] ?? [];
                  return _buildLessonBox(ctx, lesson, verseData, index, loc);
                },
              ),
            ),

            // (C) "Go to Theme" button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: _onGoToTheme,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: Colors.orange,
                ),
                child: Text(
                  loc.verticalLessonIconsGoToTheme,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Lesson box builder
  // ---------------------------------------------------------------------------
  Widget _buildLessonBox(
      BuildContext context,
      Lesson lesson,
      List<Map<String, dynamic>> verses,
      int index,
      AppLocalizations loc,
      ) {
    final isThisLessonPlaying = (_currentLessonId == lesson.id) && _isPlaying;
    final verseWidgets        = _buildVerseWidgets(context, verses);

    return GestureDetector(
      onTap: () => _openLesson(lesson, index + 1),
      child: Container(
        margin: const EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // The padded column of verses
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 60, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: verseWidgets,
              ),
            ),

            // Top-left icons
            Positioned(
              top: 5,
              left: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PLAY
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: const BorderRadius.only(
                        topLeft:  Radius.circular(15),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: IconButton(
                            icon: Icon(isThisLessonPlaying ? Icons.pause : Icons.play_arrow),
                            color: Colors.black,
                            iconSize: 20,
                            onPressed: () => _toggleLessonAudio(lesson),
                          ),
                        ),
                        // x1 badge
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              'x$_repeatCount',
                              style: const TextStyle(
                                fontFamily: 'Amiri',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),

                  // GRATITUDE
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(5),
                      ),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: IconButton(
                      onPressed: () => _openGratitudeForLesson(lesson),
                      icon: const Icon(Icons.volunteer_activism, color: Colors.black),
                      iconSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds either Arabic or transliteration text + optional translation
  List<Widget> _buildVerseWidgets(
      BuildContext context,
      List<Map<String, dynamic>> verses,
      ) {
    final userProfile      = ref.watch(userProfileProvider);
    final arabicFontFamily = userProfile.fontFamily;
    final arabicFontWeight =
    (userProfile.fontWeight == 700) ? FontWeight.bold : FontWeight.normal;

    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widgets = <Widget>[];

    for (final verse in verses) {
      final originalText = verse['text'] ?? '';
      final translation  = verse['translation'] ?? '';
      final ayahEndStr   = verse['ayahEnd'] ?? '';

      // Build text line
      final words = originalText.split(' ');
      final spans = <InlineSpan>[];

      for (final w in words) {
        spans.add(
          TextSpan(
            text: ' $w ',
            style: TextStyle(
              fontSize: screenWidth * 0.07,
              fontFamily: _isTransliteration ? null : arabicFontFamily,
              // transliteration => system font
              fontWeight: _isTransliteration ? FontWeight.normal : arabicFontWeight,
              height: 1.8,
              color: Colors.black,
            ),
          ),
        );
      }
      if (ayahEndStr.trim().isNotEmpty && !_isTransliteration) {
        spans.add(
          TextSpan(
            text: ' $ayahEndStr ',
            style: TextStyle(
              fontSize: screenWidth * 0.07,
              fontFamily: 'Amiri',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.8,
            ),
          ),
        );
      }

      // If transliteration => LTR, else => RTL
      final textDir = _isTransliteration ? TextDirection.ltr : TextDirection.rtl;

      widgets.add(
        Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.01),
          child: Align(
            alignment: Alignment.center,
            child: RichText(
              textAlign: textDir == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
              textDirection: textDir,
              text: TextSpan(children: spans),
            ),
          ),
        ),
      );

      if (_showTranslation && translation.isNotEmpty) {
        widgets.add(
          Padding(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.02,
              left: screenWidth * 0.04,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                translation,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        );
      } else {
        widgets.add(SizedBox(height: screenHeight * 0.02));
      }
    }

    return widgets;
  }

  // ---------------------------------------------------------------------------
  // “OPEN LESSON” / NAV
  // ---------------------------------------------------------------------------
  void _onBack() => Navigator.of(context).pop();

  void _openLesson(Lesson lesson, int lessonNumber) {
    _analytics.logEvent('path_lessons_open_lesson', parameters: {
      'path_id': _path?.id ?? '',
      'lesson_id': lesson.id,
      'lesson_num': lessonNumber,
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonScreen(
          lessonId:     lesson.id,
          surahId:      lesson.surahId,
          pathId:       _path?.id ?? '',
          languageCode: 'en',
        ),
      ),
    );
  }

  /// Navigate to [ThemeScreen] corresponding to the first theme ID if available.
  void _onGoToTheme() {
    _analytics.logEvent('path_lessons_go_to_theme_clicked', parameters: {
      'path_id': _path?.id ?? '',
    });

    if (_path == null || _path!.themeIds.isEmpty) {
      _loggingService.logWarning(
        '[PathLessonsScreen] Path has no themeIds; cannot navigate to ThemeScreen.',
      );
      return;
    }

    final themeId = _path!.themeIds.first;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ThemeScreen(
          pathId:  _path!.id,
          themeId: themeId,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // AUDIO FOR INDIVIDUAL LESSON
  // ---------------------------------------------------------------------------
  Future<void> _toggleLessonAudio(Lesson lesson) async {
    final sc = ScaffoldMessenger.of(context);

    // If the same lesson is playing => stop
    if (_currentLessonId == lesson.id && _isPlaying) {
      await _player.stop();
      if (!mounted) return;
      setState(() => _currentLessonId = null);
      return;
    }

    // Stop any existing playback
    await _player.stop();
    if (!mounted) return;
    setState(() => _currentLessonId = lesson.id);

    final start = lesson.startAyah;
    final end   = lesson.endAyah;
    final sId   = lesson.surahId;

    final userProfile = ref.read(userProfileProvider);
    final reciterNo   = userProfile.reciterId; // or just "1"

    try {
      for (int ay = start; ay <= end; ay++) {
        final url = 'https://quranaudio.pages.dev/$reciterNo/${sId}_$ay.mp3';
        await _player.play(UrlSource(url));
        await _player.onPlayerComplete.first;

        // If user tapped stop or changed lessons, break
        if (_currentLessonId != lesson.id) break;
      }
    } catch (e) {
      _loggingService.logError(
        '[PathLessonsScreen] error playing audio => $e (lessonId=${lesson.id})',
      );
      if (!mounted) return;
      sc.showSnackBar(
        SnackBar(content: Text('Error playing audio: $e')),
      );
      setState(() => _currentLessonId = null);
    }
  }

  // ---------------------------------------------------------------------------
  // GRATITUDE
  // ---------------------------------------------------------------------------
  void _openGratitudeForLesson(Lesson lesson) {
    _analytics.logEvent('path_lessons_gratitude_clicked', parameters: {
      'path_id':  _path?.id ?? '',
      'lesson_id': lesson.id,
    });

    showDialog<List<String>>(
      context:      context,
      barrierColor: Colors.black54,
      builder:      (_) => const GratitudeModal(),
    ).then((submitted) {
      if (!mounted || submitted == null || submitted.isEmpty) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        showDialog<void>(
          context:      context,
          barrierColor: Colors.black54,
          builder:      (_) => SubmissionFeedbackModal(submittedGratitudes: submitted),
        );
      });
    });
  }
}
