// lib/widgets/vertical_lesson_icons.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Analytics & Logging
import '../providers/analytics_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

// Models & Providers
import '../models/lesson_model.dart';
import '../services/quran_service.dart';
import '../providers/progress_service_provider.dart';

// Localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// For navigation to your PathListScreen (replace with your actual import)
import '../screens/path_list_screen.dart';

// Also import the PathService provider reference to initialize the path if needed:
import '../providers/path_service_provider.dart';

// Possibly reusing PathLessonsScreen or any other Surah-level screen you want
import '../screens/path_lessons_screen.dart'; // if you want to show the entire surah range

// NEW: For the gratitude FAB
import '../widgets/gratitude_modal.dart';
import '../widgets/submission_feedback_modal.dart';

// (NEW) Import your SubscriptionTierScreen to push when user taps Explore Plans
import '../z_onboarding/screens/subscription_tier_screen.dart';
import '../screens/home_screen.dart';

/// Displays lessons in pages of 5 icons each, arranged in a left-side vertical arc,
/// bulging outward to the left.
/// - Last icon on last page is a bigger “well” icon.
/// - A “Hudhud” icon near the first lesson on the current page (tap => "Support & Upgrade"),
///   plus a **“Surah View”** button right beneath it (same style as “Go to Theme”).
/// - Up/Down arrows for pagination
/// - Semantics & long-press snack for surah & ayah
/// - Auto-shrink icons if the screen is small
/// - “Go to Theme” button at bottom-left on every page
class VerticalLessonIcons extends ConsumerStatefulWidget {
  final List<Lesson> lessons;
  final Function(Lesson) onLessonTap;
  final double pathProgress;
  final String activePathId;

  /// ID of the theme to which this path belongs (optional).
  final String? themeId;

  /// 5 icons per “page.” If user has more than 5 lessons, we paginate.
  static const int lessonsPerPage = 5;

  const VerticalLessonIcons({
    Key? key,
    required this.lessons,
    required this.onLessonTap,
    required this.pathProgress,
    required this.activePathId,
    this.themeId,
  }) : super(key: key);

  @override
  VerticalLessonIconsState createState() => VerticalLessonIconsState();
}

class VerticalLessonIconsState extends ConsumerState<VerticalLessonIcons> {
  int currentPage = 0;

  // For demonstration, identical icons for “reward” lessons:
  final List<String> lessonIcons = [
    'assets/icons/reward.png',
    'assets/icons/reward.png',
    'assets/icons/reward.png',
    'assets/icons/reward.png',
    'assets/icons/reward.png',
  ];

  /// Convenient getter for the QuranService
  QuranService get quranService => ref.read(quranServiceProvider);

  @override
  void initState() {
    super.initState();
    // Optionally ensure this path is in memory & has lessons:
    final pathService = ref.read(pathServiceProviderRef);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await pathService.isValidPath(widget.activePathId);
      // Additional logic if needed...
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final totalLessons = widget.lessons.length;

    // If no lessons exist
    if (totalLessons == 0) {
      return Center(
        child: Text(
          loc.verticalLessonIconsNoLessons, // "No lessons found."
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.red,
          ),
        ),
      );
    }

    // 1) Calculate total pages
    final pageCount = (totalLessons / VerticalLessonIcons.lessonsPerPage).ceil();

    // 2) Clamp currentPage
    if (currentPage < 0) currentPage = 0;
    if (currentPage > pageCount - 1) currentPage = pageCount - 1;

    // 3) Slice lessons for this page
    final startIndex = currentPage * VerticalLessonIcons.lessonsPerPage;
    final endIndex = min(
      startIndex + VerticalLessonIcons.lessonsPerPage,
      totalLessons,
    );
    final currentPageLessons = widget.lessons.sublist(startIndex, endIndex);

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // Desired base icon size
        final desiredBaseIconSize = screenWidth * 0.15;
        final wellScale = 1.25; // bigger scale for “well” icon

        // Scale the arrows proportionally
        final minDim = min(screenWidth, screenHeight);
        final arrowIconSize = minDim * 0.07;

        // Always base scale factor on 5 items
        final sizingCount = VerticalLessonIcons.lessonsPerPage;
        double totalRequired = (desiredBaseIconSize * sizingCount) +
            (desiredBaseIconSize * 0.3 * (sizingCount + 1));

        double scaleFactor = 1.0;
        if (totalRequired > screenHeight && screenHeight > 0) {
          scaleFactor = screenHeight / totalRequired;
        }

        final itemCountOnPage = currentPageLessons.length;

        return Semantics(
          label: loc.verticalLessonIconsSemantic, // "Vertical Lesson Icons Container"
          child: Stack(
            alignment: Alignment.center,
            children: [
              // A) Surah header near top (only on first page)
              if (currentPage == 0 && currentPageLessons.isNotEmpty)
                Positioned(
                  top: screenHeight * 0.08,
                  child: FutureBuilder<String>(
                    future: _getSurahHeaderText(widget.lessons),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Semantics(
                          label: loc.verticalLessonIconsLoadingSurah,
                          child: const CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text(
                          loc.verticalLessonIconsErrorSurah,
                          style: const TextStyle(color: Colors.red),
                          semanticsLabel: loc.verticalLessonIconsErrorSurah,
                        );
                      }
                      final details = snapshot.data ?? '';
                      if (details.isEmpty) return const SizedBox.shrink();

                      return Semantics(
                        label: loc.verticalLessonIconsSurahHeaderSemantic,
                        child: Text(
                          details, // e.g. "Surah Al-Kafiroun, Ayah 1-6"
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04 * scaleFactor,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Amiri',
                          ),
                        ),
                      );
                    },
                  ),
                ),

              // B) The vertical arc of lesson icons
              for (int i = 0; i < currentPageLessons.length; i++)
                _buildLessonIconPositioned(
                  constraints: constraints,
                  lesson: currentPageLessons[i],
                  idxOnPage: i,
                  itemCountOnPage: itemCountOnPage,
                  baseIconSize: desiredBaseIconSize,
                  wellScale: wellScale,
                  scaleFactor: scaleFactor,
                  pageCount: pageCount,
                  globalLessonIndex: startIndex + i,
                ),

              // C) “Hudhud” icon near the first icon, plus "Surah View" button below it
              if (currentPageLessons.isNotEmpty)
                Builder(
                  builder: (context) {
                    final firstPos = _calculateLeftOutwardArcPosition(
                      indexOnPage: 0,
                      itemCountOnPage: currentPageLessons.length,
                      constraints: constraints,
                      baseIconSize: desiredBaseIconSize,
                      wellScale: wellScale,
                      scaleFactor: scaleFactor,
                      isLastPage: (currentPage == pageCount - 1),
                    );

                    final scaledBaseIconSize = desiredBaseIconSize * scaleFactor;
                    final hudhudIconSize = scaledBaseIconSize * 2.0;

                    // Shift the Hudhud icon so it's near the first lesson icon
                    final hudhudX = firstPos.dx + (scaledBaseIconSize * 1);
                    final hudhudY = firstPos.dy - (scaledBaseIconSize * 0.25);

                    return Stack(
                      children: [
                        // 1) The Hudhud icon
                        Positioned(
                          left: hudhudX,
                          top: hudhudY,
                          child: GestureDetector(
                            onTap: () {
                              final analytics = ref.read(analyticsServiceProvider);
                              analytics.logEvent(
                                  'vertical_lesson_icons_hudhud_left_clicked');
                              _showHudhudUpgradeDialog(context);
                            },
                            child: Semantics(
                              label: loc.verticalLessonIconsHudhudIconSemantic,
                              child: Image.asset(
                                'assets/icons/hudhud_left.png',
                                filterQuality: FilterQuality.high,
                                width: hudhudIconSize,
                                height: hudhudIconSize,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        // 2) "Surah View" button with same style as "Go to Theme," directly below
                        Positioned(
                          left: hudhudX,
                          top: hudhudY + hudhudIconSize + 8, // ~8 px below
                          child: _buildSurahViewButton(context),
                        ),
                      ],
                    );
                  },
                ),

              // D) Arrow down if multi pages & not on last
              if (pageCount > 1 && currentPage < pageCount - 1)
                Positioned(
                  bottom: screenHeight * 0.05,
                  child: Semantics(
                    label: loc.verticalLessonIconsNextPageSemantic,
                    button: true,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: arrowIconSize * 1.5 * scaleFactor,
                      onPressed: () {
                        final analytics = ref.read(analyticsServiceProvider);
                        analytics.logEvent(
                          'page_arrow_down_clicked',
                          parameters: {
                            'from_page': currentPage + 1,
                            'to_page': currentPage + 2,
                          },
                        );
                        setState(() => currentPage++);
                      },
                    ),
                  ),
                ),

              // E) Arrow up if multi pages & not on first
              if (pageCount > 1 && currentPage > 0)
                Positioned(
                  top: screenHeight * 0.08,
                  left: ((screenWidth - arrowIconSize * scaleFactor) / 2)
                      - (arrowIconSize * 0.2 * scaleFactor),
                  child: Semantics(
                    label: loc.verticalLessonIconsPreviousPageSemantic,
                    button: true,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      iconSize: arrowIconSize * 1.5 * scaleFactor,
                      onPressed: () {
                        final analytics = ref.read(analyticsServiceProvider);
                        analytics.logEvent(
                          'page_arrow_up_clicked',
                          parameters: {
                            'from_page': currentPage + 1,
                            'to_page': currentPage,
                          },
                        );
                        setState(() => currentPage--);
                      },
                    ),
                  ),
                ),

              // F) “Go to Theme” button => bottom-left
              Positioned(
                bottom: screenHeight * 0.05,
                left: screenWidth * 0.025,
                child: _buildGoToPathListButton(context),
              ),

              // G) Gratitude FAB => bottom-right
              Positioned(
                bottom: screenHeight * 0.05,
                right: screenWidth * 0.025,
                child: _buildFloatingActionButton(
                  context,
                  ref,
                  ref.read(ffLoggingServiceProvider),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// “Surah View” button with the **same** styling as "Go to Theme"—white background,
  /// orange text, bold, plus the same scaling logic for width & height.
  Widget _buildSurahViewButton(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final shortSide = min(screenWidth, screenHeight);

    double scaleFactorBtn = shortSide / 420.0;
    scaleFactorBtn = scaleFactorBtn.clamp(1.0, 1.4);

    final double buttonWidth = 140 * scaleFactorBtn;
    final double buttonHeight = 48 * scaleFactorBtn;

    return Semantics(
      label: loc.goToSurahViewLabel, // e.g. "Surah View"
      button: true,
      child: Material(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: InkWell(
          onTap: () => _onSurahViewClicked(context),
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: Center(
              child: Text(
                loc.goToSurahViewLabel, // "Surah View"
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

  /// When user taps "Surah View," we navigate to a PathLessonsScreen (or any other)
  /// with the entire path’s min start & max end. The logic is similar to LessonScreen's approach.
  Future<void> _onSurahViewClicked(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;
    final analytics = ref.read(analyticsServiceProvider);

    analytics.logEvent('vertical_lesson_icons_surah_view_clicked', parameters: {
      'active_path_id': widget.activePathId,
      'lesson_count': widget.lessons.length,
    });

    final pathService = ref.read(pathServiceProviderRef);
    final activePath = pathService.getPathById(widget.activePathId);
    if (activePath == null || activePath.lessons.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.verticalLessonIconsNoLessons)),
      );
      return;
    }

    // Merge all lessons => find earliest start & latest end. Assume same surah.
    final firstLesson = activePath.lessons.first;
    final mergedSurahId = firstLesson.surahId;
    int minStart = activePath.lessons
        .map((l) => l.startAyah)
        .reduce((a, b) => a < b ? a : b);
    int maxEnd = activePath.lessons
        .map((l) => l.endAyah)
        .reduce((a, b) => a > b ? a : b);

    // Surah name from quranService
    final mergedSurahName = quranService.getSurahNamePreferred(mergedSurahId);

    // Push PathLessonsScreen or your surah-level screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PathLessonsScreen(
          surahId: mergedSurahId,
          surahName: mergedSurahName,
          startAyah: minStart,
          endAyah: maxEnd,
          lessonId: firstLesson.id,
          pathId: widget.activePathId,
        ),
      ),
    );
  }

  /// Build one lesson icon plus progress overlay
  Widget _buildLessonIconPositioned({
    required BoxConstraints constraints,
    required Lesson lesson,
    required int idxOnPage,
    required int itemCountOnPage,
    required double baseIconSize,
    required double wellScale,
    required double scaleFactor,
    required int pageCount,
    required int globalLessonIndex,
  }) {
    final loc = AppLocalizations.of(context)!;
    final isLastPage = (currentPage == pageCount - 1);
    final isLastOnThisPage = (idxOnPage == itemCountOnPage - 1) && isLastPage;

    return FutureBuilder<Map<String, dynamic>>(
      future: ref
          .read(progressServiceProvider)
          .getLessonProgress(lesson.id, pathId: widget.activePathId),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Positioned(
            left: 0,
            top: 0,
            child: Semantics(
              label: loc.verticalLessonIconsLoadingProgress,
              child: const CircularProgressIndicator(),
            ),
          );
        }
        if (snap.hasError) {
          return Positioned(
            left: 0,
            top: 0,
            child: Text(
              loc.verticalLessonIconsErrorProgress,
              semanticsLabel: loc.verticalLessonIconsErrorProgress,
            ),
          );
        }

        final progress = snap.data?['progress'] ?? 0;

        final rawIconSize =
        isLastOnThisPage ? baseIconSize * wellScale : baseIconSize;
        final finalIconSize = rawIconSize * scaleFactor;

        final offset = _calculateLeftOutwardArcPosition(
          indexOnPage: idxOnPage,
          itemCountOnPage: itemCountOnPage,
          constraints: constraints,
          baseIconSize: baseIconSize,
          wellScale: wellScale,
          scaleFactor: scaleFactor,
          isLastPage: isLastPage,
        );

        // Decide which icon to show
        String iconPath;
        if (isLastOnThisPage) {
          iconPath = 'assets/icons/well3.png';
        } else if (idxOnPage < lessonIcons.length) {
          iconPath = lessonIcons[idxOnPage];
        } else {
          iconPath = 'assets/icons/reward.png';
        }

        // Surah name & range:
        final surahName = quranService.getSurahNamePreferred(lesson.surahId);
        final surahAyahRange = loc.verticalLessonIconsSurahAyahFormat(
          surahName,
          lesson.startAyah.toString(),
          lesson.endAyah.toString(),
        );

        // This is our global 1-based icon number, e.g. 1..n across pages
        final starNumber = globalLessonIndex + 1;
        final iconSemanticLabel = loc.verticalLessonIconSemantic(
          surahAyahRange,
          progress.toString(),
        );

        return Positioned(
          left: offset.dx,
          top: offset.dy,
          child: Semantics(
            label: iconSemanticLabel,
            button: true,
            child: GestureDetector(
              onTap: () {
                final analytics = ref.read(analyticsServiceProvider);
                analytics.logEvent(
                  'lesson_icon_tapped',
                  parameters: {
                    'star_number': starNumber,
                    'page_index': currentPage + 1,
                    'surah_id': lesson.surahId,
                    'start_ayah': lesson.startAyah,
                    'end_ayah': lesson.endAyah,
                    'progress_percent': progress,
                  },
                );
                widget.onLessonTap(lesson);
              },
              onLongPress: () {
                final analytics = ref.read(analyticsServiceProvider);
                analytics.logEvent(
                  'lesson_icon_long_pressed',
                  parameters: {
                    'star_number': starNumber,
                    'page_index': currentPage + 1,
                    'surah_id': lesson.surahId,
                    'start_ayah': lesson.startAyah,
                    'end_ayah': lesson.endAyah,
                  },
                );
                // Show "Surah X, Ayah Y-Z" in a snackbar
                ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(
                    content: Text(
                      surahAyahRange,
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // The numeric label, offset further up-left
                  Positioned(
                    left: -finalIconSize * 0.45,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      color: Colors.white70,
                      child: Text(
                        starNumber.toString(),
                        style: TextStyle(
                          fontSize: finalIconSize * 0.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    iconPath,
                    width: finalIconSize,
                    height: finalIconSize,
                  ),
                  if (progress < 100)
                    ClipOval(
                      child: Container(
                        width: finalIconSize * 0.55,
                        height: finalIconSize * 0.45,
                        color: Colors.grey.withAlpha(128),
                      ),
                    ),
                  if (progress == 100)
                    Semantics(
                      label: loc.verticalLessonIconsCompletedSemantic,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: finalIconSize * 0.5,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Positions items in a vertical arc from top to bottom, **bulging to the left**.
  ///
  /// Angles range from -π/2 (top) to +π/2 (bottom)
  Offset _calculateLeftOutwardArcPosition({
    required int indexOnPage,
    required int itemCountOnPage,
    required BoxConstraints constraints,
    required double baseIconSize,
    required double wellScale,
    required double scaleFactor,
    required bool isLastPage,
  }) {
    final containerWidth = constraints.maxWidth;
    final containerHeight = constraints.maxHeight;

    // For demonstration, pick a fraction that works for phone & tablet
    final centerX = containerWidth * 0.70;
    final radius = containerHeight * 0.30;
    final centerY = containerHeight / 2;

    // spread angles from -π/2 to +π/2
    final angleStep = pi / (itemCountOnPage + 1);
    final startAngle = -pi / 2;
    final angle = startAngle + angleStep * (indexOnPage + 1);

    // Determine icon size
    final isLastOnThisPage = (indexOnPage == itemCountOnPage - 1) && isLastPage;
    final iconHeight = isLastOnThisPage
        ? (baseIconSize * wellScale * scaleFactor)
        : (baseIconSize * scaleFactor);

    final x = centerX - radius * cos(angle) - (iconHeight / 2);
    final y = centerY + radius * sin(angle) - (iconHeight / 2);

    return Offset(x, y);
  }

  /// Surah header => e.g. "Surah Al-Kafiroun, Ayah 1–6"
  Future<String> _getSurahHeaderText(List<Lesson> allLessons) async {
    if (allLessons.isEmpty) return '';

    final first = allLessons.first;
    final last = allLessons.last;
    final surahName = quranService.getSurahNamePreferred(first.surahId);
    final loc = AppLocalizations.of(context)!;

    return loc.verticalLessonIconsSurahAyahFormat(
      surahName,
      first.startAyah.toString(),
      last.endAyah.toString(),
    );
  }

  /// Show "Support & Upgrade" dialog, updated to have two buttons:
  /// 1) Explore Plans -> SubscriptionTierScreen
  /// 2) Back to Home
  void _showHudhudUpgradeDialog(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(loc.verticalLessonIconsDialogTitle),
        content: Text(loc.verticalLessonIconsDialogBody),
        actions: [
          // (A) Explore Plans => push SubscriptionTierScreen
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx); // close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubscriptionTierScreen(
                    // minimal placeholders for onNext, onSkip
                    onNext: (_) {
                      // e.g. pop until home or show a "Thanks" message
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    onSkip: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ),
              );
            },
            // Reuse the same localizations from top bar:
            child: Text(loc.topBarExplorePlansLabel), // e.g. "Explore Plans"
          ),

          // (B) Back to Home => pushReplacement
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
            child: Text(loc.topBarBackHomeLabel), // e.g. "Back to Home"
          ),
        ],
      ),
    );
  }

  /// Builds the "Go to Theme" (or "Go to Path List") button to look more like the FAB style.
  Widget _buildGoToPathListButton(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final shortSide = min(screenWidth, screenHeight);

    // We'll scale from 420 px reference
    double scaleFactorBtn = shortSide / 420.0;
    scaleFactorBtn = scaleFactorBtn.clamp(1.0, 1.4);

    final double buttonWidth = 140 * scaleFactorBtn;
    final double buttonHeight = 48 * scaleFactorBtn;

    return Semantics(
      label: loc.verticalLessonIconsGoToTheme,
      button: true,
      child: Material(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: InkWell(
          onTap: () => _handleGoToPathListTap(context),
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: Center(
              child: Text(
                loc.verticalLessonIconsGoToTheme,
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

  /// Navigate to a "PathListScreen" in the given theme. (Update to your actual screen name.)
  void _handleGoToPathListTap(BuildContext context) {
    final analytics = ref.read(analyticsServiceProvider);

    // Hardcode a fallback for path_fatihah if desired:
    String finalThemeId;
    if (widget.activePathId == 'path_fatihah') {
      finalThemeId = 'theme_core_recitation';
    } else {
      finalThemeId = widget.themeId ?? 'unknown';
    }

    analytics.logEvent(
      'go_to_path_list_screen_clicked',
      parameters: {
        'path_id': widget.activePathId,
        'theme_id': finalThemeId,
      },
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PathListScreen(
          themeId: finalThemeId,
        ),
      ),
    );
  }

  /// A FloatingActionButton that logs gratitude
  Widget _buildFloatingActionButton(
      BuildContext context,
      WidgetRef ref,
      LoggingService loggingService,
      ) {
    final loc = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final shortSide = min(screenWidth, screenHeight);
    double scaleFactorFab = shortSide / 420.0;
    scaleFactorFab = scaleFactorFab.clamp(1.0, 1.4);

    final double fabSize = 56.0 * scaleFactorFab;

    return Semantics(
      label: loc.fabLogGratitudeLabel,
      button: true,
      child: Material(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: fabSize,
          height: fabSize,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () async {
              final submittedGratitudes = await showDialog<List<String>>(
                context: context,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (_) => const GratitudeModal(),
              );
              if (!context.mounted) return;

              if (submittedGratitudes != null && submittedGratitudes.isNotEmpty) {
                await showDialog<void>(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.5),
                  builder: (_) => SubmissionFeedbackModal(
                    submittedGratitudes: submittedGratitudes,
                  ),
                );
              }
            },
            child: Icon(
              Icons.volunteer_activism,
              size: fabSize * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}
