import 'dart:developer';
import 'package:hive/hive.dart';

import '../services/local_storage_service.dart';
import '../services/lesson_service.dart';
import '../services/path_service.dart'; // We import PathService so we can add theme-based paths
import '../models/path_model.dart';
import '../models/lesson_model.dart';
import '../providers/ff_logging_service_provider.dart';
import 'package:uuid/uuid.dart'; // For generating a unique pathId if needed

/// A renamed and expanded localization class for the theme and path names/descriptions.
class AppStrings {
  // Theme names
  String get themeNameCoreRecitation => 'Core Daily Recitation';
  String get themeNameBeginJourney => 'Beginning the Journey';
  String get themeNameMercyAndHope => 'Mercy and Hope';
  String get themeNameGratitudeReflection => 'Gratitude and Reflection';
  String get themeNameStoriesReminders => 'Stories, Lessons, and Reminders';
  String get themeNamePatience => 'Patience (Ṣabr)';
  String get themeNameUserCreated => 'User Created';

  // Path names & descriptions for the "Core Recitation" theme
  String get pathNameFatihah => 'Surah Al-Fātiḥah';
  String get pathDescFatihah => 'Entire Surah (1:1–7). Essential for each rakʿah.';
  String get pathNameKafirun => 'Surah Al-Kāfirūn';
  String get pathDescKafirun => 'Entire Surah (109:1–6). Statement of Tawḥīd.';
  String get pathNameIkhlas => 'Surah Al-Ikhlāṣ';
  String get pathDescIkhlas => 'Entire Surah (112:1–4). Tawḥīd of Allah.';
  String get pathNameFalaq => 'Surah Al-Falaq';
  String get pathDescFalaq => 'Entire Surah (113:1–5). Seek refuge from external evils.';
  String get pathNameNas => 'Surah An-Nās';
  String get pathDescNas => 'Entire Surah (114:1–6). Seek refuge from internal whispers.';

  // Beginning the Journey
  String get pathNameAsrBegin => 'Surah Al-ʿAṣr';
  String get pathDescAsrBegin => '(103:1–3). Only 3 verses but central to “patience”.';
  String get pathNameTakathur => 'Surah At-Takāthur';
  String get pathDescTakathur => '(102:1–8) about worldly competition and accountability.';
  String get pathNameFil => 'Surah Al-Fīl';
  String get pathDescFil => '(105:1–5). Elephant incident; short 5 verses.';
  String get pathNameQuraysh => 'Surah Quraysh';
  String get pathDescQuraysh => '(106:1–4). On gratitude for safe journeys.';

  // Mercy and Hope
  String get pathNameRahmanA => 'Ar-Raḥmān A';
  String get pathDescRahmanA => '(55:1–13): Teaching of the Quran & creation of humankind.';
  String get pathNameRahmanB => 'Ar-Raḥmān B';
  String get pathDescRahmanB => '(55:26–36): Humans & jinn accountability.';
  String get pathNameYasinBlock => 'Surah Yā Sīn (Block)';
  String get pathDescYasinBlock => '(36:1–12). Intro to the Prophet’s message & warnings.';
  String get pathNameMulkBlock => 'Surah Al-Mulk (Block)';
  String get pathDescMulkBlock => '(67:1–15). Emphasizes Allah’s sovereignty & reflection.';

  // Gratitude and Reflection
  String get pathNameBaqarah21_29 => 'Al-Baqarah (2:21–29)';
  String get pathDescBaqarah21_29 => '9 verses on creation & reflection for gratitude.';
  String get pathNameNahl66_72 => 'An-Naḥl (16:66–72)';
  String get pathDescNahl66_72 => '7 verses enumerating blessings: livestock, fruits, etc.';
  String get pathNameAdDuha => 'Surah Aḍ-Ḍuḥā';
  String get pathDescAdDuha => '(93:1–11) 11 verses of hope & reassurance.';

  // Stories, Lessons, and Reminders
  String get pathNameKahfCave => 'Al-Kahf: The Cave Youth';
  String get pathDescKahfCave => '(18:9–16) The story of young believers in a cave.';
  String get pathNameKahfMusa => 'Al-Kahf: Mūsā & Al-Khiḍr';
  String get pathDescKahfMusa => '(18:60–70) Emphasizes patience & hidden wisdom.';
  String get pathNameWaqiah => 'Al-Wāqiʿah (56:1–15)';
  String get pathDescWaqiah => '15 verses on the sudden arrival of the Hour.';

  // Patience (Ṣabr)
  String get pathNameAsrPatience => 'Surah Al-ʿAṣr (Patience)';
  String get pathDescAsrPatience => '(103:1–3) again, 3 verses, famously about patience.';
  String get pathNameBaq153_157 => 'Al-Baqarah (2:153–157)';
  String get pathDescBaq153_157 => '5 verses: “Seek help through patience & prayer.”';
  String get pathNameYusuf7_14 => 'Sūrah Yūsuf (12:7–14)';
  String get pathDescYusuf7_14 => 'Jealousy of Yusuf’s brothers. Patience tested.';
  String get pathNameYusuf83_92 => 'Sūrah Yūsuf (12:83–92)';
  String get pathDescYusuf83_92 => 'Yaʿqūb’s grief & Yusuf’s forgiveness (10 verses).';
  String get pathNameInshirah => 'Surah Al-Inshirāḥ (94:1–8)';
  String get pathDescInshirah => '8 verses: reassurance after hardship. Tied to patience & hope.';
}

/// Distinguishes free vs. premium themes
enum ThemeAccessLevel {
  free,
  premium,
  premiumPlus,
}

/// Represents one “Theme” (category) in the app, each containing a list of [Path].
class ThemeDataQ {
  final String id;
  final String name;
  final bool isUserEditable;
  final List<Path> paths; // Each path within this theme
  final ThemeAccessLevel accessLevel;

  ThemeDataQ({
    required this.id,
    required this.name,
    required this.isUserEditable,
    required this.paths,
    this.accessLevel = ThemeAccessLevel.free,
  });

  /// Convert this theme to a map for storage (Hive or JSON, etc.).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isUserEditable': isUserEditable,
      'paths': paths.map((p) => p.toJson()).toList(),
      'accessLevel': accessLevel.toString(),
    };
  }

  /// Construct a [ThemeDataQ] from a map (Hive or JSON).
  static ThemeDataQ fromMap(Map<String, dynamic> map) {
    final accessStr = map['accessLevel'] as String? ?? 'ThemeAccessLevel.free';
    final parsedAccess = ThemeAccessLevel.values.firstWhere(
          (lvl) => lvl.toString() == accessStr,
      orElse: () => ThemeAccessLevel.free,
    );

    final rawPaths = (map['paths'] ?? []) as List<dynamic>;
    final parsedPaths = rawPaths.map((p) {
      return Path.fromJson(Map<String, dynamic>.from(p as Map));
    }).toList();

    return ThemeDataQ(
      id: map['id'] as String,
      name: map['name'] as String,
      isUserEditable: map['isUserEditable'] as bool,
      paths: parsedPaths,
      accessLevel: parsedAccess,
    );
  }

  /// Create a copy of this theme with optional overrides.
  ThemeDataQ copyWith({
    String? id,
    String? name,
    bool? isUserEditable,
    List<Path>? paths,
    ThemeAccessLevel? accessLevel,
  }) {
    return ThemeDataQ(
      id: id ?? this.id,
      name: name ?? this.name,
      isUserEditable: isUserEditable ?? this.isUserEditable,
      paths: paths ?? this.paths,
      accessLevel: accessLevel ?? this.accessLevel,
    );
  }
}

/// This service manages both system-defined and user-defined themes, each
/// containing multiple [Path]s. By default, it does **not** generate lessons
/// immediately; generation is done lazily in [generateLessonsForSystemPath].
/// We can also push system-defined paths to [PathService] on user selection,
/// ensuring those paths appear in PathService.getAllPaths().
class ThemeService {
  final LocalStorageService localStorageService;
  final LoggingService loggingService;
  final LessonService lessonService;
  final PathService pathService;
  final AppStrings _strings; // Injected localization strings

  bool _initialized = false;
  final List<ThemeDataQ> _themes = [];
  static const _themeBoxName = 'themesBox';

  ThemeService({
    required this.localStorageService,
    required this.loggingService,
    required this.lessonService,
    required this.pathService,
    required AppStrings strings,
  }) : _strings = strings;

  /// Expose an immutable list of all themes: system + user.
  List<ThemeDataQ> get allThemes => List.unmodifiable(_themes);

  /// Called once at app startup. Creates or loads system themes (without generating lessons).
  /// Then persists these “system paths” to [PathService] so they remain after app restart,
  /// preserving the correct name/description for each path.
  Future<void> initializeSystemThemes() async {
    if (_initialized) return;
    _initialized = true;

    loggingService.logWarning('[ThemeService] initializeSystemThemes() -> Start');
    loggingService.logInfo('Initializing system + user themes (no lesson generation yet).');

    _themes.clear();
    final loc = _strings;

    // ------------------------------------------------------------------
    // (1) Core Daily Recitation
    // ------------------------------------------------------------------
    Path pathFatiha = Path(
      id: 'path_fatihah',
      name: loc.pathNameFatihah,
      description: loc.pathDescFatihah,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_core_recitation', 'theme_begin_journey', 'theme_gratitude_reflection'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathKafirun = Path(
      id: 'path_kafirun',
      name: loc.pathNameKafirun,
      description: loc.pathDescKafirun,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_core_recitation'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathIkhlas = Path(
      id: 'path_ikhlas',
      name: loc.pathNameIkhlas,
      description: loc.pathDescIkhlas,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_core_recitation'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathFalaq = Path(
      id: 'path_falaq',
      name: loc.pathNameFalaq,
      description: loc.pathDescFalaq,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_core_recitation'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathNas = Path(
      id: 'path_nas',
      name: loc.pathNameNas,
      description: loc.pathDescNas,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_core_recitation'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );

    ThemeDataQ themeCoreRecitation = ThemeDataQ(
      id: 'theme_core_recitation',
      name: loc.themeNameCoreRecitation,
      isUserEditable: false,
      accessLevel: ThemeAccessLevel.free,
      paths: [
        pathFatiha,
        pathKafirun,
        pathIkhlas,
        pathFalaq,
        pathNas,
      ],
    );

    // ------------------------------------------------------------------
    // (2) Beginning the Journey
    // ------------------------------------------------------------------
    Path pathAsr = Path(
      id: 'path_asr_begin',
      name: loc.pathNameAsrBegin,
      description: loc.pathDescAsrBegin,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_begin_journey'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathTakathur = Path(
      id: 'path_takathur',
      name: loc.pathNameTakathur,
      description: loc.pathDescTakathur,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_begin_journey'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathFil = Path(
      id: 'path_fil',
      name: loc.pathNameFil,
      description: loc.pathDescFil,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_begin_journey'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathQuraysh = Path(
      id: 'path_quraysh',
      name: loc.pathNameQuraysh,
      description: loc.pathDescQuraysh,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_begin_journey'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );

    ThemeDataQ themeBeginJourney = ThemeDataQ(
      id: 'theme_begin_journey',
      name: loc.themeNameBeginJourney,
      isUserEditable: false,
      accessLevel: ThemeAccessLevel.free,
      paths: [
        pathAsr,
        pathTakathur,
        pathFil,
        pathQuraysh,
      ],
    );

    // ------------------------------------------------------------------
    // (3) Mercy and Hope
    // ------------------------------------------------------------------
    Path pathRahmanA = Path(
      id: 'path_rahman_a',
      name: loc.pathNameRahmanA,
      description: loc.pathDescRahmanA,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_mercy_and_hope'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathRahmanB = Path(
      id: 'path_rahman_b',
      name: loc.pathNameRahmanB,
      description: loc.pathDescRahmanB,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_mercy_and_hope'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathYasinBlock = Path(
      id: 'path_yasin_block',
      name: loc.pathNameYasinBlock,
      description: loc.pathDescYasinBlock,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_mercy_and_hope'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathMulkBlock = Path(
      id: 'path_mulk_block',
      name: loc.pathNameMulkBlock,
      description: loc.pathDescMulkBlock,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_mercy_and_hope'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );

    ThemeDataQ themeMercyHope = ThemeDataQ(
      id: 'theme_mercy_and_hope',
      name: loc.themeNameMercyAndHope,
      isUserEditable: false,
      accessLevel: ThemeAccessLevel.free,
      paths: [
        pathRahmanA,
        pathRahmanB,
        pathYasinBlock,
        pathMulkBlock,
      ],
    );

    // ------------------------------------------------------------------
    // (4) Gratitude and Reflection
    // ------------------------------------------------------------------
    Path pathAdDuha = Path(
      id: 'path_ad_duha',
      name: loc.pathNameAdDuha,
      description: loc.pathDescAdDuha,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_gratitude_reflection'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );

    Path pathNahl66_72 = Path(
      id: 'path_nahl_66_72',
      name: loc.pathNameNahl66_72,
      description: loc.pathDescNahl66_72,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_gratitude_reflection'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );

    Path pathBaqarah21_29 = Path(
      id: 'path_baqarah_21_29',
      name: loc.pathNameBaqarah21_29,
      description: loc.pathDescBaqarah21_29,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_gratitude_reflection'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );

    ThemeDataQ themeGratitudeReflection = ThemeDataQ(
      id: 'theme_gratitude_reflection',
      name: loc.themeNameGratitudeReflection,
      isUserEditable: false,
      accessLevel: ThemeAccessLevel.free,
      paths: [
        pathBaqarah21_29,
        pathNahl66_72,
        pathAdDuha,
      ],
    );

    // ------------------------------------------------------------------
    // (5) Stories, Lessons, and Reminders
    // ------------------------------------------------------------------
    Path pathKahfCave = Path(
      id: 'path_kahf_cave',
      name: loc.pathNameKahfCave,
      description: loc.pathDescKahfCave,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_stories_reminders'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathKahfMusa = Path(
      id: 'path_kahf_musa',
      name: loc.pathNameKahfMusa,
      description: loc.pathDescKahfMusa,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_stories_reminders'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathWaqiah = Path(
      id: 'path_waqiah',
      name: loc.pathNameWaqiah,
      description: loc.pathDescWaqiah,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_stories_reminders'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );

    ThemeDataQ themeStoriesReminders = ThemeDataQ(
      id: 'theme_stories_reminders',
      name: loc.themeNameStoriesReminders,
      isUserEditable: false,
      accessLevel: ThemeAccessLevel.free,
      paths: [
        pathKahfCave,
        pathKahfMusa,
        pathWaqiah,
      ],
    );

    // ------------------------------------------------------------------
    // (6) Patience (Ṣabr)
    // ------------------------------------------------------------------
    Path pathAsrPatience = Path(
      id: 'path_asr_patience',
      name: loc.pathNameAsrPatience,
      description: loc.pathDescAsrPatience,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_patience'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathBaqarahPatience = Path(
      id: 'path_baq_153_157',
      name: loc.pathNameBaq153_157,
      description: loc.pathDescBaq153_157,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_patience'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathYusuf7_14 = Path(
      id: 'path_yusuf_7_14',
      name: loc.pathNameYusuf7_14,
      description: loc.pathDescYusuf7_14,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_patience'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathYusuf83_92 = Path(
      id: 'path_yusuf_83_92',
      name: loc.pathNameYusuf83_92,
      description: loc.pathDescYusuf83_92,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_patience'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );
    Path pathInshirah = Path(
      id: 'path_inshirah',
      name: loc.pathNameInshirah,
      description: loc.pathDescInshirah,
      lessons: [],
      isUserGenerated: false,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: ['theme_patience'],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );

    ThemeDataQ themePatience = ThemeDataQ(
      id: 'theme_patience',
      name: loc.themeNamePatience,
      isUserEditable: false,
      accessLevel: ThemeAccessLevel.free,
      paths: [
        pathAsrPatience,
        pathBaqarahPatience,
        pathYusuf7_14,
        pathYusuf83_92,
        pathInshirah,
      ],
    );

    // ------------------------------------------------------------------
    // (7) User Created (empty by default)
    // ------------------------------------------------------------------
    ThemeDataQ userCreatedTheme = ThemeDataQ(
      id: 'theme_user_created',
      name: loc.themeNameUserCreated,
      isUserEditable: true,
      accessLevel: ThemeAccessLevel.free,
      paths: [],
    );

    // ------------------------------------------------------------------
    // Add all 7 themes (system + user) to our in-memory list
    // ------------------------------------------------------------------
    _themes.addAll([
      themeCoreRecitation,
      themeBeginJourney,
      themeMercyHope,
      themeGratitudeReflection,
      themeStoriesReminders,
      themePatience,
      userCreatedTheme,
    ]);

    // Load user modifications from Hive (if any)
    await _loadUserThemes();

    // Persist these system paths to the PathService so they survive
    // a full restart with the correct themeIds.
    for (final theme in _themes) {
      for (final p in theme.paths) {
        final existing = pathService.getPathById(p.id);
        if (existing == null) {
          // Path not in memory => add it with correct name/description.
          await pathService.addPredefinedPath(p);
        } else {
          bool changed = false;
          var newExisting = existing;

          // Merge theme IDs if missing.
          for (final tId in p.themeIds) {
            if (!newExisting.themeIds.contains(tId)) {
              newExisting = newExisting.copyWith(
                themeIds: [...newExisting.themeIds, tId],
              );
              changed = true;
            }
          }

          // If existing's name is the same as path.id, override w/ official name/desc.
          if (newExisting.name == newExisting.id) {
            newExisting = newExisting.copyWith(
              name: p.name,
              description: p.description,
            );
            changed = true;
          }

          if (changed) {
            await pathService.updatePath(newExisting);
            loggingService.logWarning(
              '[ThemeService] merged path "${newExisting.id}" => '
                  'name="${newExisting.name}" desc="${newExisting.description}" '
                  'themeIds=${newExisting.themeIds}',
            );
          }
        }
      }
    }

    loggingService.logWarning('[ThemeService] initializeSystemThemes() -> Done. '
        'Themes: ${_themes.map((t) => t.name).join(", ")}');
  }

  /// Called when the user selects a theme, to ensure those [Path]s exist in [PathService].
  /// Also merges name/description if the path was a placeholder.
  Future<void> addThemePathsToPathService(String themeId) async {
    final theme = getThemeById(themeId);
    if (theme == null) return;

    for (final sysPath in theme.paths) {
      final existing = pathService.getPathById(sysPath.id);
      if (existing == null) {
        await pathService.addPredefinedPath(sysPath);
      } else {
        bool changed = false;
        var newExisting = existing;

        // 1) Merge theme IDs:
        for (final tId in sysPath.themeIds) {
          if (!newExisting.themeIds.contains(tId)) {
            newExisting = newExisting.copyWith(
              themeIds: [...newExisting.themeIds, tId],
            );
            changed = true;
          }
        }

        // 2) If existing name is a placeholder, fix it:
        if (newExisting.name == newExisting.id) {
          newExisting = newExisting.copyWith(
            name: sysPath.name,
            description: sysPath.description,
          );
          changed = true;
        }

        if (changed) {
          await pathService.updatePath(newExisting);
        }
      }
    }

    loggingService.logWarning(
      '[ThemeService] addThemePathsToPathService() -> done adding paths for themeId=$themeId',
    );
  }

  /// If user taps on a path that has zero lessons, generate them lazily.
  Future<void> generateLessonsForSystemPath(Path path) async {
    if (path.lessons.isNotEmpty) {
      loggingService.logWarning(
        '[ThemeService] Path ${path.id} already has lessons => skipping generation.',
      );
      return;
    }

    int surahId = 1;
    int startAyah = 1;
    int endAyah = 7;
    int wordsPerLesson = 5;

    switch (path.id) {
    // Core Daily Recitation
      case 'path_fatihah':
        surahId = 1;
        startAyah = 1;
        endAyah = 7;
        wordsPerLesson = 2;
        break;
      case 'path_kafirun':
        surahId = 109;
        startAyah = 1;
        endAyah = 6;
        wordsPerLesson = 2;
        break;
      case 'path_ikhlas':
        surahId = 112;
        startAyah = 1;
        endAyah = 4;
        wordsPerLesson = 2;
        break;
      case 'path_falaq':
        surahId = 113;
        startAyah = 1;
        endAyah = 5;
        wordsPerLesson = 2;
        break;
      case 'path_nas':
        surahId = 114;
        startAyah = 1;
        endAyah = 6;
        wordsPerLesson = 2;
        break;

    // Beginning the Journey
      case 'path_asr_begin':
        surahId = 103;
        startAyah = 1;
        endAyah = 3;
        wordsPerLesson = 2;
        break;
      case 'path_takathur':
        surahId = 102;
        startAyah = 1;
        endAyah = 8;
        wordsPerLesson = 2;
        break;
      case 'path_fil':
        surahId = 105;
        startAyah = 1;
        endAyah = 5;
        wordsPerLesson = 2;
        break;
      case 'path_quraysh':
        surahId = 106;
        startAyah = 1;
        endAyah = 4;
        wordsPerLesson = 2;
        break;

    // Mercy and Hope
      case 'path_rahman_a':
        surahId = 55;
        startAyah = 1;
        endAyah = 13;
        wordsPerLesson = 5;
        break;
      case 'path_rahman_b':
        surahId = 55;
        startAyah = 26;
        endAyah = 36;
        wordsPerLesson = 5;
        break;
      case 'path_yasin_block':
        surahId = 36;
        startAyah = 1;
        endAyah = 12;
        wordsPerLesson = 5;
        break;
      case 'path_mulk_block':
        surahId = 67;
        startAyah = 1;
        endAyah = 15;
        wordsPerLesson = 5;
        break;

    // Gratitude and Reflection
      case 'path_baqarah_21_29':
        surahId = 2;
        startAyah = 21;
        endAyah = 29;
        wordsPerLesson = 5;
        break;
      case 'path_nahl_66_72':
        surahId = 16;
        startAyah = 66;
        endAyah = 72;
        wordsPerLesson = 5;
        break;
      case 'path_ad_duha':
        surahId = 93;
        startAyah = 1;
        endAyah = 11;
        wordsPerLesson = 2;
        break;

    // Stories, Lessons, and Reminders
      case 'path_kahf_cave':
        surahId = 18;
        startAyah = 9;
        endAyah = 16;
        wordsPerLesson = 5;
        break;
      case 'path_kahf_musa':
        surahId = 18;
        startAyah = 60;
        endAyah = 70;
        wordsPerLesson = 5;
        break;
      case 'path_waqiah':
        surahId = 56;
        startAyah = 1;
        endAyah = 15;
        wordsPerLesson = 5;
        break;

    // Patience (Ṣabr)
      case 'path_asr_patience':
        surahId = 103;
        startAyah = 1;
        endAyah = 3;
        wordsPerLesson = 2;
        break;
      case 'path_baq_153_157':
        surahId = 2;
        startAyah = 153;
        endAyah = 157;
        wordsPerLesson = 5;
        break;
      case 'path_yusuf_7_14':
        surahId = 12;
        startAyah = 7;
        endAyah = 14;
        wordsPerLesson = 5;
        break;
      case 'path_yusuf_83_92':
        surahId = 12;
        startAyah = 83;
        endAyah = 92;
        wordsPerLesson = 5;
        break;
      case 'path_inshirah':
        surahId = 94;
        startAyah = 1;
        endAyah = 8;
        wordsPerLesson = 2;
        break;

      default:
        loggingService.logWarning(
          '[ThemeService] generateLessonsForSystemPath() -> Unknown path.id=${path.id}, fallback to Surah Fatiha (1:1–7).',
        );
        surahId = 1;
        startAyah = 1;
        endAyah = 7;
        wordsPerLesson = 5;
        break;
    }

    loggingService.logWarning(
      '[ThemeService] generating lessons for path=${path.id}, surahId=$surahId, $startAyah..$endAyah, wPL=$wordsPerLesson',
    );

    final newLessons = await lessonService.generateLessons(
      surahId,
      wordsPerLesson,
      startAyah: startAyah,
      endAyah: endAyah,
      pathId: path.id,
    );

    path.lessons.addAll(newLessons);

    int totalSteps = 0;
    for (final ls in newLessons) {
      totalSteps += ls.totalSteps;
    }
    path.totalSteps = totalSteps;

    // Update the path in PathService (persist)
    await pathService.updatePath(path);

    loggingService.logWarning(
      '[ThemeService] Created ${newLessons.length} lessons for path=${path.id}',
    );
  }

  // ------------------------------------------------------------------
  //                LOADING & SAVING USER-CREATED THEMES
  // ------------------------------------------------------------------
  Future<void> _loadUserThemes() async {
    try {
      final box = await Hive.openBox<Map>(_themeBoxName);
      final storedMap = box.toMap().cast<dynamic, Map>();
      if (storedMap.isEmpty) {
        return;
      }
      for (final entry in storedMap.entries) {
        final themeId = entry.key as String;
        final mapData = entry.value;
        final loadedTheme = ThemeDataQ.fromMap(Map<String, dynamic>.from(mapData));

        final idx = _themes.indexWhere((t) => t.id == themeId);
        if (idx == -1) {
          _themes.add(loadedTheme);
          loggingService.logWarning('[ThemeService] loaded user theme: ${loadedTheme.name}');
        } else {
          if (_themes[idx].isUserEditable) {
            _themes[idx] = loadedTheme;
            loggingService.logWarning('[ThemeService] updated user-editable theme: ${loadedTheme.name}');
          } else {
            loggingService.logWarning('[ThemeService] system theme $themeId is read-only => ignoring user changes.');
          }
        }
      }
    } catch (e) {
      loggingService.logError('[ThemeService] Error loading user themes => $e');
    }
  }

  Future<void> _saveUserThemes() async {
    try {
      final box = await Hive.openBox<Map>(_themeBoxName);

      // Store only user-editable themes in Hive
      for (final theme in _themes) {
        if (theme.isUserEditable) {
          box.put(theme.id, theme.toMap());
        }
      }

      // Remove system themes from the box if they happen to be stored
      for (final theme in _themes) {
        if (!theme.isUserEditable && box.containsKey(theme.id)) {
          await box.delete(theme.id);
        }
      }

      loggingService.logWarning('[ThemeService] saved user themes to hive.');
    } catch (e) {
      loggingService.logError('[ThemeService] error saving user themes => $e');
    }
  }

  /// Retrieve a theme by ID from our in-memory list
  ThemeDataQ? getThemeById(String themeId) {
    final idx = _themes.indexWhere((t) => t.id == themeId);
    if (idx == -1) return null;
    return _themes[idx];
  }

  /// Add or update a user-editable theme in the in-memory list (then save).
  Future<void> addOrUpdateTheme(ThemeDataQ newTheme) async {
    final idx = _themes.indexWhere((t) => t.id == newTheme.id);
    if (idx == -1) {
      _themes.add(newTheme);
    } else {
      // If theme is system-defined (read-only), ignore changes
      if (!_themes[idx].isUserEditable) {
        loggingService.logWarning('[ThemeService] ignoring attempt to modify system theme ${newTheme.id}');
        return;
      }
      _themes[idx] = newTheme;
    }
    await _saveUserThemes();
  }

  /// For a user-editable theme only: add or update a path in that theme
  Future<void> addOrUpdatePathInTheme(String themeId, Path newPath) async {
    final theme = getThemeById(themeId);
    if (theme == null) return;
    if (!theme.isUserEditable) {
      loggingService.logWarning('[ThemeService] theme $themeId is read-only');
      return;
    }

    final updatedPaths = [...theme.paths];
    final idx = updatedPaths.indexWhere((p) => p.id == newPath.id);
    if (idx == -1) {
      updatedPaths.add(newPath);
    } else {
      updatedPaths[idx] = newPath;
    }
    final updated = theme.copyWith(paths: updatedPaths);
    await addOrUpdateTheme(updated);
  }

  /// For a user-editable theme only: remove a path
  Future<void> removePathFromTheme(String themeId, String pathId) async {
    final theme = getThemeById(themeId);
    if (theme == null) return;
    if (!theme.isUserEditable) {
      loggingService.logWarning('[ThemeService] theme $themeId is read-only => skip remove');
      return;
    }

    final updatedPaths = theme.paths.where((p) => p.id != pathId).toList();
    final updated = theme.copyWith(paths: updatedPaths);
    await addOrUpdateTheme(updated);
  }

  // ------------------------------------------------------------------
  //                 NEW: getOrCreateSurahPath EXAMPLE
  // ------------------------------------------------------------------
  /// Returns an existing Path for [surahId] & optional [startAyah..endAyah] if found.
  /// Otherwise, creates a new user path in 'theme_user_created' (or a chosen [themeId]),
  /// generates lessons, and returns it.
  ///
  /// You can pass a custom [surahName], or default to e.g. "Surah $surahId"
  /// [wordsPerLesson] controls how big each lesson chunk is.
  /// If [themeId] is omitted, we'll store the new path in 'theme_user_created'.
  Future<Path> getOrCreateSurahPath({
    required int surahId,
    int? startAyah,
    int? endAyah,
    String? surahName,
    int wordsPerLesson = 5,
    String themeId = 'theme_user_created',
  }) async {
    loggingService.logWarning(
      '[ThemeService] getOrCreateSurahPath -> surahId=$surahId, '
          'start=$startAyah, end=$endAyah, theme=$themeId, wPL=$wordsPerLesson',
    );

    // 1) See if there's already a matching path in pathService
    final existing = pathService.findPathBySurahRange(
      surahId,
      startAyah: startAyah,
      endAyah: endAyah,
    );
    if (existing != null) {
      loggingService.logWarning('[ThemeService] Found existing path => ${existing.id}');
      return existing;
    }

    // 2) Otherwise, create a new path in the user-created theme
    final userTheme = getThemeById(themeId);
    if (userTheme == null) {
      throw Exception('Theme $themeId not found or not loaded. Cannot create path.');
    }
    if (!userTheme.isUserEditable) {
      throw Exception('Theme $themeId is read-only. Cannot create path.');
    }

    // Generate a unique path ID
    final newPathId = const Uuid().v4();
    final displayName = surahName ?? 'Surah $surahId';
    final desc = (startAyah != null && endAyah != null)
        ? 'Surah $surahId: Ayahs $startAyah..$endAyah'
        : 'Custom Surah $surahId';

    final newPath = Path(
      id: newPathId,
      name: displayName,
      description: desc,
      lessons: [],
      isUserGenerated: true,
      currentStep: 0,
      progress: 0,
      totalSteps: 0,
      themeIds: [themeId],
      creationDate: DateTime.now(),
      tracksProgress: true,
    );

    // 3) Insert this new path into the user theme’s path list
    await addOrUpdatePathInTheme(themeId, newPath);

    // 4) Generate lessons for this new path
    final newLessons = await lessonService.generateLessons(
      surahId,
      wordsPerLesson,
      startAyah: startAyah ?? 1,
      endAyah: endAyah, // if null, the method can figure out default range
      pathId: newPathId,
    );

    newPath.lessons.addAll(newLessons);

    // compute totalSteps:
    final totalSteps = newLessons.fold<int>(0, (sum, ls) => sum + ls.totalSteps);
    newPath.totalSteps = totalSteps;

    // Persist in pathService
    await pathService.addUserPath(newPath);

    loggingService.logWarning(
      '[ThemeService] Created new user path => $newPathId, surah=$surahId, steps=$totalSteps',
    );

    return newPath;
  }
}
