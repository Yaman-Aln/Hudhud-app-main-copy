import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1) Import your generated localization class
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// 2) Analytics provider
import '../providers/analytics_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

// 3) Import your screens
import '../screens/home_screen.dart' as home;
import '../screens/path_list_screen.dart' as path_list;
import '../screens/gratitude_log_screen.dart';
import '../screens/theme_screen.dart'; // Your ThemeScreen
import '../screens/profile_screen.dart'; // "class ProfileScreen extends ..."

/// A bottom navbar with 4 tabs: Home, Quran, Gratitude, Profile
/// Tapping each logs an analytics event & navigates.
class BottomNavBar extends ConsumerWidget {
  final int currentIndex; // The currently "selected" tab index
  final WidgetRef ref;
  final String? pathId;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.ref,
    this.pathId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    // Localized tab names (4 tabs)
    final tabNames = [
      loc.navHomeLabel,
      loc.navQuranLabel,
      loc.navGratitudeLabel,
      loc.navProfileLabel,
    ];

    // If width > 600 => tablet => 72 px, else 60 px (a bit bigger than 56)
    final deviceWidth = MediaQuery.of(context).size.width;
    final double dynamicNavBarHeight = (deviceWidth > 600) ? 170.0 : 140.0;

    return SizedBox(
      // Add 2 px to avoid possible rounding overflow
      height: dynamicNavBarHeight + 2.0,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final barWidth = constraints.maxWidth;
          final barHeight = constraints.maxHeight;
          // If barHeight is actually 0, fallback to 60
          final safeHeight = (barHeight == 0) ? 60.0 : barHeight;

          final possibleIconWidth = barWidth / 4 * 0.85;
          final possibleIconHeight = safeHeight * 0.6;
          final iconSize = (possibleIconHeight < possibleIconWidth)
              ? possibleIconHeight
              : possibleIconWidth;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
                height: 0.0, // Don’t add extra vertical space
              ),
              Semantics(
                // Overall nav bar semantics
                label: loc.navBarSemanticLabel,
                container: true,
                child: BottomNavigationBar(
                  currentIndex: currentIndex,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedFontSize: iconSize * 0.15,
                  unselectedFontSize: iconSize * 0.15,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: Semantics(
                        label: loc.navHomeSemantic,
                        child: Image.asset(
                          'assets/icons/home1.png',
                          width: iconSize,
                          height: iconSize,
                        ),
                      ),
                      label: loc.navHomeLabel,
                    ),
                    BottomNavigationBarItem(
                      icon: Semantics(
                        label: loc.navQuranSemantic,
                        child: Image.asset(
                          'assets/icons/quran.png',
                          width: iconSize,
                          height: iconSize,
                        ),
                      ),
                      label: loc.navQuranLabel,
                    ),
                    BottomNavigationBarItem(
                      icon: Semantics(
                        label: loc.navGratitudeSemantic,
                        child: Image.asset(
                          'assets/icons/grateful_open.png',
                          width: iconSize,
                          height: iconSize,
                        ),
                      ),
                      label: loc.navGratitudeLabel,
                    ),
                    BottomNavigationBarItem(
                      icon: Semantics(
                        label: loc.navProfileSemantic,
                        child: Image.asset(
                          'assets/icons/profile2.png',
                          width: iconSize,
                          height: iconSize,
                        ),
                      ),
                      label: loc.navProfileLabel,
                    ),
                  ],
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    final analytics = ref.read(analyticsServiceProvider);
                    analytics.logEvent(
                      'bottom_nav_tapped',
                      parameters: {
                        'from_screen': tabNames[currentIndex],
                        'to_screen': tabNames[index],
                      },
                    );
                    analytics.setUserProperty(
                      'last_active_screen',
                      tabNames[index],
                    );

                    final sameTab = (index == currentIndex);

                    switch (index) {
                      case 0: // Home
                      // Always pop to a fresh HomeScreen
                        ref.invalidate(home.asyncActivePathProvider);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const home.HomeScreen(),
                          ),
                              (route) => false,
                        );
                        break;

                      case 1: // Quran => forcibly go to ThemeScreen
                        if (!sameTab) {
                          // We are switching tabs from something else to "Quran"
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ThemeScreen(
                                pathId: pathId ?? '',
                                themeId: null,
                              ),
                              settings: const RouteSettings(name: 'ThemeScreen'),
                            ),
                          );
                        } else {
                          // Already in the "Quran" tab, possibly in a deeper route
                          bool foundThemeScreen = false;
                          Navigator.of(context).popUntil((route) {
                            if (route.settings.name == 'ThemeScreen') {
                              foundThemeScreen = true;
                            }
                            return foundThemeScreen || route.isFirst;
                          });

                          if (!foundThemeScreen) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ThemeScreen(
                                  pathId: pathId ?? '',
                                  themeId: null,
                                ),
                                settings: const RouteSettings(
                                  name: 'ThemeScreen',
                                ),
                              ),
                            );
                          }
                        }
                        break;

                      case 2: // Gratitudes
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const GratitudeLogScreen(),
                          ),
                        );
                        break;

                      case 3: // Profile
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                        break;
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
