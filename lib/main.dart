import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:developer'; // For logging
import 'dart:convert';  // For jsonDecode
import 'package:flutter/services.dart' show rootBundle;
import 'package:in_app_purchase/in_app_purchase.dart';

// Logging & analytics providers/services
import 'providers/analytics_service_provider.dart';
import 'services/analytics_service.dart';
import 'providers/ff_logging_service_provider.dart';
import 'services/scoring_service.dart';
import 'models/daily_score_data.dart';
import 'models/mistake_log.dart';

// Local services & screens
import 'screens/home_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/path_list_screen.dart';
import 'screens/path_detail_screen.dart';
import 'screens/gratitude_log_screen.dart';
import 'services/local_storage_service.dart';
import 'providers/path_service_provider.dart';
import 'providers/local_storage_service_provider.dart';
import 'services/notification_service.dart';

// Hive & model adapters
import 'models/gratitude_entry_model.dart';
import 'models/difficulty_level_model.dart';
import 'z_onboarding/models/unique_test_model.dart';

// Onboarding references
import 'z_onboarding/services/user_preferences_manager.dart';
import 'z_onboarding/onboarding_coordinator.dart';
import 'z_onboarding/onboarding_flow.dart';
import 'z_onboarding/providers/user_profile_provider.dart'; // for onboardingCheckProvider

// Streak/totals watchers
import 'providers/user_metrics_sync_provider.dart';

// Additional config
import 'package:hudhud_quran_app_new/config.dart';

// NavigatorKey provider
import 'providers/navigator_key_provider.dart';

// Purchase provider
import 'package:hudhud_quran_app_new/providers/purchase_service_provider.dart';

// Theme & Lesson services
import 'services/theme_service.dart';
import 'services/lesson_service.dart';

// [ADDED] Quran Service (for transliteration)
import 'services/quran_service.dart';

// [ADDED] Our generated localizations
import 'l10n/app_localizations.dart';

// [NEW] Distractor provider import => see File 1
import 'providers/quran_distractor_provider.dart';
// [NEW] Actual distractor service class
import 'services/quran_distractor_service.dart';

/// ---------------------------------------------------------------------------
/// PROVIDER FOR LessonService
/// ---------------------------------------------------------------------------
final lessonServiceProviderRef = Provider<LessonService>((ref) {
  final localStorage = ref.read(localStorageServiceProvider);
  final loggingService = ref.read(ffLoggingServiceProvider);

  return LessonService(
    ref: ref,
    localStorageService: localStorage,
    loggingService: loggingService,
  );
});

/// ---------------------------------------------------------------------------
/// PROVIDER FOR ThemeService
/// ---------------------------------------------------------------------------
final themeServiceProvider = Provider<ThemeService>((ref) {
  final loggingService = ref.read(ffLoggingServiceProvider);
  final localStorage = ref.read(localStorageServiceProvider);
  final lessonService = ref.read(lessonServiceProviderRef);
  final pathService = ref.read(pathServiceProviderRef);

  return ThemeService(
    localStorageService: localStorage,
    loggingService: loggingService,
    lessonService: lessonService,
    pathService: pathService,
    strings: AppStrings(),
  );
});

/// Minimal app initialization => loads user paths, etc.
final appInitializationProvider = FutureProvider<void>((ref) async {
  final loggingService = ref.read(ffLoggingServiceProvider);
  final pathService = ref.read(pathServiceProviderRef);
  final localStorage = ref.read(localStorageServiceProvider);

  loggingService.logInfo('[main.dart] Initializing app...');

  // (1) Load any system "placeholder" paths
  await pathService.initializePredefinedPaths();
  loggingService.logInfo('[main.dart] Predefined paths loaded.');

  // (2) Initialize system themes
  final themeService = ref.read(themeServiceProvider);
  await themeService.initializeSystemThemes();
  loggingService.logInfo('[main.dart] System themes loaded.');

  // (3) Check lastActive path
  final lastActive = await localStorage.getLastActivePath();
  loggingService.logWarning('[main.dart] lastActivePath => $lastActive');

  if (lastActive == null) {
    final fatiha = pathService.getPathById('path_fatihah');
    if (fatiha != null) {
      await localStorage.saveLastActivePath('path_fatihah');
      loggingService.logInfo('[main.dart] Defaulted lastActivePath to path_fatihah');
    }
  } else {
    if (lastActive != 'path_fatihah') {
      final path = pathService.getPathById(lastActive);
      if (path != null && path.lessons.isEmpty) {
        loggingService.logWarning(
          '[main.dart] Generating lessons for lastActivePath => $lastActive',
        );
        await themeService.generateLessonsForSystemPath(path);
        loggingService.logWarning('[main.dart] Done generating lessons for $lastActive');
      }
    }
  }
});

/// A FutureProvider that checks if we have "already shown LessonOne."
final didShowLessonOneProvider = FutureProvider<bool>((ref) async {
  final localStorage = ref.read(localStorageServiceProvider);
  final didShow = await localStorage.getDidShowLessonOneImmediately();
  final loggingService = ref.read(ffLoggingServiceProvider);
  loggingService.logWarning('[main.dart] didShowLessonOneProvider => $didShow');
  return didShow;
});

// Connectivity
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged.map((dynamic event) {
    if (event is ConnectivityResult) {
      return event;
    } else if (event is List<ConnectivityResult>) {
      return event.isEmpty ? ConnectivityResult.none : event.first;
    }
    return ConnectivityResult.none;
  });
});

// Simple boolean to indicate online/offline
final isOnlineProvider = Provider<bool>((ref) {
  final connectivityStatus = ref.watch(connectivityProvider);
  return connectivityStatus.when(
    data: (status) => status != ConnectivityResult.none,
    loading: () => true,
    error: (_, __) => false,
  );
});

/// Optional debug helper
Future<void> clearAllHiveData() async {
  await Hive.close();
  await Hive.deleteFromDisk();
}

/// ---------------------------------------------------------------------------
/// MAIN
/// ---------------------------------------------------------------------------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Initialize Firebase
  await Firebase.initializeApp();

  // 2) Create a LoggingService
  final loggingService = LoggingService();
  loggingService.logWarning('[main.dart] Initializing early for distractors...');

  // 3) Build distractor service & load AR + transliteration data
  final distractorService = QuranDistractorService();

  // ----- Load Arabic from quran_ar.json -----
  loggingService.logWarning('[main.dart] Loading Arabic JSON now, for distractors...');
  final rawQuranStringAr = await rootBundle.loadString('assets/quran/quran_ar.json');
  final Map<String, dynamic> parsedMapAr = jsonDecode(rawQuranStringAr);

  final singleWordsAr = <String>[];
  final twoWordPairsAr = <String>[];

  parsedMapAr.forEach((key, versesList) {
    // The Arabic file apparently has "key: [ { 'text': '...' }, ...]"
    if (versesList is List) {
      for (final verseObject in versesList) {
        final textAr = verseObject['text'] as String;
        final tokensAr = textAr.split(' ');
        singleWordsAr.addAll(tokensAr);
        for (var i = 0; i < tokensAr.length - 1; i++) {
          twoWordPairsAr.add('${tokensAr[i]} ${tokensAr[i + 1]}');
        }
      }
    }
  });
  loggingService.logWarning(
    '[main.dart] AR distractors => singleWords:${singleWordsAr.length}, pairs:${twoWordPairsAr.length}',
  );

  // ----- Load transliteration from quran_translit.json -----
  //
  // NOTE: If your transliteration file is structured as:
  // { "1:1": { "t": "...some text..." }, "1:2": { "t": "..." } }
  // then each key is a single object with a "t" field.
  // So we need to parse it accordingly:
  loggingService.logWarning('[main.dart] Loading transliteration JSON now...');
  final rawQuranStringTr = await rootBundle.loadString('assets/quran/transliteration.json');
  final Map<String, dynamic> parsedMapTr = jsonDecode(rawQuranStringTr);

  final singleWordsTr = <String>[];
  final twoWordPairsTr = <String>[];

  // We loop over "1:1", "1:2", etc. -> each value is e.g. {"t": "Bismi Allahi ..."}
  parsedMapTr.forEach((key, verseMap) {
    if (verseMap is Map) {
      final textTr = verseMap['t'] as String?;
      if (textTr != null) {
        final tokensTr = textTr.split(' ');
        singleWordsTr.addAll(tokensTr);
        for (var i = 0; i < tokensTr.length - 1; i++) {
          twoWordPairsTr.add('${tokensTr[i]} ${tokensTr[i + 1]}');
        }
      }
    }
  });
  loggingService.logWarning(
    '[main.dart] TR distractors => singleWords:${singleWordsTr.length}, pairs:${twoWordPairsTr.length}',
  );

  // Put them into distractorService
  distractorService.loadBothData(
    singleWordsAr: singleWordsAr,
    twoWordPairsAr: twoWordPairsAr,
    singleWordsTranslit: singleWordsTr,
    twoWordPairsTranslit: twoWordPairsTr,
  );
  loggingService.logWarning('[main.dart] loaded distractor data (AR + translit).');
  print('Translit tokens (some sample): ${singleWordsTr.take(50).toList()}');

  // 4) Init Hive
  loggingService.logWarning('[main.dart] Initializing Hive...');
  await Hive.initFlutter();

  // !!! WARNING: Do NOT call clearAllHiveData() in production !!!
  /*
  await clearAllHiveData();
  */

  // 5) Register adapters, open boxes
  Hive.registerAdapter(GratitudeEntryAdapter());
  Hive.registerAdapter(UniqueTestModelAdapter());
  Hive.registerAdapter(LanguageAdapter());
  Hive.registerAdapter(SubscriptionTierAdapter());
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(ReminderFrequencyAdapter());
  Hive.registerAdapter(DailyScoreDataAdapter());
  Hive.registerAdapter(MistakeLogAdapter());
  Hive.registerAdapter(DifficultyLevelAdapter());

  await Hive.openBox<GratitudeEntry>('gratitude_entries');
  await Hive.openBox('streakBox');
  await Hive.openBox('lessonSubmitLog');
  await Hive.openBox<UniqueTestModel>('userProfileBox'); // userProfile box

  // 6) Initialize LocalStorage
  await LocalStorageService(loggingService: loggingService).init();
  loggingService.logWarning('[main.dart] Hive initialized & local storage service set up.');

  // 7) Initialize Firebase Analytics & Mixpanel
  final firebaseAnalytics = FirebaseAnalytics.instance;
  loggingService.logInfo('[main.dart] FirebaseAnalytics acquired.');

  final mixpanel = await Mixpanel.init(
    "00816a9302c095d8de2e1fcc78af2447", // Replace with your Mixpanel token
    optOutTrackingDefault: false,
    trackAutomaticEvents: true,
  );
  loggingService.logInfo('[main.dart] Mixpanel initialized.');

  if (!kEnableMixpanel) {
    mixpanel.optOutTracking();
  }

  // 8) Create the AnalyticsService
  final analyticsService = AnalyticsService(
    firebaseAnalytics: firebaseAnalytics,
    mixpanel: mixpanel,
  );

  // 9) Build a single ProviderContainer with override for quranDistractorService
  final container = ProviderContainer(
    overrides: [
      analyticsServiceProvider.overrideWithValue(analyticsService),
      quranDistractorServiceProvider.overrideWithValue(distractorService),
    ],
  );

  // After container is built, we can read from it
  final purchaseService = container.read(purchaseServiceProvider);
  final qService = container.read(quranServiceProvider);

  loggingService.logWarning('[main.dart] container created. Reading purchaseService & quranService now...');

  // 10) Load transliteration for actual verse display (qService)
  loggingService.logWarning('[main.dart] Loading transliteration JSON into quranService...');
  await qService.loadTransliterationJson();
  loggingService.logWarning('[main.dart] transliteration loaded successfully in quranService.');

  // Finally, run the app
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const QuranApp(),
    ),
  );
}

class QuranApp extends ConsumerStatefulWidget {
  const QuranApp({Key? key}) : super(key: key);

  @override
  ConsumerState<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends ConsumerState<QuranApp> {
  bool _didScheduleNotifications = false;

  @override
  void initState() {
    super.initState();
    final loggingService = ref.read(ffLoggingServiceProvider);
    loggingService.logWarning(
      '[main.dart] _QuranAppState.initState => calling _initIAPAndCheck now...',
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initIAPAndCheck();
    });
  }

  Future<void> _initIAPAndCheck() async {
    final loggingService = ref.read(ffLoggingServiceProvider);
    loggingService.logInfo('[main.dart] _initIAPAndCheck => start');

    // 1) Initialize the plugin & purchase service
    final purchaseService = ref.read(purchaseServiceProvider);
    loggingService.logInfo('[main.dart] About to call purchaseService.init()');
    await purchaseService.init();
    loggingService.logInfo('[main.dart] purchaseService init() complete');

    // 2) Attempt to restore past purchases
    loggingService.logInfo('[main.dart] about to call purchaseService.restorePurchases()');
    await purchaseService.restorePurchases();
    loggingService.logInfo('[main.dart] restorePurchases() complete');
  }

  @override
  Widget build(BuildContext context) {
    final loggingService = ref.read(ffLoggingServiceProvider);
    loggingService.setLoggingEnabled(true);
    loggingService.setLogLevel(LogLevel.debug);

    loggingService.logWarning('[main.dart] Building QuranApp UI...');

    // 1) Log an event to analytics on app build
    final analytics = ref.watch(analyticsServiceProvider);
    analytics.logEvent("quranapp_ui_build");

    // 2) Force userMetricsSyncProvider to run => watchers for streak, etc.
    ref.read(userMetricsSyncProvider);

    // 3) Watch userProfile => used for picking the UI language
    final userProfile = ref.watch(userProfileProvider);
    loggingService.logWarning('[main.dart] userProfile => $userProfile');

    // Convert userProfile.languagePreference => Locale
    Locale chosenLocale;
    switch (userProfile.languagePreference) {
      case Language.french:
        chosenLocale = const Locale('fr');
        break;
      case Language.arabic:
        chosenLocale = const Locale('ar');
        break;
      case Language.farsi:
        chosenLocale = const Locale('fa');
        break;
      case Language.turkish:
        chosenLocale = const Locale('tr');
        break;
      case Language.spanish:
        chosenLocale = const Locale('es');
        break;
      case Language.malaysian:
        chosenLocale = const Locale('ms');
        break;
      case Language.indonesian:
        chosenLocale = const Locale('id');
        break;
      case Language.urdu:
        chosenLocale = const Locale('ur');
        break;
      default:
        chosenLocale = const Locale('en');
        break;
    }

    // Grab our global navigatorKey
    final navKey = ref.watch(navigatorKeyProvider);

    // Connectivity
    final isOnline = ref.watch(isOnlineProvider);
    loggingService.logInfo('[main.dart] isOnline => $isOnline');

    return MaterialApp(
      navigatorKey: navKey,
      title: 'Quran Memorization App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue[800],
          selectionColor: Colors.blue[200],
          selectionHandleColor: Colors.blue[800],
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: chosenLocale,
      initialRoute: '/',
      routes: {
        '/paths': (context) => const PathListScreen(),
        '/gratitudeLog': (context) => const GratitudeLogScreen(),
      },
      onGenerateRoute: (settings) {
        loggingService.logWarning('[main.dart] Generating route: ${settings.name}');
        if (settings.name == '/lesson') {
          final args = settings.arguments as Map<String, dynamic>;
          loggingService.logWarning(
            '[main.dart] Navigating to LessonScreen with args: $args',
          );
          return MaterialPageRoute(
            builder: (context) => LessonScreen(
              lessonId: args['lessonId'],
              languageCode: args['languageCode'],
              surahId: args['surahId'],
              pathId: args['pathId'],
            ),
          );
        } else if (settings.name == '/path_detail') {
          final args = settings.arguments as Map<String, dynamic>;
          loggingService.logWarning(
            '[main.dart] Navigating to PathDetailScreen with args: $args',
          );
          return MaterialPageRoute(
            builder: (context) => PathDetailScreen(pathId: args['pathId']),
          );
        }
        return null;
      },
      home: Consumer(
        builder: (context, ref, _) {
          // A) Minimal app initialization
          final asyncAppInitialization = ref.watch(appInitializationProvider);

          // B) Distractor service init
          final asyncDistractorInit = ref.watch(distractorInitProvider);

          // Ensure userProfile is loaded
          final userProfileNotifier = ref.watch(userProfileProvider.notifier);
          if (!userProfileNotifier.hasLoadedFromHive) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // C) Check if user finished onboarding
          final isOnboardingDone = ref.watch(onboardingCheckProvider);

          // D) Check forced first lesson
          final asyncDidShowLessonOne = ref.watch(didShowLessonOneProvider);

          loggingService.logWarning(
            '[main.dart] appInitialization => loading:${asyncAppInitialization.isLoading}, '
                'error:${asyncAppInitialization.error} | '
                'distractorInit => loading:${asyncDistractorInit.isLoading}, '
                'error:${asyncDistractorInit.error} | '
                'didShowLessonOne => loading:${asyncDidShowLessonOne.isLoading}, '
                'error:${asyncDidShowLessonOne.error}',
          );
          loggingService.logWarning('[main.dart] isOnboardingDone => $isOnboardingDone');

          if (asyncAppInitialization.isLoading ||
              asyncDistractorInit.isLoading ||
              asyncDidShowLessonOne.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (asyncAppInitialization.hasError) {
            loggingService.logError(
              '[main.dart] Error during app init => ${asyncAppInitialization.error}',
            );
            return const HomeScreen();
          }
          if (asyncDistractorInit.hasError) {
            loggingService.logError(
              '[main.dart] Error initializing distractor service => ${asyncDistractorInit.error}',
            );
            return const HomeScreen();
          }
          if (asyncDidShowLessonOne.hasError) {
            loggingService.logError(
              '[main.dart] Error checking didShowLessonOne => ${asyncDidShowLessonOne.error}',
            );
            return const HomeScreen();
          }

          final didShowLessonOne = asyncDidShowLessonOne.value ?? false;
          loggingService.logInfo(
            '[main.dart] Routing => onboardingDone=$isOnboardingDone, didShowLessonOne=$didShowLessonOne',
          );

          // 1) If not done => OnboardingFlow
          if (!isOnboardingDone) {
            loggingService.logInfo('[main.dart] => OnboardingFlow (onboarding NOT done)');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final coordinator = ref.read(onboardingCoordinatorProvider);
              if (!coordinator.isInitialized) {
                loggingService.logWarning(
                  '[main.dart] Initializing OnboardingCoordinator now...',
                );
                coordinator.initialize();
              } else {
                loggingService.logWarning(
                  '[main.dart] OnboardingCoordinator was already initialized.',
                );
              }
            });
            return ProviderScope(
              overrides: [
                onboardingCoordinatorProvider.overrideWith(
                      (overrideRef) => OnboardingCoordinator(
                    totalSteps: 6,
                    ref: overrideRef,
                  ),
                ),
              ],
              child: const OnboardingFlow(enableAnimations: true),
            );
          }

          // 2) If onboarding done => forced lesson => Al-Fatiha if not shown
          if (!didShowLessonOne) {
            loggingService.logInfo('[main.dart] => Forcing first lesson => Al-Fatiha');
            return LessonScreen(
              lessonId: 'lesson_path_fatihah_2',
              languageCode: 'en',
              surahId: 1,
              pathId: 'path_fatihah',
              forcedFirstLesson: true,
            );
          }

          // 3) If onboarding & forced lesson are done => go Home
          loggingService.logInfo('[main.dart] => HomeScreen');

          if (!_didScheduleNotifications) {
            _didScheduleNotifications = true;
            final loc = AppLocalizations.of(context)!;
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final notifService = ref.read(notificationServiceProvider);
              await notifService.initNotificationService();
              await notifService.scheduleNextNotification(ref, loc);
            });
          }

          return const HomeScreen();
        },
      ),
    );
  }
}
