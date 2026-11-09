import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models & Providers
import '../models/path_model.dart';
import 'package:hudhud_quran_app_new/z_onboarding/models/unique_test_model.dart';
import 'package:hudhud_quran_app_new/z_onboarding/providers/user_profile_provider.dart'; // <-- ADDED
import '../providers/path_service_provider.dart';      // For pathService
import '../providers/progress_service_provider.dart';  // For progressService
import '../services/theme_service.dart';               // For ThemeService
import '../providers/theme_service_provider.dart';     // For theme-related providers
import '../providers/ff_logging_service_provider.dart';
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// Screens & Widgets
import '../screens/home_screen.dart' as home;
import 'create_path_screen.dart';
import 'path_detail_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/progress_bar.dart';

// NEW: Generated localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// NEW: We import ThemeScreen so that our new button can link to it
import 'theme_screen.dart'; // <-- ADDED to link "Go to Theme Screen" on click.
// ADDED: SurahSearchScreen import
import 'surah_search_screen.dart'; // For the magnifying-glass search icon

/// A small data class to hold a [Path] plus its [progress] and [isValid].
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

/// A tiny helper function: can user see progress?
/// - Free => false, Premium/PremiumPlus => true
bool canViewProgress(SubscriptionTier userTier) {
  switch (userTier) {
    case SubscriptionTier.free:
      return false;
    case SubscriptionTier.premium:
    case SubscriptionTier.premiumPlus:
      return true;
  }
}

/// A Riverpod FutureProvider.family that loads only the paths for a specific
/// themeId (or all if themeId == null) and retrieves each path’s existing
/// progress (from Hive) without re-summing.
final asyncThemePathsWithProgressProvider =
FutureProvider.family<List<PathWithProgress>, String?>((ref, themeId) async {
  final pathService = ref.read(pathServiceProviderRef);
  final progressService = ref.read(progressServiceProvider);
  final loggingService = ref.read(ffLoggingServiceProvider);

  // 1) Load all from memory or filter by themeId if given
  final allPaths = pathService.getAllPaths();

  // 2) Filter by themeId if provided
  final relevantPaths = (themeId == null)
      ? allPaths
      : allPaths.where((p) => p.themeIds.contains(themeId)).toList();

  // Early out if none
  if (relevantPaths.isEmpty) {
    loggingService.logWarning(
      '[PathListScreen] No relevant paths for theme=$themeId.',
    );
    return [];
  }

  // 3) For each relevant path, check validity & retrieve existing path progress
  final List<PathWithProgress> results = [];
  for (final p in relevantPaths) {
    try {
      final valid = await pathService.isValidPath(p.id);

      double prog = 0.0;
      if (valid && p.tracksProgress) {
        // Just read the "static" path progress from Hive:
        prog = await progressService.getPathProgress(p.id);
      }

      results.add(PathWithProgress(path: p, progress: prog, isValid: valid));
      loggingService.logInfo('Loaded path=${p.id}, progress=$prog');
    } catch (e) {
      loggingService.logError('Error loading pathId=${p.id} => $e');
      results.add(PathWithProgress(path: p, progress: -1, isValid: false));
    }
  }

  return results;
});

/// Returns a localized name for the theme, similar to how theme_screen.dart does it.
String _getLocalizedThemeName(BuildContext context, ThemeDataQ theme) {
  final loc = AppLocalizations.of(context)!;

  // If the theme is user-editable, it’s presumably a custom theme => use DB name
  if (theme.isUserEditable) {
    return theme.name;
  }

  // Otherwise, switch on known theme IDs to localize the name
  switch (theme.id) {
    case 'theme_core_recitation':
      return loc.themeNameCoreRecitation;
    case 'theme_begin_journey':
      return loc.themeNameBeginJourney;
    case 'theme_mercy_and_hope':
      return loc.themeNameMercyAndHope;
    case 'theme_gratitude_reflection':
      return loc.themeNameGratitudeReflection;
    case 'theme_stories_reminders':
      return loc.themeNameStoriesReminders;
    case 'theme_patience':
      return loc.themeNamePatience;
    default:
    // Fallback to DB name if not recognized
      return theme.name;
  }
}

/// A screen that shows:
///  - If [themeId] != null, only the paths for that theme.
///  - Else all paths in the system.
/// Displays each path's name, validity, progress, and allows creation of new paths.
class PathListScreen extends ConsumerStatefulWidget {
  final String? themeId;

  const PathListScreen({Key? key, this.themeId}) : super(key: key);

  @override
  ConsumerState<PathListScreen> createState() => _PathListScreenState();
}

class _PathListScreenState extends ConsumerState<PathListScreen> {
  @override
  void initState() {
    super.initState();
    // 1) Log "path_list_screen_viewed"
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('path_list_screen_viewed');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // localizations
    final loggingService = ref.read(ffLoggingServiceProvider);
    final analytics = ref.read(analyticsServiceProvider);

    // Watch theme-specific paths
    final asyncThemePaths =
    ref.watch(asyncThemePathsWithProgressProvider(widget.themeId));

    // Watch the subscription tier from userProfile
    final userTier = ref.watch(userProfileProvider).subscriptionTier;

    // If [themeId] is provided, attempt to retrieve that theme's data
    String? themeDisplayName;
    if (widget.themeId != null) {
      final themeSvc = ref.read(themeServiceProviderRef);
      final foundTheme = themeSvc.getThemeById(widget.themeId!);

      // Instead of just foundTheme?.name, we do a localized fetch:
      if (foundTheme != null) {
        themeDisplayName = _getLocalizedThemeName(context, foundTheme);
      }
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        centerTitle: true,
        leading: Semantics(
          label: loc.pathListScreenBackArrowSemantic, // "Go back"
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Log "path_list_screen_back_pressed"
              analytics.logEvent('path_list_screen_back_pressed', parameters: {
                'from_screen': 'path_list_screen',
                'to_screen': 'previous',
                'cta_source': 'app_bar_arrow',
              });

              // Invalidate the provider for this themeId
              ref.invalidate(
                asyncThemePathsWithProgressProvider(widget.themeId),
              );
              ref.invalidate(home.asyncActivePathProvider);

              loggingService.logInfo('[PathListScreen] Back pressed');
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          loc.pathListScreenTitle, // e.g. "Paths for Theme"
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045,
          ),
        ),
        // <<----------- UPDATED ACTIONS WITH SEARCH + PLUS --------------->>
        actions: [
          // Magnifying-glass icon on the LEFT
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: loc.pathListSearchIconSemantic, // e.g. "Search Surahs"
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SurahSearchScreen()),
              );
            },
          ),
          // The existing plus icon on the RIGHT
          Semantics(
            label: loc.pathListScreenAddIconSemantic, // "Add new path"
            button: true,
            child: IconButton(
              icon: const Icon(Icons.add),
              tooltip: loc.pathListAddNewPathTooltip, // "Add New Path"
              onPressed: () async {
                // Log "path_list_screen_create_pressed"
                analytics.logEvent(
                  'path_list_screen_create_pressed',
                  parameters: {
                    'from_screen': 'path_list_screen',
                    'cta_source': 'icon_add',
                  },
                );

                loggingService.logInfo('[PathListScreen] Add path pressed');

                final nav = Navigator.of(context);
                await nav.push(
                  MaterialPageRoute(builder: (_) => const CreatePathScreen()),
                );

                // Re-invalidate only this theme's paths
                ref.invalidate(
                  asyncThemePathsWithProgressProvider(widget.themeId),
                );
                ref.invalidate(home.asyncActivePathProvider);
              },
            ),
          ),
        ],
      ),
      body: asyncThemePaths.when(
        data: (pathsWithProgress) {
          if (pathsWithProgress.isEmpty) {
            return _buildEmptyScreen(
              context,
              ref,
              screenWidth,
              screenHeight,
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.themeId != null && themeDisplayName != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Text(
                    '"$themeDisplayName" ${loc.pathListThemeLabel}',
                    // e.g.  "Beginning the Journey Theme"
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
              Expanded(
                child: ListView.separated(
                  itemCount: pathsWithProgress.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final pwp = pathsWithProgress[index];
                    final path = pwp.path;
                    final valid = pwp.isValid;
                    final pathProgress = pwp.progress;
                    final isComplete = pathProgress >= 100;

                    // If valid => default color, else => tinted red
                    return Card(
                      elevation: 2.0,
                      color: valid ? null : Colors.red[50],
                      child: Semantics(
                        label: loc.pathListPathCardSemantic, // "Tap to open path details"
                        button: true,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: _buildLeadingIcon(
                            context,
                            isComplete: isComplete,
                            valid: valid,
                            screenWidth: screenWidth,
                          ),
                          title: Text(
                            _getLocalizedPathName(
                              context,
                              path.id,
                              path.isUserGenerated,
                              path.name,
                            ),
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: _buildSubtitle(
                            ref,
                            path,
                            valid,
                            pathProgress,
                            userTier,
                            screenWidth,
                            screenHeight,
                          ),
                          trailing: Semantics(
                            label: loc.arrowForwardSemanticLabel, // "Open details"
                            button: true,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: screenWidth * 0.05,
                              color: Colors.grey[400],
                            ),
                          ),
                          onTap: () async {
                            // Capture the navigator before awaiting
                            final nav = Navigator.of(context);

                            // Log "path_list_screen_path_clicked"
                            analytics.logEvent(
                              'path_list_screen_path_clicked',
                              parameters: {
                                'path_id': path.id,
                                'path_name': path.name,
                                'location': (index + 1).toString(),
                                'valid': valid.toString(),
                                'is_user_generated': path.isUserGenerated.toString(),
                                'lesson_count': path.lessons.length.toString(),
                                'surah_ids': path.lessons
                                    .map((l) => l.surahId)
                                    .toSet()
                                    .toList()
                                    .toString(),
                              },
                            );

                            if (!valid) {
                              loggingService.logInfo(
                                '[PathListScreen] tapped invalid pathId=${path.id}',
                              );
                              return;
                            }
                            loggingService.logInfo(
                              '[PathListScreen] tapped pathId=${path.id}',
                            );

                            // If it’s a system path with no lessons, generate them
                            if (!path.isUserGenerated && path.lessons.isEmpty) {
                              final themeSvc = ref.read(themeServiceProviderRef);
                              await themeSvc.generateLessonsForSystemPath(path);
                            }

                            // Navigate to details
                            final refreshNeeded = await nav.push<bool>(
                              MaterialPageRoute(
                                builder: (_) => PathDetailScreen(pathId: path.id),
                              ),
                            );

                            // If the detail screen indicates progress changed:
                            if (refreshNeeded == true) {
                              ref.invalidate(
                                asyncThemePathsWithProgressProvider(widget.themeId),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              // ADDITION: A "Go to Theme Screen" button at the bottom
              const SizedBox(height: 12),
              Center(
                child: _buildGoToThemeScreenButton(),
              ),
              const SizedBox(height: 12),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('${loc.pathListErrorLoadingPaths} $err'),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, // e.g. the “Paths” tab
        ref: ref,
        pathId: null,
      ),
    );
  }

  /// Builds a big "Add new path" screen if no paths exist
  Widget _buildEmptyScreen(
      BuildContext context,
      WidgetRef ref,
      double screenWidth,
      double screenHeight,
      ) {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Semantics(
            label: loc.pathListScreenAddIconSemanticEmpty, // "Tap to add your first path"
            button: true,
            child: IconButton(
              icon: const Icon(
                Icons.add_circle,
                color: Colors.blueGrey,
                size: 72,
              ),
              onPressed: () async {
                // Log "path_list_screen_create_pressed"
                analytics.logEvent('path_list_screen_create_pressed',
                    parameters: {
                      'from_screen': 'path_list_screen',
                      'cta_source': 'icon_add_circle_empty',
                    });

                final nav = Navigator.of(context);
                await nav.push(
                  MaterialPageRoute(builder: (_) => const CreatePathScreen()),
                );
                ref.invalidate(
                  asyncThemePathsWithProgressProvider(widget.themeId),
                );
                ref.invalidate(home.asyncActivePathProvider);
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            loc.pathListEmptyMessage, // e.g. "No paths yet...\nTap the “+”..."
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Leading icon on each list tile
  Widget _buildLeadingIcon(
      BuildContext context, {
        required bool isComplete,
        required bool valid,
        required double screenWidth,
      }) {
    final loc = AppLocalizations.of(context)!;

    // If complete => check icon
    if (isComplete) {
      return Semantics(
        label: loc.pathListCompleteIconSemantic, // "Path complete"
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: screenWidth * 0.08,
        ),
      );
    }

    // If valid => hourglass
    if (valid) {
      return Semantics(
        label: loc.pathListInProgressIconSemantic, // "Path in progress"
        child: Icon(
          Icons.hourglass_empty,
          color: Colors.orange,
          size: screenWidth * 0.08,
        ),
      );
    }

    // else => error
    return Semantics(
      label: loc.pathListInvalidIconSemantic, // "Path invalid or unavailable"
      child: Icon(
        Icons.error,
        color: Colors.red,
        size: screenWidth * 0.08,
      ),
    );
  }

  /// Subtitle for each path tile: either an italic description, then progress or disclaimers
  Widget _buildSubtitle(
      WidgetRef ref,
      Path path,
      bool valid,
      double pathProgress,
      SubscriptionTier userTier,
      double screenWidth,
      double screenHeight,
      ) {
    final loc = AppLocalizations.of(ref.context)!;

    // If path is invalid
    if (!valid) {
      return Text(
        loc.pathListUnavailableLabel, // "This path is currently unavailable"
        style: const TextStyle(color: Colors.red),
      );
    }

    final lines = <Widget>[];

    // Possibly localize description if system path
    final localizedDesc = _getLocalizedPathDescription(
      ref.context,
      path.id,
      path.isUserGenerated,
      path.description,
    );
    if (localizedDesc.isNotEmpty) {
      lines.add(
        Text(
          localizedDesc,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: screenWidth * 0.035,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    // If no progress tracking
    if (!path.tracksProgress) {
      lines.add(
        Text(
          loc.noTrackProgressLabel, // "This path does not track progress."
          style: const TextStyle(color: Colors.blueGrey),
        ),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines,
      );
    }

    // If user can't view => disclaim
    if (!canViewProgress(userTier)) {
      lines.add(
        Text(
          loc.premiumRequiredLabel, // e.g. "Progress requires premium"
          style: const TextStyle(color: Colors.redAccent),
        ),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines,
      );
    }

    // Otherwise => show progress bar
    final completedString =
        '${pathProgress.toStringAsFixed(1)}% ${loc.completedLabel}';

    lines.add(
      Text(
        completedString,
        style: TextStyle(
          fontSize: screenWidth * 0.035,
          color: Colors.grey[700],
        ),
      ),
    );
    lines.add(SizedBox(height: screenHeight * 0.005));
    lines.add(ProgressBar(progress: pathProgress));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines,
    );
  }

  /// Localize path name if system-defined; else DB text
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
        return pathNameFromDb;
    }
  }

  /// Localize path description if system-defined; else DB text
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
        return pathDescFromDb;
    }
  }

  // ----------------------
  // ADDED: "Go to Theme Screen" button
  // ----------------------
  Widget _buildGoToThemeScreenButton() {
    final loc = AppLocalizations.of(context)!;
    // Style: same as "Go to Theme" in vertical icons
    final double buttonWidth = 180;
    final double buttonHeight = 48;

    return Semantics(
      // Use the localized string for the semantic label
      label: loc.pathListExploreOtherThemes,
      button: true,
      child: Material(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: InkWell(
          onTap: _handleGoToThemeScreenTap,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: Center(
              child: Text(
                // Also localized text for the button label
                loc.pathListExploreOtherThemes,
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Avoid using [context] after an async gap by capturing Navigator, etc.
  void _handleGoToThemeScreenTap() async {
    // 1) Capture the Navigator first, so we don't use BuildContext after awaiting
    final nav = Navigator.of(context);

    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent(
      'path_list_go_to_theme_screen_clicked',
      parameters: {
        'theme_id': widget.themeId ?? 'unknown',
      },
    );

    // 2) If a themeId was provided, do an immediate lazy load
    if (widget.themeId != null) {
      final themeSvc = ref.read(themeServiceProviderRef);
      await themeSvc.addThemePathsToPathService(widget.themeId!);
    }

    // 3) Find at least one path that corresponds to this themeId (if any)
    final pathService = ref.read(pathServiceProviderRef);
    final relevantPaths = (widget.themeId == null)
        ? pathService.getAllPaths()
        : pathService
        .getAllPaths()
        .where((p) => p.themeIds.contains(widget.themeId))
        .toList();

    final pathIdToUse = relevantPaths.isNotEmpty
        ? relevantPaths.first.id
        : 'placeholder_path';

    // 4) Navigate using the captured Navigator
    nav.push(
      MaterialPageRoute(
        builder: (_) => ThemeScreen(
          pathId: pathIdToUse,
          themeId: widget.themeId,
        ),
      ),
    );
  }
}
