import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commentA => 'Onboarding keys';

  @override
  String get appBarTitleWelcome => 'Welcome';

  @override
  String get skipLabel => 'Skip';

  @override
  String get welcomeHeadline => 'Welcome to Quran with Hudhud!';

  @override
  String get getStartedLabel => 'Get Started';

  @override
  String get commentB => 'Lesson screen keys';

  @override
  String get lessonScreenAppBarTitle => 'Lesson';

  @override
  String get noAyahAvailable => 'No ayah available to play.';

  @override
  String audioNotFound(Object url) {
    return 'Audio not found at $url';
  }

  @override
  String get restartLessonTitle => 'Restart Lesson';

  @override
  String get resetLessonBody => 'Reset all your progress for this lesson?';

  @override
  String get cancelLabel => 'Cancel';

  @override
  String get yesLabel => 'Yes';

  @override
  String get errorResettingLesson => 'Error resetting lesson';

  @override
  String get startLabel => 'Start';

  @override
  String get submitLabel => 'Submit';

  @override
  String get nextLabel => 'Next';

  @override
  String get voiceErrorMicDeniedTitle => 'Microphone Denied';

  @override
  String get voiceErrorMicDeniedBody => 'Recording requires microphone access. Please grant permission in Settings.';

  @override
  String get voiceErrorMicDeniedSemanticLabel => 'Microphone permission denied dialog';

  @override
  String get voiceErrorRecorderStartTitle => 'Recording Error';

  @override
  String get voiceErrorRecorderStartBody => 'We could not start the recorder. Please try again.';

  @override
  String get voiceErrorRecorderStartSemanticLabel => 'Recorder start error dialog';

  @override
  String get voiceErrorRecorderStopTitle => 'Stop Recording Error';

  @override
  String get voiceErrorRecorderStopBody => 'We could not stop the recorder properly. Please try again.';

  @override
  String get voiceErrorRecorderStopSemanticLabel => 'Recorder stop error dialog';

  @override
  String get voiceErrorNoSoundTitle => 'No Sound Detected';

  @override
  String get voiceErrorNoSoundBody => 'Your recording was silent or too quiet. Please try again.';

  @override
  String get voiceErrorNoSoundSemanticLabel => 'No sound detected dialog';

  @override
  String get voiceErrorTranscriptionTitle => 'Transcription Error';

  @override
  String get voiceErrorTranscriptionBody => 'We could not transcribe your recording. Please check your connection and try again.';

  @override
  String get voiceErrorTranscriptionSemanticLabel => 'Transcription error dialog';

  @override
  String get tapColoredWordsHint => 'Tap the highlighted words to see the corrected version.';

  @override
  String get emptyInputWarning => 'You must input something before submitting';

  @override
  String get getHintLabel => 'Get Hint';

  @override
  String get removeHintLabel => 'Remove Hint';

  @override
  String get typeTheMissingWordsLabel => 'Type the missing word(s)';

  @override
  String get difficultyLabel => 'Difficulty';

  @override
  String get repeatCountLabel => '# of Repeats';

  @override
  String get backButtonLabel => 'Back';

  @override
  String get toggleTranslationLabel => 'Toggle inline translation';

  @override
  String get openTranslationScreenLabel => 'Open translation screen';

  @override
  String get restartLessonSemanticLabel => 'Restart the lesson';

  @override
  String get verseDisplayAreaLabel => 'Quran verse display area';

  @override
  String get playAudioSemanticLabel => 'Play ayah audio';

  @override
  String get openGratitudeSemanticLabel => 'Open gratitude modal';

  @override
  String get voiceUsageSemanticLabel => 'Voice usage in minutes';

  @override
  String get voiceRecordSemanticLabel => 'Start or stop voice recording';

  @override
  String get commentC => 'New HOME screen strings';

  @override
  String get homeTitle => 'Home';

  @override
  String get noPathsLabel => 'No valid paths available.';

  @override
  String errorLoadingActivePath(Object err) {
    return 'Error loading the active path: $err';
  }

  @override
  String get verticalLessonIconsGoToTheme => 'Go to Theme';

  @override
  String get homePathCardLabel => 'Tap to open theme screen';

  @override
  String get arrowForwardSemanticLabel => 'Open details';

  @override
  String get noTrackProgressLabel => 'This path does not track progress.';

  @override
  String get premiumRequiredLabel => 'Upgrade to unlock progress functionality. Support us make more features!';

  @override
  String get completedLabel => 'completed';

  @override
  String get fabLogGratitudeLabel => 'Tap to log gratitude';

  @override
  String get errorNavigatingToLesson => 'Error navigating to lesson';

  @override
  String get commentD => 'Profile screen strings';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileBackArrowLabel => 'Back to previous screen';

  @override
  String get profileAvatarSemanticLabel => 'User avatar';

  @override
  String get profileEnterYourName => 'Enter your name';

  @override
  String get nameEntryNotificationFrequencyDropdownLabel => 'Notification Frequency';

  @override
  String get nameEntryNotificationFrequencyWeekly => 'Weekly';

  @override
  String get nameEntryNotificationFrequencyNone => 'None';

  @override
  String get notificationPermissionPrompt => 'We’d like to send gentle reminders to complete your gratitude or lesson submissions - please allow notifications if you\'d like us to help build the habit 😃.';

  @override
  String get profileNameSave => 'Save';

  @override
  String get profileNameCancel => 'Cancel';

  @override
  String get profileNameGuest => 'Guest';

  @override
  String get profileNameEdit => 'Edit';

  @override
  String get profilePreferredLanguage => 'Language:';

  @override
  String get okLabel => 'OK';

  @override
  String get profileReciterLabel => 'Reciter';

  @override
  String get profileFontLabel => 'Font:';

  @override
  String get profileReciterMishary => 'Mishary Rashid Al-Afasy';

  @override
  String get profileReciterShatri => 'Abu Bakr Al-Shatri';

  @override
  String get profileReciterQatami => 'Nasser Al Qatami';

  @override
  String get profileUpgradePremiumTitle => 'Unlock More Personalization!';

  @override
  String get profileUpgradePremiumBody => 'You can enjoy changing fonts and reciters by upgrading to Pro. Support our continuous efforts and personalize your experience further!';

  @override
  String get profileWeeksProgress => 'MashAllah, here is your week\'s progress:';

  @override
  String get profileGratefulnessCalendar => 'Gratefulness Calendar';

  @override
  String get profileQuranLearningCalendar => 'Quran Learning Calendar';

  @override
  String get profilePrevWeekSemantic => 'Go to previous week';

  @override
  String get profileNextWeekSemantic => 'Go to next week';

  @override
  String get profileNotificationFrequency => 'Notification Frequency';

  @override
  String get commentE => 'Gratitude Log Screen strings';

  @override
  String get gratitudeLogTitle => 'My Gratitude Log';

  @override
  String get gratitudeLogBackArrowSemantic => 'Go back to home';

  @override
  String get gratitudeLogClearAllSemantic => 'Clear all gratitude entries';

  @override
  String get gratitudeLogAddSemantic => 'Add new gratitude entry';

  @override
  String get gratitudeLogClearDialogTitle => 'Clear Gratitude Log';

  @override
  String get gratitudeLogClearDialogBody => 'Are you sure you want to clear all your gratitude entries? This action cannot be undone.';

  @override
  String get gratitudeLogClearConfirm => 'Yes, Clear';

  @override
  String gratitudeLogStreak(Object days) {
    return '⭐ Gratitude Streak: $days days';
  }

  @override
  String get gratitudeLogStreakLoading => 'Calculating streak...';

  @override
  String get gratitudeLogStreakError => 'Failed to calculate streak.';

  @override
  String gratitudeLogTotalDays(Object count) {
    return 'Total Gratitude Days: $count';
  }

  @override
  String get gratitudeLogDataLoading => 'Loading gratitude data...';

  @override
  String get gratitudeLogDataError => 'Failed to load gratitude data.';

  @override
  String get gratitudeLogCardSemantic => 'Gratitude entry card';

  @override
  String get gratitudeLogItemIcon => 'Gratitude icon';

  @override
  String get gratitudeLogEmptyIconSemantic => 'Tap to add your first gratitude';

  @override
  String get gratitudeLogEmptyMessage => 'No gratitude entries yet.\nTap the “+” to add your first gratitude!';

  @override
  String get gratitudeLogEntriesAdded => 'Gratitudes added successfully!';

  @override
  String get gratitudeLogEntriesFailed => 'Failed to add gratitudes. Please try again.';

  @override
  String get commentF => 'Lesson Completion Screen strings';

  @override
  String get lessonCompletedTitle => 'Lesson Completed';

  @override
  String get lessonCompletedBackArrowSemantic => 'Back to home';

  @override
  String get lessonCompletedMashaAllah => 'MashaAllah!';

  @override
  String get lessonCompletedMashaAllahSemantic => 'Congratulations text';

  @override
  String get lessonCompletedMessage => 'You have completed this lesson!';

  @override
  String get lessonCompletedImageSemantic => 'Hudhud Quran illustration';

  @override
  String get lessonCompletedGoBackSemantic => 'Return to the path selection';

  @override
  String get lessonCompletedGoBackButton => 'Go Back to Path';

  @override
  String get lessonCompletedRestartSemantic => 'Restart the lesson';

  @override
  String get lessonCompletedRestartButton => 'Restart Lesson';

  @override
  String get lessonCompletedEncouragement => 'Keep up the great work!';

  @override
  String get commentG => 'Theme Screen strings';

  @override
  String get themeScreenTitle => 'Themes';

  @override
  String get themeNameCoreRecitation => 'Core Daily Recitation';

  @override
  String get themeNameBeginJourney => 'Beginning the Journey';

  @override
  String get themeNameMercyAndHope => 'Mercy and Hope';

  @override
  String get themeNameGratitudeReflection => 'Gratitude and Reflection';

  @override
  String get themeNameStoriesReminders => 'Stories, Lessons, and Reminders';

  @override
  String get themeNamePatience => 'Patience (Ṣabr)';

  @override
  String get themeNameUserCreated => 'User Created';

  @override
  String get themeScreenNoThemesLabel => 'No Themes Available';

  @override
  String get themeScreenBackArrowSemantic => 'Go back';

  @override
  String get themeScreenThemeCardSemantic => 'Tap to open theme\'s paths';

  @override
  String get themeScreenLockIconSemantic => 'Theme locked. Requires upgrade.';

  @override
  String get pathListExploreOtherThemes => 'Explore Other Themes';

  @override
  String get themeScreenUserCreatedSubtitle => 'Created by you—personalize it as you like.';

  @override
  String get themeSubtitleCoreRecitation => 'Essential surahs for daily prayers and protection.';

  @override
  String get themeSubtitleBeginJourney => 'Short surahs for starting your Quranic journey.';

  @override
  String get themeSubtitleMercyAndHope => 'Reflect on Allah’s compassion and nurturing hope.';

  @override
  String get themeSubtitleGratitudeReflection => 'Cultivate thankfulness and introspection through selected ayahs.';

  @override
  String get themeSubtitleStoriesReminders => 'Explore Quranic narratives that guide and remind.';

  @override
  String get themeSubtitlePatience => 'Surahs and passages emphasizing patience and perseverance.';

  @override
  String get themeSubtitleDefault => 'A dedicated set of surahs for deeper spiritual growth.';

  @override
  String get themeScreenRequiredPremium => 'Requires Premium';

  @override
  String get themeScreenRequiredPremiumPlus => 'Requires Pro Beta';

  @override
  String get commentH => 'Path List Screen strings';

  @override
  String get pathListScreenTitle => 'Paths for Theme';

  @override
  String get pathListScreenBackArrowSemantic => 'Go back';

  @override
  String get pathListScreenAddIconSemantic => 'Add new path';

  @override
  String get pathListAddNewPathTooltip => 'Add New Path';

  @override
  String get pathListScreenAddIconSemanticEmpty => 'Tap to add your first path';

  @override
  String get pathListEmptyMessage => 'No paths yet.\nTap the “+” to create your first path!';

  @override
  String get pathListUnavailableLabel => 'This path is currently unavailable';

  @override
  String get pathListThemeLabel => 'Theme';

  @override
  String get pathListPathCardSemantic => 'Tap to open path details';

  @override
  String get pathListCompleteIconSemantic => 'Path complete';

  @override
  String get pathListInProgressIconSemantic => 'Path in progress';

  @override
  String get pathListInvalidIconSemantic => 'Path invalid or unavailable';

  @override
  String get pathListErrorLoadingPaths => 'Error loading paths:';

  @override
  String get commentI => 'Path Detail Screen strings';

  @override
  String get pathDetailScreenTitle => 'Path Details';

  @override
  String get pathDetailScreenBackArrowSemantic => 'Go back to path list';

  @override
  String get pathDetailScreenNotFound => 'Path not found.';

  @override
  String get pathDetailScreenFailToUpdate => 'Failed to update path progress:';

  @override
  String get pathDetailScreenProgressDisabled => 'Progress disabled for this path.';

  @override
  String get pathDetailScreenLessonsHeading => 'Lessons:';

  @override
  String get pathDetailScreenNoLessonsLabel => 'No lessons available.';

  @override
  String get pathDetailScreenErrorLoading => 'Error loading path or lessons:';

  @override
  String get pathDetailScreenLessonCardSemantic => 'Tap to open lesson details';

  @override
  String get pathDetailScreenLessonCompleteIconSemantic => 'Lesson complete';

  @override
  String get pathDetailScreenLessonInProgressIconSemantic => 'Lesson in progress';

  @override
  String get pathDetailScreenLessonInvalidIconSemantic => 'Lesson invalid or unavailable';

  @override
  String get pathDetailScreenLessonProgressUnavailable => 'Progress unavailable';

  @override
  String get pathDetailScreenLessonNoProgress => 'No progress for this path';

  @override
  String get pathDetailScreenLessonUpgrade => 'Upgrade for progress functionality.';

  @override
  String pathDetailScreenLessonProgressLabel(Object progress) {
    return 'Progress: $progress%';
  }

  @override
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah) {
    return 'Lesson $lessonIndex: $surahName - Ayah $startAyah-$endAyah';
  }

  @override
  String get commentJ => 'Create Path Screen strings';

  @override
  String get createPathTitle => 'Create New Path';

  @override
  String get createPathBackArrowSemantic => 'Back to previous screen';

  @override
  String get createPathNameLabel => 'Path Name';

  @override
  String get createPathNameValidation => 'Enter a path name';

  @override
  String get createPathDescriptionLabel => 'Description';

  @override
  String get createPathDescriptionValidation => 'Enter a description';

  @override
  String get createPathSurahSelectorLabel => 'Select Surah:';

  @override
  String get createPathStartAyahLabel => 'Start Ayah';

  @override
  String get createPathNumAyahsLabel => 'Number of Ayahs in the Path';

  @override
  String get createPathEndAyahLabel => 'End Ayah';

  @override
  String get createPathWordsPerLessonLabel => 'Words per Lesson';

  @override
  String get createPathWordsSuffix => 'words';

  @override
  String get createPathInvalidRange => 'Invalid range';

  @override
  String get createPathAyahsSuffix => 'Ayahs';

  @override
  String get createPathCreateButton => 'Create Path';

  @override
  String get createPathSubmitSemantic => 'Tap to create path';

  @override
  String get commentK => 'Translation Screen strings';

  @override
  String get translationScreenTitle => 'Translation';

  @override
  String get translationScreenBackArrowSemantic => 'Return to lesson';

  @override
  String get translationScreenLoadingSemantic => 'Loading translations';

  @override
  String get translationScreenNoTranslations => 'No translations available.';

  @override
  String get translationScreenReturnButton => 'Return to Lesson';

  @override
  String get translationScreenReturnSemantic => 'Tap to return to lesson';

  @override
  String get translationScreenLoadError => 'Error loading translations:';

  @override
  String get commentL => 'Language Selection Screen strings';

  @override
  String get languageSelectionScreenSemantic => 'Language Selection Screen';

  @override
  String get languageSelectionTitle => 'Select Your Language';

  @override
  String get languageSelectionBackSemantic => 'Back';

  @override
  String get languageSelectionSkipSemantic => 'Skip selection';

  @override
  String get languageSelectionInstructions => 'Please choose your preferred language:';

  @override
  String get languageSelectionNextSemantic => 'Tap to confirm language choice';

  @override
  String get languageSelectionNextLabel => 'Next';

  @override
  String get languageSelectionImageSemantic => 'Hudhud Quran illustration';

  @override
  String get commentM => 'Welcome Screen strings';

  @override
  String get welcomeScreenSemantic => 'Onboarding Welcome Screen';

  @override
  String get welcomeScreenLogoSemantic => 'Hudhud Quran illustration';

  @override
  String get welcomeScreenSkipSemantic => 'Skip the welcome step';

  @override
  String get welcomeScreenNextSemantic => 'Proceed to next onboarding step';

  @override
  String get commentN => 'Hudhud Info Screen strings';

  @override
  String get hudhudInfoSemantic => 'Hudhud Information Screen';

  @override
  String get hudhudInfoAppBarTitle => 'Meet Hudhud';

  @override
  String get hudhudInfoIllustrationSemantic => 'Hudhud illustration';

  @override
  String get hudhudInfoBody1 => 'Hudhud, also known as the hoopoe bird, played a special role in helping Prophet Suleiman [AS] by observing and carrying messages.';

  @override
  String get hudhudInfoBody2 => 'Hudhud’s story reminds us that even a small creature can have a big impact by being observant, curious, and proactive about the right things. In our journey, we can place our consistent attention on the beauty of the Quran, and integrate gratitude reminders to appreciate each moment of progress.';

  @override
  String get hudhudInfoBody3 => 'By following Hudhud’s example—staying watchful and engaged—we hope to deepen our connection to the Quran and foster a sense of gratitude in everyday life.';

  @override
  String get hudhudInfoNextLabel => 'Next';

  @override
  String get hudhudInfoNextSemantic => 'Proceed to next section';

  @override
  String get hudhudInfoSkipSemantic => 'Skip the Hudhud info step';

  @override
  String get commentO => 'Subscription Tier Screen strings';

  @override
  String get subscriptionTierScreenSemantic => 'Subscription Tier Selection Screen';

  @override
  String get subscriptionTierScreenAppBarTitle => 'Choose Your Plan';

  @override
  String get subscriptionTierScreenSkipSemantic => 'Skip subscription tier selection';

  @override
  String get subscriptionTierScreenFreeLabel => 'Free';

  @override
  String get subscriptionTierScreenSmileySemantic => 'Smiley face icon';

  @override
  String get subscriptionTierScreenDonationText => 'A portion of the funds will go to the Almubtasim Initiative, helping orphans through Islamic Relief.';

  @override
  String get subscriptionTierScreenConfirmSemantic => 'Confirm subscription tier selection';

  @override
  String get subscriptionTierScreenNextLabel => 'Next';

  @override
  String subscriptionTierScreenRadioSemantic(Object title) {
    return 'Tap to select the $title subscription tier';
  }

  @override
  String get commentP => 'Goal Selection Screen strings';

  @override
  String get goalSelectionScreenSemantic => 'Goal Selection Screen';

  @override
  String get goalSelectionScreenAppBarTitle => 'Select Your Goals';

  @override
  String get goalSelectionScreenSkipSemantic => 'Skip goal selection';

  @override
  String get goalSelectionScreenIntroText => 'Which of the following goals interest you? You can select multiple options.';

  @override
  String get goalSelectionScreenNextSemantic => 'Confirm goal selections';

  @override
  String get goalSelectionScreenNextLabel => 'Next';

  @override
  String goalSelectionTileSemantic(Object goalTitle) {
    return 'Tap to select or unselect the $goalTitle goal option';
  }

  @override
  String get goalConnectQuranTitle => 'Connect further with the Quran';

  @override
  String get goalConnectQuranDesc => 'Enhance your relationship through reading or reflection.';

  @override
  String get goalMemorizeQuranTitle => 'Memorize the Quran';

  @override
  String get goalMemorizeQuranDesc => 'Embark on a memorization journey.';

  @override
  String get goalBeMoreGratefulTitle => 'Be more grateful and happy in life';

  @override
  String get goalBeMoreGratefulDesc => 'Focus on everyday gratitude practices.';

  @override
  String get goalBuildConsistencyTitle => 'Build consistency';

  @override
  String get goalBuildConsistencyDesc => 'Develop a daily or weekly habit.';

  @override
  String get goalImproveArabicTitle => 'Improve my Arabic';

  @override
  String get goalImproveArabicDesc => 'Focus on written or spoken language skills.';

  @override
  String get goalDeepenTafsirTitle => 'Deepen Tafsir';

  @override
  String get goalDeepenTafsirDesc => 'Study commentary and the deeper meanings of the Quran.';

  @override
  String get goalOtherTitle => 'Other';

  @override
  String get goalOtherDesc => 'Pursue any other personal objective.';

  @override
  String get commentQ => 'Level Selection Screen strings';

  @override
  String get levelSelectionScreenSemantic => 'Level Selection Screen';

  @override
  String get levelSelectionScreenAppBarTitle => 'Select Your Level';

  @override
  String get levelSelectionScreenSkipSemantic => 'Skip level selection';

  @override
  String get levelSelectionScreenIntroText => 'Please select the option that best describes your current recitation level:';

  @override
  String get levelStarterLabel => 'Starter';

  @override
  String get levelStarterDescription => 'New or casual learner, beginning to explore Quran recitation.';

  @override
  String get levelAdvancedLabel => 'Advanced';

  @override
  String get levelAdvancedDescription => 'Comfortable reading Arabic script with some tajweed knowledge.';

  @override
  String get levelQariLabel => 'Qari';

  @override
  String get levelQariDescription => 'Skilled in recitation with strong tajweed proficiency.';

  @override
  String get levelSelectionNextSemantic => 'Confirm level selection';

  @override
  String get levelSelectionNextLabel => 'Next';

  @override
  String levelSelectionTileSemantic(Object levelTitle) {
    return 'Tap to select the $levelTitle recitation level option';
  }

  @override
  String get commentR => 'Onboarding Completion Screen strings';

  @override
  String get onboardingCompletionScreenSemantic => 'Onboarding Completion Screen';

  @override
  String get onboardingCompletionScreenAppBarTitle => 'All Set!';

  @override
  String get onboardingCompletionScreenImageSemantic => 'Hudhud Quran illustration';

  @override
  String get onboardingCompletionScreenBody1 => 'Congratulations! You\'ve successfully completed the setup. We hope this journey will bring you closer to the Quran and enhance your gratitude to Allah. \n \nMay this app be a source of growth and blessings in your life and those you touch.';

  @override
  String get onboardingCompletionScreenBody2 => 'Whenever you\'re ready, tap the button below to proceed. The main memorization and progress features are waiting, and you can log your gratitude or choose a path from the Navbar.';

  @override
  String get onboardingCompletionScreenBody3 => 'This is an early version — we appreciate your support and patience and hope to give even more features very soon inshAllah!';

  @override
  String get onboardingCompletionScreenBeginSemantic => 'Begin using the app';

  @override
  String get onboardingCompletionScreenBeginLabel => 'Let\'s Begin';

  @override
  String get commentS => 'Name Entry Screen strings';

  @override
  String get nameEntryScreenSemantic => 'Name Entry Screen';

  @override
  String get nameEntryScreenAppBarTitle => 'Your profile';

  @override
  String get nameEntryScreenSkipSemantic => 'Skip entering your name';

  @override
  String get nameEntryScreenIntroText => 'What is your name? ';

  @override
  String get nameEntryTextFieldSemantic => 'Name input text field';

  @override
  String get nameEntryNextSemantic => 'Confirm name entry';

  @override
  String get nameEntryNextLabel => 'Next';

  @override
  String get commentT => 'VerticalLessonIcons strings';

  @override
  String get verticalLessonIconsSemantic => 'Vertical Lesson Icons Container';

  @override
  String get verticalLessonIconsNoLessons => 'No lessons found.';

  @override
  String get verticalLessonIconsLoadingSurah => 'Loading Surah details';

  @override
  String get verticalLessonIconsErrorSurah => 'Error loading surah details';

  @override
  String get verticalLessonIconsSurahHeaderSemantic => 'Surah details header';

  @override
  String get verticalLessonIconsHudhudIconSemantic => 'Hudhud helper icon';

  @override
  String get verticalLessonIconsNextPageSemantic => 'Next page arrow';

  @override
  String get verticalLessonIconsPreviousPageSemantic => 'Previous page arrow';

  @override
  String get verticalLessonIconsLoadingProgress => 'Loading lesson progress';

  @override
  String get verticalLessonIconsErrorProgress => 'Error loading progress';

  @override
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent) {
    return 'Lesson icon, $surahAyahRange, progress is $percent%';
  }

  @override
  String get verticalLessonIconsCompletedSemantic => 'Lesson completed';

  @override
  String get verticalLessonIconsDialogTitle => 'Support & Upgrade';

  @override
  String get verticalLessonIconsDialogOk => 'OK';

  @override
  String get commentU => 'Navbar strings';

  @override
  String get navBarSemanticLabel => 'Bottom navigation bar';

  @override
  String get navHomeLabel => 'Home';

  @override
  String get navHomeSemantic => 'Home tab';

  @override
  String get navQuranLabel => 'Quran';

  @override
  String get navQuranSemantic => 'Quran tab';

  @override
  String get navGratitudeLabel => 'Gratitude';

  @override
  String get navGratitudeSemantic => 'Gratitude tab';

  @override
  String get navProfileLabel => 'Profile';

  @override
  String get navProfileSemantic => 'Profile tab';

  @override
  String get commentV => 'TopBar strings';

  @override
  String get topBarSemanticLabel => 'Top navigation bar';

  @override
  String topBarTitleSemantic(Object title) {
    return 'Top bar title: $title';
  }

  @override
  String topBarStreakIconSemantic(Object days) {
    return 'Streak icon: $days days';
  }

  @override
  String get topBarStreakDialogBody => 'This shows how many consecutive days you\'ve recited or written a gratitude. Keep it going to maintain or grow your streak!';

  @override
  String get topBarHudhudIconSemantic => 'Hudhud icon, tap for support';

  @override
  String get topBarHudhudDialogTitle => 'Support & Upgrade';

  @override
  String get topBarHudhudDialogBody => 'All features are in the free version, but if you would like you can support us in building more features. Part of your subscription is donated to Islamic Relief. Jazāk Allāhu Khayran!';

  @override
  String get commentW => 'Gratitude Modal strings';

  @override
  String get gratitudeModalSemantic => 'Gratitude Modal Dialog';

  @override
  String get gratitudeModalTitle => 'What are you grateful for today based on these verses?';

  @override
  String gratitudeModalHint(Object index) {
    return 'Alhamdulilah for (enter gratitude) #$index';
  }

  @override
  String gratitudeModalTextFieldSemantic(Object index) {
    return 'Enter gratitude #$index';
  }

  @override
  String get gratitudeModalEmptyWarning => 'Please enter at least one gratitude.';

  @override
  String get gratitudeModalSubmitError => 'Failed to log gratitude. Please try again.';

  @override
  String get dailyVoiceLimitReachedTitle => 'MashaAllah!';

  @override
  String get dailyVoiceLimitReachedMessage => 'You have completed 10 minutes of Quran voice recitation. Please continue to review by writing, and continue reciting tomorrow.';

  @override
  String get upgradeVoiceUsageTitle => 'Upgrade to Premium';

  @override
  String get gratitudeModalLoadingSemantic => 'Gratitude submission in progress';

  @override
  String get commentX => '== NEW KEYS for submission_feedback_modal, progress_bar, surah_selector ==';

  @override
  String get submissionFeedbackModalSemanticLabel => 'Submission feedback dialog';

  @override
  String get submissionFeedbackModalTitle => 'Submission Feedback';

  @override
  String get submissionFeedbackModalNoNew => 'No new gratitudes were submitted.';

  @override
  String get submissionFeedbackModalYouSubmitted => 'You submitted these gratitudes:';

  @override
  String submissionFeedbackModalStreak(Object days) {
    return 'Current gratitude streak: $days days';
  }

  @override
  String submissionFeedbackModalTotalDays(Object count) {
    return 'Total gratitude days: $count';
  }

  @override
  String get submissionFeedbackModalLoading => 'Loading your gratitude data...';

  @override
  String get submissionFeedbackModalError => 'Could not load gratitude data.';

  @override
  String get submissionFeedbackModalViewLog => 'View Log';

  @override
  String get submissionFeedbackModalClose => 'Close';

  @override
  String progressBarSemanticLabel(Object percent) {
    return 'Progress: $percent%';
  }

  @override
  String get surahSelectorSemanticLabel => 'Select a Surah';

  @override
  String get commentZ => 'Localizable Path Names & Descriptions for system-defined paths';

  @override
  String get pathNameFatihah => 'Surah Al-Fātiḥah';

  @override
  String get pathDescFatihah => 'Entire Surah (1:1–7). Essential for each rakʿah.';

  @override
  String get pathNameKafirun => 'Surah Al-Kāfirūn';

  @override
  String get pathDescKafirun => 'Entire Surah (109:1–6). Statement of Tawḥīd.';

  @override
  String get pathNameIkhlas => 'Surah Al-Ikhlāṣ';

  @override
  String get pathDescIkhlas => 'Entire Surah (112:1–4). Tawḥīd of Allah.';

  @override
  String get pathNameFalaq => 'Surah Al-Falaq';

  @override
  String get pathDescFalaq => 'Entire Surah (113:1–5). Seek refuge from external evils.';

  @override
  String get pathNameNas => 'Surah An-Nās';

  @override
  String get pathDescNas => 'Entire Surah (114:1–6). Seek refuge from internal whispers.';

  @override
  String get pathNameAsrBegin => 'Surah Al-ʿAṣr';

  @override
  String get pathDescAsrBegin => '(103:1–3). Only 3 verses but central to “patience”.';

  @override
  String get pathNameTakathur => 'Surah At-Takāthur';

  @override
  String get pathDescTakathur => '(102:1–8) about worldly competition and accountability.';

  @override
  String get pathNameFil => 'Surah Al-Fīl';

  @override
  String get pathDescFil => '(105:1–5). Elephant incident; short 5 verses.';

  @override
  String get pathNameQuraysh => 'Surah Quraysh';

  @override
  String get pathDescQuraysh => '(106:1–4). On gratitude for safe journeys.';

  @override
  String get pathNameRahmanA => 'Ar-Raḥmān A';

  @override
  String get pathDescRahmanA => '(55:1–13): Teaching of the Quran & creation of humankind.';

  @override
  String get pathNameRahmanB => 'Ar-Raḥmān B';

  @override
  String get pathDescRahmanB => '(55:26–36): Humans & jinn accountability.';

  @override
  String get pathNameYasinBlock => 'Surah Yā Sīn (Block)';

  @override
  String get pathDescYasinBlock => '(36:1–12). Intro to the Prophet’s message & warnings.';

  @override
  String get pathNameMulkBlock => 'Surah Al-Mulk (Block)';

  @override
  String get pathDescMulkBlock => '(67:1–15). Emphasizes Allah’s sovereignty & reflection.';

  @override
  String get pathNameBaqarah21_29 => 'Al-Baqarah (2:21–29)';

  @override
  String get pathDescBaqarah21_29 => '9 verses on creation & reflection for gratitude.';

  @override
  String get pathNameNahl66_72 => 'An-Naḥl (16:66–72)';

  @override
  String get pathDescNahl66_72 => '7 verses enumerating blessings: livestock, fruits, etc.';

  @override
  String get pathNameAdDuha => 'Surah Aḍ-Ḍuḥā';

  @override
  String get pathDescAdDuha => '(93:1–11) 11 verses of hope & reassurance.';

  @override
  String get pathNameKahfCave => 'Al-Kahf: The Cave Youth';

  @override
  String get pathDescKahfCave => '(18:9–16) The story of young believers in a cave.';

  @override
  String get pathNameKahfMusa => 'Al-Kahf: Mūsā & Al-Khiḍr';

  @override
  String get pathDescKahfMusa => '(18:60–70) Emphasizes patience & hidden wisdom.';

  @override
  String get pathNameWaqiah => 'Al-Wāqiʿah (56:1–15)';

  @override
  String get pathDescWaqiah => '15 verses on the sudden arrival of the Hour.';

  @override
  String get pathNameAsrPatience => 'Surah Al-ʿAṣr (Patience)';

  @override
  String get pathDescAsrPatience => '(103:1–3) again, 3 verses, famously about patience.';

  @override
  String get pathNameBaq153_157 => 'Al-Baqarah (2:153–157)';

  @override
  String get pathDescBaq153_157 => '5 verses: “Seek help through patience & prayer.”';

  @override
  String get pathNameYusuf7_14 => 'Sūrah Yūsuf (12:7–14)';

  @override
  String get pathDescYusuf7_14 => 'Jealousy of Yusuf’s brothers. Patience tested.';

  @override
  String get pathNameYusuf83_92 => 'Sūrah Yūsuf (12:83–92)';

  @override
  String get pathDescYusuf83_92 => 'Yaʿqūb’s grief & Yusuf’s forgiveness (10 verses).';

  @override
  String get pathNameInshirah => 'Surah Al-Inshirāḥ (94:1–8)';

  @override
  String get pathDescInshirah => '8 verses: reassurance after hardship. Tied to patience & hope.';

  @override
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah) {
    return 'Surah $surahName, Ayah $startAyah-$endAyah';
  }

  @override
  String get finishLabel => 'Finish';

  @override
  String get twoWordMultipleChoiceLabel => 'Select the correct two words';

  @override
  String get singleWordMultipleChoiceLabel => 'Select the correct word';

  @override
  String get correctAnswerLabel => 'Correct!';

  @override
  String get incorrectAnswerLabel => 'Incorrect!';

  @override
  String get lessonCompletedLabel => 'Lesson completed!';

  @override
  String get profileAnalyticsScoreLabel => 'Analytics & Score';

  @override
  String get profileDailyLabel => 'Daily';

  @override
  String get profileWeeklyLabel => 'Weekly';

  @override
  String get profileMonthlyLabel => 'Monthly';

  @override
  String get profileTotalLabel => 'Total';

  @override
  String get profileViewChart => 'View Chart';

  @override
  String get profileCloseLabel => 'Close';

  @override
  String get profileScoreChartTitle => 'Score Chart';

  @override
  String get profileScoreChartHistory => 'History';

  @override
  String get profileNoData => 'No data';

  @override
  String get topBarDailyScoreLabel => '⭐ Today';

  @override
  String topBarDailyScoreSemantic(Object score) {
    return 'Your daily score is $score';
  }

  @override
  String get profilePremiumNeeded => 'Please upgrade to view progress calendar and support us in building more features inshAllah!';

  @override
  String get levelMultipleChoiceLabel => 'Multiple Choice';

  @override
  String get levelMultipleChoiceDescription => 'Single or two-word multiple-choice steps with optional skipping of pairs.';

  @override
  String get levelBeginnerLabel => 'Beginner';

  @override
  String get levelBeginnerDescription => 'Progressive word removal in grouped sequences for gradual memorization.';

  @override
  String get subscriptionTierScreenPremiumLabel => 'Plus';

  @override
  String get featureUnavailableOffline => 'Feature unavailable offline. Connect or unlock offline mode by upgrading to Plus or Pro Beta.';

  @override
  String submissionFeedbackModalTotalCount(Object count) {
    return 'Total number of gratitudes entered: $count';
  }

  @override
  String get notificationDailyTitle => 'Gentle Quran Reminder';

  @override
  String get notificationWeeklyTitle => 'Weekly Quran Check-In';

  @override
  String get notificationWeeklyBody => 'Reflect on your progress and memorize a new portion of the Quran while practicing gratitude.';

  @override
  String get notificationChannelDailyRemindersName => 'Daily Reminders';

  @override
  String get notificationChannelDailyRemindersDesc => 'Reminders for daily Quran memorization';

  @override
  String get notificationChannelWeeklyRemindersName => 'Weekly Reminders';

  @override
  String get notificationChannelWeeklyRemindersDesc => 'Reminders for weekly Quran memorization check-in';

  @override
  String get nameEntryNotificationFrequencyDaily => 'Daily';

  @override
  String get topBarStreakDialogTitle => 'Streak';

  @override
  String get fillInTheBlanksLabel => 'Fill in the blanks';

  @override
  String get loadingDataLabel => 'Loading…';

  @override
  String ayahRangeLabel(Object start, Object end) {
    return 'Ayah $start - $end';
  }

  @override
  String get nextPageSemanticLabel => 'Next page';

  @override
  String get prevPageSemanticLabel => 'Previous page';

  @override
  String pageXOfYLabel(Object current, Object total) {
    return 'Page $current of $total';
  }

  @override
  String verseSemanticLabel(Object ayahNumber, Object surahName) {
    return 'Ayah $ayahNumber from surah $surahName';
  }

  @override
  String get ayahLabel => 'Ayah';

  @override
  String get goToSurahViewLabel => 'Surah View';

  @override
  String get clickOnAyaToOpenLesson => 'Click on any ayah below to start a lesson';

  @override
  String get difficultyChoosingScreenIntro => 'Select your preference: multiple choice or fill-in-the-blanks, and how many times each step and audio play is repeated.';

  @override
  String get upgradeVoiceUsageMessage => 'Upgrade to Pro Beta to try the voice feature and help us improve it!';

  @override
  String get restorePurchasesLabel => 'Restore Purchases';

  @override
  String get subscriptionTierScreenMonthly => 'Monthly';

  @override
  String get subscriptionTierScreenYearly => 'Yearly';

  @override
  String get subscriptionTierScreenFreePrice => 'Free';

  @override
  String get subscriptionTierScreenPremiumMonthlyPrice => 'Now \$3/month (was \$5)';

  @override
  String get subscriptionTierScreenPremiumYearlyPrice => 'Now \$28/year (was \$60)';

  @override
  String get subscriptionTierScreenPremiumPlusMonthlyPrice => 'Now \$7/month (was \$10)';

  @override
  String get subscriptionTierScreenPremiumPlusYearlyPrice => 'Now \$45/year (was \$84)';

  @override
  String get subscriptionPurchaseError => 'Error purchasing subscription';

  @override
  String get topBarExplorePlansLabel => 'Explore Plans';

  @override
  String get topBarBackHomeLabel => 'Back to Home';

  @override
  String get profileRequiresPlanUpdate => 'Requires Plan Update';

  @override
  String get subscriptionTierScreenPremiumDescription => 'Everything in the free version, plus offline lesson learning and feedback, historical analytics as well as progress bars, profile and quran customization. Support us in building more features!';

  @override
  String get subscriptionAutoRenewNotice => 'The subscription auto-renews, and can be cancelled to not be billed for the next period. A portion of the funds will be donated to Islamic Relief through the Almubtasim Initiative 😀.';

  @override
  String get subscriptionTierScreenSubscribeLabel => 'Subscribe';

  @override
  String get subscriptionTierScreenFinalMessage => 'We appreciate your support!';

  @override
  String get subscriptionPurchaseRestoreSuccess => 'Your purchases have been successfully restored.';

  @override
  String get subscriptionTierScreenRestoreLabel => 'Restore Purchases';

  @override
  String get arabicLabel => 'Arabic';

  @override
  String get transliterationLabel => 'English';

  @override
  String get surahSearchScreenTitle => 'Surah Search';

  @override
  String get genericBack => 'Back';

  @override
  String get surahSearchSelectSurah => 'Select a Surah:';

  @override
  String get surahSearchExistingPaths => 'Existing Paths for This Surah';

  @override
  String get surahSearchNoMatches => 'No existing paths found.';

  @override
  String get surahSearchHideCreateForm => 'Hide Create Form';

  @override
  String get surahSearchShowCreateForm => 'Create New Path for Surah';

  @override
  String get createPathTrackProgress => 'Track Progress?';

  @override
  String get themeScreenSearchIconSemantic => 'Search Surahs';

  @override
  String get pathListSearchIconSemantic => 'Search Surahs';

  @override
  String get pathLessonsSearchIconSemantic => 'Search Surahs';

  @override
  String get playAllSurahSemantic => 'Play entire surah';

  @override
  String get toggleTransliterationLabel => 'Toggle transliteration';

  @override
  String get englishLabel => 'English';

  @override
  String get subscriptionTierScreenPremiumPlusLabel => 'Support Us (Yearly)';

  @override
  String get subscriptionTierScreenFreeDescription => 'All features are free and ad-free!';

  @override
  String get subscriptionTierScreenPremiumPlusDescription => 'Help fund new features and improvements! Also, investing a small amount of money can help the habit build!';

  @override
  String get subscriptionTierScreenSupportLabel => 'Support Yearly';

  @override
  String get verticalLessonIconsDialogBody => 'All features are in the free version, but if you would like you can support us in building more features. Part of your subscription is donated to Islamic Relief. Jazāk Allāhu Khayran!';

  @override
  String get welcomeBody => 'Hudhud played a special role in helping Prophet Suleiman [AS] by observing and carrying messages. \n \n He doesn\'t judge you regardless of where you are in your journey, and is excited to guide you through the journey of discovering the beauty of the Quran, and integrating gratitude reminders to appreciate each moment with it.';

  @override
  String get surahSearchByName => 'Search by name (English or Arabic)';

  @override
  String get surahSearchHintAnyName => 'Type any Surah name...';

  @override
  String get surahSearchFieldLabel => 'Search Surah';

  @override
  String get surahSearchInvalidLessonsError => 'One or more lessons were invalid. Cannot create path.';

  @override
  String get surahSearchUserSurahPrefix => 'User Surah';

  @override
  String get notificationDailyBody => 'Take a moment to find some peace through the Quran and remind yourself of why you are grateful today.';
}
