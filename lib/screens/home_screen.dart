import 'dart:developer' show log;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers
import '../providers/path_service_provider.dart';
import '../providers/progress_service_provider.dart';
import '../providers/local_storage_service_provider.dart';
import '../providers/combined_streak_provider.dart';
import '../providers/ff_logging_service_provider.dart';
import '../providers/theme_service_provider.dart';
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';
import '../services/quran_service.dart'; // For QuranService

// Models & Services
import '../models/path_model.dart';
import '../models/lesson_model.dart';
import '../services/scoring_service.dart';
import 'package:hudhud_quran_app_new/z_onboarding/models/unique_test_model.dart'; // For SubscriptionTier

// We removed subscription_provider.dart, now we rely on user_profile_provider:
import '../z_onboarding/providers/user_profile_provider.dart';

// Widgets
import '../widgets/top_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/gratitude_modal.dart';
import '../widgets/submission_feedback_modal.dart';
import '../widgets/vertical_lesson_icons.dart';
import '../widgets/progress_bar.dart'; // Same ProgressBar used in path_detail

// Screens
import 'lesson_screen.dart';
import 'theme_screen.dart';

// NEW: Generated localization
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

/// A data class that holds a Path plus progress & validity.
class PathWithProgress {
  final Path path;
  final double progress;
  final bool isValid;

  PathWithProgress({
    required this.path,
    required this.progress,
    required this.isValid,
  });
}

/// A FutureProvider that loads the “active path” from local storage
/// or falls back to path_fatihah if none is found.
final asyncActivePathProvider = FutureProvider<PathWithProgress>((ref) async {
  final loggingService = ref.read(ffLoggingServiceProvider);
  final localStorage = ref.read(localStorageServiceProvider);
  final pathService = ref.read(pathServiceProviderRef);
  final progressService = ref.read(progressServiceProvider);
  final themeService = ref.read(themeServiceProviderRef);

  final lastActivePathId = await localStorage.getLastActivePath();
  loggingService.logWarning(
      '[asyncActivePathProvider] lastActivePathId: $lastActivePathId');

  if (lastActivePathId == null) {
    loggingService.logWarning(
        '[asyncActivePathProvider] No lastActivePath => default to path_fatihah');
    return _loadOrFallbackToPlaceholder(ref, 'path_fatihah');
  }

  try {
    var path = pathService.getPathById(lastActivePathId);

    if (path == null) {
      // Attempt user path from disk, else generate system path
      loggingService.logWarning(
          '[asyncActivePathProvider] Path "$lastActivePathId" not found => generate...');
      final userPathFromDisk = await localStorage.getPathById(lastActivePathId);
      if (userPathFromDisk != null) {
        pathService.addUserPath(userPathFromDisk);
        path = userPathFromDisk;
      } else {
        final systemPath = Path(
          id: lastActivePathId,
          name: lastActivePathId,
          lessons: [],
          themeIds: ['theme_core_recitation'],
          currentStep: 0,
          description: lastActivePathId,
          isUserGenerated: false,
        );
        // Generate lessons lazily
        await themeService.generateLessonsForSystemPath(systemPath);
        pathService.addPredefinedPath(systemPath);
        path = systemPath;
      }
    }

    if (path == null) {
      // Ultimately fallback to path_fatihah if everything fails
      loggingService.logWarning(
          '[asyncActivePathProvider] fallback => path_fatihah');
      return _loadOrFallbackToPlaceholder(ref, 'path_fatihah');
    }

    // If path is valid & tracksProgress => get progress from disk
    final valid = await pathService.isValidPath(path.id);
    if (valid && path.tracksProgress) {
      final prog = await progressService.getPathProgress(path.id);
      loggingService.logWarning(
          '[asyncActivePathProvider] Active path: ${path.id}, progress=$prog');
      return PathWithProgress(path: path, progress: prog, isValid: true);
    }

    loggingService.logWarning(
        '[asyncActivePathProvider] Invalid => path_fatihah');
    return _loadOrFallbackToPlaceholder(ref, 'path_fatihah');
  } catch (e, st) {
    loggingService.logWarning(
        '[asyncActivePathProvider] Error => fallback to path_fatihah\n$e\n$st');
    return _loadOrFallbackToPlaceholder(ref, 'path_fatihah');
  }
});

/// Helper that tries loading requestedPathId or returns placeholder.
Future<PathWithProgress> _loadOrFallbackToPlaceholder(
    Ref ref,
    String requestedPathId,
    ) async {
  final loggingService = ref.read(ffLoggingServiceProvider);
  final pathService = ref.read(pathServiceProviderRef);
  final progressService = ref.read(progressServiceProvider);

  final fallback = pathService.getPathById(requestedPathId);
  if (fallback != null) {
    final validF = await pathService.isValidPath(requestedPathId);
    double progF = 0.0;
    if (validF && fallback.tracksProgress) {
      progF = await progressService.getPathProgress(requestedPathId);
    }
    return PathWithProgress(path: fallback, progress: progF, isValid: validF);
  } else {
    loggingService.logWarning(
        '[asyncActivePathProvider] No "$requestedPathId" => placeholder');
    return PathWithProgress(
      path: Path(
        id: 'placeholder',
        name: 'No Valid Path Found',
        lessons: [],
        currentStep: 0,
        description: 'No valid paths are available.',
        isUserGenerated: false,
      ),
      progress: 0.0,
      isValid: false,
    );
  }
}

/// Whether user can see progress or not, based on subscription tier.
bool canViewProgress(SubscriptionTier userTier) {
  switch (userTier) {
    case SubscriptionTier.free:
      return false;
    case SubscriptionTier.premium:
    case SubscriptionTier.premiumPlus:
      return true;
  }
}

/// A FutureProvider that fetches today's daily score from ScoreService.
final dailyScoreProvider = FutureProvider<int>((ref) async {
  final scoreService = ScoreService();
  final now = DateTime.now();
  final points = await scoreService.fetchDailyPoints(now);
  return points;
});

/// The HomeScreen shows the top bar (with streak bubble), the active path,
/// its progress, and a "lessons" area. Has a FAB for logging gratitude.
class HomeScreen extends ConsumerStatefulWidget {
  final String? themeId;

  const HomeScreen({Key? key, this.themeId}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('home_screen_viewed');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // For localizations
    final loggingService = ref.read(ffLoggingServiceProvider);

    // Watch dailyScore => required for TopBar(dailyScore: ...)
    final dailyScoreAsync = ref.watch(dailyScoreProvider);

    return dailyScoreAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stackTrace) {
        loggingService.logError('[HomeScreen] dailyScore error => $err');
        return Scaffold(
          body: Center(
            child: Text('${loc.errorLoadingActivePath}: $err'),
          ),
        );
      },
      data: (dailyScore) {
        // Now that we have the daily score, watch the active path
        final activePathAsync = ref.watch(asyncActivePathProvider);

        // 2) Watch the combined streak
        final combinedStreak = ref.watch(combinedStreakProvider);

        // 3) Instead of a separate subscription_provider, read user profile
        final userProfile = ref.watch(userProfileProvider);
        final userTier = userProfile.subscriptionTier;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            // Make the status bar area blue so it doesn't appear black
            statusBarColor: Colors.blue[50],
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: activePathAsync.when(
              // If data => show the content
              data: (activePathWP) {
                // If no valid path => fallback
                if (activePathWP.path.id == 'placeholder') {
                  return Scaffold(
                    backgroundColor: Colors.blue[50],
                    appBar: AppBar(
                      backgroundColor: Colors.blue[50],
                      title: Text(
                        loc.homeTitle, // e.g. "Home"
                        style: const TextStyle(color: Colors.black),
                      ),
                      centerTitle: true,
                      elevation: 0,
                      iconTheme: const IconThemeData(color: Colors.black),
                    ),
                    body: Center(
                      child: Text(
                        loc.noPathsLabel, // e.g. "No valid paths available."
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }

                // If valid path => build
                return Column(
                  children: [
                    // Top portion in blue (including status bar)
                    Container(
                      color: Colors.blue[50],
                      child: SafeArea(
                        child: TopBar(
                          streakCount: combinedStreak.consecutiveDays,
                          dailyScore: dailyScore, // pass the daily score
                        ),
                      ),
                    ),
                    // The main content in white
                    Expanded(
                      child: _buildHomeContent(
                        context: context,
                        activePath: activePathWP.path,
                        progress: activePathWP.progress,
                        userTier: userTier,
                        ref: ref,
                        loggingService: loggingService,
                      ),
                    ),
                  ],
                );
              },
              // Show a spinner while loading
              loading: () => const Center(child: CircularProgressIndicator()),
              // Or show error message if error
              error: (err, stackTrace) {
                loggingService.logError('[HomeScreen] Error => $err');
                return Center(
                  // e.g. "Error loading the active path: {err}"
                  child: Text(
                    loc.errorLoadingActivePath('$err'),
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              },
            ),

            // Bottom nav bar, if we have data => show it with the active path ID
            bottomNavigationBar: activePathAsync.when(
              data: (activePathWP) => BottomNavBar(
                currentIndex: 0,
                pathId: activePathWP.path.id,
                ref: ref,
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }

  /// The main content area: path card, progress bar, vertical icons.
  Widget _buildHomeContent({
    required BuildContext context,
    required Path activePath,
    required double progress,
    required SubscriptionTier userTier,
    required WidgetRef ref,
    required LoggingService loggingService,
  }) {
    final loc = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // *** Use whichever is smaller for consistent phone vs. tablet scaling
    final shortSide = (screenWidth < screenHeight) ? screenWidth : screenHeight;

    // We define a text scale factor that won't exceed 1.3 on tablets:
    double scaleText = shortSide / 420.0;
    // Keep it 1.0 on phones, up to 1.3 on tablets:
    scaleText = scaleText.clamp(1.0, 1.0);

    // Clamp progress to [0..100]
    final clampedProgress = progress.clamp(0.0, 100.0);

    // If system-defined => localize from .arb. If user path => show path.name
    final displayedPathName = _getLocalizedPathName(
      context,
      activePath.id,
      activePath.isUserGenerated,
      activePath.name,
    );

    // We'll scale the card's padding and arrow icon size using screenWidth
    final double horizontalPadding = screenWidth * 0.04;
    final double verticalPadding = screenWidth * 0.03;
    final double arrowIconSize = screenWidth * 0.05;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.02),

        // A card that shows the path's name => "Tap to open theme screen"
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Semantics(
              label: loc.homePathCardLabel, // e.g. "Tap to open theme screen"
              button: true,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _onPathCardTapped(context, activePath, ref),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          displayedPathName,
                          style: TextStyle(
                            // For phone => same as before; for tablet => up to +30%
                            fontSize: (shortSide * 0.04) * scaleText,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Semantics(
                        label: loc.arrowForwardSemanticLabel,
                        // e.g. "Open details"
                        button: false,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: arrowIconSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: screenHeight * 0.02),

        // If path tracks progress => show progress. Else disclaimers.
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Builder(builder: (_) {
            if (!activePath.tracksProgress) {
              return Text(
                loc.noTrackProgressLabel,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  // For phone => same as before; for tablet => up to +30%
                  fontSize: (shortSide * 0.035) * scaleText,
                ),
              );
            }
            if (!canViewProgress(userTier)) {
              return Text(
                loc.premiumRequiredLabel,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  // For phone => same as before; for tablet => up to +30%
                  fontSize: (shortSide * 0.035) * scaleText,
                ),
              );
            }

            // Otherwise show progress bar & label
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${clampedProgress.toStringAsFixed(1)}% ${loc.completedLabel}',
                  style: TextStyle(
                    // For phone => same as before; for tablet => up to +30%
                    fontSize: (shortSide * 0.045) * scaleText,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                ProgressBar(progress: clampedProgress),
              ],
            );
          }),
        ),

        // The lessons area => a flexible vertical list
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            child: VerticalLessonIcons(
              lessons: activePath.lessons,
              onLessonTap: (lesson) =>
                  _navigateToLesson(context, lesson, activePath.id, ref),
              pathProgress: clampedProgress,
              activePathId: activePath.id,
              // Pass themeId here:
              themeId: (widget.themeId?.isNotEmpty == true)
                  ? widget.themeId
                  : (activePath.themeIds.isNotEmpty
                  ? activePath.themeIds.first
                  : null),
            ),
          ),
        ),
      ],
    );
  }

  /// Called when user taps the path "dropdown" card => navigate to ThemeScreen (or path detail).
  void _onPathCardTapped(BuildContext context, Path activePath, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);

    analytics.logEvent('home_screen_path_card_tapped', parameters: {
      'path_id': activePath.id,
      'path_name': activePath.name,
    });

    final nav = Navigator.of(context);
    final themeId = (widget.themeId?.isNotEmpty == true)
        ? widget.themeId
        : (activePath.themeIds.isNotEmpty ? activePath.themeIds.first : null);

    nav.push(
      MaterialPageRoute(
        builder: (_) => ThemeScreen(pathId: activePath.id, themeId: themeId),
      ),
    ).then((_) {
      if (!context.mounted) return;
      // Refresh progress if changed
      ref.invalidate(asyncActivePathProvider);
    });
  }

  /// Show the path's name in the correct language if system-defined; else use DB text.
  String _getLocalizedPathName(
      BuildContext context,
      String pathId,
      bool isUserGenerated,
      String pathNameFromDb,
      ) {
    final loc = AppLocalizations.of(context)!;

    if (isUserGenerated) {
      // If the user typed the name manually, we just return it
      return pathNameFromDb;
    }

    // If it's a system-defined path => do the same approach as PathDetail
    switch (pathId) {
      case 'path_fatihah':
        return loc.pathNameFatihah;
      case 'path_kafirun':
        return loc.pathNameKafirun;
      case 'path_ikhlas':
        return loc.pathNameIkhlas;
      case 'path_falaq':
        return loc.pathNameFalaq;
      case 'path_nas':
        return loc.pathNameNas;
      case 'path_asr_begin':
        return loc.pathNameAsrBegin;
      case 'path_takathur':
        return loc.pathNameTakathur;
      case 'path_fil':
        return loc.pathNameFil;
      case 'path_quraysh':
        return loc.pathNameQuraysh;
      case 'path_rahman_a':
        return loc.pathNameRahmanA;
      case 'path_rahman_b':
        return loc.pathNameRahmanB;
      case 'path_yasin_block':
        return loc.pathNameYasinBlock;
      case 'path_mulk_block':
        return loc.pathNameMulkBlock;
      case 'path_baqarah_21_29':
        return loc.pathNameBaqarah21_29;
      case 'path_nahl_66_72':
        return loc.pathNameNahl66_72;
      case 'path_ad_duha':
        return loc.pathNameAdDuha;
      case 'path_kahf_cave':
        return loc.pathNameKahfCave;
      case 'path_kahf_musa':
        return loc.pathNameKahfMusa;
      case 'path_waqiah':
        return loc.pathNameWaqiah;
      case 'path_asr_patience':
        return loc.pathNameAsrPatience;
      case 'path_baq_153_157':
        return loc.pathNameBaq153_157;
      case 'path_yusuf_7_14':
        return loc.pathNameYusuf7_14;
      case 'path_yusuf_83_92':
        return loc.pathNameYusuf83_92;
      case 'path_inshirah':
        return loc.pathNameInshirah;

      default:
      // If not recognized => fallback to DB text
        return pathNameFromDb;
    }
  }

  /// Navigate to the LessonScreen
  void _navigateToLesson(
      BuildContext context,
      Lesson lesson,
      String pathId,
      WidgetRef ref,
      ) {
    final nav = Navigator.of(context);
    nav
        .push(
      MaterialPageRoute(
        builder: (_) => LessonScreen(
          lessonId: lesson.id,
          languageCode: 'en', // or your user language if you wish
          surahId: lesson.surahId,
          pathId: pathId,
        ),
      ),
    )
        .then((_) {
      if (!context.mounted) return;
      // Invalidate => refresh progress if changed
      ref.invalidate(asyncActivePathProvider);
    }).catchError((err) {
      if (!context.mounted) return;
      final loc = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${loc.errorNavigatingToLesson}: $err')),
      );
    });
  }
}
