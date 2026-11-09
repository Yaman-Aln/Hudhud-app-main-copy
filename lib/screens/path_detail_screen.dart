import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' show log;

// Providers
import '../providers/path_service_provider.dart';
import '../providers/progress_service_provider.dart';
import 'package:hudhud_quran_app_new/z_onboarding/providers/user_profile_provider.dart'; // <--- ADDED
import '../providers/ff_logging_service_provider.dart';
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';
import '../providers/theme_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

// Models & Services
import 'package:hudhud_quran_app_new/z_onboarding/models/unique_test_model.dart';
import '../services/quran_service.dart';
import '../models/path_model.dart';
import '../models/lesson_model.dart';
import '../services/theme_service.dart'; // For generateLessonsForSystemPath

// Screens & Widgets
import 'lesson_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/progress_bar.dart';

// NEW: localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

/// A small data class to hold one Path (if found) plus a list of Lessons w/ progress.
class PathWithLessons {
  final Path? path;
  final List<Lesson> lessons;

  PathWithLessons({
    required this.path,
    required this.lessons,
  });
}

/// Whether user can see progress or not, based on tier.
bool canViewProgress(SubscriptionTier userTier) {
  switch (userTier) {
    case SubscriptionTier.free:
      return false;
    case SubscriptionTier.premium:
    case SubscriptionTier.premiumPlus:
      return true;
  }
}

/// A FutureProvider.family that, given a [pathId], fetches the [Path] from memory
/// and loads each lesson’s progress from [ProgressService].
final asyncLessonsWithProgressProvider =
FutureProvider.family<PathWithLessons, String>((ref, pathId) async {
  final pathService = ref.read(pathServiceProviderRef);
  final progressService = ref.read(progressServiceProvider);
  final logSvc = ref.read(ffLoggingServiceProvider);

  // 1) Attempt to retrieve the path from memory
  final path = pathService.getPathById(pathId);
  if (path == null) {
    logSvc.logWarning('[PathDetailScreen] Path not found for pathId: $pathId');
    return PathWithLessons(path: null, lessons: []);
  }

  // 2) For each lesson in that path, retrieve progress
  final List<Lesson> lessonsWithProgress = [];
  for (final lesson in path.lessons) {
    try {
      final progData = await progressService.getLessonProgress(
        lesson.id,
        pathId: pathId,
      );
      final prog = (progData['progress'] ?? 0) as int;
      final currentStep = (progData['currentStep'] ?? 0) as int;

      lessonsWithProgress.add(
        lesson.copyWith(
          progress: prog,
          currentStep: currentStep,
        ),
      );
      logSvc.logWarning(
        '[PathDetailScreen] Loaded progress for lesson ${lesson.id}: ${prog}%',
      );
    } catch (e) {
      logSvc.logWarning(
        '[PathDetailScreen] Error loading progress for lesson ${lesson.id}: $e',
      );
    }
  }

  return PathWithLessons(path: path, lessons: lessonsWithProgress);
});

/// A screen that shows:
///  - Path’s name & description (localized if system-defined)
///  - Path-level progress (if tracksProgress + user can see)
///  - A list of lessons with progress. Tapping a lesson => [LessonScreen].
class PathDetailScreen extends ConsumerStatefulWidget {
  final String pathId;

  const PathDetailScreen({Key? key, required this.pathId}) : super(key: key);

  @override
  ConsumerState<PathDetailScreen> createState() => _PathDetailScreenState();
}

class _PathDetailScreenState extends ConsumerState<PathDetailScreen> {
  /// To avoid repeatedly generating lessons in a rebuild loop, track if we’ve done it once.
  bool _didGenerateSystemLessons = false;

  @override
  void initState() {
    super.initState();
    // 1) Log "path_detail_screen_viewed" w/ pathId
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('path_detail_screen_viewed', parameters: {
      'path_id': widget.pathId,
    });
  }

  /// Recompute path progress on exit, then pop with “refresh = true”.
  Future<void> _updateAndNavigateBack(
      WidgetRef ref,
      String pathId,
      BuildContext context,
      ) async {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final logSvc = ref.read(ffLoggingServiceProvider);

    // Log "path_detail_screen_update_and_navigate_back"
    analytics.logEvent('path_detail_screen_update_and_navigate_back', parameters: {
      'path_id': pathId,
      'cta_source': 'app_bar_back_button',
    });

    final nav = Navigator.of(context);

    try {
      // 1) Recompute path progress
      await ref.read(progressServiceProvider).calculateAndSavePathProgress(pathId);

      // 2) Optionally log the updated progress
      final updatedProg = await ref.read(progressServiceProvider).getPathProgress(pathId);
      logSvc.logWarning(
        '[PathDetailScreen] Recalculated progress for $pathId => $updatedProg%',
      );

      // 3) Invalidate to refresh
      ref.invalidate(asyncLessonsWithProgressProvider(pathId));

      // 4) Return "true" (refresh needed)
      nav.pop(true);
    } catch (e) {
      logSvc.logWarning('[PathDetailScreen] Error saving path progress: $e');
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('${loc.pathDetailScreenFailToUpdate} $e')),
      );
      nav.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);
    final logSvc = ref.read(ffLoggingServiceProvider);

    // 1) Watch Path + Lessons
    final asyncData = ref.watch(asyncLessonsWithProgressProvider(widget.pathId));
    // 2) Watch user tier for progress logic
    final userTier = ref.watch(userProfileProvider).subscriptionTier;

    // Dynamic sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        centerTitle: true,
        leading: Semantics(
          label: loc.pathDetailScreenBackArrowSemantic, // e.g. "Go back to path list"
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              // Log "path_detail_screen_back_pressed"
              analytics.logEvent('path_detail_screen_back_pressed', parameters: {
                'from_screen': 'path_detail_screen',
                'path_id': widget.pathId,
                'cta_source': 'app_bar_arrow',
              });
              // Then do the update
              await _updateAndNavigateBack(ref, widget.pathId, context);
            },
          ),
        ),
        title: Text(
          loc.pathDetailScreenTitle, // e.g. "Path Details"
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045,
          ),
        ),
      ),
      body: asyncData.when(
        data: (pwl) {
          final path = pwl.path;
          if (path == null) {
            logSvc.logWarning(
              '[PathDetailScreen] Path not found for pathId=${widget.pathId}',
            );
            return Center(
              child: Text(loc.pathDetailScreenNotFound), // e.g. "Path not found."
            );
          }

          // If it’s a system path, no lessons => generate them now
          if (!path.isUserGenerated && path.lessons.isEmpty && !_didGenerateSystemLessons) {
            _didGenerateSystemLessons = true; // to prevent repeated calls
            // Kick off async generation, then refresh
            ref
                .read(themeServiceProviderRef)
                .generateLessonsForSystemPath(path)
                .then((_) {
              ref.invalidate(asyncLessonsWithProgressProvider(widget.pathId));
            });
            // Meanwhile, show a spinner
            return const Center(child: CircularProgressIndicator());
          }

          // Sort lessons by ayah range
          final lessons = pwl.lessons.toList()
            ..sort((a, b) => a.startAyah.compareTo(b.startAyah));

          // Does user see path-level progress?
          final userCanViewProgress = path.tracksProgress && canViewProgress(userTier);

          // Localize the path name & description if system-defined
          final localizedPathName = _getLocalizedPathName(
            context,
            path.id,
            path.isUserGenerated,
            path.name,
          );
          final localizedPathDesc = _getLocalizedPathDescription(
            context,
            path.id,
            path.isUserGenerated,
            path.description,
          );

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Path name
                Text(
                  localizedPathName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Path description
                if (localizedPathDesc.isNotEmpty) ...[
                  Text(
                    localizedPathDesc,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],

                const Divider(),

                // Path-level progress or disclaimers
                if (!path.tracksProgress)
                  Text(
                    loc.pathDetailScreenProgressDisabled,
                    style: const TextStyle(color: Colors.blueGrey),
                  )
                else if (!userCanViewProgress)
                  Text(
                    loc.premiumRequiredLabel, // "Progress requires premium, etc."
                    style: const TextStyle(color: Colors.redAccent),
                  )
                else ...[
                    Text(
                      '${path.progress.toStringAsFixed(1)}% ${loc.completedLabel}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    ProgressBar(progress: path.progress.toDouble()),
                  ],

                SizedBox(height: screenHeight * 0.02),
                const Divider(),

                // Lessons heading
                Text(
                  loc.pathDetailScreenLessonsHeading, // e.g. "Lessons:"
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // List of lessons
                Expanded(
                  child: lessons.isEmpty
                      ? Center(
                    child: Text(loc.pathDetailScreenNoLessonsLabel),
                  )
                      : ListView.separated(
                    itemCount: lessons.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: screenHeight * 0.01),
                    itemBuilder: (ctx, idx) {
                      final lesson = lessons[idx];
                      final complete = lesson.progress >= 100;
                      final valid = lesson.progress >= 0; // custom logic

                      // Surah name from the library, based on userProfile language
                      final surahName = ref
                          .read(quranServiceProvider)
                          .getSurahNamePreferred(lesson.surahId);

                      final cardColor = valid ? null : Colors.red[50];

                      return Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: cardColor,
                        child: Semantics(
                          label: loc.pathDetailScreenLessonCardSemantic,
                          button: true,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            leading: _buildLessonLeadingIcon(
                              context: ctx,
                              complete: complete,
                              valid: valid,
                              screenWidth: screenWidth,
                            ),
                            title: Text(
                              loc.pathDetailScreenLessonTitle(
                                (idx + 1).toString(),
                                surahName,
                                lesson.startAyah.toString(),
                                lesson.endAyah.toString(),
                              ),
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: valid ? Colors.black : Colors.red,
                              ),
                            ),
                            subtitle: valid
                                ? _buildLessonSubtitle(
                              path,
                              lesson,
                              userCanViewProgress,
                              screenWidth,
                              screenHeight,
                              loc,
                            )
                                : Text(
                              loc.pathDetailScreenLessonProgressUnavailable,
                              style: const TextStyle(color: Colors.red),
                            ),
                            onTap: () async {
                              // Log "path_detail_screen_lesson_clicked"
                              final nav = Navigator.of(ctx);

                              analytics.logEvent(
                                'path_detail_screen_lesson_clicked',
                                parameters: {
                                  'path_id': path.id,
                                  'path_name': path.name,
                                  'lesson_id': lesson.id,
                                  'surah_name': surahName,
                                  'start_ayah': lesson.startAyah.toString(),
                                  'end_ayah': lesson.endAyah.toString(),
                                  'lesson_location': (idx + 1).toString(),
                                  'lesson_progress': lesson.progress.toString(),
                                },
                              );

                              if (!valid) {
                                logSvc.logWarning(
                                  '[PathDetailScreen] tapped invalid lesson ${lesson.id}',
                                );
                                return;
                              }

                              logSvc.logWarning(
                                '[PathDetailScreen] Tapping lesson ${lesson.id}',
                              );

                              // Navigate to LessonScreen
                              final result = await nav.push<bool>(
                                MaterialPageRoute(
                                  builder: (_) => LessonScreen(
                                    lessonId: lesson.id,
                                    languageCode: 'en',
                                    surahId: lesson.surahId,
                                    pathId: path.id,
                                  ),
                                ),
                              );

                              // If user completed or changed progress => re-invalidate
                              if (result == true) {
                                ref.invalidate(
                                  asyncLessonsWithProgressProvider(path.id),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) {
          logSvc.logWarning(
              '[PathDetailScreen] Error loading path or lessons => $err');
          return Center(
            child: Text('${loc.pathDetailScreenErrorLoading} $err'),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, // e.g. the “Paths” tab
        ref: ref,
        pathId: null,
      ),
    );
  }

  /// Builds a leading icon for each Lesson item (check, hourglass, or error) with Semantics.
  Widget _buildLessonLeadingIcon({
    required BuildContext context,
    required bool complete,
    required bool valid,
    required double screenWidth,
  }) {
    final loc = AppLocalizations.of(context)!;

    if (complete) {
      return Semantics(
        label: loc.pathDetailScreenLessonCompleteIconSemantic, // "Lesson complete"
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: screenWidth * 0.08,
        ),
      );
    } else if (valid) {
      return Semantics(
        label: loc.pathDetailScreenLessonInProgressIconSemantic, // "Lesson in progress"
        child: Icon(
          Icons.hourglass_empty,
          color: Colors.orange,
          size: screenWidth * 0.08,
        ),
      );
    } else {
      return Semantics(
        label: loc.pathDetailScreenLessonInvalidIconSemantic, // "Lesson invalid or unavailable"
        child: Icon(
          Icons.error,
          color: Colors.red,
          size: screenWidth * 0.08,
        ),
      );
    }
  }

  /// A helper for building the subtitle for each Lesson item
  Widget _buildLessonSubtitle(
      Path path,
      Lesson lesson,
      bool userCanViewProgress,
      double screenWidth,
      double screenHeight,
      AppLocalizations loc,
      ) {
    if (!path.tracksProgress) {
      // "No progress for this path"
      return Text(
        loc.pathDetailScreenLessonNoProgress,
        style: const TextStyle(color: Colors.blueGrey),
      );
    } else if (!userCanViewProgress) {
      // "Upgrade to premium for progress!"
      return Text(
        loc.pathDetailScreenLessonUpgrade,
        style: const TextStyle(color: Colors.redAccent),
      );
    } else {
      // e.g. "Progress: 42%"
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.pathDetailScreenLessonProgressLabel(lesson.progress.toString()),
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          ProgressBar(progress: lesson.progress.toDouble()),
        ],
      );
    }
  }

  /// Localize path name if system-defined; otherwise use DB text.
  String _getLocalizedPathName(
      BuildContext context,
      String pathId,
      bool isUserGenerated,
      String pathNameFromDb,
      ) {
    final loc = AppLocalizations.of(context)!;

    if (isUserGenerated) {
      return pathNameFromDb;
    }

    // Add every system path ID from your .arb (commentZ) for name
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
      // If not recognized, return DB text
        return pathNameFromDb;
    }
  }

  /// Localize path description if system-defined; otherwise DB text.
  String _getLocalizedPathDescription(
      BuildContext context,
      String pathId,
      bool isUserGenerated,
      String pathDescFromDb,
      ) {
    final loc = AppLocalizations.of(context)!;

    if (isUserGenerated) {
      return pathDescFromDb;
    }

    // Add every system path ID from your .arb (commentZ) for description
    switch (pathId) {
      case 'path_fatihah':
        return loc.pathDescFatihah;
      case 'path_kafirun':
        return loc.pathDescKafirun;
      case 'path_ikhlas':
        return loc.pathDescIkhlas;
      case 'path_falaq':
        return loc.pathDescFalaq;
      case 'path_nas':
        return loc.pathDescNas;
      case 'path_asr_begin':
        return loc.pathDescAsrBegin;
      case 'path_takathur':
        return loc.pathDescTakathur;
      case 'path_fil':
        return loc.pathDescFil;
      case 'path_quraysh':
        return loc.pathDescQuraysh;
      case 'path_rahman_a':
        return loc.pathDescRahmanA;
      case 'path_rahman_b':
        return loc.pathDescRahmanB;
      case 'path_yasin_block':
        return loc.pathDescYasinBlock;
      case 'path_mulk_block':
        return loc.pathDescMulkBlock;
      case 'path_baqarah_21_29':
        return loc.pathDescBaqarah21_29;
      case 'path_nahl_66_72':
        return loc.pathDescNahl66_72;
      case 'path_ad_duha':
        return loc.pathDescAdDuha;
      case 'path_kahf_cave':
        return loc.pathDescKahfCave;
      case 'path_kahf_musa':
        return loc.pathDescKahfMusa;
      case 'path_waqiah':
        return loc.pathDescWaqiah;
      case 'path_asr_patience':
        return loc.pathDescAsrPatience;
      case 'path_baq_153_157':
        return loc.pathDescBaq153_157;
      case 'path_yusuf_7_14':
        return loc.pathDescYusuf7_14;
      case 'path_yusuf_83_92':
        return loc.pathDescYusuf83_92;
      case 'path_inshirah':
        return loc.pathDescInshirah;
      default:
      // If not recognized, return DB text
        return pathDescFromDb;
    }
  }
}
