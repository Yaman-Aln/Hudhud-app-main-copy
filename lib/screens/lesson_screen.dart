import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui' as ui;

// NEW: For playing single-ayah audio
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

// ADDITION: permission_handler import
import 'package:permission_handler/permission_handler.dart';

import '../screens/path_lessons_screen.dart'; // <-- Add this near the top

import '../services/quran_service.dart';
import '../widgets/gratitude_modal.dart';
import 'package:hudhud_quran_app_new/main.dart' show isOnlineProvider;
import '../widgets/submission_feedback_modal.dart';
import '../services/local_storage_service.dart';
import '../services/scoring_service.dart';
import '../screens/completed_lesson_screen.dart';
import '../screens/home_screen.dart'; // (NEW) so we can navigate to Home if forcedFirstLesson
import '../screens/path_detail_screen.dart';
import '../screens/translation_screen.dart'; // For opening the separate translation screen
import '../providers/local_storage_service_provider.dart';
import '../providers/lesson_service_provider.dart';
// We use lessonSubmitProvider for daily lesson logs.
import '../providers/lesson_submit_provider.dart';
import '../providers/voice_transcription_provider.dart'; // Must return a VoiceTranscriptionService
import '../providers/path_service_provider.dart';
import '../providers/quran_distractor_provider.dart';
import '../providers/progress_service_provider.dart' as progress_service;
import '../providers/difficulty_service_provider.dart';
import '../providers/similarity_service_provider.dart';
import '../providers/hint_service_provider.dart';
import '../providers/repeat_service_provider.dart';
import '../providers/server_time_provider.dart';
import 'package:hudhud_quran_app_new/z_onboarding/models/unique_test_model.dart';

import '../providers/ff_logging_service_provider.dart'; // Logging service
import '../services/repeat_service.dart';
import '../services/audio_playback_service.dart';
import '../models/difficulty_level_model.dart';
import '../models/path_model.dart';
import '../models/lesson_model.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/progress_bar.dart';

// NEW: Analytics
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// NEW: Generated localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// We read the user's chosen reciter + font + subscription tier from user_profile_provider:
import 'package:hudhud_quran_app_new/z_onboarding/providers/user_profile_provider.dart';

// NEW: We import our distractor service for reference
import '../services/quran_distractor_service.dart';

/// Step structure for a single multiple-choice question:
/// [correctAnswer] might be a single word or a "two words" combo.
/// [options] are the 4 choices (including the correct one).
/// [isPair] indicates whether it's a pair of words.
/// [correctIndices] is the list of global word indices to remove from displayedVerses.
class _MCQuestion {
  final String correctAnswer;
  final List<String> options;
  final bool isPair;
  final List<int> correctIndices;

  _MCQuestion({
    required this.correctAnswer,
    required this.options,
    required this.isPair,
    required this.correctIndices,
  });
}

/// A stateful widget that manages the exercise logic for a single lesson.
///
/// [forcedFirstLesson]: if true, we display this lesson immediately after onboarding.
///   - As soon as the lesson loads, we set didShowLessonOneImmediately=true so that
///     main.dart no longer tries to re-show it.
///   - If the user taps back arrow, we push them to [HomeScreen] instead of the normal back stack.
class LessonScreen extends ConsumerStatefulWidget {
  final int surahId;
  final String languageCode;
  final String lessonId;
  final String pathId;
  final bool isReviewMode;
  final bool forcedFirstLesson;

  const LessonScreen({
    Key? key,
    required this.surahId,
    required this.languageCode,
    required this.lessonId,
    required this.pathId,
    this.isReviewMode = false,
    this.forcedFirstLesson = false,
  }) : super(key: key);

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  // -------------------------------------------------------------------------
  // Services & Providers
  // -------------------------------------------------------------------------
  late final QuranService quranService;
  late final AudioPlaybackService audioPlaybackService;

  late final QuranDistractorService _distractorService =
  ref.read(quranDistractorServiceProvider);

  late final difficultyService = ref.read(difficultyServiceProvider);
  late final similarityService = ref.read(similarityServiceProvider);
  late final progressService = ref.read(progress_service.progressServiceProvider);
  late final lessonService = ref.read(lessonServiceProviderRef);
  late final repeatService = ref.read(repeatServiceProvider);

  /// (REMAINS UNCHANGED) This getter still exists, as requested:
  LoggingService get loggingService => ref.read(ffLoggingServiceProvider);

  // NEW: We store the logging service in a final variable to avoid ref.read after dispose.
  late final LoggingService _logger;

  late final analytics = ref.read(analyticsServiceProvider);

  // ScoreService
  late final ScoreService scoreService = ScoreService();

  // -------------------------------------------------------------------------
  // Lesson State
  // -------------------------------------------------------------------------
  /// We declare _startAyah and _endAyah in the State so we can modify them.
  int? _startAyah;
  int? _endAyah;

  DifficultyLevel selectedDifficultyLevel = DifficultyLevel.multipleChoice;
  int selectedRepeatCount = 2;
  int currentRepeatCount = 0;
  int totalSteps = 0;
  int currentStepIndex = 0;
  bool exerciseStarted = false;
  bool isFeedbackMode = false;
  bool submitEnabled = true;
  bool showCorrectAnswer = false;
  bool _showEmptyInputWarning = false;
  bool _showTranslation = true;

  // [NEW] indicates whether user wants transliterated text (true) or Arabic (false)
  bool _isTransliteration = false;

  List<Map<String, dynamic>> verses = [];
  List<Map<String, dynamic>> displayedVerses = [];
  List<int> currentIndicesToRemove = [];
  Set<int> cumulativeIndicesToRemove = {};

  final TextEditingController _userInputController = TextEditingController();
  final Map<int, String> userIncorrectInputs = {};
  List<Map<String, dynamic>> _lastRemovedWords = [];

  bool isExerciseCompleted = false;

  // Audio
  final AudioPlayer _singleAyahPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.stopped;
  bool get _isAyahPlaying => _playerState == PlayerState.playing;

  // For daily limit (premiumPlus)
  static const int _dailyLimitSeconds = 600;
  bool _dailyLimitReached = false;
  DateTime? _transcriptionStart;
  int _usedSecondsSoFar = 0;
  bool _shownDailyLimitDialog = false;

  // For free voice usage
  static const int _FREE_VOICE_USAGE_LIMIT = 0;
  int _freeVoiceUsageCount = 0;

  // MULTIPLE CHOICE
  List<_MCQuestion> _multipleChoiceSteps = [];
  int _mcQuestionIndex = 0;
  String? _selectedMCOption;
  bool _mcSubmitted = false;

  // -------------------------------------------------------------------------
  // NEW: Lock UI except the Difficulty dropdown on forcedFirstLesson
  // -------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    quranService = ref.read(quranServiceProvider);
    audioPlaybackService = AudioPlaybackService();

    // Initialize our local logger to avoid using ref.read in dispose
    _logger = ref.read(ffLoggingServiceProvider);

    _logger.logError(
      '[LessonScreen] initState => surahId=${widget.surahId}, lessonId=${widget.lessonId}, forced=${widget.forcedFirstLesson}',
    );

    analytics.logEvent('lesson_screen_viewed', parameters: {
      'lesson_id': widget.lessonId,
      'path_id': widget.pathId,
      'surah_id': widget.surahId,
      'forced_first_lesson': widget.forcedFirstLesson.toString(),
    });

    // If forcedFirstLesson => we still do a quick callback so we won't show it again
    if (widget.forcedFirstLesson) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final ls = ref.read(localStorageServiceProvider);
        await ls.setDidShowLessonOneImmediately(true);
        _logger.logError(
          '[LessonScreen] forcedFirstLesson => set didShowLessonOneImmediately=true',
        );
      });
    }

    // COMMENTED OUT the onPlayerStateChanged for multi-ayah fix
    // Because each ayah triggers "completed" at the end, which sets _playerState=stopped,
    // messing up the multi-ayah loop in _toggleAyahPlayback().
    /*
    _singleAyahPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (!mounted) return;
      setState(() => _playerState = s);
    });
    */

    // (A) Load the user's transliteration setting from Hive/local storage
    _loadIsTransliteration();

    // Load verses, difficulty, repeats
    _loadVerses();
    _loadDifficultyLevel();
    _loadRepeatCount();

    // Possibly check daily limit + free voice usage
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _possiblyCheckDailyLimit();
      await _loadFreeVoiceUsageCount();
    });
  }

  @override
  void dispose() {
    // Use _logger, not loggingService, so we don't do ref.read(...) after dispose
    _logger.logInfo('[LessonScreen] dispose() called => cleaning up controllers');
    _userInputController.dispose();
    audioPlaybackService.dispose();
    _singleAyahPlayer.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // (1) LOAD _isTransliteration FROM HIVE
  // -------------------------------------------------------------------------
  /// Loads the user's transliteration preference from Hive/local storage.
  /// If no value is found, default to 'false' (i.e. Arabic).
  Future<void> _loadIsTransliteration() async {
    final ls = ref.read(localStorageServiceProvider);
    final storedValue = await ls.getBool('prefIsTransliteration') ?? false;
    setState(() {
      _isTransliteration = storedValue;
    });
  }

  // -------------------------------------------------------------------------
  // FREE VOICE USAGE
  // -------------------------------------------------------------------------
  Future<void> _loadFreeVoiceUsageCount() async {
    final ls = ref.read(localStorageServiceProvider);
    final count = await ls.getInt('freeVoiceUsageCount') ?? 0;
    setState(() => _freeVoiceUsageCount = count);

    _logger.logError(
      '[LessonScreen] loaded _freeVoiceUsageCount=$count (limit=$_FREE_VOICE_USAGE_LIMIT)',
    );
  }

  Future<void> _incrementFreeVoiceUsageCount() async {
    final ls = ref.read(localStorageServiceProvider);
    final newCount = _freeVoiceUsageCount + 1;
    await ls.saveInt('freeVoiceUsageCount', newCount);
    setState(() => _freeVoiceUsageCount = newCount);

    _logger.logError('[LessonScreen] incremented _freeVoiceUsageCount=$newCount');
  }

  void _showUpgradeDialog() {
    final loc = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(
          loc.upgradeVoiceUsageTitle,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Text(
          loc.upgradeVoiceUsageMessage,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(loc.okLabel, style: const TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // PREMIUM+ DAILY LIMIT
  // -------------------------------------------------------------------------
  Future<void> _possiblyCheckDailyLimit() async {
    final userTier = ref.read(userProfileProvider).subscriptionTier;
    if (userTier != SubscriptionTier.premiumPlus) return;
    await _checkDailyLimit();
  }

  Future<void> _checkDailyLimit() async {
    final ls = ref.read(localStorageServiceProvider);
    final nowUtc = await ref.read(serverTimeServiceProvider).fetchServerUtcTime();
    final userOffset = ref.read(userUtcOffsetProvider);
    final localMidnightUtc =
    ref.read(serverTimeServiceProvider).calculateUserLocalMidnightUtc(nowUtc, userOffset);

    final lastReset = await ls.getHiveString('voice_lastResetUtc');
    if (lastReset == null) {
      await ls.saveString('voice_lastResetUtc', localMidnightUtc.toIso8601String());
      await ls.saveInt('voice_usedSeconds', 0);
    } else {
      final lastResetUtc = DateTime.tryParse(lastReset);
      if (lastResetUtc == null) {
        await ls.saveString('voice_lastResetUtc', localMidnightUtc.toIso8601String());
        await ls.saveInt('voice_usedSeconds', 0);
      } else {
        if (localMidnightUtc.isAfter(lastResetUtc) && nowUtc.isAfter(localMidnightUtc)) {
          await ls.saveString('voice_lastResetUtc', localMidnightUtc.toIso8601String());
          await ls.saveInt('voice_usedSeconds', 0);
        }
      }
    }

    final used = await ls.getInt('voice_usedSeconds') ?? 0;
    setState(() {
      _usedSecondsSoFar = used;
      _dailyLimitReached = (used >= _dailyLimitSeconds);
    });

    _logger.logError(
      '[LessonScreen] _checkDailyLimit => used=$used, dailyLimitReached=$_dailyLimitReached',
    );
  }

  void _showDailyLimitDialog() {
    final loc = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          loc.dailyVoiceLimitReachedTitle,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Text(
          loc.dailyVoiceLimitReachedMessage,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(loc.okLabel, style: const TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Future<void> _incrementUsage(int seconds) async {
    final userTier = ref.read(userProfileProvider).subscriptionTier;
    if (userTier != SubscriptionTier.premiumPlus) return;
    final ls = ref.read(localStorageServiceProvider);

    final used = await ls.getInt('voice_usedSeconds') ?? 0;
    final safeSeconds = (seconds < 1) ? 1 : seconds;
    final updated = used + safeSeconds;
    final finalVal = updated > _dailyLimitSeconds ? _dailyLimitSeconds : updated;

    await ls.saveInt('voice_usedSeconds', finalVal);
    setState(() {
      _usedSecondsSoFar = finalVal;
      _dailyLimitReached = (finalVal >= _dailyLimitSeconds);
    });
    if (_dailyLimitReached && !_shownDailyLimitDialog) {
      _shownDailyLimitDialog = true;
      _showDailyLimitDialog();
    }
  }

  // -------------------------------------------------------------------------
  // DIFFICULTY & REPEAT
  // -------------------------------------------------------------------------
  Future<void> _loadRepeatCount() async {
    final ls = ref.read(localStorageServiceProvider);
    final savedRepeat = await ls.getRepeatCount(widget.lessonId);

    if (savedRepeat != null) {
      setState(() => selectedRepeatCount = savedRepeat);
      _logger.logError('[LessonScreen] loaded repeat=$savedRepeat from localStorage');
    } else {
      final globalRepeat = ref.read(userProfileProvider).defaultRepeatCount;
      if (globalRepeat != null) {
        setState(() => selectedRepeatCount = globalRepeat);
        _logger.logError('[LessonScreen] fallback to userProfile defaultRepeat=$globalRepeat');
      } else {
        setState(() => selectedRepeatCount = 1);
        _logger.logError('[LessonScreen] no local or userProfile default => using 1');
      }
    }
  }

  Future<void> _loadDifficultyLevel() async {
    final ls = ref.read(localStorageServiceProvider);
    final savedDifficulty = await ls.getDifficultyLevel(widget.lessonId);

    if (savedDifficulty != null) {
      setState(() => selectedDifficultyLevel = savedDifficulty);
      _logger.logError(
        '[LessonScreen] loaded difficulty=$savedDifficulty from localStorage (lesson-specific)',
      );
    } else {
      // If no lesson-specific override, fallback to userProfile's defaultDifficulty
      final globalDefault = ref.read(userProfileProvider).defaultDifficulty;
      if (globalDefault != null) {
        setState(() => selectedDifficultyLevel = globalDefault);
        _logger.logError(
          '[LessonScreen] fallback to userProfile default=$globalDefault',
        );
      } else {
        // If userProfile also has no default => fallback to multipleChoice
        setState(() => selectedDifficultyLevel = DifficultyLevel.multipleChoice);
        _logger.logError(
          '[LessonScreen] no local or userProfile default => using multipleChoice',
        );
      }
    }
  }

  // -------------------------------------------------------------------------
  // VERSES & PROGRESS INIT
  // -------------------------------------------------------------------------
  Future<void> _loadVerses() async {
    try {
      final lessonDetails = await lessonService.getLessonDetails(widget.lessonId);
      _startAyah = lessonDetails['startAyah'] as int?;
      _endAyah = lessonDetails['endAyah'] as int?;

      // CHANGED: fetch transliteration or Arabic based on _isTransliteration
      final rawVerses = <Map<String, dynamic>>[];

      final start = _startAyah ?? 1;
      final end = _endAyah ?? 7;

      _logger.logInfo('[LessonScreen] _loadVerses() => start=$start, end=$end');

      for (int ay = start; ay <= end; ay++) {
        String verseText;
        if (_isTransliteration) {
          verseText = quranService.getTransliteration(widget.surahId, ay)
              ?? quranService.getVerse(widget.surahId, ay); // fallback
        } else {
          verseText = quranService.getVerse(widget.surahId, ay);
        }

        final ayahEnd = quranService.getArabicVerseEndSymbol(ay, arabicNumeral: true);
        rawVerses.add({
          'id': ay,
          'text': verseText,
          'ayahEnd': ayahEnd,
        });
      }

      final rawTranslations = await quranService.getTranslationsInRange(
        widget.surahId,
        start,
        end,
      );

      final translationMap = <String, String>{};
      for (final tverse in rawTranslations) {
        final tid = tverse['id'].toString();
        final txt = tverse['text'] ?? '';
        translationMap[tid] = txt;
      }

      for (final v in rawVerses) {
        final vid = v['id']?.toString() ?? '';
        final trans = translationMap[vid] ?? '';
        v['translation'] = trans;
      }

      setState(() {
        verses = rawVerses;
        _prepareDisplayedVerses();
      });

      _logger.logInfo('[LessonScreen] _loadVerses => verses count: ${verses.length}');

      await _initializeProgress(selectedDifficultyLevel);
    } catch (e) {
      _logger.logError('[LessonScreen] error loading verses => $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading verses: $e')),
      );
    }
  }

  Future<void> _initializeProgress(DifficultyLevel difficulty, {bool reset = false}) async {
    _logger.logInfo(
      '[LessonScreen] _initializeProgress(difficulty=$difficulty, reset=$reset)',
    );

    if (reset) {
      currentStepIndex = 0;
      userIncorrectInputs.clear();
      exerciseStarted = false;
      cumulativeIndicesToRemove.clear();
      await repeatService.resetCurrentRepeat(widget.lessonId);
    } else {
      final pd = await progressService.getLessonProgress(widget.lessonId, pathId: widget.pathId);
      currentStepIndex = pd['currentStep'] ?? 0;
    }

    _updateTotalSteps();
    _updateWordsForCurrentStep(difficulty);

    // Only build MC steps anew if reset or we haven't built them yet
    if (difficulty == DifficultyLevel.multipleChoice && reset) {
      _initializeMultipleChoiceSteps();
    }
  }

  /// HELPER: We update partial progress after the user presses SUBMIT
  Future<void> _updatePartialProgressOnSubmit() async {
    if (totalSteps == 0) return;
    final partial = ((currentStepIndex + 1) / totalSteps) * 100;
    final safeProg = partial.clamp(0, 100).ceil();

    _logger.logInfo(
      '[LessonScreen] _updatePartialProgressOnSubmit => partial=$partial, safeProg=$safeProg',
    );

    await progressService.updateLessonProgress(
      widget.lessonId,
      safeProg,
      currentStep: currentStepIndex,
      pathId: widget.pathId,
    );
    await progressService.calculateAndSavePathProgress(widget.pathId);
  }

  void _prepareDisplayedVerses() {
    displayedVerses.clear();
    int globalIndex = 0;

    for (final verse in verses) {
      final words = verse['text'].split(' ');
      final ayahEndStr = verse['ayahEnd'] ?? '(END)';
      final trans = verse['translation'] ?? '';

      final startIndex = globalIndex;

      final wordList = <Map<String, dynamic>>[];
      for (final w in words) {
        wordList.add({
          'word': w,
          'isRemoved': false,
          'similarity': null,
          'globalWordIndex': globalIndex,
          'isAyahMarker': false,
        });
        globalIndex++;
      }
      if (ayahEndStr.trim().isNotEmpty) {
        wordList.add({
          'word': ayahEndStr,
          'isRemoved': false,
          'similarity': null,
          'isAyahMarker': true,
          'globalWordIndex': globalIndex,
        });
        globalIndex++;
      }

      final endIndex = globalIndex - 1;

      displayedVerses.add({
        'id': verse['id'],
        'words': wordList,
        'translation': trans,
        'startGlobalWordIndex': startIndex,
        'endGlobalWordIndex': endIndex,
      });
    }
  }

  void _updateTotalSteps() {
    final stepsPerCycle =
    difficultyService.getTotalStepsPerCycle(verses, selectedDifficultyLevel);
    totalSteps = stepsPerCycle < 1 ? 1 : stepsPerCycle;

    _logger.logInfo('[LessonScreen] _updateTotalSteps => totalSteps=$totalSteps');
  }

  void _updateWordsForCurrentStep(DifficultyLevel difficulty) {
    if (!exerciseStarted) {
      for (final dv in displayedVerses) {
        for (final w in dv['words']) {
          w['isRemoved'] = false;
        }
      }
      return;
    }

    if (difficulty == DifficultyLevel.multipleChoice) {
      if (_mcQuestionIndex < 0 || _mcQuestionIndex >= _multipleChoiceSteps.length) return;
      cumulativeIndicesToRemove.clear();
      final question = _multipleChoiceSteps[_mcQuestionIndex];
      cumulativeIndicesToRemove.addAll(question.correctIndices);
    } else {
      final totalStepsPerCycle =
      difficultyService.getTotalStepsPerCycle(verses, difficulty);
      int effIdx = currentStepIndex;
      if (effIdx >= totalStepsPerCycle) effIdx = totalStepsPerCycle - 1;

      final allWords = displayedVerses
          .expand((v) => v['words'] as List)
          .where((x) => x['isAyahMarker'] == false)
          .map((x) => x['word'] as String)
          .toList();

      final removalIndices = difficultyService.getRemovalIndices(
        difficulty,
        effIdx,
        allWords,
        displayedVerses.length,
        displayedVerses: displayedVerses,
      );
      currentIndicesToRemove = removalIndices.cast<int>();
      cumulativeIndicesToRemove.addAll(currentIndicesToRemove);
    }

    for (final dv in displayedVerses) {
      for (final w in dv['words']) {
        final idx = w['globalWordIndex'] as int;
        w['isRemoved'] = cumulativeIndicesToRemove.contains(idx);
      }
    }
  }

  // MULTIPLE CHOICE
  void _initializeMultipleChoiceSteps() {
    _logger.logInfo('[LessonScreen] _initializeMultipleChoiceSteps');

    _multipleChoiceSteps.clear();
    _mcQuestionIndex = 0;
    _selectedMCOption = null;
    _mcSubmitted = false;

    final allWords = <Map<String, dynamic>>[];
    for (final dv in displayedVerses) {
      final wlist = dv['words'] as List;
      for (final w in wlist) {
        if (w['isAyahMarker'] == false) {
          allWords.add({
            'text': w['word'],
            'index': w['globalWordIndex'],
          });
        }
      }
    }

    final totalWords = allWords.length;
    if (totalWords < 1) return;

    final singleWordSteps = <_MCQuestion>[];
    for (int i = 0; i < totalWords; i++) {
      final text = allWords[i]['text'] as String;
      final idx = allWords[i]['index'] as int;
      final distractors = _generateDistractors(text, 3);
      final options = [text, ...distractors]..shuffle();
      singleWordSteps.add(_MCQuestion(
        correctAnswer: text,
        options: options,
        isPair: false,
        correctIndices: [idx],
      ));
    }

    final pairSteps = <_MCQuestion>[];
    for (int i = 0; i < totalWords - 1; i++) {
      final first = allWords[i];
      final second = allWords[i + 1];
      final pairText = '${first['text']} ${second['text']}';
      final distractors = _generateDistractors(pairText, 3);
      final options = [pairText, ...distractors]..shuffle();
      pairSteps.add(_MCQuestion(
        correctAnswer: pairText,
        options: options,
        isPair: true,
        correctIndices: [first['index'], second['index']],
      ));
    }

    if (selectedRepeatCount == 1) {
      _multipleChoiceSteps.addAll(singleWordSteps);
      if (pairSteps.isNotEmpty) {
        _multipleChoiceSteps.add(pairSteps.first);
        if (pairSteps.length > 2) {
          _multipleChoiceSteps.add(pairSteps.last);
        } else if (pairSteps.length == 2) {
          _multipleChoiceSteps.add(pairSteps[1]);
        }
      }
    } else {
      _multipleChoiceSteps.addAll(singleWordSteps);
      _multipleChoiceSteps.addAll(pairSteps);

      if (selectedRepeatCount > 1) {
        final copyList = List<_MCQuestion>.from(_multipleChoiceSteps);
        for (int r = 1; r < selectedRepeatCount; r++) {
          final repeated = copyList.map((step) {
            final newDistractors = _generateDistractors(step.correctAnswer, 3);
            final newOptions = [step.correctAnswer, ...newDistractors]..shuffle();
            return _MCQuestion(
              correctAnswer: step.correctAnswer,
              options: newOptions,
              isPair: step.isPair,
              correctIndices: step.correctIndices,
            );
          }).toList();
          _multipleChoiceSteps.addAll(repeated);
        }
      }
    }
  }

  List<String> _generateDistractors(String correct, int count) {
    if (correct.trim().contains(' ')) {
      return _distractorService.getTwoWordDistractors(
        correct,
        count,
        useTranslit: _isTransliteration,
      );
    } else {
      return _distractorService.getSingleWordDistractors(
        correct,
        count,
        useTranslit: _isTransliteration,
      );
    }
  }

  bool get _isCurrentMCCorrect {
    if (_mcQuestionIndex < 0 || _mcQuestionIndex >= _multipleChoiceSteps.length) return false;
    final q = _multipleChoiceSteps[_mcQuestionIndex];
    return _selectedMCOption == q.correctAnswer;
  }

  // -------------------------------------------------------------------------
  // START / RESET / FINALIZE
  // -------------------------------------------------------------------------
  void _startExercise(DifficultyLevel difficulty) {
    _logger.logInfo(
      '[LessonScreen] _startExercise => difficulty=$difficulty, repeat=$selectedRepeatCount',
    );

    analytics.logEvent('lesson_start_clicked', parameters: {
      'lelosson_id': widget.lessonId,
      'path_id': widget.pathId,
      'difficulty': difficulty.displayName,
      'repeat_count': selectedRepeatCount,
    });

    setState(() {
      exerciseStarted = true;
      submitEnabled = true;
      isFeedbackMode = false;
      cumulativeIndicesToRemove.clear();
      currentStepIndex = 0;
    });

    if (difficulty == DifficultyLevel.multipleChoice) {
      _initializeMultipleChoiceSteps();
      setState(() {
        totalSteps = _multipleChoiceSteps.length;
      });
      _updateWordsForCurrentStep(difficulty);
    } else {
      _updateWordsForCurrentStep(difficulty);
    }
  }

  Future<void> _onRestartLesson() async {
    final loc = AppLocalizations.of(context)!;
    final pathIdToSave = widget.pathId;

    _logger.logInfo('[LessonScreen] _onRestartLesson => pathId=$pathIdToSave');

    await _saveLastActivePath(pathIdToSave);
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (dlgCtx) => AlertDialog(
        title: Text(loc.restartLessonTitle, style: const TextStyle(color: Colors.black)),
        content: Text(loc.resetLessonBody, style: const TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dlgCtx).pop(),
            child: Text(loc.cancelLabel, style: const TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dlgCtx).pop();
              _resetLesson();
            },
            child: Text(loc.yesLabel, style: const TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Future<void> _resetLesson() async {
    _logger.logInfo('[LessonScreen] _resetLesson => currentStepIndex=$currentStepIndex');

    analytics.logEvent('lesson_restart_clicked', parameters: {
      'lesson_id': widget.lessonId,
      'path_id': widget.pathId,
      'current_step': currentStepIndex,
    });

    try {
      await progressService.updateLessonProgress(
        widget.lessonId,
        0,
        currentStep: 0,
        pathId: widget.pathId,
      );
      await progressService.calculateAndSavePathProgress(widget.pathId);
      await repeatService.resetCurrentRepeat(widget.lessonId);

      _updateTotalSteps();
      setState(() {
        currentStepIndex = 0;
        currentRepeatCount = 0;
        exerciseStarted = false;
        isFeedbackMode = false;
        submitEnabled = true;
        showCorrectAnswer = false;
        _userInputController.clear();
        userIncorrectInputs.clear();
        verses.clear();
        displayedVerses.clear();
        cumulativeIndicesToRemove.clear();
        _multipleChoiceSteps.clear();
        _mcQuestionIndex = 0;
        _selectedMCOption = null;
        _mcSubmitted = false;
      });

      ref.invalidate(asyncLessonsWithProgressProvider(widget.pathId));
      await _loadVerses();
    } catch (e) {
      _logger.logError('[LessonScreen] error resetting => $e');
      if (!mounted) return;

      final loc = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${loc.errorResettingLesson}: $e')),
      );
    }
  }

  Future<void> _finalizeExercise() async {
    _logger.logInfo('[LessonScreen] _finalizeExercise => isExerciseCompleted=$isExerciseCompleted');
    if (isExerciseCompleted) return;

    isExerciseCompleted = true;

    try {
      await progressService.saveProgressOnLessonSubmit(
        widget.lessonId,
        totalSteps,
        totalSteps,
        pathId: widget.pathId,
      );
    } catch (e) {
      _logger.logError('[LessonScreen] error finalizing => $e');
    }

    ref.invalidate(asyncLessonsWithProgressProvider(widget.pathId));

    final pathIdToSave = widget.pathId;
    await _saveLastActivePath(pathIdToSave);
    if (!mounted) return;

    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) => LessonCompletionScreen(
          lessonId: widget.lessonId,
          pathId: widget.pathId,
          surahId: widget.surahId,
          totalSteps: totalSteps,
        ),
      ),
    )
        .then((res) {
      if (!mounted) return;
      if (res != null && res['restart'] == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LessonScreen(
              key: UniqueKey(),
              surahId: widget.surahId,
              languageCode: widget.languageCode,
              lessonId: widget.lessonId,
              pathId: widget.pathId,
              forcedFirstLesson: widget.forcedFirstLesson,
            ),
          ),
        );
      }
    });
  }

  // -------------------------------------------------------------------------
  // FILL-IN SUBMIT / NEXT
  // -------------------------------------------------------------------------
  void _onSubmitInput() async {
    analytics.logEvent('lesson_submit_clicked', parameters: {
      'lesson_id': widget.lessonId,
      'path_id': widget.pathId,
      'current_step': currentStepIndex,
    });

    final userInput = _userInputController.text.trim();
    if (userInput.isEmpty) {
      setState(() => _showEmptyInputWarning = true);
      return;
    }

    final removedWords = displayedVerses
        .expand((dv) => (dv['words'] as List).where((w) => w['isRemoved'] == true))
        .map((w) => w as Map<String, dynamic>)
        .toList();

    final expected = removedWords.length;
    var inputWords = userInput.split(RegExp(r'\s+'));
    if (inputWords.isEmpty) {
      inputWords = List.filled(expected, '____');
    } else if (inputWords.length < expected) {
      inputWords.addAll(List.filled(expected - inputWords.length, '____'));
    } else if (inputWords.length > expected) {
      inputWords = inputWords.sublist(0, expected);
    }

    for (int i = 0; i < removedWords.length; i++) {
      final wData = removedWords[i];
      final correctWord = wData['word'] as String;
      final userWord = inputWords[i];

      final similarity = similarityService.calculateSimilarity(userWord, correctWord);
      wData['similarity'] = similarity;

      final color = (similarity >= 0.9)
          ? 'green'
          : (similarity >= 0.5)
          ? 'yellow'
          : 'red';

      final points = similarityService.getPointsForSimilarity(similarity);
      await scoreService.logMistake(
        date: DateTime.now(),
        surahId: widget.surahId,
        verseId: _startAyah ?? 0,
        word: userWord,
        color: color,
        points: points,
      );
      ref.invalidate(dailyScoreProvider);

      ref.invalidate(asyncLessonsWithProgressProvider(widget.pathId));

      final gIdx = wData['globalWordIndex'] as int;
      userIncorrectInputs[gIdx] = userWord;
    }

    _lastRemovedWords = removedWords.map((r) => {...r}).toList();

    await _updatePartialProgressOnSubmit();
    ref.invalidate(asyncLessonsWithProgressProvider(widget.pathId));

    setState(() {
      submitEnabled = false;
      isFeedbackMode = true;
      _userInputController.clear();
    });

    ref.read(lessonSubmitProvider.notifier).addSubmissionDate(DateTime.now());
  }

  Future<void> _onNext() async {
    analytics.logEvent('lesson_next_clicked', parameters: {
      'lesson_id': widget.lessonId,
      'path_id': widget.pathId,
      'current_step': currentStepIndex,
    });

    if (currentStepIndex >= totalSteps) {
      _finalizeExercise();
      return;
    }

    final hasReachedRepeatLimit = await repeatService.hasCompletedRepeats(widget.lessonId);
    if (hasReachedRepeatLimit) {
      await repeatService.resetCurrentRepeat(widget.lessonId);
      setState(() {
        currentRepeatCount = 0;
        currentStepIndex++;
        cumulativeIndicesToRemove.clear();
      });
      if (currentStepIndex >= totalSteps) {
        _finalizeExercise();
        return;
      }
    } else {
      await repeatService.incrementCurrentRepeat(widget.lessonId);
      setState(() => currentRepeatCount++);
    }

    try {
      final partial = (currentStepIndex / totalSteps) * 100;
      final safeProg = partial.clamp(0, 100).ceil();
      await progressService.updateLessonProgress(
        widget.lessonId,
        safeProg,
        currentStep: currentStepIndex,
        pathId: widget.pathId,
      );
      await progressService.calculateAndSavePathProgress(widget.pathId);
      ref.invalidate(asyncLessonsWithProgressProvider(widget.pathId));
    } catch (e) {
      _logger.logError('[LessonScreen] error saving partial => $e');
    }

    ref.read(hintLevelProvider.notifier).resetHintLevel();
    _clearHintsFromUI();

    _updateWordsForCurrentStep(selectedDifficultyLevel);
    setState(() {
      _userInputController.clear();
      userIncorrectInputs.clear();
      submitEnabled = true;
      isFeedbackMode = false;
      showCorrectAnswer = false;
      _lastRemovedWords.clear();
    });

    try {
      await lessonService.saveLastOpenedLesson(widget.lessonId, widget.surahId, widget.pathId);
    } catch (e) {
      _logger.logError('[LessonScreen] error saving lastOpened => $e');
    }
  }

  // -------------------------------------------------------------------------
  // MULTIPLE CHOICE SUBMIT & NEXT
  // -------------------------------------------------------------------------
  void _onSubmitMultipleChoice() async {
    if (_selectedMCOption == null) {
      setState(() => _showEmptyInputWarning = true);
      return;
    }

    final isCorrect = _isCurrentMCCorrect;
    final color = isCorrect ? 'green' : 'red';
    final points = isCorrect ? 10 : 2;

    await scoreService.logMistake(
      date: DateTime.now(),
      surahId: widget.surahId,
      verseId: _startAyah ?? 0,
      word: _selectedMCOption!,
      color: color,
      points: points,
    );
    ref.invalidate(dailyScoreProvider);

    ref.invalidate(asyncLessonsWithProgressProvider(widget.pathId));

    ref.read(lessonSubmitProvider.notifier).addSubmissionDate(DateTime.now());

    await _updatePartialProgressOnSubmit();
    ref.invalidate(asyncLessonsWithProgressProvider(widget.pathId));

    setState(() {
      _mcSubmitted = true;
      currentStepIndex = _mcQuestionIndex;
      _updateWordsForCurrentStep(selectedDifficultyLevel);
    });
  }

  Future<void> _onNextMultipleChoice() async {
    if (_mcQuestionIndex >= _multipleChoiceSteps.length - 1) {
      _finalizeExercise();
      return;
    }

    final hasReachedRepeatLimit = await repeatService.hasCompletedRepeats(widget.lessonId);
    if (hasReachedRepeatLimit) {
      await repeatService.resetCurrentRepeat(widget.lessonId);
      setState(() => currentRepeatCount = 0);
    } else {
      await repeatService.incrementCurrentRepeat(widget.lessonId);
      setState(() => currentRepeatCount++);
    }

    try {
      final upcomingIndex = _mcQuestionIndex + 1;
      final partial = (upcomingIndex / totalSteps) * 100;
      final safeProg = partial.clamp(0, 100).ceil();
      await progressService.updateLessonProgress(
        widget.lessonId,
        safeProg,
        currentStep: upcomingIndex,
        pathId: widget.pathId,
      );
      await progressService.calculateAndSavePathProgress(widget.pathId);
      ref.invalidate(asyncLessonsWithProgressProvider(widget.pathId));
    } catch (e) {
      _logger.logError('[LessonScreen] error saving partial => $e');
    }

    setState(() {
      _mcQuestionIndex++;
      _selectedMCOption = null;
      _mcSubmitted = false;
      _showEmptyInputWarning = false;
      currentStepIndex = _mcQuestionIndex;
      _updateWordsForCurrentStep(selectedDifficultyLevel);
    });

    try {
      await lessonService.saveLastOpenedLesson(widget.lessonId, widget.surahId, widget.pathId);
    } catch (e) {
      _logger.logError('[LessonScreen] error saving lastOpened => $e');
    }
  }

  // -------------------------------------------------------------------------
  // BACK ARROW
  // -------------------------------------------------------------------------
  void _navigateBack() async {
    _logger.logInfo('[LessonScreen] _navigateBack => isExerciseCompleted=$isExerciseCompleted, exerciseStarted=$exerciseStarted');

    if (!isExerciseCompleted && exerciseStarted) {
      try {
        final partial = (currentStepIndex / totalSteps) * 100;
        final safeProg = partial.clamp(0, 100).ceil();
        await progressService.updateLessonProgress(
          widget.lessonId,
          safeProg,
          currentStep: currentStepIndex,
          pathId: widget.pathId,
        );
        await progressService.calculateAndSavePathProgress(widget.pathId);
      } catch (e) {
        _logger.logError('[LessonScreen] error partial on back => $e');
      }
    }

    if (!mounted) return;

    if (widget.forcedFirstLesson) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
      );
      return;
    }

    await _saveLastActivePath(widget.pathId);
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> _saveLastActivePath(String pathId) async {
    final ls = ref.read(localStorageServiceProvider);
    await ls.saveLastActivePath(pathId);
    _logger.logInfo('[LessonScreen] _saveLastActivePath => $pathId');
  }

  // -------------------------------------------------------------------------
  // HINTS
  // -------------------------------------------------------------------------
  void _applyHints() {
    final oldLevel = ref.read(hintLevelProvider);
    ref.read(hintLevelProvider.notifier).incrementHintLevel();
    final newLevel = ref.read(hintLevelProvider);

    analytics.logEvent('lesson_hint_requested', parameters: {
      'lesson_id': widget.lessonId,
      'path_id': widget.pathId,
      'current_step': currentStepIndex,
      'old_hint_level': oldLevel,
      'new_hint_level': newLevel,
    });

    for (final dv in displayedVerses) {
      final wlist = dv['words'] as List;
      for (final w in wlist) {
        if (w['isRemoved'] == true) {
          final word = w['word'] as String;
          final hint = ref.read(hintLevelProvider.notifier).getHint(word);
          w['hintText'] = hint;
        }
      }
    }

    _logger.logInfo('[LessonScreen] _applyHints => newLevel=$newLevel');
  }

  void _clearHintsFromUI() {
    final oldLevel = ref.read(hintLevelProvider);

    analytics.logEvent('lesson_hint_removed', parameters: {
      'lesson_id': widget.lessonId,
      'path_id': widget.pathId,
      'current_step': currentStepIndex,
      'old_hint_level': oldLevel,
    });
    ref.read(hintLevelProvider.notifier).resetHintLevel();

    for (final dv in displayedVerses) {
      final wlist = dv['words'] as List;
      for (final w in wlist) {
        if (w['isRemoved'] == true) {
          w['hintText'] = null;
        }
      }
    }

    _logger.logInfo('[LessonScreen] _clearHintsFromUI => oldLevel was $oldLevel, now reset');
  }

  // -------------------------------------------------------------------------
  // AUDIO: Toggle play/pause
  // -------------------------------------------------------------------------
  Future<void> _toggleAyahPlayback() async {
    final loc = AppLocalizations.of(context)!;
    final sc = ScaffoldMessenger.of(context);

    analytics.logEvent('lesson_play_clicked', parameters: {
      'lesson_id': widget.lessonId,
      'path_id': widget.pathId,
      'current_step': currentStepIndex,
      'surah_id': widget.surahId,
      'start_ayah': _startAyah,
      'end_ayah': _endAyah,
    });

    if (_startAyah == null || _endAyah == null) {
      sc.showSnackBar(SnackBar(content: Text(loc.noAyahAvailable)));
      return;
    }

    if (_playerState == PlayerState.playing) {
      await _singleAyahPlayer.stop();
      setState(() => _playerState = PlayerState.stopped);
      return;
    }

    try {
      final reciterNo = ref.read(userProfileProvider).reciterId;

      // We do a HEAD request just for the FIRST ayah to check that audio is available for the chosen reciter
      final firstAyahUrl =
          'https://quranaudio.pages.dev/$reciterNo/${widget.surahId}_${_startAyah!}.mp3';
      final headResp = await http.head(Uri.parse(firstAyahUrl));
      if (headResp.statusCode != 200) {
        sc.showSnackBar(SnackBar(content: Text(loc.audioNotFound(firstAyahUrl))));
        return;
      }

      await _singleAyahPlayer.stop();
      setState(() => _playerState = PlayerState.playing);

      // Now we manually loop from _startAyah to _endAyah
      for (int r = 0; r < selectedRepeatCount; r++) {
        for (int ayah = _startAyah!; ayah <= _endAyah!; ayah++) {
          final currentUrl =
              'https://quranaudio.pages.dev/$reciterNo/${widget.surahId}_$ayah.mp3';
          await _singleAyahPlayer.play(UrlSource(currentUrl));
          await _singleAyahPlayer.onPlayerComplete.first;
        }
      }

      setState(() => _playerState = PlayerState.stopped);
    } catch (e) {
      _logger.logError('[LessonScreen] error playing => $e');
      sc.showSnackBar(SnackBar(content: Text('Error playing audio: $e')));
      setState(() => _playerState = PlayerState.stopped);
    }
  }

  // -------------------------------------------------------------------------
  // TRANSLATION
  // -------------------------------------------------------------------------
  void _toggleLocalTranslation() {
    setState(() => _showTranslation = !_showTranslation);
  }

  Future<void> _openTranslation() async {
    analytics.logEvent('lesson_translate_clicked', parameters: {
      'lesson_id': widget.lessonId,
      'path_id': widget.pathId,
      'surah_id': widget.surahId,
    });

    try {
      final details = await lessonService.getLessonDetails(widget.lessonId);
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TranslationScreen(
            surahId: widget.surahId,
            lessonId: widget.lessonId,
            pathId: widget.pathId,
            startAyah: details['startAyah'],
            endAyah: details['endAyah'],
          ),
        ),
      );
    } catch (e) {
      _logger.logError('[LessonScreen] error opening translation => $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening translation: $e')),
      );
    }
  }

  bool _containsBlacklisted(String text, Set<String> blacklisted) {
    for (final phrase in blacklisted) {
      if (text.contains(phrase)) return true;
    }
    return false;
  }

  // -------------------------------------------------------------------------
  // BUILD
  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final userTier = ref.watch(userProfileProvider).subscriptionTier;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final voiceService = ref.watch(voiceTranscriptionServiceProvider);
    final isOnline = ref.watch(isOnlineProvider);

    // If user is FREE tier and offline, block usage
    if (userTier == SubscriptionTier.free && !isOnline) {
      return Scaffold(
        backgroundColor: Colors.blue[50],
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loc.featureUnavailableOffline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Upgrade flow...')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.015,
                    ),
                  ),
                  child: Text(
                    'Upgrade',
                    style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.lessonScreenAppBarTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[50],
        leading: Semantics(
          label: loc.backButtonLabel,
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: _navigateBack,
          ),
        ),
        actions: [
          Semantics(
            label: loc.toggleTranslationLabel,
            button: true,
            child: IconButton(
              icon: Icon(
                _showTranslation ? Icons.language : Icons.language_outlined,
                color: Colors.black,
              ),
              onPressed: _toggleLocalTranslation,
            ),
          ),
          Semantics(
            label: loc.openTranslationScreenLabel,
            button: true,
            child: IconButton(
              icon: const Icon(Icons.translate, color: Colors.black),
              onPressed: _openTranslation,
            ),
          ),
          Semantics(
            label: loc.restartLessonSemanticLabel,
            button: true,
            child: IconButton(
              icon: const Icon(Icons.restart_alt, color: Colors.black),
              onPressed: _onRestartLesson,
            ),
          ),
        ],
      ),
      bottomNavigationBar:
      exerciseStarted ? null : BottomNavBar(currentIndex: 1, ref: ref, pathId: null),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                // If exercise hasn't started, show toggles + start
                if (!exerciseStarted)
                  Center(
                    child: Column(
                      children: [
                        // Show the toggle (Arabic / English) *before* start, but renamed
                        _buildTextFormToggle(screenWidth, screenHeight, loc),
                        SizedBox(height: screenHeight * 0.01),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          child: _buildDifficultyAndRepeatsUI(screenWidth, screenHeight, loc),
                        ),
                      ],
                    ),
                  ),

                if (exerciseStarted)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.02,
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                    ),
                    child: LinearProgressIndicator(
                      value: totalSteps == 0
                          ? 0
                          : (currentStepIndex / totalSteps).clamp(0, 1),
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                  ),

                // Additionally show the toggle AFTER start
                if (exerciseStarted)
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.02,
                      bottom: screenHeight * 0.02,
                    ),
                    child: _buildTextFormToggle(screenWidth, screenHeight, loc),
                  ),

                if (verses.isNotEmpty)
                  Semantics(
                    label: loc.verseDisplayAreaLabel,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey,
                          width: screenWidth * 0.003,
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.02,
                              left: screenWidth * 0.1,
                              right: screenWidth * 0.05,
                              bottom: screenHeight * 0.02,
                            ),
                            child: _buildVerseDisplay(screenWidth, screenHeight, loc),
                          ),
                          Positioned(
                            top: 5,
                            left: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Semantics(
                                  label: loc.playAudioSemanticLabel,
                                  button: true,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
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
                                            icon: Icon(
                                              _isAyahPlaying ? Icons.pause : Icons.play_arrow,
                                              color: Colors.black,
                                            ),
                                            iconSize: 20,
                                            onPressed: _toggleAyahPlayback,
                                          ),
                                        ),
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
                                              'x$selectedRepeatCount',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Semantics(
                                  label: loc.openGratitudeSemanticLabel,
                                  button: true,
                                  child: Container(
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
                                      onPressed: () {
                                        analytics.logEvent('lesson_gratitude_clicked', parameters: {
                                          'lesson_id': widget.lessonId,
                                          'path_id': widget.pathId,
                                        });
                                        showDialog<List<String>>(
                                          context: context,
                                          barrierColor: const Color.fromRGBO(0, 0, 0, 0.5),
                                          builder: (_) => const GratitudeModal(),
                                        ).then((submitted) {
                                          if (!mounted || submitted == null || submitted.isEmpty) {
                                            return;
                                          }
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            if (!mounted) return;
                                            showDialog<void>(
                                              context: context,
                                              barrierColor: const Color.fromRGBO(0, 0, 0, 0.5),
                                              builder: (_) => SubmissionFeedbackModal(
                                                submittedGratitudes: submitted,
                                              ),
                                            );
                                          });
                                        });
                                      },
                                      icon: const Icon(Icons.volunteer_activism, color: Colors.black),
                                      iconSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  const Center(child: CircularProgressIndicator()),

                if (!exerciseStarted)
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.02),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _saveLastActivePath(widget.pathId);
                            _startExercise(selectedDifficultyLevel);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[50],
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1,
                              vertical: screenHeight * 0.015,
                            ),
                          ),
                          child: Text(
                            loc.startLabel,
                            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        ElevatedButton(
                          onPressed: () async {
                            analytics.logEvent('lesson_go_to_surah_view_clicked', parameters: {
                              'lesson_id': widget.lessonId,
                              'path_id': widget.pathId,
                              'surah_id': widget.surahId,
                              'start_ayah': _startAyah,
                              'end_ayah': _endAyah,
                            });

                            final pathService = ref.read(pathServiceProviderRef);
                            final activePath = pathService.getPathById(widget.pathId);

                            if (activePath == null || activePath.lessons.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('No valid path found.')),
                              );
                              return;
                            }

                            final lessons = activePath.lessons;
                            final firstLesson = lessons.first;
                            final mergedSurahId = firstLesson.surahId;
                            final minStart = lessons
                                .map((l) => l.startAyah)
                                .reduce((a, b) => a < b ? a : b);
                            final maxEnd = lessons
                                .map((l) => l.endAyah)
                                .reduce((a, b) => a > b ? a : b);

                            final mergedSurahName = quranService.getSurahName(mergedSurahId);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PathLessonsScreen(
                                  surahId: mergedSurahId,
                                  surahName: mergedSurahName,
                                  startAyah: minStart,
                                  endAyah: maxEnd,
                                  lessonId: widget.lessonId,
                                  pathId: widget.pathId,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[50],
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1,
                              vertical: screenHeight * 0.015,
                            ),
                          ),
                          child: Text(
                            loc.goToSurahViewLabel,
                            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (exerciseStarted && selectedDifficultyLevel == DifficultyLevel.multipleChoice)
                  ...[_buildMultipleChoiceUI(screenWidth, screenHeight, loc)]
                else if (exerciseStarted) ...[
                  SizedBox(height: screenHeight * 0.03),
                  if (!isFeedbackMode)
                    _buildUserInputRow(
                      screenWidth,
                      screenHeight,
                      userTier,
                      voiceService,
                      {'اشتركوا في القناة', 'شكرا على المشاهدة', 'شكرا على', 'شكرا'},
                      loc,
                    ),
                  SizedBox(height: screenHeight * 0.03),
                  ElevatedButton(
                    onPressed: (submitEnabled || isFeedbackMode)
                        ? () {
                      if (isFeedbackMode) {
                        _onNext();
                      } else if (_userInputController.text.isNotEmpty) {
                        _onSubmitInput();
                      } else {
                        setState(() => _showEmptyInputWarning = true);
                      }
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[50],
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    child: Text(
                      isFeedbackMode ? loc.nextLabel : loc.submitLabel,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  if (_showEmptyInputWarning)
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.01),
                      child: Text(
                        loc.emptyInputWarning,
                        style: TextStyle(color: Colors.red, fontSize: screenWidth * 0.035),
                      ),
                    ),
                  if (isFeedbackMode && selectedDifficultyLevel != DifficultyLevel.multipleChoice)
                    _buildConsolidatedPoints(loc, screenWidth, screenHeight),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // (3) Updated toggle that saves the new value on switch, with "English" label
  Widget _buildTextFormToggle(double w, double h, AppLocalizations loc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          loc.arabicLabel,
          style: TextStyle(fontSize: w * 0.04, color: Colors.black),
        ),
        Switch(
          value: _isTransliteration,
          onChanged: (val) => _saveIsTransliteration(val),
        ),
        Text(
          loc.englishLabel, // CHANGED from transliterationLabel to englishLabel
          style: TextStyle(fontSize: w * 0.04, color: Colors.black),
        ),
      ],
    );
  }

  // Saves the updated transliteration preference to Hive, updates local state, and refreshes verses
  Future<void> _saveIsTransliteration(bool val) async {
    final ls = ref.read(localStorageServiceProvider);
    await ls.saveBool('prefIsTransliteration', val);

    setState(() => _isTransliteration = val);
    await _loadVerses();

    // If we've already started and are in Multiple Choice mode,
    // re-initialize the steps so distractors/final answers refresh.
    if (exerciseStarted && selectedDifficultyLevel == DifficultyLevel.multipleChoice) {
      final oldIndex = _mcQuestionIndex;
      _initializeMultipleChoiceSteps();
      // Keep the same question index if possible
      _mcQuestionIndex = oldIndex.clamp(0, _multipleChoiceSteps.length - 1);
      _mcSubmitted = false;
      // Re-apply the step
      _updateWordsForCurrentStep(selectedDifficultyLevel);
    }
  }

  Widget _buildConsolidatedPoints(
      AppLocalizations loc,
      double screenWidth,
      double screenHeight,
      ) {
    if (_lastRemovedWords.isEmpty) {
      return const SizedBox.shrink();
    }

    int redCount = 0;
    int orangeCount = 0;
    int greenCount = 0;

    for (final rd in _lastRemovedWords) {
      final sim = rd['similarity'] as double? ?? 0.0;
      if (sim >= 0.9) {
        greenCount++;
      } else if (sim >= 0.5) {
        orangeCount++;
      } else {
        redCount++;
      }
    }

    final lines = <Widget>[];
    if (greenCount > 0) {
      lines.add(_pointsLine('+10 x $greenCount', Colors.green, screenWidth));
    }
    if (orangeCount > 0) {
      lines.add(_pointsLine('+5 x $orangeCount', Colors.orange, screenWidth));
    }
    if (redCount > 0) {
      lines.add(_pointsLine('+2 x $redCount', Colors.red, screenWidth));
    }

    if (lines.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        ...lines,
        SizedBox(height: screenHeight * 0.01),
        Text(
          loc.tapColoredWordsHint,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _pointsLine(String label, Color color, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(top: screenWidth * 0.02),
      child: Text(
        label,
        style: TextStyle(
          fontSize: screenWidth * 0.04,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDifficultyAndRepeatsUI(double w, double h, AppLocalizations loc) {
    final surahName = quranService.getSurahName(widget.surahId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: h * 0.015),
          child: Text(
            '$surahName (${widget.surahId})',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: w * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.015),
                child: Column(
                  children: [
                    Text(
                      loc.difficultyLabel,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    DropdownButton<DifficultyLevel?>(
                      value: selectedDifficultyLevel,
                      onChanged: (newVal) async {
                        if (newVal == null) return;
                        analytics.logEvent('lesson_difficulty_changed', parameters: {
                          'lesson_id': widget.lessonId,
                          'path_id': widget.pathId,
                          'old': selectedDifficultyLevel.displayName,
                          'new': newVal.displayName,
                        });

                        final oldVal = selectedDifficultyLevel;
                        setState(() => selectedDifficultyLevel = newVal);

                        await ref
                            .read(localStorageServiceProvider)
                            .saveDifficultyLevel(widget.lessonId, newVal);

                        ref.read(userProfileProvider.notifier).updateDefaultDifficulty(newVal);

                        _logger.logError(
                          '[LessonScreen] changed difficulty => old=$oldVal, new=$newVal',
                        );

                        await _resetLesson();
                      },
                      isExpanded: true,
                      dropdownColor: Colors.blue[50],
                      itemHeight: null,
                      items: DifficultyLevel.values.expand((dl) {
                        final normalItem = DropdownMenuItem<DifficultyLevel?>(
                          value: dl,
                          child: Text(dl.displayName(context)),
                        );
                        if (dl == DifficultyLevel.multipleChoice) {
                          return [
                            normalItem,
                            DropdownMenuItem<DifficultyLevel?>(
                              value: null,
                              enabled: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Divider(thickness: 1.0, color: Colors.grey),
                                  Text(
                                    loc.fillInTheBlanksLabel,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ];
                        } else {
                          return [normalItem];
                        }
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: w * 0.04),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.015),
                child: Column(
                  children: [
                    Text(
                      loc.repeatCountLabel,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    DropdownButton<int>(
                      value: selectedRepeatCount,
                      onChanged: (val) {
                        if (val == null) return;
                        analytics.logEvent('lesson_repeat_changed', parameters: {
                          'lesson_id': widget.lessonId,
                          'path_id': widget.pathId,
                          'old': selectedRepeatCount,
                          'new': val,
                        });
                        ref.read(repeatServiceProvider).saveRepeatCount(widget.lessonId, val);

                        setState(() => selectedRepeatCount = val);
                        _resetLesson();
                      },
                      isExpanded: true,
                      dropdownColor: Colors.blue[50],
                      items: [1, 2, 3, 5, 10].map((v) {
                        return DropdownMenuItem<int>(
                          value: v,
                          child: Text(v.toString()),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserInputRow(
      double w,
      double h,
      SubscriptionTier userTier,
      dynamic voiceService,
      Set<String> blacklisted,
      AppLocalizations loc,
      ) {
    final isRecording = voiceService.isRecording;
    final gradientColors = isRecording
        ? [Colors.red.shade200, Colors.red.shade400]
        : [Colors.green.shade200, Colors.green.shade400];
    final icon = isRecording ? Icons.stop : Icons.mic;

    bool isMicEnabled = true;
    if (userTier == SubscriptionTier.premiumPlus) {
      if (_dailyLimitReached) isMicEnabled = false;
    } else {
      if (_freeVoiceUsageCount >= _FREE_VOICE_USAGE_LIMIT) isMicEnabled = false;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _userInputController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              labelText: loc.typeTheMissingWordsLabel,
              labelStyle: TextStyle(fontSize: w * 0.04, color: Colors.blue),
            ),
            style: TextStyle(fontSize: w * 0.04, color: Colors.black),
            onChanged: (_) => setState(() => _showEmptyInputWarning = false),
          ),
          SizedBox(height: h * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (ref.watch(hintLevelProvider) <
                  ref.read(hintLevelProvider.notifier).maxHintLevel)
                ElevatedButton(
                  onPressed: _applyHints,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[50]),
                  child: Text(
                    loc.getHintLabel,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              SizedBox(width: w * 0.02),
              if (ref.watch(hintLevelProvider) > 0)
                ElevatedButton(
                  onPressed: _clearHintsFromUI,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[50]),
                  child: Text(
                    loc.removeHintLabel,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerseDisplay(double w, double h, AppLocalizations loc) {
    final userProfile = ref.watch(userProfileProvider);
    final arabicFontFamily = userProfile.fontFamily;
    final arabicFontWeight =
    (userProfile.fontWeight == 700) ? FontWeight.bold : FontWeight.normal;

    final verseWidgets = <Widget>[];

    for (final dv in displayedVerses) {
      final wlist = dv['words'] as List;
      final spans = <InlineSpan>[];

      for (final wd in wlist) {
        final isMarker = wd['isAyahMarker'] == true;
        final isRemoved = wd['isRemoved'] == true;
        var textColor = Colors.black;
        String displayText = wd['word'];

        if (isMarker) {
          spans.add(
            TextSpan(
              text: ' $displayText ',
              style: TextStyle(
                fontSize: w * 0.07,
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold,
                height: 1.8,
                color: Colors.black,
              ),
            ),
          );
          continue;
        }

        if (isRemoved) {
          displayText = '_____';
          if (wd['hintText'] != null) {
            displayText = wd['hintText'] as String;
            textColor = Colors.grey;
          }
          if (isFeedbackMode && wd['similarity'] != null) {
            final sim = wd['similarity'] as double;
            final gIdx = wd['globalWordIndex'] as int;
            if (showCorrectAnswer) {
              displayText = wd['word'];
              textColor = Colors.green;
            } else {
              displayText = userIncorrectInputs[gIdx] ?? '_____';
              if (sim >= 0.9) {
                textColor = Colors.green;
              } else if (sim >= 0.5) {
                textColor = Colors.orange;
              } else {
                textColor = Colors.red;
              }
            }
            spans.add(
              TextSpan(
                text: ' $displayText ',
                style: TextStyle(
                  fontSize: w * 0.07,
                  fontFamily: arabicFontFamily,
                  fontWeight: arabicFontWeight,
                  color: textColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() => showCorrectAnswer = !showCorrectAnswer);
                  },
              ),
            );
            continue;
          }
          spans.add(
            TextSpan(
              text: ' $displayText ',
              style: TextStyle(
                fontSize: w * 0.07,
                fontFamily: arabicFontFamily,
                fontWeight: arabicFontWeight,
                color: textColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() => showCorrectAnswer = !showCorrectAnswer);
                },
            ),
          );
        } else {
          spans.add(
            TextSpan(
              text: ' $displayText ',
              style: TextStyle(
                fontSize: w * 0.07,
                fontFamily: arabicFontFamily,
                fontWeight: arabicFontWeight,
                height: 1.8,
                color: Colors.black,
              ),
            ),
          );
        }
      }

      // If transliteration => left-to-right, else right-to-left
      final textDir = _isTransliteration ? TextDirection.ltr : TextDirection.rtl;

      verseWidgets.add(
        Align(
          alignment: Alignment.center,
          child: RichText(
            textAlign: textDir == TextDirection.rtl ? TextAlign.right : TextAlign.left,
            textDirection: textDir,
            text: TextSpan(children: spans),
          ),
        ),
      );

      if (_showTranslation) {
        final translation = dv['translation'] ?? '';
        if (translation.isNotEmpty) {
          verseWidgets.add(
            Padding(
              padding: EdgeInsets.only(top: h * 0.005, left: w * 0.04),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  translation,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: w * 0.04,
                    color: Colors.blueGrey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          );
        }
      }

      verseWidgets.add(SizedBox(height: h * 0.02));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: verseWidgets);
  }

  Widget _buildMultipleChoiceUI(double w, double h, AppLocalizations loc) {
    if (_multipleChoiceSteps.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text(
              loc.lessonCompletedLabel,
              style: TextStyle(fontSize: w * 0.045, color: Colors.black),
            ),
            ElevatedButton(
              onPressed: _finalizeExercise,
              child: Text(loc.finishLabel),
            ),
          ],
        ),
      );
    }
    if (_mcQuestionIndex < 0 || _mcQuestionIndex >= _multipleChoiceSteps.length) {
      return Container();
    }

    final question = _multipleChoiceSteps[_mcQuestionIndex];
    final title = question.isPair
        ? loc.twoWordMultipleChoiceLabel
        : loc.singleWordMultipleChoiceLabel;
    final totalMC = _multipleChoiceSteps.length;
    final curNum = _mcQuestionIndex + 1;

    bool twoLineNeeded = false;
    final singleBoxWidth = (w * 0.5) - (w * 0.02);
    final txtStyle = TextStyle(fontSize: w * 0.04, color: Colors.black);

    for (final opt in question.options) {
      final measure = _measureTextWidth(opt, txtStyle);
      if (measure > singleBoxWidth) {
        twoLineNeeded = true;
        break;
      }
    }
    final aspectRatio = twoLineNeeded ? 2.0 : 3.0;

    return Column(
      children: [
        Text(
          '$title  ($curNum/$totalMC)',
          style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: h * 0.02),
        SizedBox(
          width: double.infinity,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: h * 0.01,
              crossAxisSpacing: w * 0.02,
              childAspectRatio: aspectRatio,
            ),
            itemCount: 4,
            itemBuilder: (ctx, i) {
              final opt = question.options[i];
              final isSelected = (opt == _selectedMCOption);
              final isSubmitted = _mcSubmitted;
              final isCorrect = (opt == question.correctAnswer);

              Color bg = Colors.blue[50]!;
              if (isSubmitted) {
                if (isCorrect && isSelected) {
                  bg = Colors.green.shade200;
                } else if (isCorrect) {
                  bg = Colors.green.shade100;
                } else if (isSelected) {
                  bg = Colors.red.shade200;
                }
              } else if (isSelected) {
                bg = Colors.blue.shade200;
              }

              return GestureDetector(
                onTap: () {
                  if (isSubmitted) return;
                  setState(() {
                    _selectedMCOption = opt;
                    _showEmptyInputWarning = false;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(w * 0.01),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black26, width: 1),
                  ),
                  child: Text(
                    opt,
                    textAlign: TextAlign.center,
                    style: txtStyle,
                    maxLines: twoLineNeeded ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              );
            },
          ),
        ),
        if (_showEmptyInputWarning)
          Padding(
            padding: EdgeInsets.only(top: h * 0.01),
            child: Text(
              loc.emptyInputWarning,
              style: TextStyle(color: Colors.red, fontSize: w * 0.035),
            ),
          ),
        SizedBox(height: h * 0.03),
        ElevatedButton(
          onPressed: () {
            if (!_mcSubmitted) {
              _onSubmitMultipleChoice();
            } else {
              _onNextMultipleChoice();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[50],
            padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.015),
          ),
          child: Text(
            _mcSubmitted ? loc.nextLabel : loc.submitLabel,
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        if (_mcSubmitted)
          Padding(
            padding: EdgeInsets.only(top: h * 0.01),
            child: Text(
              _isCurrentMCCorrect
                  ? '${loc.correctAnswerLabel} +10'
                  : '${loc.incorrectAnswerLabel} +2',
              style: TextStyle(
                fontSize: w * 0.04,
                color: _isCurrentMCCorrect ? Colors.green : Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  double _measureTextWidth(String text, TextStyle style) {
    final span = TextSpan(text: text, style: style);
    final tp = TextPainter(text: span, maxLines: 1, textDirection: TextDirection.ltr);
    tp.layout();
    return tp.width;
  }
}
