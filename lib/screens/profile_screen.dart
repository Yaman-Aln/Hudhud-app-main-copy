import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// We import dart:ui to fix the "getter ltr not found" by referencing ui.TextDirection.ltr
import 'dart:ui' as ui;

// Analytics & logging
import '../providers/analytics_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

// Our user profile provider
import '../z_onboarding/providers/user_profile_provider.dart';

// Additional providers
import '../providers/gratitude_provider.dart';
import '../providers/lesson_submit_provider.dart';

// Models & Helpers
import '../z_onboarding/models/unique_test_model.dart'; // includes Language & SubscriptionTier
import '../providers/language_helper.dart';
import '../models/gratitude_entry_model.dart';

// Widgets
import '../widgets/bottom_nav_bar.dart';

// Generated localization
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// NEW: Import your ScoreService
import '../services/scoring_service.dart';

// NEW: Import SubscriptionTierScreen for the "Explore Plans" button
import '../z_onboarding/screens/subscription_tier_screen.dart';

/// A Profile screen that displays/edits the user's name & language,
/// plus optional premium progress calendars, all using userProfileProvider.
///
/// It also checks subscriptionTier from the same userProfileProvider
/// to decide if certain features are locked.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  String _originalName = '';

  DateTime currentWeekStart = DateTime.now();

  // --------------------------------------------------------------------------
  // NEW: Score fields for daily/weekly/monthly/total
  // --------------------------------------------------------------------------
  int? _dailyScore;
  int? _weeklyScore;
  int? _monthlyScore;
  int? _totalScore;

  @override
  void initState() {
    super.initState();
    final analytics = ref.read(analyticsServiceProvider);

    // Log "profile_screen_viewed"
    analytics.logEvent(
      'profile_screen_viewed',
      parameters: {'from_screen': 'unknown', 'to_screen': 'profile'},
    );

    // Align currentWeekStart to Monday
    currentWeekStart = currentWeekStart.subtract(
      Duration(days: currentWeekStart.weekday - 1),
    );

    // Initialize name from userProfile
    final profile = ref.read(userProfileProvider);
    _nameController = TextEditingController(
      text: (profile.name == 'Guest') ? '' : profile.name,
    );
    _originalName = profile.name;

    // ------------------------------------------------------------------------
    // NEW: Load daily/weekly/monthly/total scores
    // ------------------------------------------------------------------------
    _loadScores();
  }

  Future<void> _loadScores() async {
    final scoreService = ScoreService();
    final now = DateTime.now();

    final daily = await scoreService.fetchDailyPoints(now);
    final weekly = await scoreService.fetchWeeklyScore(now);
    final monthly = await scoreService.fetchMonthlyScore(now);
    final total = await scoreService.fetchAllTimeScore();

    if (!mounted) return;
    setState(() {
      _dailyScore = daily;
      _weeklyScore = weekly;
      _monthlyScore = monthly;
      _totalScore = total;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Moves the currently displayed week by [direction] weeks.
  /// - Negative => go to previous week
  /// - Positive => go to next week
  void _changeWeek(int direction) {
    final todayStart = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );
    setState(() {
      final newWeekStart = currentWeekStart.add(Duration(days: 7 * direction));
      // Restrict future weeks
      if (direction < 0 ||
          newWeekStart.isBefore(todayStart.add(const Duration(days: 7)))) {
        currentWeekStart = newWeekStart;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // Localizations
    final analytics = ref.read(analyticsServiceProvider);
    final loggingService = ref.read(ffLoggingServiceProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontScale = screenHeight / 810;

    // Watch entire userProfile
    final userProfile = ref.watch(userProfileProvider);
    // Now we get the subscription tier from the same userProfile
    final userTier = userProfile.subscriptionTier;

    // Data for progress calendars
    final gratitudeEntries = ref.watch(gratitudeEntriesProvider);
    final lessonSubmitDates = ref.watch(lessonSubmitProvider);

    return Scaffold(
      appBar: AppBar(
        // Localized "Profile"
        title: Text(
          loc.profileTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20 * fontScale,
          ),
        ),
        centerTitle: true,
        leading: Semantics(
          label: loc.profileBackArrowLabel, // e.g. "Back to previous screen"
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              analytics.logEvent('profile_screen_back_pressed', parameters: {
                'from_screen': 'profile',
                'to_screen': 'previous',
              });
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // (1) Row with circle avatar + name display + Edit button
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Semantics(
                    label: loc.profileAvatarSemanticLabel, // "User avatar"
                    child: CircleAvatar(
                      radius: 40 * fontScale,
                      backgroundColor: Colors.blue[50],
                      child: Text(
                        userProfile.name.isEmpty
                            ? loc.profileNameGuest[0].toUpperCase()
                            : userProfile.name[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 24 * fontScale,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Name editing or label
                  Expanded(
                    child: _isEditing
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: loc.profileEnterYourName,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final oldName = userProfile.name;
                                final trimmed = _nameController.text.trim();
                                final newName = trimmed.isEmpty
                                    ? loc.profileNameGuest
                                    : trimmed;

                                // Log the name update
                                analytics.logEvent(
                                  'profile_name_updated',
                                  parameters: {
                                    'old_name': oldName,
                                    'new_name': newName,
                                  },
                                );

                                // Update in provider
                                await ref
                                    .read(userProfileProvider.notifier)
                                    .updateName(newName);

                                setState(() {
                                  _isEditing = false;
                                  _originalName = newName;
                                });
                              },
                              child: Text(loc.profileNameSave), // "Save"
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: () {
                                // Revert
                                _nameController.text =
                                (_originalName == loc.profileNameGuest)
                                    ? ''
                                    : _originalName;
                                setState(() {
                                  _isEditing = false;
                                });
                              },
                              child: Text(loc.profileNameCancel), // "Cancel"
                            ),
                          ],
                        )
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProfile.name.isEmpty
                              ? loc.profileNameGuest // "Guest"
                              : userProfile.name,
                          style: TextStyle(
                            fontSize: 20 * fontScale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Start editing
                            setState(() {
                              _isEditing = true;
                              _originalName = userProfile.name;
                              _nameController.text =
                              (userProfile.name == loc.profileNameGuest)
                                  ? ''
                                  : userProfile.name;
                            });
                          },
                          child: Text(loc.profileNameEdit), // "Edit"
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // (2) Language (always allowed)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      loc.profilePreferredLanguage,
                      style: TextStyle(
                        fontSize: (18.0 * fontScale) - 0.5, // 0.5 smaller
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    // Freed => always clickable
                    child: _buildLanguageDropdown(userProfile, fontScale),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // (3) Reciter
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      loc.profileReciterLabel, // e.g. "Reciter (Qari)"
                      style: TextStyle(
                        fontSize: (18.0 * fontScale) - 0.5, // 0.5 smaller
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildReciterDropdown(userProfile, fontScale, userTier),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // (4) Font
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      loc.profileFontLabel, // e.g. "Font:"
                      style: TextStyle(
                        fontSize: (18.0 * fontScale) - 0.5, // 0.5 smaller
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildFontSelection(userProfile, fontScale, userTier),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // (5) Example: show progress if premium
              Text(
                loc.profileWeeksProgress, // e.g. "Here is your week's progress:"
                style: TextStyle(
                  fontSize: 18 * fontScale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildWeekNavigation(fontScale),
              const SizedBox(height: 20),

              // If user is free => show the "locked" message
              if (userTier == SubscriptionTier.free) ...[
                Text(
                  loc.profilePremiumNeeded, // "Progress requires premium..."
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Explore Plans Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SubscriptionTierScreen(
                          onNext: (_) {
                            // e.g., pop to home after purchase
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          onSkip: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                        ),
                      ),
                    );
                  },
                  child: Text(
                    // Reuse the same label from top bar's "Explore Plans"
                    loc.topBarExplorePlansLabel,
                  ),
                ),
              ] else ...[
                // If premium => show the real progress calendars
                _buildGratefulnessCalendar(
                  title: loc.profileGratefulnessCalendar,
                  gratitudeEntries: gratitudeEntries,
                  startOfWeek: currentWeekStart,
                  fontScale: fontScale,
                ),
                SizedBox(height: 18 * fontScale),
                _buildLessonSubmitCalendar(
                  title: loc.profileQuranLearningCalendar,
                  submissionDates: lessonSubmitDates,
                  startOfWeek: currentWeekStart,
                  fontScale: fontScale,
                ),
              ],

              const SizedBox(height: 30),
              // ------------------------------------------------------------------
              // Analytics / Score Section
              // ------------------------------------------------------------------
              _buildAnalyticsSection(fontScale),

              // ------------------------------------------------------------------
              // MOVED: Notification Frequency to the bottom
              // ------------------------------------------------------------------
              const SizedBox(height: 40),
              Text(
                loc.profileNotificationFrequency, // "Notification Frequency"
                style: TextStyle(
                  fontSize: 18 * fontScale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildNotificationFrequencyDropdown(userProfile, fontScale),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        ref: ref,
        pathId: null,
      ),
    );
  }

  /// Popup used when user in free tier tries to change a locked setting
  Future<void> _showUpgradeProDialog(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(loc.profileUpgradePremiumTitle),
        content: Text(loc.profileUpgradePremiumBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(loc.okLabel),
          ),
        ],
      ),
    );
  }

  /// (A) Language dropdown that updates userProfile.languagePreference
  /// Always allowed (even for free).
  Widget _buildLanguageDropdown(
      UniqueTestModel userProfile,
      double fontScale,
      ) {
    final analytics = ref.read(analyticsServiceProvider);
    final loc = AppLocalizations.of(context)!;
    final languageMap = getLanguageDisplayMap(); // your local helper map
    final currentLanguage = userProfile.languagePreference;

    return DropdownButton<Language>(
      value: currentLanguage,
      isExpanded: true,
      items: Language.values.map((lang) {
        final displayName = languageMap[lang] ?? lang.name;
        return DropdownMenuItem<Language>(
          value: lang,
          child: Text(displayName),
        );
      }).toList(),
      onChanged: (newLang) async {
        if (newLang == null || newLang == currentLanguage) return;
        analytics.logEvent('profile_language_changed', parameters: {
          'old_language': currentLanguage.name,
          'new_language': newLang.name,
        });
        await ref.read(userProfileProvider.notifier).updateLanguage(newLang);
      },
      underline: Container(
        height: 1,
        color: Colors.black45,
      ),
      style: TextStyle(
        color: Colors.black,
        fontSize: (16.0 * fontScale) - 0.5, // 0.5 smaller
      ),
    );
  }

  /// (B) Reciter dropdown (freemium => disabled => pop up)
  Widget _buildReciterDropdown(
      UniqueTestModel userProfile,
      double fontScale,
      SubscriptionTier userTier,
      ) {
    final analytics = ref.read(analyticsServiceProvider);
    final loc = AppLocalizations.of(context)!;

    // Define reciters with localized strings
    final reciterMap = <int, String>{
      1: loc.profileReciterMishary,
      2: loc.profileReciterShatri,
      3: loc.profileReciterQatami,
    };

    final isDisabled = (userTier == SubscriptionTier.free);
    final currentReciterId = userProfile.reciterId;

    return DropdownButton<int>(
      value: currentReciterId,
      isExpanded: true,
      items: reciterMap.entries.map((e) {
        return DropdownMenuItem<int>(
          value: e.key,
          child: Text(e.value),
        );
      }).toList(),
      onChanged: isDisabled
          ? (val) => _showUpgradeProDialog(context)
          : (newReciterId) async {
        if (newReciterId == null || newReciterId == currentReciterId) {
          return;
        }
        analytics.logEvent('profile_reciter_changed', parameters: {
          'old_reciter': currentReciterId,
          'new_reciter': newReciterId,
        });

        await ref
            .read(userProfileProvider.notifier)
            .updateReciter(newReciterId);
      },
      disabledHint: Text(
        reciterMap[currentReciterId] ?? 'Unknown',
        style: TextStyle(color: Colors.grey.shade600),
      ),
      underline: Container(
        height: 1,
        color: isDisabled ? Colors.grey : Colors.black45,
      ),
      style: TextStyle(
        color: isDisabled ? Colors.grey : Colors.black,
        fontSize: (16.0 * fontScale) - 0.5, // 0.5 smaller
      ),
    );
  }

  /// (C) Font selection (freemium => disabled => pop up)
  Widget _buildFontSelection(
      UniqueTestModel userProfile,
      double fontScale,
      SubscriptionTier userTier,
      ) {
    final analytics = ref.read(analyticsServiceProvider);
    final loc = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> fonts = [
      {
        'display': 'NotoNaskh (Normal)',
        'family': 'NotoNaskh',
        'weight': 400,
      },
      {
        'display': 'NotoNaskh (Bold)',
        'family': 'NotoNaskh',
        'weight': 700,
      },
      {
        'display': 'Amiri (Normal)',
        'family': 'Amiri',
        'weight': 400,
      },
      {
        'display': 'Amiri (Bold)',
        'family': 'Amiri',
        'weight': 700,
      },
    ];

    int getSelectedFontIndex(String family, int weight) {
      return fonts.indexWhere(
            (f) => f['family'] == family && f['weight'] == weight,
      );
    }

    final currentIndex =
    getSelectedFontIndex(userProfile.fontFamily, userProfile.fontWeight);
    final selectedValue = currentIndex >= 0 ? currentIndex : 0;

    final isDisabled = (userTier == SubscriptionTier.free);

    return DropdownButton<int>(
      value: selectedValue,
      isExpanded: true,
      items: List.generate(fonts.length, (index) {
        final item = fonts[index];
        final family = item['family'] as String;
        final weight = item['weight'] as int;
        return DropdownMenuItem<int>(
          value: index,
          child: Text(
            // Show Arabic text "الْحَمْدُ لِلَّهِ" in the actual font
            'الْحَمْدُ لِلَّهِ',
            style: TextStyle(
              fontFamily: family,
              fontWeight: (weight == 700) ? FontWeight.bold : FontWeight.normal,
              fontSize: 18 * fontScale,
            ),
          ),
        );
      }),
      onChanged: isDisabled
          ? (val) => _showUpgradeProDialog(context)
          : (newIndex) async {
        if (newIndex == null || newIndex == selectedValue) return;

        final newItem = fonts[newIndex];
        final oldFamily = userProfile.fontFamily;
        final oldWeight = userProfile.fontWeight;
        final newFamily = newItem['family'] as String;
        final newWeight = newItem['weight'] as int;

        analytics.logEvent('profile_font_changed', parameters: {
          'old_family': oldFamily,
          'old_weight': oldWeight,
          'new_family': newFamily,
          'new_weight': newWeight,
        });

        // Update user profile
        await ref
            .read(userProfileProvider.notifier)
            .updateFontSelection(newFamily, newWeight);
      },
      disabledHint: Text(
        'الْحَمْدُ لِلَّهِ',
        style: TextStyle(
          fontFamily: userProfile.fontFamily,
          fontWeight:
          (userProfile.fontWeight == 700) ? FontWeight.bold : FontWeight.normal,
          fontSize: 18 * fontScale,
          color: Colors.grey.shade600,
        ),
      ),
      underline: Container(
        height: 1,
        color: isDisabled ? Colors.grey : Colors.black45,
      ),
      style: TextStyle(
        color: isDisabled ? Colors.grey : Colors.black,
        fontSize: (16.0 * fontScale) - 0.5, // 0.5 smaller
      ),
    );
  }

  /// Row with arrow buttons and the date range
  Widget _buildWeekNavigation(double fontScale) {
    final loc = AppLocalizations.of(context)!;
    final formatter = DateFormat('MMM dd');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Semantics(
          label: loc.profilePrevWeekSemantic, // e.g. "Go to previous week"
          button: true,
          child: IconButton(
            onPressed: () => _changeWeek(-1),
            icon: const Icon(Icons.arrow_left),
          ),
        ),
        Text(
          '${formatter.format(currentWeekStart)} - '
              '${formatter.format(currentWeekStart.add(const Duration(days: 6)))}',
          style: TextStyle(
            fontSize: 16 * fontScale,
            fontWeight: FontWeight.bold,
          ),
        ),
        Semantics(
          label: loc.profileNextWeekSemantic, // e.g. "Go to next week"
          button: true,
          child: IconButton(
            onPressed: () => _changeWeek(1),
            icon: const Icon(Icons.arrow_right),
          ),
        ),
      ],
    );
  }

  Widget _buildGratefulnessCalendar({
    required String title,
    required List<GratitudeEntry>? gratitudeEntries,
    required DateTime startOfWeek,
    required double fontScale,
  }) {
    final completedDates = (gratitudeEntries ?? [])
        .map((entry) => entry.date)
        .whereType<DateTime>()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, // e.g. "Gratefulness Calendar"
          style: TextStyle(
            fontSize: 18 * fontScale,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final day = startOfWeek.add(Duration(days: index));
            final isMarked = completedDates.any((d) =>
            d.year == day.year && d.month == day.month && d.day == day.day);

            return Column(
              children: [
                Text(
                  DateFormat.E().format(day), // "Mon", "Tue", etc.
                  style: TextStyle(fontSize: 14 * fontScale),
                ),
                SizedBox(height: 5 * fontScale),
                CircleAvatar(
                  radius: 16 * fontScale,
                  backgroundColor:
                  isMarked ? Colors.green : Colors.grey.shade300,
                  child: isMarked
                      ? Icon(Icons.check,
                      color: Colors.white, size: 20 * fontScale)
                      : Text(
                    day.day.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12 * fontScale,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildLessonSubmitCalendar({
    required String title,
    required List<DateTime> submissionDates,
    required DateTime startOfWeek,
    required double fontScale,
  }) {
    bool isMarkedDate(DateTime day) => submissionDates.any(
            (d) => d.year == day.year && d.month == day.month && d.day == day.day);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, // e.g. "Quran Learning Calendar"
          style: TextStyle(
            fontSize: 18 * fontScale,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final day = startOfWeek.add(Duration(days: index));
            final isMarked = isMarkedDate(day);

            return Column(
              children: [
                Text(
                  DateFormat.E().format(day),
                  style: TextStyle(fontSize: 14 * fontScale),
                ),
                SizedBox(height: 5 * fontScale),
                CircleAvatar(
                  radius: 16 * fontScale,
                  backgroundColor:
                  isMarked ? Colors.green : Colors.grey.shade300,
                  child: isMarked
                      ? Icon(Icons.check,
                      color: Colors.white, size: 20 * fontScale)
                      : Text(
                    day.day.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12 * fontScale,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  /// A dropdown for updating userProfile.notificationFrequency
  Widget _buildNotificationFrequencyDropdown(
      UniqueTestModel userProfile,
      double fontScale,
      ) {
    final analytics = ref.read(analyticsServiceProvider);
    final loc = AppLocalizations.of(context)!;

    // "Daily", "Weekly", or "None"
    final currentFreq = userProfile.notificationFrequency;

    return DropdownButton<String>(
      value: currentFreq,
      isExpanded: true,
      items: [
        DropdownMenuItem(
          value: 'Daily',
          child: Text(loc.nameEntryNotificationFrequencyDaily),
        ),
        DropdownMenuItem(
          value: 'Weekly',
          child: Text(loc.nameEntryNotificationFrequencyWeekly),
        ),
        DropdownMenuItem(
          value: 'None',
          child: Text(loc.nameEntryNotificationFrequencyNone),
        ),
      ],
      onChanged: (newVal) async {
        if (newVal == null || newVal == currentFreq) return;
        analytics.logEvent('profile_notification_frequency_changed',
            parameters: {
              'old_freq': currentFreq,
              'new_freq': newVal,
            });
        await ref
            .read(userProfileProvider.notifier)
            .updateNotificationFrequency(newVal);
      },
    );
  }

  // --------------------------------------------------------------------------
  // NEW: Build a simple "Analytics" section for Daily/Weekly/Monthly/Total
  // --------------------------------------------------------------------------
  Widget _buildAnalyticsSection(double fontScale) {
    final loc = AppLocalizations.of(context)!;
    final userTier = ref.watch(userProfileProvider).subscriptionTier;

    // Block if user does NOT have premium or premium plus
    if (userTier != SubscriptionTier.premium &&
        userTier != SubscriptionTier.premiumPlus) {
      // "Leave the type, but now explicitly show (Locked)"
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.profileAnalyticsScoreLabel, // e.g. "Analytics & Score"
            style: TextStyle(
              fontSize: 18 * fontScale,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // The 4 "types" with "(Locked)" appended
          Text(
            '${loc.profileDailyLabel} (${loc.profileRequiresPlanUpdate}):',
            style: TextStyle(fontSize: 16 * fontScale),
          ),
          Text(
            '${loc.profileWeeklyLabel} (${loc.profileRequiresPlanUpdate}):',
            style: TextStyle(fontSize: 16 * fontScale),
          ),
          Text(
            '${loc.profileMonthlyLabel} (${loc.profileRequiresPlanUpdate}):',
            style: TextStyle(fontSize: 16 * fontScale),
          ),
          Text(
            '${loc.profileTotalLabel} (${loc.profileRequiresPlanUpdate}):',
            style: TextStyle(fontSize: 16 * fontScale),
          ),

          const SizedBox(height: 20),

          // The label from your JSON:
          Text(
            loc.premiumRequiredLabel,
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // "Explore Plans" button => goes to SubscriptionTierScreen
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubscriptionTierScreen(
                    onNext: (_) {
                      // e.g. pop to home after purchase
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    onSkip: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ),
              );
            },
            child: Text(loc.topBarExplorePlansLabel),
          ),
        ],
      );
    }

    // If user is premium or premium plus, show the actual analytics
    // If scores not yet loaded => show a spinner
    if (_dailyScore == null ||
        _weeklyScore == null ||
        _monthlyScore == null ||
        _totalScore == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.profileAnalyticsScoreLabel, // e.g. "Analytics & Score"
          style: TextStyle(
            fontSize: 18 * fontScale,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // DAILY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${loc.profileDailyLabel}: ${_dailyScore ?? 0}'),
            ElevatedButton(
              onPressed: () => _showScoreChart('Daily'),
              child: Text(loc.profileViewChart),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // WEEKLY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${loc.profileWeeklyLabel}: ${_weeklyScore ?? 0}'),
            ElevatedButton(
              onPressed: () => _showScoreChart('Weekly'),
              child: Text(loc.profileViewChart),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // MONTHLY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${loc.profileMonthlyLabel}: ${_monthlyScore ?? 0}'),
            ElevatedButton(
              onPressed: () => _showScoreChart('Monthly'),
              child: Text(loc.profileViewChart),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // TOTAL
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${loc.profileTotalLabel}: ${_totalScore ?? 0}'),
            ElevatedButton(
              onPressed: () => _showScoreChart('Total'),
              child: Text(loc.profileViewChart),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  /// Show a bar chart dialog for the given range: "Daily", "Weekly", "Monthly", "Total"
  ///
  /// UPDATED: now it starts from the earliest date the user has data for this range,
  /// or uses "today / this week / this month" with a 0 if there's no prior data.
  /// Then we REVERSE it so today's (most recent) is first.
  Future<void> _showScoreChart(String rangeType) async {
    final scoreService = ScoreService();
    List<Map<String, dynamic>> data = [];

    final now = DateTime.now();

    // First, ask the ScoreService for the earliest date with logged data
    // for this range type. If it returns null, it means there's no data at all.
    // In that case, we'll just treat "earliestDate" as now.
    DateTime? earliestDate;
    try {
      earliestDate = await scoreService.fetchEarliestLoggedDate(rangeType);
    } catch (e) {
      // If the method isn't implemented or fails, fallback to now
    }
    earliestDate ??= now;

    // Build the history from earliestDate to 'now'
    if (earliestDate.isAfter(now)) {
      earliestDate = now;
    }

    try {
      if (rangeType == 'Daily') {
        // Iterate day by day from earliest to now
        for (DateTime day = earliestDate;
        !day.isAfter(now);
        day = day.add(const Duration(days: 1))) {
          final score = await scoreService.fetchDailyPoints(day);
          final label = DateFormat('EEEE MM/dd').format(day);
          data.add({'label': label, 'score': score});
        }
      } else if (rangeType == 'Weekly') {
        // Step in increments of 7 days
        DateTime weekDate = earliestDate;
        while (!weekDate.isAfter(now)) {
          final score = await scoreService.fetchWeeklyScore(weekDate);
          final label = 'Wk ${DateFormat('MM/dd').format(weekDate)}';
          data.add({'label': label, 'score': score});
          weekDate = weekDate.add(const Duration(days: 7));
        }
      } else if (rangeType == 'Monthly') {
        // Step month by month
        DateTime monthDate = DateTime(earliestDate.year, earliestDate.month, 1);
        final endMonth = DateTime(now.year, now.month, 1);
        while (!monthDate.isAfter(endMonth)) {
          final score = await scoreService.fetchMonthlyScore(monthDate);
          final label = DateFormat('MMM').format(monthDate);
          data.add({'label': label, 'score': score});
          monthDate = DateTime(monthDate.year, monthDate.month + 1, 1);
        }
      } else {
        // "Total" => for a chart, also do it month by month
        DateTime monthDate = DateTime(earliestDate.year, earliestDate.month, 1);
        final endMonth = DateTime(now.year, now.month, 1);
        while (!monthDate.isAfter(endMonth)) {
          final score = await scoreService.fetchMonthlyScore(monthDate);
          final label = DateFormat('MMM').format(monthDate);
          data.add({'label': label, 'score': score});
          monthDate = DateTime(monthDate.year, monthDate.month + 1, 1);
        }
      }
    } catch (e) {
      // Just in case of errors fetching the data
    }

    // Reverse the data so the most recent is first (top)
    data = data.reversed.toList();

    if (!mounted) return;

    showDialog<void>(
      context: context,
      builder: (ctx) {
        final loc = AppLocalizations.of(ctx)!;
        return AlertDialog(
          title: Text(
            '$rangeType ${loc.profileScoreChartTitle}', // e.g. "Daily Score Chart"
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(ctx).size.width * 0.9,
              height: 300,
              child: ScoreBarChart(
                title: '$rangeType ${loc.profileScoreChartHistory}',
                data: data,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(loc.profileCloseLabel),
            ),
          ],
        );
      },
    );
  }
}

// ------------------------------------------------------------------------
// NEW: A minimal bar chart widget using CustomPainter
// with nicer visuals (rounded corners, gradient fill).
// ------------------------------------------------------------------------
class ScoreBarChart extends StatelessWidget {
  final String title;
  // A list of { 'label': 'Feb', 'score': 120 }
  final List<Map<String, dynamic>> data;

  const ScoreBarChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.profileNoData));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: CustomPaint(
            painter: _BarChartPainter(data),
          ),
        ),
      ],
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  _BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.blue;

    // We'll measure text to determine spacing for labels & scores
    final textPainter = TextPainter(
      textDirection: ui.TextDirection.ltr,
      maxLines: 1,
    );

    // 1) Find the maximum score
    final int maxScore = data.fold<int>(0, (maxVal, e) {
      final s = e['score'] as int;
      return (s > maxVal) ? s : maxVal;
    });

    // 2) Measure the widest label (for left margin)
    double widestLabel = 0.0;
    for (final d in data) {
      final label = d['label'] as String;
      final labelSpan = TextSpan(
        text: label,
        style: const TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.text = labelSpan;
      textPainter.layout();
      if (textPainter.width > widestLabel) {
        widestLabel = textPainter.width;
      }
    }

    // We add padding so bars don’t collide with the widest label
    final double leftMargin = widestLabel + 10; // space for label
    // A little gap on the right for the numeric score
    final double rightMargin = 10;

    // 3) We want to draw bars *from the top down*, so let's define:
    final double topMargin = 10.0;
    // We'll have 'barCount' bars plus 'barCount-1' gaps:
    final int barCount = data.length;
    // Let’s define a simpler constant barHeight:
    const double barHeight = 24.0;
    // Gap between bars:
    const double barGap = 12.0;

    // 4) total vertical space needed for all bars + gaps:
    final totalBarsHeight = barCount * barHeight + (barCount - 1) * barGap;

    // If the total needed is bigger than the available size, we scale down
    final double scaleY =
    (totalBarsHeight > size.height) ? size.height / totalBarsHeight : 1.0;

    // We'll keep a running yOffset from the topMargin
    double yOffset = topMargin;

    for (int i = 0; i < barCount; i++) {
      final d = data[i];
      final score = d['score'] as int;
      final label = d['label'] as String;

      final fraction = (maxScore == 0) ? 0.0 : (score / maxScore);
      final availableWidth = size.width - leftMargin - rightMargin;
      final barLength = fraction * availableWidth;

      // Apply vertical scale to bar placement
      final scaledBarHeight = barHeight * scaleY;
      final scaledY = yOffset * scaleY;

      // 5) The bar rect
      final barRect = Rect.fromLTWH(
        leftMargin,
        scaledY,
        barLength,
        scaledBarHeight,
      );

      // Gradient fill
      final gradientShader = const LinearGradient(
        colors: [
          Color(0xFF66BBFF),
          Color(0xFF0044BB),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(barRect);

      paint.shader = gradientShader;

      // Round corners
      final rRect = RRect.fromRectAndRadius(
        barRect,
        Radius.circular(scaledBarHeight * 0.4),
      );
      canvas.drawRRect(rRect, paint);

      paint.shader = null; // reset so text drawing isn't affected

      // 6) Numeric score to right of bar
      final scoreTextSpan = TextSpan(
        text: '$score',
        style: const TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.text = scoreTextSpan;
      textPainter.layout();

      const double scoreGap = 8.0;
      final scoreOffsetX = leftMargin + barLength + scoreGap;
      final scoreOffsetY =
          scaledY + (scaledBarHeight / 2) - (textPainter.height / 2);

      textPainter.paint(canvas, Offset(scoreOffsetX, scoreOffsetY));

      // 7) Draw the label on the left
      final labelSpan = TextSpan(
        text: label,
        style: const TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.text = labelSpan;
      textPainter.layout();

      final labelOffsetY =
          scaledY + (scaledBarHeight / 2) - (textPainter.height / 2);
      textPainter.paint(canvas, Offset(0, labelOffsetY));

      // 8) Move yOffset down for next bar (unscaled)
      yOffset += (barHeight + barGap);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
