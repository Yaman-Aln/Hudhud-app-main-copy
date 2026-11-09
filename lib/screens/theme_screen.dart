import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Services & Providers
import 'package:hudhud_quran_app_new/z_onboarding/models/unique_test_model.dart';
import '../providers/theme_service_provider.dart';
import '../services/theme_service.dart'; // for ThemeAccessLevel, ThemeDataQ
import 'package:hudhud_quran_app_new/z_onboarding/providers/user_profile_provider.dart'; // <-- ADDED
import '../widgets/bottom_nav_bar.dart';
import '../screens/path_list_screen.dart';
import '../providers/ff_logging_service_provider.dart';
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';

// We want to invalidate the path list if partial progress changed
import '../screens/path_list_screen.dart' show asyncThemePathsWithProgressProvider;

// We also want to invalidate the per-path lessons:
import 'path_detail_screen.dart' show asyncLessonsWithProgressProvider;
import '../providers/path_service_provider.dart'; // so we can read all paths for a theme

// NEW: Generated localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Import your SurahSearchScreen
import '../screens/surah_search_screen.dart';

/// Helper function to decide if a theme is locked for the current user tier.
bool isThemeLockedForUser(ThemeAccessLevel level, SubscriptionTier userTier) {
  switch (level) {
    case ThemeAccessLevel.free:
      return false;
    case ThemeAccessLevel.premium:
      return (userTier == SubscriptionTier.free);
    case ThemeAccessLevel.premiumPlus:
      return (userTier == SubscriptionTier.free || userTier == SubscriptionTier.premium);
  }
}

/// Returns a localized name for each theme ID, or uses a special case
/// for the single “User Created” theme name if isUserEditable == true.
String _getLocalizedThemeName(BuildContext context, ThemeDataQ theme) {
  final loc = AppLocalizations.of(context)!;

  // If the theme is user-editable (the special single user-created theme):
  if (theme.isUserEditable) {
    // 1) If the DB name is exactly "User Created", localize it.
    if (theme.name == 'User Created') {
      return loc.themeNameUserCreated;
    } else {
      // 2) If it has been changed to something else, display the custom text.
      return theme.name;
    }
  }

  // Otherwise switch on the known theme IDs to fetch from localizations.
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
    // If the theme ID doesn't match any known system theme, fall back to theme.name.
      return theme.name;
  }
}

/// Returns a localized subtitle for each theme ID, falling back to user-created or default.
String _getLocalizedThemeSubtitle(
    BuildContext context,
    String themeId,
    bool isUserEditable,
    ) {
  final loc = AppLocalizations.of(context)!;

  if (isUserEditable) {
    return loc.themeScreenUserCreatedSubtitle;
  }

  switch (themeId) {
    case 'theme_core_recitation':
      return loc.themeSubtitleCoreRecitation;
    case 'theme_begin_journey':
      return loc.themeSubtitleBeginJourney;
    case 'theme_mercy_and_hope':
      return loc.themeSubtitleMercyAndHope;
    case 'theme_gratitude_reflection':
      return loc.themeSubtitleGratitudeReflection;
    case 'theme_stories_reminders':
      return loc.themeSubtitleStoriesReminders;
    case 'theme_patience':
      return loc.themeSubtitlePatience;
    default:
      return loc.themeSubtitleDefault;
  }
}

class ThemeScreen extends ConsumerStatefulWidget {
  final String pathId;
  final String? themeId;

  const ThemeScreen({
    Key? key,
    required this.pathId,
    this.themeId,
  }) : super(key: key);

  @override
  ConsumerState<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends ConsumerState<ThemeScreen> {
  @override
  void initState() {
    super.initState();
    // Log "theme_screen_viewed"
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('theme_screen_viewed');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final loggingService = ref.read(ffLoggingServiceProvider);
    final analytics = ref.read(analyticsServiceProvider);

    // This provider presumably returns a List<ThemeDataQ>
    final asyncThemes = ref.watch(asyncThemesProvider);
    // Now we get the userTier from userProfile:
    final userTier = ref.watch(userProfileProvider).subscriptionTier;

    // For consistent dynamic font sizing
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // Light blue background (matching PathListScreen)
        backgroundColor: Colors.blue[50],
        centerTitle: true,
        title: Text(
          loc.themeScreenTitle, // "Themes"
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045,
          ),
        ),
        leading: Semantics(
          label: loc.themeScreenBackArrowSemantic, // e.g. "Go back"
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Log "theme_screen_back_pressed"
              analytics.logEvent('theme_screen_back_pressed', parameters: {
                'from_screen': 'theme_screen',
                'to_screen': 'previous',
                'cta_source': 'app_bar_arrow',
              });
              Navigator.of(context).pop();
            },
          ),
        ),
        // ADD THE SEARCH BUTTON HERE
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: loc.themeScreenSearchIconSemantic, // e.g. "Search Surahs"
            onPressed: () {
              // Navigate to SurahSearchScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SurahSearchScreen()),
              );
            },
          ),
        ],
      ),
      body: asyncThemes.when(
        data: (themes) {
          if (themes.isEmpty) {
            return Center(
              child: Text(
                loc.themeScreenNoThemesLabel, // "No Themes Available"
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            );
          }

          // Reorder so user-created themes appear first
          final userCreated = themes.where((t) => t.isUserEditable).toList();
          final system = themes.where((t) => !t.isUserEditable).toList();
          final ordered = [...userCreated, ...system];

          return ListView.separated(
            itemCount: ordered.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final theme = ordered[index];
              final locked = isThemeLockedForUser(theme.accessLevel, userTier);

              // If locked => tinted red, else default card color
              return Card(
                elevation: 2.0,
                color: locked ? Colors.red[50] : null,
                child: Semantics(
                  label: loc.themeScreenThemeCardSemantic, // "Tap to open theme's paths"
                  button: true,
                  child: ListTile(
                    title: Text(
                      _getLocalizedThemeName(context, theme),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    subtitle: _buildSubtitle(context, theme, screenWidth),
                    trailing: locked
                        ? Semantics(
                      label: loc.themeScreenLockIconSemantic,
                      // "Theme locked. Requires upgrade."
                      child: const Icon(Icons.lock, color: Colors.red),
                    )
                        : null,
                    onTap: () async {
                      // 1) Log "theme_clicked"
                      analytics.logEvent('theme_clicked', parameters: {
                        'theme_id': theme.id,
                        'theme_name': theme.name,
                        'theme_location': (index + 1).toString(),
                        'locked': locked.toString(),
                      });

                      // 2) If locked, do nothing or show paywall
                      if (locked) {
                        loggingService.logWarning(
                          '[ThemeScreen] User tapped locked theme: ${theme.id}',
                        );
                        return;
                      }

                      // 3) Navigator reference
                      final nav = Navigator.of(context);

                      // 4) Load or add the theme's paths
                      await ref.read(themeServiceProviderRef).addThemePathsToPathService(theme.id);

                      // 5) Invalidate lessons & paths for partial progress refresh
                      final pathSvc = ref.read(pathServiceProviderRef);
                      final relevantPaths = pathSvc
                          .getAllPaths()
                          .where((p) => p.themeIds.contains(theme.id))
                          .toList();
                      for (final p in relevantPaths) {
                        ref.invalidate(asyncLessonsWithProgressProvider(p.id));
                      }
                      ref.invalidate(asyncThemePathsWithProgressProvider(theme.id));

                      // 6) Navigate to PathListScreen
                      nav.push(
                        MaterialPageRoute(
                          builder: (_) => PathListScreen(themeId: theme.id),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading themes: $err')),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, // e.g. the “Themes” tab
        ref: ref,
        pathId: null,
      ),
    );
  }

  /// Builds the multiline subtitle with dynamic font sizes
  Widget _buildSubtitle(
      BuildContext context,
      ThemeDataQ theme,
      double screenWidth,
      ) {
    final loc = AppLocalizations.of(context)!;
    final lines = <Widget>[];

    // 1) The main descriptive line, now localized
    lines.add(
      Text(
        _getLocalizedThemeSubtitle(context, theme.id, theme.isUserEditable),
        style: TextStyle(
          fontSize: screenWidth * 0.035,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    // 2) If Premium or PremiumPlus, show the note in red
    if (theme.accessLevel == ThemeAccessLevel.premium) {
      lines.add(
        Text(
          loc.themeScreenRequiredPremium, // "Requires Premium"
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.redAccent,
          ),
        ),
      );
    } else if (theme.accessLevel == ThemeAccessLevel.premiumPlus) {
      lines.add(
        Text(
          loc.themeScreenRequiredPremiumPlus, // "Requires Premium Plus"
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.redAccent,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines,
    );
  }
}
