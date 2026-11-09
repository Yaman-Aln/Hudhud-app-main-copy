import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('id'),
    Locale('ms'),
    Locale('tr'),
    Locale('ur')
  ];

  /// No description provided for @commentA.
  ///
  /// In en, this message translates to:
  /// **'Onboarding keys'**
  String get commentA;

  /// Shown on the Welcome Screen app bar
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get appBarTitleWelcome;

  /// Generic button label for skipping a step
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipLabel;

  /// Headline text on the Welcome Onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to Quran with Hudhud!'**
  String get welcomeHeadline;

  /// Button label to proceed to the next onboarding step
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStartedLabel;

  /// No description provided for @commentB.
  ///
  /// In en, this message translates to:
  /// **'Lesson screen keys'**
  String get commentB;

  /// Text for the Lesson app bar title
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get lessonScreenAppBarTitle;

  /// Snackbar message if we have no ayah to play
  ///
  /// In en, this message translates to:
  /// **'No ayah available to play.'**
  String get noAyahAvailable;

  /// Error message when audio doesn't exist on the server
  ///
  /// In en, this message translates to:
  /// **'Audio not found at {url}'**
  String audioNotFound(Object url);

  /// Dialog title when user tries to reset all lesson progress
  ///
  /// In en, this message translates to:
  /// **'Restart Lesson'**
  String get restartLessonTitle;

  /// Dialog body text for resetting a lesson
  ///
  /// In en, this message translates to:
  /// **'Reset all your progress for this lesson?'**
  String get resetLessonBody;

  /// Generic button label for cancelling an action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelLabel;

  /// Generic button label to confirm an action
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesLabel;

  /// Snackbar prefix if we fail to reset a lesson
  ///
  /// In en, this message translates to:
  /// **'Error resetting lesson'**
  String get errorResettingLesson;

  /// Button label to start a lesson or session
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startLabel;

  /// Button label for submission
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitLabel;

  /// Button label for going to the next step
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextLabel;

  /// Title of popup when user denies mic permission
  ///
  /// In en, this message translates to:
  /// **'Microphone Denied'**
  String get voiceErrorMicDeniedTitle;

  /// Body text for mic-denied popup
  ///
  /// In en, this message translates to:
  /// **'Recording requires microphone access. Please grant permission in Settings.'**
  String get voiceErrorMicDeniedBody;

  /// Semantic label for screen readers
  ///
  /// In en, this message translates to:
  /// **'Microphone permission denied dialog'**
  String get voiceErrorMicDeniedSemanticLabel;

  /// Title of popup if we fail to start recording
  ///
  /// In en, this message translates to:
  /// **'Recording Error'**
  String get voiceErrorRecorderStartTitle;

  /// Body text if starting the recorder fails
  ///
  /// In en, this message translates to:
  /// **'We could not start the recorder. Please try again.'**
  String get voiceErrorRecorderStartBody;

  /// Semantic label for screen readers
  ///
  /// In en, this message translates to:
  /// **'Recorder start error dialog'**
  String get voiceErrorRecorderStartSemanticLabel;

  /// Title of popup if we fail to stop the recorder
  ///
  /// In en, this message translates to:
  /// **'Stop Recording Error'**
  String get voiceErrorRecorderStopTitle;

  /// Body text if stopping the recorder fails
  ///
  /// In en, this message translates to:
  /// **'We could not stop the recorder properly. Please try again.'**
  String get voiceErrorRecorderStopBody;

  /// Semantic label for screen readers
  ///
  /// In en, this message translates to:
  /// **'Recorder stop error dialog'**
  String get voiceErrorRecorderStopSemanticLabel;

  /// Title of popup if the audio was empty or silent
  ///
  /// In en, this message translates to:
  /// **'No Sound Detected'**
  String get voiceErrorNoSoundTitle;

  /// Body text for no-sound popup
  ///
  /// In en, this message translates to:
  /// **'Your recording was silent or too quiet. Please try again.'**
  String get voiceErrorNoSoundBody;

  /// Semantic label for screen readers
  ///
  /// In en, this message translates to:
  /// **'No sound detected dialog'**
  String get voiceErrorNoSoundSemanticLabel;

  /// Title if network or server fails for transcription
  ///
  /// In en, this message translates to:
  /// **'Transcription Error'**
  String get voiceErrorTranscriptionTitle;

  /// Body text for transcription error popup
  ///
  /// In en, this message translates to:
  /// **'We could not transcribe your recording. Please check your connection and try again.'**
  String get voiceErrorTranscriptionBody;

  /// Semantic label for screen readers
  ///
  /// In en, this message translates to:
  /// **'Transcription error dialog'**
  String get voiceErrorTranscriptionSemanticLabel;

  /// Informing users about feature of corrected Quran.
  ///
  /// In en, this message translates to:
  /// **'Tap the highlighted words to see the corrected version.'**
  String get tapColoredWordsHint;

  /// Warning shown if user tries to submit blank text
  ///
  /// In en, this message translates to:
  /// **'You must input something before submitting'**
  String get emptyInputWarning;

  /// Button label for revealing a hint
  ///
  /// In en, this message translates to:
  /// **'Get Hint'**
  String get getHintLabel;

  /// Button label for removing an applied hint
  ///
  /// In en, this message translates to:
  /// **'Remove Hint'**
  String get removeHintLabel;

  /// Label above the textfield for missing words
  ///
  /// In en, this message translates to:
  /// **'Type the missing word(s)'**
  String get typeTheMissingWordsLabel;

  /// Label above the Difficulty dropdown
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficultyLabel;

  /// Label above the number-of-repeats dropdown
  ///
  /// In en, this message translates to:
  /// **'# of Repeats'**
  String get repeatCountLabel;

  /// Semantics label for the back arrow in the lesson app bar
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButtonLabel;

  /// Semantics label for the icon that toggles verse translation
  ///
  /// In en, this message translates to:
  /// **'Toggle inline translation'**
  String get toggleTranslationLabel;

  /// Semantics label for the icon opening the separate Translation screen
  ///
  /// In en, this message translates to:
  /// **'Open translation screen'**
  String get openTranslationScreenLabel;

  /// Semantics label for the restart lesson icon button
  ///
  /// In en, this message translates to:
  /// **'Restart the lesson'**
  String get restartLessonSemanticLabel;

  /// Semantics label for the main container displaying verses
  ///
  /// In en, this message translates to:
  /// **'Quran verse display area'**
  String get verseDisplayAreaLabel;

  /// Semantics label for the play audio icon button
  ///
  /// In en, this message translates to:
  /// **'Play ayah audio'**
  String get playAudioSemanticLabel;

  /// Semantics label for the icon button that opens the gratitude modal
  ///
  /// In en, this message translates to:
  /// **'Open gratitude modal'**
  String get openGratitudeSemanticLabel;

  /// Semantics label for the area displaying voice usage stats (PremiumPlus)
  ///
  /// In en, this message translates to:
  /// **'Voice usage in minutes'**
  String get voiceUsageSemanticLabel;

  /// Semantics label for the mic icon button in the text field suffix
  ///
  /// In en, this message translates to:
  /// **'Start or stop voice recording'**
  String get voiceRecordSemanticLabel;

  /// No description provided for @commentC.
  ///
  /// In en, this message translates to:
  /// **'New HOME screen strings'**
  String get commentC;

  /// Top bar title for the home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Shown if no active path is found
  ///
  /// In en, this message translates to:
  /// **'No valid paths available.'**
  String get noPathsLabel;

  /// Error message if fetching the active path fails
  ///
  /// In en, this message translates to:
  /// **'Error loading the active path: {err}'**
  String errorLoadingActivePath(Object err);

  /// Button label for navigating to the ThemeScreen when user finishes the path
  ///
  /// In en, this message translates to:
  /// **'Go to Theme'**
  String get verticalLessonIconsGoToTheme;

  /// Semantics label for tapping the path card
  ///
  /// In en, this message translates to:
  /// **'Tap to open theme screen'**
  String get homePathCardLabel;

  /// Semantics label for the forward arrow icon in the path card
  ///
  /// In en, this message translates to:
  /// **'Open details'**
  String get arrowForwardSemanticLabel;

  /// Shown if path doesn't track progress
  ///
  /// In en, this message translates to:
  /// **'This path does not track progress.'**
  String get noTrackProgressLabel;

  /// Shown if user is free tier but path tracks progress
  ///
  /// In en, this message translates to:
  /// **'Upgrade to unlock progress functionality. Support us make more features!'**
  String get premiumRequiredLabel;

  /// Suffix for e.g. 'xx% completed'
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completedLabel;

  /// Semantics label for the floating action button that logs gratitude
  ///
  /// In en, this message translates to:
  /// **'Tap to log gratitude'**
  String get fabLogGratitudeLabel;

  /// Snackbar prefix if lesson screen fails to open
  ///
  /// In en, this message translates to:
  /// **'Error navigating to lesson'**
  String get errorNavigatingToLesson;

  /// No description provided for @commentD.
  ///
  /// In en, this message translates to:
  /// **'Profile screen strings'**
  String get commentD;

  /// AppBar title for the profile screen
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// Semantics label for the back arrow on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Back to previous screen'**
  String get profileBackArrowLabel;

  /// Semantics label for the circle avatar showing user's initial
  ///
  /// In en, this message translates to:
  /// **'User avatar'**
  String get profileAvatarSemanticLabel;

  /// Hint text in the text field for user name
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get profileEnterYourName;

  /// Label describing the dropdown to select notification frequency
  ///
  /// In en, this message translates to:
  /// **'Notification Frequency'**
  String get nameEntryNotificationFrequencyDropdownLabel;

  /// Option in the dropdown indicating weekly reminders
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get nameEntryNotificationFrequencyWeekly;

  /// Option in the dropdown indicating no reminders
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get nameEntryNotificationFrequencyNone;

  /// Short explanation about why the app requests notification permissions
  ///
  /// In en, this message translates to:
  /// **'We’d like to send gentle reminders to complete your gratitude or lesson submissions - please allow notifications if you\'d like us to help build the habit 😃.'**
  String get notificationPermissionPrompt;

  /// Button label to save new user name
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileNameSave;

  /// Button label to cancel editing user name
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileNameCancel;

  /// Fallback name if user does not input anything
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get profileNameGuest;

  /// Button label to start editing user name
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profileNameEdit;

  /// Label above the language dropdown in the profile screen
  ///
  /// In en, this message translates to:
  /// **'Language:'**
  String get profilePreferredLanguage;

  /// Generic confirmation or acknowledgement button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okLabel;

  /// Label for the reciter dropdown in the Profile screen
  ///
  /// In en, this message translates to:
  /// **'Reciter'**
  String get profileReciterLabel;

  /// Label for the font dropdown in the Profile screen
  ///
  /// In en, this message translates to:
  /// **'Font:'**
  String get profileFontLabel;

  /// Display name for reciter #1
  ///
  /// In en, this message translates to:
  /// **'Mishary Rashid Al-Afasy'**
  String get profileReciterMishary;

  /// Display name for reciter #2
  ///
  /// In en, this message translates to:
  /// **'Abu Bakr Al-Shatri'**
  String get profileReciterShatri;

  /// Display name for reciter #3
  ///
  /// In en, this message translates to:
  /// **'Nasser Al Qatami'**
  String get profileReciterQatami;

  /// No description provided for @profileUpgradePremiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock More Personalization!'**
  String get profileUpgradePremiumTitle;

  /// No description provided for @profileUpgradePremiumBody.
  ///
  /// In en, this message translates to:
  /// **'You can enjoy changing fonts and reciters by upgrading to Pro. Support our continuous efforts and personalize your experience further!'**
  String get profileUpgradePremiumBody;

  /// Section heading for user's weekly progress
  ///
  /// In en, this message translates to:
  /// **'MashAllah, here is your week\'s progress:'**
  String get profileWeeksProgress;

  /// Header for the weekly gratitude calendar
  ///
  /// In en, this message translates to:
  /// **'Gratefulness Calendar'**
  String get profileGratefulnessCalendar;

  /// Header for the weekly lesson submission calendar
  ///
  /// In en, this message translates to:
  /// **'Quran Learning Calendar'**
  String get profileQuranLearningCalendar;

  /// Semantics label for the left arrow that navigates to the previous week
  ///
  /// In en, this message translates to:
  /// **'Go to previous week'**
  String get profilePrevWeekSemantic;

  /// Semantics label for the right arrow that navigates to the next week
  ///
  /// In en, this message translates to:
  /// **'Go to next week'**
  String get profileNextWeekSemantic;

  /// Label above the notification frequency dropdown in the profile screen
  ///
  /// In en, this message translates to:
  /// **'Notification Frequency'**
  String get profileNotificationFrequency;

  /// No description provided for @commentE.
  ///
  /// In en, this message translates to:
  /// **'Gratitude Log Screen strings'**
  String get commentE;

  /// Title for the gratitude log app bar
  ///
  /// In en, this message translates to:
  /// **'My Gratitude Log'**
  String get gratitudeLogTitle;

  /// Semantics label for the back arrow in the gratitude log
  ///
  /// In en, this message translates to:
  /// **'Go back to home'**
  String get gratitudeLogBackArrowSemantic;

  /// Semantics label for the delete icon in the gratitude log
  ///
  /// In en, this message translates to:
  /// **'Clear all gratitude entries'**
  String get gratitudeLogClearAllSemantic;

  /// Semantics label for the add icon in the gratitude log
  ///
  /// In en, this message translates to:
  /// **'Add new gratitude entry'**
  String get gratitudeLogAddSemantic;

  /// Dialog title for confirming clearing all gratitude entries
  ///
  /// In en, this message translates to:
  /// **'Clear Gratitude Log'**
  String get gratitudeLogClearDialogTitle;

  /// Dialog body text for clearing all gratitude entries
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all your gratitude entries? This action cannot be undone.'**
  String get gratitudeLogClearDialogBody;

  /// Button label to confirm clearing all entries
  ///
  /// In en, this message translates to:
  /// **'Yes, Clear'**
  String get gratitudeLogClearConfirm;

  /// Displayed streak line, e.g. 3 days in a row
  ///
  /// In en, this message translates to:
  /// **'⭐ Gratitude Streak: {days} days'**
  String gratitudeLogStreak(Object days);

  /// Shown while the streak data is loading
  ///
  /// In en, this message translates to:
  /// **'Calculating streak...'**
  String get gratitudeLogStreakLoading;

  /// Error text if streak data fails
  ///
  /// In en, this message translates to:
  /// **'Failed to calculate streak.'**
  String get gratitudeLogStreakError;

  /// Total distinct days user has logged gratitude
  ///
  /// In en, this message translates to:
  /// **'Total Gratitude Days: {count}'**
  String gratitudeLogTotalDays(Object count);

  /// Shown while gratitude data is being loaded
  ///
  /// In en, this message translates to:
  /// **'Loading gratitude data...'**
  String get gratitudeLogDataLoading;

  /// Error text if we fail to load gratitude data
  ///
  /// In en, this message translates to:
  /// **'Failed to load gratitude data.'**
  String get gratitudeLogDataError;

  /// Semantics label for each gratitude card in the list
  ///
  /// In en, this message translates to:
  /// **'Gratitude entry card'**
  String get gratitudeLogCardSemantic;

  /// Semantics label for the heart icon next to each item
  ///
  /// In en, this message translates to:
  /// **'Gratitude icon'**
  String get gratitudeLogItemIcon;

  /// Semantics label for big orange icon on empty screen
  ///
  /// In en, this message translates to:
  /// **'Tap to add your first gratitude'**
  String get gratitudeLogEmptyIconSemantic;

  /// Instructions shown if the log is empty
  ///
  /// In en, this message translates to:
  /// **'No gratitude entries yet.\nTap the “+” to add your first gratitude!'**
  String get gratitudeLogEmptyMessage;

  /// Snackbar text if adding a new gratitude was successful
  ///
  /// In en, this message translates to:
  /// **'Gratitudes added successfully!'**
  String get gratitudeLogEntriesAdded;

  /// Snackbar text if adding a new gratitude failed
  ///
  /// In en, this message translates to:
  /// **'Failed to add gratitudes. Please try again.'**
  String get gratitudeLogEntriesFailed;

  /// No description provided for @commentF.
  ///
  /// In en, this message translates to:
  /// **'Lesson Completion Screen strings'**
  String get commentF;

  /// AppBar title for the Lesson Completion screen
  ///
  /// In en, this message translates to:
  /// **'Lesson Completed'**
  String get lessonCompletedTitle;

  /// Semantics label for the back arrow on the lesson completion screen
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get lessonCompletedBackArrowSemantic;

  /// Large congratulatory text
  ///
  /// In en, this message translates to:
  /// **'MashaAllah!'**
  String get lessonCompletedMashaAllah;

  /// Semantics label for the big green text
  ///
  /// In en, this message translates to:
  /// **'Congratulations text'**
  String get lessonCompletedMashaAllahSemantic;

  /// Subtitle indicating user finished the lesson
  ///
  /// In en, this message translates to:
  /// **'You have completed this lesson!'**
  String get lessonCompletedMessage;

  /// Semantics label for the displayed success image
  ///
  /// In en, this message translates to:
  /// **'Hudhud Quran illustration'**
  String get lessonCompletedImageSemantic;

  /// Semantics label for the 'Go Back to Path' button
  ///
  /// In en, this message translates to:
  /// **'Return to the path selection'**
  String get lessonCompletedGoBackSemantic;

  /// Button label to navigate back to path/home screen
  ///
  /// In en, this message translates to:
  /// **'Go Back to Path'**
  String get lessonCompletedGoBackButton;

  /// Semantics label for the 'Restart Lesson' button
  ///
  /// In en, this message translates to:
  /// **'Restart the lesson'**
  String get lessonCompletedRestartSemantic;

  /// Button label to restart the same lesson
  ///
  /// In en, this message translates to:
  /// **'Restart Lesson'**
  String get lessonCompletedRestartButton;

  /// Final encouraging text at the bottom
  ///
  /// In en, this message translates to:
  /// **'Keep up the great work!'**
  String get lessonCompletedEncouragement;

  /// No description provided for @commentG.
  ///
  /// In en, this message translates to:
  /// **'Theme Screen strings'**
  String get commentG;

  /// Top bar title for the theme screen
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themeScreenTitle;

  /// Name of the theme with Surah Fatiha, Ikhlas, etc.
  ///
  /// In en, this message translates to:
  /// **'Core Daily Recitation'**
  String get themeNameCoreRecitation;

  /// Name of the short-surah theme for new reciters
  ///
  /// In en, this message translates to:
  /// **'Beginning the Journey'**
  String get themeNameBeginJourney;

  /// Name of the theme focusing on Allah’s compassion and positivity
  ///
  /// In en, this message translates to:
  /// **'Mercy and Hope'**
  String get themeNameMercyAndHope;

  /// Name of the theme focusing on gratitude-based passages
  ///
  /// In en, this message translates to:
  /// **'Gratitude and Reflection'**
  String get themeNameGratitudeReflection;

  /// Name of the theme containing various narrative passages
  ///
  /// In en, this message translates to:
  /// **'Stories, Lessons, and Reminders'**
  String get themeNameStoriesReminders;

  /// Name of the theme focusing on perseverance/patience
  ///
  /// In en, this message translates to:
  /// **'Patience (Ṣabr)'**
  String get themeNamePatience;

  /// Name for the user-created custom theme
  ///
  /// In en, this message translates to:
  /// **'User Created'**
  String get themeNameUserCreated;

  /// Shown if no theme data is returned
  ///
  /// In en, this message translates to:
  /// **'No Themes Available'**
  String get themeScreenNoThemesLabel;

  /// Semantics label for the AppBar back arrow on the theme screen
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get themeScreenBackArrowSemantic;

  /// Semantics label for each theme card in the list
  ///
  /// In en, this message translates to:
  /// **'Tap to open theme\'s paths'**
  String get themeScreenThemeCardSemantic;

  /// Semantics label for the lock icon if the theme is locked
  ///
  /// In en, this message translates to:
  /// **'Theme locked. Requires upgrade.'**
  String get themeScreenLockIconSemantic;

  /// Button label that navigates to the Theme Screen for exploring other themes.
  ///
  /// In en, this message translates to:
  /// **'Explore Other Themes'**
  String get pathListExploreOtherThemes;

  /// Subtitle for user-created themes
  ///
  /// In en, this message translates to:
  /// **'Created by you—personalize it as you like.'**
  String get themeScreenUserCreatedSubtitle;

  /// Subtitle for theme_core_recitation
  ///
  /// In en, this message translates to:
  /// **'Essential surahs for daily prayers and protection.'**
  String get themeSubtitleCoreRecitation;

  /// Subtitle for theme_begin_journey
  ///
  /// In en, this message translates to:
  /// **'Short surahs for starting your Quranic journey.'**
  String get themeSubtitleBeginJourney;

  /// Subtitle for theme_mercy_and_hope
  ///
  /// In en, this message translates to:
  /// **'Reflect on Allah’s compassion and nurturing hope.'**
  String get themeSubtitleMercyAndHope;

  /// Subtitle for theme_gratitude_reflection
  ///
  /// In en, this message translates to:
  /// **'Cultivate thankfulness and introspection through selected ayahs.'**
  String get themeSubtitleGratitudeReflection;

  /// Subtitle for theme_stories_reminders
  ///
  /// In en, this message translates to:
  /// **'Explore Quranic narratives that guide and remind.'**
  String get themeSubtitleStoriesReminders;

  /// Subtitle for theme_patience
  ///
  /// In en, this message translates to:
  /// **'Surahs and passages emphasizing patience and perseverance.'**
  String get themeSubtitlePatience;

  /// Default subtitle if no known theme ID is matched
  ///
  /// In en, this message translates to:
  /// **'A dedicated set of surahs for deeper spiritual growth.'**
  String get themeSubtitleDefault;

  /// Label shown if a theme requires Premium subscription
  ///
  /// In en, this message translates to:
  /// **'Requires Premium'**
  String get themeScreenRequiredPremium;

  /// Label shown if a theme requires Premium Plus subscription
  ///
  /// In en, this message translates to:
  /// **'Requires Pro Beta'**
  String get themeScreenRequiredPremiumPlus;

  /// No description provided for @commentH.
  ///
  /// In en, this message translates to:
  /// **'Path List Screen strings'**
  String get commentH;

  /// AppBar title for the PathListScreen
  ///
  /// In en, this message translates to:
  /// **'Paths for Theme'**
  String get pathListScreenTitle;

  /// Semantics label for the app bar back arrow
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get pathListScreenBackArrowSemantic;

  /// Semantics label for the add icon in the AppBar
  ///
  /// In en, this message translates to:
  /// **'Add new path'**
  String get pathListScreenAddIconSemantic;

  /// Tooltip for the add-new-path IconButton
  ///
  /// In en, this message translates to:
  /// **'Add New Path'**
  String get pathListAddNewPathTooltip;

  /// Semantics label for the large add icon in the empty path screen
  ///
  /// In en, this message translates to:
  /// **'Tap to add your first path'**
  String get pathListScreenAddIconSemanticEmpty;

  /// Message shown if there are no existing paths
  ///
  /// In en, this message translates to:
  /// **'No paths yet.\nTap the “+” to create your first path!'**
  String get pathListEmptyMessage;

  /// Shown if the path is not valid
  ///
  /// In en, this message translates to:
  /// **'This path is currently unavailable'**
  String get pathListUnavailableLabel;

  /// Used after the themeName, e.g. '“Mercy” Theme'
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get pathListThemeLabel;

  /// Semantics label for each path card in the list
  ///
  /// In en, this message translates to:
  /// **'Tap to open path details'**
  String get pathListPathCardSemantic;

  /// Semantics label for the green check icon
  ///
  /// In en, this message translates to:
  /// **'Path complete'**
  String get pathListCompleteIconSemantic;

  /// Semantics label for the hourglass icon
  ///
  /// In en, this message translates to:
  /// **'Path in progress'**
  String get pathListInProgressIconSemantic;

  /// Semantics label for the red error icon
  ///
  /// In en, this message translates to:
  /// **'Path invalid or unavailable'**
  String get pathListInvalidIconSemantic;

  /// Prefix for an error message when path data fails
  ///
  /// In en, this message translates to:
  /// **'Error loading paths:'**
  String get pathListErrorLoadingPaths;

  /// No description provided for @commentI.
  ///
  /// In en, this message translates to:
  /// **'Path Detail Screen strings'**
  String get commentI;

  /// AppBar title for the Path Detail screen
  ///
  /// In en, this message translates to:
  /// **'Path Details'**
  String get pathDetailScreenTitle;

  /// Semantics label for the back arrow in the PathDetailScreen
  ///
  /// In en, this message translates to:
  /// **'Go back to path list'**
  String get pathDetailScreenBackArrowSemantic;

  /// Shown if we fail to retrieve the path
  ///
  /// In en, this message translates to:
  /// **'Path not found.'**
  String get pathDetailScreenNotFound;

  /// Snackbar prefix if updating path progress fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update path progress:'**
  String get pathDetailScreenFailToUpdate;

  /// Shown if path.tracksProgress == false
  ///
  /// In en, this message translates to:
  /// **'Progress disabled for this path.'**
  String get pathDetailScreenProgressDisabled;

  /// Heading text above the lesson list
  ///
  /// In en, this message translates to:
  /// **'Lessons:'**
  String get pathDetailScreenLessonsHeading;

  /// Shown if the path has zero lessons
  ///
  /// In en, this message translates to:
  /// **'No lessons available.'**
  String get pathDetailScreenNoLessonsLabel;

  /// Prefix for error messages in path detail screen
  ///
  /// In en, this message translates to:
  /// **'Error loading path or lessons:'**
  String get pathDetailScreenErrorLoading;

  /// Semantics label for each lesson card in the path detail list
  ///
  /// In en, this message translates to:
  /// **'Tap to open lesson details'**
  String get pathDetailScreenLessonCardSemantic;

  /// Semantics label for the green check icon in a completed lesson
  ///
  /// In en, this message translates to:
  /// **'Lesson complete'**
  String get pathDetailScreenLessonCompleteIconSemantic;

  /// Semantics label for the hourglass icon in an incomplete lesson
  ///
  /// In en, this message translates to:
  /// **'Lesson in progress'**
  String get pathDetailScreenLessonInProgressIconSemantic;

  /// Semantics label for the red error icon in an invalid lesson
  ///
  /// In en, this message translates to:
  /// **'Lesson invalid or unavailable'**
  String get pathDetailScreenLessonInvalidIconSemantic;

  /// Subtitle if the lesson is invalid
  ///
  /// In en, this message translates to:
  /// **'Progress unavailable'**
  String get pathDetailScreenLessonProgressUnavailable;

  /// Subtitle if path doesn't track progress
  ///
  /// In en, this message translates to:
  /// **'No progress for this path'**
  String get pathDetailScreenLessonNoProgress;

  /// Subtitle if user can't see lesson progress
  ///
  /// In en, this message translates to:
  /// **'Upgrade for progress functionality.'**
  String get pathDetailScreenLessonUpgrade;

  /// Subtitle for lesson item showing progress e.g. 'Progress: 42%'
  ///
  /// In en, this message translates to:
  /// **'Progress: {progress}%'**
  String pathDetailScreenLessonProgressLabel(Object progress);

  /// Title for each lesson item in path detail list
  ///
  /// In en, this message translates to:
  /// **'Lesson {lessonIndex}: {surahName} - Ayah {startAyah}-{endAyah}'**
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah);

  /// No description provided for @commentJ.
  ///
  /// In en, this message translates to:
  /// **'Create Path Screen strings'**
  String get commentJ;

  /// AppBar title for the create path screen
  ///
  /// In en, this message translates to:
  /// **'Create New Path'**
  String get createPathTitle;

  /// Semantics label for the back arrow on the create path screen
  ///
  /// In en, this message translates to:
  /// **'Back to previous screen'**
  String get createPathBackArrowSemantic;

  /// Label text for path name textfield
  ///
  /// In en, this message translates to:
  /// **'Path Name'**
  String get createPathNameLabel;

  /// Validation message if path name is empty
  ///
  /// In en, this message translates to:
  /// **'Enter a path name'**
  String get createPathNameValidation;

  /// Label text for description textfield
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get createPathDescriptionLabel;

  /// Validation message if description is empty
  ///
  /// In en, this message translates to:
  /// **'Enter a description'**
  String get createPathDescriptionValidation;

  /// Heading above the Surah dropdown or selector
  ///
  /// In en, this message translates to:
  /// **'Select Surah:'**
  String get createPathSurahSelectorLabel;

  /// Label for the start ayah textfield
  ///
  /// In en, this message translates to:
  /// **'Start Ayah'**
  String get createPathStartAyahLabel;

  /// Label for the dropdown picking how many ayahs to include
  ///
  /// In en, this message translates to:
  /// **'Number of Ayahs in the Path'**
  String get createPathNumAyahsLabel;

  /// Label for the read-only textfield showing the end ayah
  ///
  /// In en, this message translates to:
  /// **'End Ayah'**
  String get createPathEndAyahLabel;

  /// Label for the dropdown picking words per lesson
  ///
  /// In en, this message translates to:
  /// **'Words per Lesson'**
  String get createPathWordsPerLessonLabel;

  /// Suffix for the words-per-lesson dropdown
  ///
  /// In en, this message translates to:
  /// **'words'**
  String get createPathWordsSuffix;

  /// Text for the number-of-ayahs dropdown if the range is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid range'**
  String get createPathInvalidRange;

  /// Suffix for the number-of-ayahs dropdown, e.g. '15 Ayahs'
  ///
  /// In en, this message translates to:
  /// **'Ayahs'**
  String get createPathAyahsSuffix;

  /// Label for the button that creates the path
  ///
  /// In en, this message translates to:
  /// **'Create Path'**
  String get createPathCreateButton;

  /// Semantics label for the create path button
  ///
  /// In en, this message translates to:
  /// **'Tap to create path'**
  String get createPathSubmitSemantic;

  /// No description provided for @commentK.
  ///
  /// In en, this message translates to:
  /// **'Translation Screen strings'**
  String get commentK;

  /// AppBar title for the translation screen
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translationScreenTitle;

  /// Semantics label for the back arrow in translation screen
  ///
  /// In en, this message translates to:
  /// **'Return to lesson'**
  String get translationScreenBackArrowSemantic;

  /// Semantics label for the CircularProgressIndicator while translations load
  ///
  /// In en, this message translates to:
  /// **'Loading translations'**
  String get translationScreenLoadingSemantic;

  /// Shown if no translations are returned
  ///
  /// In en, this message translates to:
  /// **'No translations available.'**
  String get translationScreenNoTranslations;

  /// Button text for going back to the Lesson screen
  ///
  /// In en, this message translates to:
  /// **'Return to Lesson'**
  String get translationScreenReturnButton;

  /// Semantics label for the button returning to the Lesson screen
  ///
  /// In en, this message translates to:
  /// **'Tap to return to lesson'**
  String get translationScreenReturnSemantic;

  /// Snackbar prefix if we fail to load translations
  ///
  /// In en, this message translates to:
  /// **'Error loading translations:'**
  String get translationScreenLoadError;

  /// No description provided for @commentL.
  ///
  /// In en, this message translates to:
  /// **'Language Selection Screen strings'**
  String get commentL;

  /// Semantics label for the top-level container describing the language selection screen
  ///
  /// In en, this message translates to:
  /// **'Language Selection Screen'**
  String get languageSelectionScreenSemantic;

  /// AppBar title for the language selection screen
  ///
  /// In en, this message translates to:
  /// **'Select Your Language'**
  String get languageSelectionTitle;

  /// Semantics label for the back arrow in the language selection screen
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get languageSelectionBackSemantic;

  /// Semantics label for the skip text button in the language selection screen
  ///
  /// In en, this message translates to:
  /// **'Skip selection'**
  String get languageSelectionSkipSemantic;

  /// Instruction text for choosing a language
  ///
  /// In en, this message translates to:
  /// **'Please choose your preferred language:'**
  String get languageSelectionInstructions;

  /// Semantics label for the Next button in the language selection screen
  ///
  /// In en, this message translates to:
  /// **'Tap to confirm language choice'**
  String get languageSelectionNextSemantic;

  /// Button text for proceeding after choosing a language
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get languageSelectionNextLabel;

  /// Semantics label for the bottom image in the language selection screen
  ///
  /// In en, this message translates to:
  /// **'Hudhud Quran illustration'**
  String get languageSelectionImageSemantic;

  /// No description provided for @commentM.
  ///
  /// In en, this message translates to:
  /// **'Welcome Screen strings'**
  String get commentM;

  /// Semantics label for the main container describing the onboarding welcome screen
  ///
  /// In en, this message translates to:
  /// **'Onboarding Welcome Screen'**
  String get welcomeScreenSemantic;

  /// Semantics label for the welcome screen logo image
  ///
  /// In en, this message translates to:
  /// **'Hudhud Quran illustration'**
  String get welcomeScreenLogoSemantic;

  /// Semantics label for the skip button in the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Skip the welcome step'**
  String get welcomeScreenSkipSemantic;

  /// Semantics label for the 'Get Started' button
  ///
  /// In en, this message translates to:
  /// **'Proceed to next onboarding step'**
  String get welcomeScreenNextSemantic;

  /// No description provided for @commentN.
  ///
  /// In en, this message translates to:
  /// **'Hudhud Info Screen strings'**
  String get commentN;

  /// Semantics label for the top-level container describing the Hudhud info screen
  ///
  /// In en, this message translates to:
  /// **'Hudhud Information Screen'**
  String get hudhudInfoSemantic;

  /// Shown in the app bar for the Hudhud info screen
  ///
  /// In en, this message translates to:
  /// **'Meet Hudhud'**
  String get hudhudInfoAppBarTitle;

  /// Semantics label for the bird's illustration image
  ///
  /// In en, this message translates to:
  /// **'Hudhud illustration'**
  String get hudhudInfoIllustrationSemantic;

  /// First paragraph describing Hudhud's significance
  ///
  /// In en, this message translates to:
  /// **'Hudhud, also known as the hoopoe bird, played a special role in helping Prophet Suleiman [AS] by observing and carrying messages.'**
  String get hudhudInfoBody1;

  /// Second paragraph describing significance of being watchful
  ///
  /// In en, this message translates to:
  /// **'Hudhud’s story reminds us that even a small creature can have a big impact by being observant, curious, and proactive about the right things. In our journey, we can place our consistent attention on the beauty of the Quran, and integrate gratitude reminders to appreciate each moment of progress.'**
  String get hudhudInfoBody2;

  /// Third paragraph describing the overall goal of following Hudhud's example
  ///
  /// In en, this message translates to:
  /// **'By following Hudhud’s example—staying watchful and engaged—we hope to deepen our connection to the Quran and foster a sense of gratitude in everyday life.'**
  String get hudhudInfoBody3;

  /// Label text for the Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get hudhudInfoNextLabel;

  /// Semantics label for the Next button
  ///
  /// In en, this message translates to:
  /// **'Proceed to next section'**
  String get hudhudInfoNextSemantic;

  /// Semantics label for the skip button in the Hudhud info screen
  ///
  /// In en, this message translates to:
  /// **'Skip the Hudhud info step'**
  String get hudhudInfoSkipSemantic;

  /// No description provided for @commentO.
  ///
  /// In en, this message translates to:
  /// **'Subscription Tier Screen strings'**
  String get commentO;

  /// Semantics label for the main container describing the subscription tier screen
  ///
  /// In en, this message translates to:
  /// **'Subscription Tier Selection Screen'**
  String get subscriptionTierScreenSemantic;

  /// AppBar title for the subscription tier screen
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan'**
  String get subscriptionTierScreenAppBarTitle;

  /// Semantics label for the skip button in the subscription tier screen
  ///
  /// In en, this message translates to:
  /// **'Skip subscription tier selection'**
  String get subscriptionTierScreenSkipSemantic;

  /// Label for the Free tier
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get subscriptionTierScreenFreeLabel;

  /// Semantics label for the smiley emoji icon
  ///
  /// In en, this message translates to:
  /// **'Smiley face icon'**
  String get subscriptionTierScreenSmileySemantic;

  /// Text shown under the smiley face about donation usage
  ///
  /// In en, this message translates to:
  /// **'A portion of the funds will go to the Almubtasim Initiative, helping orphans through Islamic Relief.'**
  String get subscriptionTierScreenDonationText;

  /// Semantics label for the Next/Confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm subscription tier selection'**
  String get subscriptionTierScreenConfirmSemantic;

  /// Button label to confirm and proceed with the selected subscription tier
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get subscriptionTierScreenNextLabel;

  /// Semantics label for each radio tile representing a subscription tier
  ///
  /// In en, this message translates to:
  /// **'Tap to select the {title} subscription tier'**
  String subscriptionTierScreenRadioSemantic(Object title);

  /// No description provided for @commentP.
  ///
  /// In en, this message translates to:
  /// **'Goal Selection Screen strings'**
  String get commentP;

  /// Semantics label for the main container describing the goal selection screen
  ///
  /// In en, this message translates to:
  /// **'Goal Selection Screen'**
  String get goalSelectionScreenSemantic;

  /// AppBar title text for the goal selection screen
  ///
  /// In en, this message translates to:
  /// **'Select Your Goals'**
  String get goalSelectionScreenAppBarTitle;

  /// Semantics label for the skip button in the goal selection screen
  ///
  /// In en, this message translates to:
  /// **'Skip goal selection'**
  String get goalSelectionScreenSkipSemantic;

  /// Introductory text displayed at the top of the goal selection screen
  ///
  /// In en, this message translates to:
  /// **'Which of the following goals interest you? You can select multiple options.'**
  String get goalSelectionScreenIntroText;

  /// Semantics label for the Next/Confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm goal selections'**
  String get goalSelectionScreenNextSemantic;

  /// Button label to confirm and proceed with the selected goals
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get goalSelectionScreenNextLabel;

  /// Semantics label for each goal's checkbox tile
  ///
  /// In en, this message translates to:
  /// **'Tap to select or unselect the {goalTitle} goal option'**
  String goalSelectionTileSemantic(Object goalTitle);

  /// Checkbox label for the 'connectQuran' goal
  ///
  /// In en, this message translates to:
  /// **'Connect further with the Quran'**
  String get goalConnectQuranTitle;

  /// Subtitle text for the 'connectQuran' goal
  ///
  /// In en, this message translates to:
  /// **'Enhance your relationship through reading or reflection.'**
  String get goalConnectQuranDesc;

  /// Checkbox label for the 'memorizeQuran' goal
  ///
  /// In en, this message translates to:
  /// **'Memorize the Quran'**
  String get goalMemorizeQuranTitle;

  /// Subtitle text for the 'memorizeQuran' goal
  ///
  /// In en, this message translates to:
  /// **'Embark on a memorization journey.'**
  String get goalMemorizeQuranDesc;

  /// Checkbox label for the 'beMoreGrateful' goal
  ///
  /// In en, this message translates to:
  /// **'Be more grateful and happy in life'**
  String get goalBeMoreGratefulTitle;

  /// Subtitle text for the 'beMoreGrateful' goal
  ///
  /// In en, this message translates to:
  /// **'Focus on everyday gratitude practices.'**
  String get goalBeMoreGratefulDesc;

  /// Checkbox label for the 'buildConsistency' goal
  ///
  /// In en, this message translates to:
  /// **'Build consistency'**
  String get goalBuildConsistencyTitle;

  /// Subtitle text for the 'buildConsistency' goal
  ///
  /// In en, this message translates to:
  /// **'Develop a daily or weekly habit.'**
  String get goalBuildConsistencyDesc;

  /// Checkbox label for the 'improveArabic' goal
  ///
  /// In en, this message translates to:
  /// **'Improve my Arabic'**
  String get goalImproveArabicTitle;

  /// Subtitle text for the 'improveArabic' goal
  ///
  /// In en, this message translates to:
  /// **'Focus on written or spoken language skills.'**
  String get goalImproveArabicDesc;

  /// Checkbox label for the 'deepenTafsir' goal
  ///
  /// In en, this message translates to:
  /// **'Deepen Tafsir'**
  String get goalDeepenTafsirTitle;

  /// Subtitle text for the 'deepenTafsir' goal
  ///
  /// In en, this message translates to:
  /// **'Study commentary and the deeper meanings of the Quran.'**
  String get goalDeepenTafsirDesc;

  /// Checkbox label for the 'other' goal
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get goalOtherTitle;

  /// Subtitle text for the 'other' goal
  ///
  /// In en, this message translates to:
  /// **'Pursue any other personal objective.'**
  String get goalOtherDesc;

  /// No description provided for @commentQ.
  ///
  /// In en, this message translates to:
  /// **'Level Selection Screen strings'**
  String get commentQ;

  /// Semantics label for the top-level container describing the level selection screen
  ///
  /// In en, this message translates to:
  /// **'Level Selection Screen'**
  String get levelSelectionScreenSemantic;

  /// AppBar title text for the level selection screen
  ///
  /// In en, this message translates to:
  /// **'Select Your Level'**
  String get levelSelectionScreenAppBarTitle;

  /// Semantics label for the skip button in the level selection screen
  ///
  /// In en, this message translates to:
  /// **'Skip level selection'**
  String get levelSelectionScreenSkipSemantic;

  /// Introductory text displayed at the top of the level selection screen
  ///
  /// In en, this message translates to:
  /// **'Please select the option that best describes your current recitation level:'**
  String get levelSelectionScreenIntroText;

  /// Radio label for the 'starter' level
  ///
  /// In en, this message translates to:
  /// **'Starter'**
  String get levelStarterLabel;

  /// Description for the 'starter' level
  ///
  /// In en, this message translates to:
  /// **'New or casual learner, beginning to explore Quran recitation.'**
  String get levelStarterDescription;

  /// Radio label for the 'advanced' level
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get levelAdvancedLabel;

  /// Description for the 'advanced' level
  ///
  /// In en, this message translates to:
  /// **'Comfortable reading Arabic script with some tajweed knowledge.'**
  String get levelAdvancedDescription;

  /// Radio label for the 'qari' level
  ///
  /// In en, this message translates to:
  /// **'Qari'**
  String get levelQariLabel;

  /// Description for the 'qari' level
  ///
  /// In en, this message translates to:
  /// **'Skilled in recitation with strong tajweed proficiency.'**
  String get levelQariDescription;

  /// Semantics label for the Next/Confirm button in the level selection screen
  ///
  /// In en, this message translates to:
  /// **'Confirm level selection'**
  String get levelSelectionNextSemantic;

  /// Button label to confirm and proceed with the selected level
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get levelSelectionNextLabel;

  /// Semantics label for each radio tile representing a recitation level
  ///
  /// In en, this message translates to:
  /// **'Tap to select the {levelTitle} recitation level option'**
  String levelSelectionTileSemantic(Object levelTitle);

  /// No description provided for @commentR.
  ///
  /// In en, this message translates to:
  /// **'Onboarding Completion Screen strings'**
  String get commentR;

  /// Semantics label for the main container describing the final onboarding completion screen
  ///
  /// In en, this message translates to:
  /// **'Onboarding Completion Screen'**
  String get onboardingCompletionScreenSemantic;

  /// AppBar title text for the onboarding completion screen
  ///
  /// In en, this message translates to:
  /// **'All Set!'**
  String get onboardingCompletionScreenAppBarTitle;

  /// Semantics label for the final onboarding image
  ///
  /// In en, this message translates to:
  /// **'Hudhud Quran illustration'**
  String get onboardingCompletionScreenImageSemantic;

  /// First paragraph describing the successful completion of onboarding
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You\'ve successfully completed the setup. We hope this journey will bring you closer to the Quran and enhance your gratitude to Allah. \n \nMay this app be a source of growth and blessings in your life and those you touch.'**
  String get onboardingCompletionScreenBody1;

  /// Second paragraph describing next steps after onboarding
  ///
  /// In en, this message translates to:
  /// **'Whenever you\'re ready, tap the button below to proceed. The main memorization and progress features are waiting, and you can log your gratitude or choose a path from the Navbar.'**
  String get onboardingCompletionScreenBody2;

  /// Third paragraph encouraging updates and potential support
  ///
  /// In en, this message translates to:
  /// **'This is an early version — we appreciate your support and patience and hope to give even more features very soon inshAllah!'**
  String get onboardingCompletionScreenBody3;

  /// Semantics label for the 'Let's Begin' button
  ///
  /// In en, this message translates to:
  /// **'Begin using the app'**
  String get onboardingCompletionScreenBeginSemantic;

  /// Button label text for final step in onboarding
  ///
  /// In en, this message translates to:
  /// **'Let\'s Begin'**
  String get onboardingCompletionScreenBeginLabel;

  /// No description provided for @commentS.
  ///
  /// In en, this message translates to:
  /// **'Name Entry Screen strings'**
  String get commentS;

  /// Semantics label for the container describing the name entry screen
  ///
  /// In en, this message translates to:
  /// **'Name Entry Screen'**
  String get nameEntryScreenSemantic;

  /// AppBar title for the name entry screen
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get nameEntryScreenAppBarTitle;

  /// Semantics label for the skip button on the name entry screen
  ///
  /// In en, this message translates to:
  /// **'Skip entering your name'**
  String get nameEntryScreenSkipSemantic;

  /// Instruction text explaining the user can input their name or leave blank to remain 'Guest'
  ///
  /// In en, this message translates to:
  /// **'What is your name? '**
  String get nameEntryScreenIntroText;

  /// Semantics label for the text field where user enters name
  ///
  /// In en, this message translates to:
  /// **'Name input text field'**
  String get nameEntryTextFieldSemantic;

  /// Semantics label for the Next/Confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm name entry'**
  String get nameEntryNextSemantic;

  /// Button label for finalizing name entry
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nameEntryNextLabel;

  /// No description provided for @commentT.
  ///
  /// In en, this message translates to:
  /// **'VerticalLessonIcons strings'**
  String get commentT;

  /// Semantics label for the top-level container describing the vertical lesson icons stack
  ///
  /// In en, this message translates to:
  /// **'Vertical Lesson Icons Container'**
  String get verticalLessonIconsSemantic;

  /// Fallback text if we have zero lessons
  ///
  /// In en, this message translates to:
  /// **'No lessons found.'**
  String get verticalLessonIconsNoLessons;

  /// Semantics label for the CircularProgressIndicator while surah details load
  ///
  /// In en, this message translates to:
  /// **'Loading Surah details'**
  String get verticalLessonIconsLoadingSurah;

  /// Shown if there's an error getting the surah header details
  ///
  /// In en, this message translates to:
  /// **'Error loading surah details'**
  String get verticalLessonIconsErrorSurah;

  /// Semantics label for the surah header text on the first page
  ///
  /// In en, this message translates to:
  /// **'Surah details header'**
  String get verticalLessonIconsSurahHeaderSemantic;

  /// Semantics label for the hudhud_left icon
  ///
  /// In en, this message translates to:
  /// **'Hudhud helper icon'**
  String get verticalLessonIconsHudhudIconSemantic;

  /// Semantics label for the arrow down that goes to next page
  ///
  /// In en, this message translates to:
  /// **'Next page arrow'**
  String get verticalLessonIconsNextPageSemantic;

  /// Semantics label for the arrow up that goes to previous page
  ///
  /// In en, this message translates to:
  /// **'Previous page arrow'**
  String get verticalLessonIconsPreviousPageSemantic;

  /// Semantics label for the CircularProgressIndicator while lesson progress loads
  ///
  /// In en, this message translates to:
  /// **'Loading lesson progress'**
  String get verticalLessonIconsLoadingProgress;

  /// Fallback text if there's an error loading the lesson's progress
  ///
  /// In en, this message translates to:
  /// **'Error loading progress'**
  String get verticalLessonIconsErrorProgress;

  /// Semantics label for each lesson icon on the vertical list
  ///
  /// In en, this message translates to:
  /// **'Lesson icon, {surahAyahRange}, progress is {percent}%'**
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent);

  /// Semantics label for the check mark icon over a fully-completed lesson
  ///
  /// In en, this message translates to:
  /// **'Lesson completed'**
  String get verticalLessonIconsCompletedSemantic;

  /// Title for the support & upgrade dialog
  ///
  /// In en, this message translates to:
  /// **'Support & Upgrade'**
  String get verticalLessonIconsDialogTitle;

  /// OK button text in the upgrade dialog
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get verticalLessonIconsDialogOk;

  /// No description provided for @commentU.
  ///
  /// In en, this message translates to:
  /// **'Navbar strings'**
  String get commentU;

  /// Semantics label for the entire bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Bottom navigation bar'**
  String get navBarSemanticLabel;

  /// Label for the Home tab in the navbar
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHomeLabel;

  /// Semantics label for the Home icon in the navbar
  ///
  /// In en, this message translates to:
  /// **'Home tab'**
  String get navHomeSemantic;

  /// Label for the Quran tab in the navbar
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get navQuranLabel;

  /// Semantics label for the Quran icon in the navbar
  ///
  /// In en, this message translates to:
  /// **'Quran tab'**
  String get navQuranSemantic;

  /// Label for the Gratitude tab in the navbar
  ///
  /// In en, this message translates to:
  /// **'Gratitude'**
  String get navGratitudeLabel;

  /// Semantics label for the Gratitude icon in the navbar
  ///
  /// In en, this message translates to:
  /// **'Gratitude tab'**
  String get navGratitudeSemantic;

  /// Label for the Profile tab in the navbar
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfileLabel;

  /// Semantics label for the Profile icon in the navbar
  ///
  /// In en, this message translates to:
  /// **'Profile tab'**
  String get navProfileSemantic;

  /// No description provided for @commentV.
  ///
  /// In en, this message translates to:
  /// **'TopBar strings'**
  String get commentV;

  /// Semantics label for the entire top bar container
  ///
  /// In en, this message translates to:
  /// **'Top navigation bar'**
  String get topBarSemanticLabel;

  /// Semantics label for the top bar's center title text
  ///
  /// In en, this message translates to:
  /// **'Top bar title: {title}'**
  String topBarTitleSemantic(Object title);

  /// Semantics label for the streak icon showing streak days
  ///
  /// In en, this message translates to:
  /// **'Streak icon: {days} days'**
  String topBarStreakIconSemantic(Object days);

  /// Dialog body text explaining streak usage
  ///
  /// In en, this message translates to:
  /// **'This shows how many consecutive days you\'ve recited or written a gratitude. Keep it going to maintain or grow your streak!'**
  String get topBarStreakDialogBody;

  /// Semantics label for the Hudhud icon on the top bar
  ///
  /// In en, this message translates to:
  /// **'Hudhud icon, tap for support'**
  String get topBarHudhudIconSemantic;

  /// Dialog title for the Hudhud icon's support + upgrade
  ///
  /// In en, this message translates to:
  /// **'Support & Upgrade'**
  String get topBarHudhudDialogTitle;

  /// Dialog body text for the top bar's 'Support & Upgrade' prompt
  ///
  /// In en, this message translates to:
  /// **'All features are in the free version, but if you would like you can support us in building more features. Part of your subscription is donated to Islamic Relief. Jazāk Allāhu Khayran!'**
  String get topBarHudhudDialogBody;

  /// No description provided for @commentW.
  ///
  /// In en, this message translates to:
  /// **'Gratitude Modal strings'**
  String get commentW;

  /// Semantics label for the entire Gratitude Modal container
  ///
  /// In en, this message translates to:
  /// **'Gratitude Modal Dialog'**
  String get gratitudeModalSemantic;

  /// Title text at the top of the gratitude modal
  ///
  /// In en, this message translates to:
  /// **'What are you grateful for today based on these verses?'**
  String get gratitudeModalTitle;

  /// Hint text in the gratitude text fields
  ///
  /// In en, this message translates to:
  /// **'Alhamdulilah for (enter gratitude) #{index}'**
  String gratitudeModalHint(Object index);

  /// Semantics label for the i-th text field in the gratitude modal
  ///
  /// In en, this message translates to:
  /// **'Enter gratitude #{index}'**
  String gratitudeModalTextFieldSemantic(Object index);

  /// Shown if user tries to submit an empty gratitude modal
  ///
  /// In en, this message translates to:
  /// **'Please enter at least one gratitude.'**
  String get gratitudeModalEmptyWarning;

  /// Error message if gratitude submission fails
  ///
  /// In en, this message translates to:
  /// **'Failed to log gratitude. Please try again.'**
  String get gratitudeModalSubmitError;

  /// Title for daily voice-limit popup
  ///
  /// In en, this message translates to:
  /// **'MashaAllah!'**
  String get dailyVoiceLimitReachedTitle;

  /// Message shown when the user reaches 10 min of voice usage
  ///
  /// In en, this message translates to:
  /// **'You have completed 10 minutes of Quran voice recitation. Please continue to review by writing, and continue reciting tomorrow.'**
  String get dailyVoiceLimitReachedMessage;

  /// Dialog title prompting user to upgrade after free voice usage is exhausted
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeVoiceUsageTitle;

  /// Semantics label for the loading spinner if submission is in progress
  ///
  /// In en, this message translates to:
  /// **'Gratitude submission in progress'**
  String get gratitudeModalLoadingSemantic;

  /// No description provided for @commentX.
  ///
  /// In en, this message translates to:
  /// **'== NEW KEYS for submission_feedback_modal, progress_bar, surah_selector =='**
  String get commentX;

  /// Semantics label for the entire submission feedback modal
  ///
  /// In en, this message translates to:
  /// **'Submission feedback dialog'**
  String get submissionFeedbackModalSemanticLabel;

  /// AlertDialog title for the feedback modal
  ///
  /// In en, this message translates to:
  /// **'Submission Feedback'**
  String get submissionFeedbackModalTitle;

  /// Message shown when there were no new gratitudes
  ///
  /// In en, this message translates to:
  /// **'No new gratitudes were submitted.'**
  String get submissionFeedbackModalNoNew;

  /// Label above the list of just-submitted gratitudes
  ///
  /// In en, this message translates to:
  /// **'You submitted these gratitudes:'**
  String get submissionFeedbackModalYouSubmitted;

  /// Shows the current consecutive gratitude streak
  ///
  /// In en, this message translates to:
  /// **'Current gratitude streak: {days} days'**
  String submissionFeedbackModalStreak(Object days);

  /// Shows total distinct days of gratitude logged
  ///
  /// In en, this message translates to:
  /// **'Total gratitude days: {count}'**
  String submissionFeedbackModalTotalDays(Object count);

  /// Shown while waiting for gratitude data
  ///
  /// In en, this message translates to:
  /// **'Loading your gratitude data...'**
  String get submissionFeedbackModalLoading;

  /// Shown if there's an error loading the gratitude data
  ///
  /// In en, this message translates to:
  /// **'Could not load gratitude data.'**
  String get submissionFeedbackModalError;

  /// Button text to go to the gratitude log screen
  ///
  /// In en, this message translates to:
  /// **'View Log'**
  String get submissionFeedbackModalViewLog;

  /// Button text to close the submission feedback modal
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get submissionFeedbackModalClose;

  /// Semantics label for the linear progress bar, includes the numeric percentage
  ///
  /// In en, this message translates to:
  /// **'Progress: {percent}%'**
  String progressBarSemanticLabel(Object percent);

  /// Semantics label for the dropdown that allows picking a Surah
  ///
  /// In en, this message translates to:
  /// **'Select a Surah'**
  String get surahSelectorSemanticLabel;

  /// No description provided for @commentZ.
  ///
  /// In en, this message translates to:
  /// **'Localizable Path Names & Descriptions for system-defined paths'**
  String get commentZ;

  /// Name for path_fatihah
  ///
  /// In en, this message translates to:
  /// **'Surah Al-Fātiḥah'**
  String get pathNameFatihah;

  /// Description for path_fatihah
  ///
  /// In en, this message translates to:
  /// **'Entire Surah (1:1–7). Essential for each rakʿah.'**
  String get pathDescFatihah;

  /// Name for path_kafirun
  ///
  /// In en, this message translates to:
  /// **'Surah Al-Kāfirūn'**
  String get pathNameKafirun;

  /// Description for path_kafirun
  ///
  /// In en, this message translates to:
  /// **'Entire Surah (109:1–6). Statement of Tawḥīd.'**
  String get pathDescKafirun;

  /// Name for path_ikhlas
  ///
  /// In en, this message translates to:
  /// **'Surah Al-Ikhlāṣ'**
  String get pathNameIkhlas;

  /// Description for path_ikhlas
  ///
  /// In en, this message translates to:
  /// **'Entire Surah (112:1–4). Tawḥīd of Allah.'**
  String get pathDescIkhlas;

  /// Name for path_falaq
  ///
  /// In en, this message translates to:
  /// **'Surah Al-Falaq'**
  String get pathNameFalaq;

  /// Description for path_falaq
  ///
  /// In en, this message translates to:
  /// **'Entire Surah (113:1–5). Seek refuge from external evils.'**
  String get pathDescFalaq;

  /// Name for path_nas
  ///
  /// In en, this message translates to:
  /// **'Surah An-Nās'**
  String get pathNameNas;

  /// Description for path_nas
  ///
  /// In en, this message translates to:
  /// **'Entire Surah (114:1–6). Seek refuge from internal whispers.'**
  String get pathDescNas;

  /// Name for path_asr_begin
  ///
  /// In en, this message translates to:
  /// **'Surah Al-ʿAṣr'**
  String get pathNameAsrBegin;

  /// Description for path_asr_begin
  ///
  /// In en, this message translates to:
  /// **'(103:1–3). Only 3 verses but central to “patience”.'**
  String get pathDescAsrBegin;

  /// Name for path_takathur
  ///
  /// In en, this message translates to:
  /// **'Surah At-Takāthur'**
  String get pathNameTakathur;

  /// Description for path_takathur
  ///
  /// In en, this message translates to:
  /// **'(102:1–8) about worldly competition and accountability.'**
  String get pathDescTakathur;

  /// Name for path_fil
  ///
  /// In en, this message translates to:
  /// **'Surah Al-Fīl'**
  String get pathNameFil;

  /// Description for path_fil
  ///
  /// In en, this message translates to:
  /// **'(105:1–5). Elephant incident; short 5 verses.'**
  String get pathDescFil;

  /// Name for path_quraysh
  ///
  /// In en, this message translates to:
  /// **'Surah Quraysh'**
  String get pathNameQuraysh;

  /// Description for path_quraysh
  ///
  /// In en, this message translates to:
  /// **'(106:1–4). On gratitude for safe journeys.'**
  String get pathDescQuraysh;

  /// Name for path_rahman_a
  ///
  /// In en, this message translates to:
  /// **'Ar-Raḥmān A'**
  String get pathNameRahmanA;

  /// Description for path_rahman_a
  ///
  /// In en, this message translates to:
  /// **'(55:1–13): Teaching of the Quran & creation of humankind.'**
  String get pathDescRahmanA;

  /// Name for path_rahman_b
  ///
  /// In en, this message translates to:
  /// **'Ar-Raḥmān B'**
  String get pathNameRahmanB;

  /// Description for path_rahman_b
  ///
  /// In en, this message translates to:
  /// **'(55:26–36): Humans & jinn accountability.'**
  String get pathDescRahmanB;

  /// Name for path_yasin_block
  ///
  /// In en, this message translates to:
  /// **'Surah Yā Sīn (Block)'**
  String get pathNameYasinBlock;

  /// Description for path_yasin_block
  ///
  /// In en, this message translates to:
  /// **'(36:1–12). Intro to the Prophet’s message & warnings.'**
  String get pathDescYasinBlock;

  /// Name for path_mulk_block
  ///
  /// In en, this message translates to:
  /// **'Surah Al-Mulk (Block)'**
  String get pathNameMulkBlock;

  /// Description for path_mulk_block
  ///
  /// In en, this message translates to:
  /// **'(67:1–15). Emphasizes Allah’s sovereignty & reflection.'**
  String get pathDescMulkBlock;

  /// Name for path_baqarah_21_29
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah (2:21–29)'**
  String get pathNameBaqarah21_29;

  /// Description for path_baqarah_21_29
  ///
  /// In en, this message translates to:
  /// **'9 verses on creation & reflection for gratitude.'**
  String get pathDescBaqarah21_29;

  /// Name for path_nahl_66_72
  ///
  /// In en, this message translates to:
  /// **'An-Naḥl (16:66–72)'**
  String get pathNameNahl66_72;

  /// Description for path_nahl_66_72
  ///
  /// In en, this message translates to:
  /// **'7 verses enumerating blessings: livestock, fruits, etc.'**
  String get pathDescNahl66_72;

  /// Name for path_ad_duha
  ///
  /// In en, this message translates to:
  /// **'Surah Aḍ-Ḍuḥā'**
  String get pathNameAdDuha;

  /// Description for path_ad_duha
  ///
  /// In en, this message translates to:
  /// **'(93:1–11) 11 verses of hope & reassurance.'**
  String get pathDescAdDuha;

  /// Name for path_kahf_cave
  ///
  /// In en, this message translates to:
  /// **'Al-Kahf: The Cave Youth'**
  String get pathNameKahfCave;

  /// Description for path_kahf_cave
  ///
  /// In en, this message translates to:
  /// **'(18:9–16) The story of young believers in a cave.'**
  String get pathDescKahfCave;

  /// Name for path_kahf_musa
  ///
  /// In en, this message translates to:
  /// **'Al-Kahf: Mūsā & Al-Khiḍr'**
  String get pathNameKahfMusa;

  /// Description for path_kahf_musa
  ///
  /// In en, this message translates to:
  /// **'(18:60–70) Emphasizes patience & hidden wisdom.'**
  String get pathDescKahfMusa;

  /// Name for path_waqiah
  ///
  /// In en, this message translates to:
  /// **'Al-Wāqiʿah (56:1–15)'**
  String get pathNameWaqiah;

  /// Description for path_waqiah
  ///
  /// In en, this message translates to:
  /// **'15 verses on the sudden arrival of the Hour.'**
  String get pathDescWaqiah;

  /// Name for path_asr_patience
  ///
  /// In en, this message translates to:
  /// **'Surah Al-ʿAṣr (Patience)'**
  String get pathNameAsrPatience;

  /// Description for path_asr_patience
  ///
  /// In en, this message translates to:
  /// **'(103:1–3) again, 3 verses, famously about patience.'**
  String get pathDescAsrPatience;

  /// Name for path_baq_153_157
  ///
  /// In en, this message translates to:
  /// **'Al-Baqarah (2:153–157)'**
  String get pathNameBaq153_157;

  /// Description for path_baq_153_157
  ///
  /// In en, this message translates to:
  /// **'5 verses: “Seek help through patience & prayer.”'**
  String get pathDescBaq153_157;

  /// Name for path_yusuf_7_14
  ///
  /// In en, this message translates to:
  /// **'Sūrah Yūsuf (12:7–14)'**
  String get pathNameYusuf7_14;

  /// Description for path_yusuf_7_14
  ///
  /// In en, this message translates to:
  /// **'Jealousy of Yusuf’s brothers. Patience tested.'**
  String get pathDescYusuf7_14;

  /// Name for path_yusuf_83_92
  ///
  /// In en, this message translates to:
  /// **'Sūrah Yūsuf (12:83–92)'**
  String get pathNameYusuf83_92;

  /// Description for path_yusuf_83_92
  ///
  /// In en, this message translates to:
  /// **'Yaʿqūb’s grief & Yusuf’s forgiveness (10 verses).'**
  String get pathDescYusuf83_92;

  /// Name for path_inshirah
  ///
  /// In en, this message translates to:
  /// **'Surah Al-Inshirāḥ (94:1–8)'**
  String get pathNameInshirah;

  /// Description for path_inshirah
  ///
  /// In en, this message translates to:
  /// **'8 verses: reassurance after hardship. Tied to patience & hope.'**
  String get pathDescInshirah;

  /// Builds a string like 'Surah Al-Fatiha, Ayah 1-7'.
  ///
  /// In en, this message translates to:
  /// **'Surah {surahName}, Ayah {startAyah}-{endAyah}'**
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah);

  /// Button label for finishing the lesson
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishLabel;

  /// Prompt text for two-word multiple choice
  ///
  /// In en, this message translates to:
  /// **'Select the correct two words'**
  String get twoWordMultipleChoiceLabel;

  /// Prompt text for single-word multiple choice
  ///
  /// In en, this message translates to:
  /// **'Select the correct word'**
  String get singleWordMultipleChoiceLabel;

  /// Shown after user selects correct multiple choice
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correctAnswerLabel;

  /// Shown after user selects a wrong multiple choice
  ///
  /// In en, this message translates to:
  /// **'Incorrect!'**
  String get incorrectAnswerLabel;

  /// Shown when the user has no more MC questions to do.
  ///
  /// In en, this message translates to:
  /// **'Lesson completed!'**
  String get lessonCompletedLabel;

  /// Header label for the analytics/score section in ProfileScreen
  ///
  /// In en, this message translates to:
  /// **'Analytics & Score'**
  String get profileAnalyticsScoreLabel;

  /// Label for daily score
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get profileDailyLabel;

  /// Label for weekly score
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get profileWeeklyLabel;

  /// Label for monthly score
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get profileMonthlyLabel;

  /// Label for total/all-time score
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get profileTotalLabel;

  /// Button label to open the chart
  ///
  /// In en, this message translates to:
  /// **'View Chart'**
  String get profileViewChart;

  /// Button label to close the dialog
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get profileCloseLabel;

  /// Used in the alert dialog's title, e.g. 'Daily Score Chart'
  ///
  /// In en, this message translates to:
  /// **'Score Chart'**
  String get profileScoreChartTitle;

  /// Used in the chart's internal title, e.g. 'Daily History'
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get profileScoreChartHistory;

  /// Shown if the chart has no data to display
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get profileNoData;

  /// Short label for daily score displayed on the left side of the TopBar.
  ///
  /// In en, this message translates to:
  /// **'⭐ Today'**
  String get topBarDailyScoreLabel;

  /// Accessibility label for daily score in the TopBar, announcing how many points the user has earned.
  ///
  /// In en, this message translates to:
  /// **'Your daily score is {score}'**
  String topBarDailyScoreSemantic(Object score);

  /// Shown if user is free tier but wants to see weekly progress
  ///
  /// In en, this message translates to:
  /// **'Please upgrade to view progress calendar and support us in building more features inshAllah!'**
  String get profilePremiumNeeded;

  /// Radio label for the 'multipleChoice' level
  ///
  /// In en, this message translates to:
  /// **'Multiple Choice'**
  String get levelMultipleChoiceLabel;

  /// Description for the 'multipleChoice' level
  ///
  /// In en, this message translates to:
  /// **'Single or two-word multiple-choice steps with optional skipping of pairs.'**
  String get levelMultipleChoiceDescription;

  /// Radio label for the 'starter' or 'beginner' level
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get levelBeginnerLabel;

  /// Description for the 'beginner' level
  ///
  /// In en, this message translates to:
  /// **'Progressive word removal in grouped sequences for gradual memorization.'**
  String get levelBeginnerDescription;

  /// Label for the Premium tier
  ///
  /// In en, this message translates to:
  /// **'Plus'**
  String get subscriptionTierScreenPremiumLabel;

  /// Message shown when a free user tries to use offline features.
  ///
  /// In en, this message translates to:
  /// **'Feature unavailable offline. Connect or unlock offline mode by upgrading to Plus or Pro Beta.'**
  String get featureUnavailableOffline;

  /// Shows how many total gratitude entries the user has in total. {count} is replaced by the actual number.
  ///
  /// In en, this message translates to:
  /// **'Total number of gratitudes entered: {count}'**
  String submissionFeedbackModalTotalCount(Object count);

  /// Title for the daily Quran reminder notification
  ///
  /// In en, this message translates to:
  /// **'Gentle Quran Reminder'**
  String get notificationDailyTitle;

  /// Title for the weekly Quran reminder notification
  ///
  /// In en, this message translates to:
  /// **'Weekly Quran Check-In'**
  String get notificationWeeklyTitle;

  /// Body text for the weekly reminder
  ///
  /// In en, this message translates to:
  /// **'Reflect on your progress and memorize a new portion of the Quran while practicing gratitude.'**
  String get notificationWeeklyBody;

  /// Channel name for daily reminders
  ///
  /// In en, this message translates to:
  /// **'Daily Reminders'**
  String get notificationChannelDailyRemindersName;

  /// Channel description for daily reminders
  ///
  /// In en, this message translates to:
  /// **'Reminders for daily Quran memorization'**
  String get notificationChannelDailyRemindersDesc;

  /// Channel name for weekly reminders
  ///
  /// In en, this message translates to:
  /// **'Weekly Reminders'**
  String get notificationChannelWeeklyRemindersName;

  /// Channel description for weekly reminders
  ///
  /// In en, this message translates to:
  /// **'Reminders for weekly Quran memorization check-in'**
  String get notificationChannelWeeklyRemindersDesc;

  /// Option in the dropdown indicating daily reminders
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get nameEntryNotificationFrequencyDaily;

  /// Dialog title explaining user streak
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get topBarStreakDialogTitle;

  /// Non-clickable divider text shown after 'Multiple Choice' in the Difficulty dropdown
  ///
  /// In en, this message translates to:
  /// **'Fill in the blanks'**
  String get fillInTheBlanksLabel;

  /// Label shown while data is loading
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loadingDataLabel;

  /// A placeholder for ayah range on the first page, e.g. 1-7 in Al-Fatihah
  ///
  /// In en, this message translates to:
  /// **'Ayah {start} - {end}'**
  String ayahRangeLabel(Object start, Object end);

  /// Semantic label for the downward arrow to go to the next page
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get nextPageSemanticLabel;

  /// Semantic label for the upward arrow to go to the previous page
  ///
  /// In en, this message translates to:
  /// **'Previous page'**
  String get prevPageSemanticLabel;

  /// Snack bar text after the pagination arrow is tapped
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageXOfYLabel(Object current, Object total);

  /// Semantic label for a verse card, referencing the ayah number and surah name
  ///
  /// In en, this message translates to:
  /// **'Ayah {ayahNumber} from surah {surahName}'**
  String verseSemanticLabel(Object ayahNumber, Object surahName);

  /// Prefix label for an ayah number, e.g. 'Ayah 3'
  ///
  /// In en, this message translates to:
  /// **'Ayah'**
  String get ayahLabel;

  /// A button label that navigates to a path-based surah screen.
  ///
  /// In en, this message translates to:
  /// **'Surah View'**
  String get goToSurahViewLabel;

  /// No description provided for @clickOnAyaToOpenLesson.
  ///
  /// In en, this message translates to:
  /// **'Click on any ayah below to start a lesson'**
  String get clickOnAyaToOpenLesson;

  /// Intro text at the top of the difficulty choosing screen
  ///
  /// In en, this message translates to:
  /// **'Select your preference: multiple choice or fill-in-the-blanks, and how many times each step and audio play is repeated.'**
  String get difficultyChoosingScreenIntro;

  /// Main message displayed when user has exceeded free voice usage
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro Beta to try the voice feature and help us improve it!'**
  String get upgradeVoiceUsageMessage;

  /// Button label for restoring purchases
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchasesLabel;

  /// Label for monthly toggle
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get subscriptionTierScreenMonthly;

  /// Label for yearly toggle
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get subscriptionTierScreenYearly;

  /// The displayed price for the free tier
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get subscriptionTierScreenFreePrice;

  /// Discounted monthly price for Premium
  ///
  /// In en, this message translates to:
  /// **'Now \$3/month (was \$5)'**
  String get subscriptionTierScreenPremiumMonthlyPrice;

  /// Discounted yearly price for Premium
  ///
  /// In en, this message translates to:
  /// **'Now \$28/year (was \$60)'**
  String get subscriptionTierScreenPremiumYearlyPrice;

  /// Discounted monthly price for PremiumPlus
  ///
  /// In en, this message translates to:
  /// **'Now \$7/month (was \$10)'**
  String get subscriptionTierScreenPremiumPlusMonthlyPrice;

  /// Discounted yearly price for PremiumPlus
  ///
  /// In en, this message translates to:
  /// **'Now \$45/year (was \$84)'**
  String get subscriptionTierScreenPremiumPlusYearlyPrice;

  /// Generic error message for subscription purchase
  ///
  /// In en, this message translates to:
  /// **'Error purchasing subscription'**
  String get subscriptionPurchaseError;

  /// Button text to navigate to subscription screen
  ///
  /// In en, this message translates to:
  /// **'Explore Plans'**
  String get topBarExplorePlansLabel;

  /// Button text to return to HomeScreen
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get topBarBackHomeLabel;

  /// Indicator shown when a feature requires subscription/premium plan
  ///
  /// In en, this message translates to:
  /// **'Requires Plan Update'**
  String get profileRequiresPlanUpdate;

  /// Description for the Premium tier
  ///
  /// In en, this message translates to:
  /// **'Everything in the free version, plus offline lesson learning and feedback, historical analytics as well as progress bars, profile and quran customization. Support us in building more features!'**
  String get subscriptionTierScreenPremiumDescription;

  /// Short notice displayed above the purchase button about auto-renewal
  ///
  /// In en, this message translates to:
  /// **'The subscription auto-renews, and can be cancelled to not be billed for the next period. A portion of the funds will be donated to Islamic Relief through the Almubtasim Initiative 😀.'**
  String get subscriptionAutoRenewNotice;

  /// Button label to confirm subscription purchase
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscriptionTierScreenSubscribeLabel;

  /// Short final message at the bottom of the subscription screen
  ///
  /// In en, this message translates to:
  /// **'We appreciate your support!'**
  String get subscriptionTierScreenFinalMessage;

  /// Shown when the restore purchase process succeeds
  ///
  /// In en, this message translates to:
  /// **'Your purchases have been successfully restored.'**
  String get subscriptionPurchaseRestoreSuccess;

  /// Button label for restoring previously purchased subscriptions
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get subscriptionTierScreenRestoreLabel;

  /// Label for the toggle option when user wants Arabic text.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabicLabel;

  /// Label for the toggle option when user wants transliterated text (Latin characters).
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get transliterationLabel;

  /// Title for the Surah Search screen
  ///
  /// In en, this message translates to:
  /// **'Surah Search'**
  String get surahSearchScreenTitle;

  /// Label for the back button in the app bar
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get genericBack;

  /// Prompt to choose a Surah from the list
  ///
  /// In en, this message translates to:
  /// **'Select a Surah:'**
  String get surahSearchSelectSurah;

  /// Section title listing any existing user/system paths for the chosen surah
  ///
  /// In en, this message translates to:
  /// **'Existing Paths for This Surah'**
  String get surahSearchExistingPaths;

  /// Message if no path references the chosen surah
  ///
  /// In en, this message translates to:
  /// **'No existing paths found.'**
  String get surahSearchNoMatches;

  /// Label for toggling OFF the create form
  ///
  /// In en, this message translates to:
  /// **'Hide Create Form'**
  String get surahSearchHideCreateForm;

  /// Label for toggling ON the create form
  ///
  /// In en, this message translates to:
  /// **'Create New Path for Surah'**
  String get surahSearchShowCreateForm;

  /// Label for a toggle or switch to enable path progress tracking
  ///
  /// In en, this message translates to:
  /// **'Track Progress?'**
  String get createPathTrackProgress;

  /// Tooltip text for the search icon on the Theme screen's app bar
  ///
  /// In en, this message translates to:
  /// **'Search Surahs'**
  String get themeScreenSearchIconSemantic;

  /// Tooltip text for the search icon in the PathListScreen app bar
  ///
  /// In en, this message translates to:
  /// **'Search Surahs'**
  String get pathListSearchIconSemantic;

  /// Tooltip text for the search icon in the PathLessonsScreen app bar
  ///
  /// In en, this message translates to:
  /// **'Search Surahs'**
  String get pathLessonsSearchIconSemantic;

  /// Tooltip for the 'Play All' icon that plays the entire surah range
  ///
  /// In en, this message translates to:
  /// **'Play entire surah'**
  String get playAllSurahSemantic;

  /// Tooltip for toggling transliteration mode (Arabic vs. transliteration)
  ///
  /// In en, this message translates to:
  /// **'Toggle transliteration'**
  String get toggleTransliterationLabel;

  /// Label displayed for the English transliteration option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLabel;

  /// Label for the Premium Plus tier
  ///
  /// In en, this message translates to:
  /// **'Support Us (Yearly)'**
  String get subscriptionTierScreenPremiumPlusLabel;

  /// Description for the Free tier
  ///
  /// In en, this message translates to:
  /// **'All features are free and ad-free!'**
  String get subscriptionTierScreenFreeDescription;

  /// Description for the Pro tier
  ///
  /// In en, this message translates to:
  /// **'Help fund new features and improvements! Also, investing a small amount of money can help the habit build!'**
  String get subscriptionTierScreenPremiumPlusDescription;

  /// Label for the 'Support' tier
  ///
  /// In en, this message translates to:
  /// **'Support Yearly'**
  String get subscriptionTierScreenSupportLabel;

  /// Body text for the upgrade dialog describing benefits and charity
  ///
  /// In en, this message translates to:
  /// **'All features are in the free version, but if you would like you can support us in building more features. Part of your subscription is donated to Islamic Relief. Jazāk Allāhu Khayran!'**
  String get verticalLessonIconsDialogBody;

  /// Main body text explaining the purpose of the app
  ///
  /// In en, this message translates to:
  /// **'Hudhud played a special role in helping Prophet Suleiman [AS] by observing and carrying messages. \n \n He doesn\'t judge you regardless of where you are in your journey, and is excited to guide you through the journey of discovering the beauty of the Quran, and integrating gratitude reminders to appreciate each moment with it.'**
  String get welcomeBody;

  /// Label above the autocomplete for searching surah by name
  ///
  /// In en, this message translates to:
  /// **'Search by name (English or Arabic)'**
  String get surahSearchByName;

  /// Hint text in the Autocomplete search field
  ///
  /// In en, this message translates to:
  /// **'Type any Surah name...'**
  String get surahSearchHintAnyName;

  /// Label text in the Autocomplete search field
  ///
  /// In en, this message translates to:
  /// **'Search Surah'**
  String get surahSearchFieldLabel;

  /// SnackBar message when generated lessons are invalid
  ///
  /// In en, this message translates to:
  /// **'One or more lessons were invalid. Cannot create path.'**
  String get surahSearchInvalidLessonsError;

  /// Used as a default path name prefix if user doesn't enter one
  ///
  /// In en, this message translates to:
  /// **'User Surah'**
  String get surahSearchUserSurahPrefix;

  /// Body text for the daily reminder
  ///
  /// In en, this message translates to:
  /// **'Take a moment to find some peace through the Quran and remind yourself of why you are grateful today.'**
  String get notificationDailyBody;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'es', 'fa', 'fr', 'id', 'ms', 'tr', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fa': return AppLocalizationsFa();
    case 'fr': return AppLocalizationsFr();
    case 'id': return AppLocalizationsId();
    case 'ms': return AppLocalizationsMs();
    case 'tr': return AppLocalizationsTr();
    case 'ur': return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
