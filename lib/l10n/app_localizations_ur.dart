import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get commentA => 'آن بورڈنگ کے متعلّق کلیدیں';

  @override
  String get appBarTitleWelcome => 'خوش آمدید';

  @override
  String get skipLabel => 'چھوڑیں';

  @override
  String get welcomeHeadline => 'حدہد کے ساتھ قرآن میں خوش آمدید!';

  @override
  String get getStartedLabel => 'آغاز کریں';

  @override
  String get commentB => 'درس اسکرین کے متعلّق کلیدیں';

  @override
  String get lessonScreenAppBarTitle => 'سبق';

  @override
  String get noAyahAvailable => 'چلانے کے لیے کوئی آیت دستیاب نہیں۔';

  @override
  String audioNotFound(Object url) {
    return 'آڈیو اس پتے پر نہیں ملی: $url';
  }

  @override
  String get restartLessonTitle => 'سبق دوبارہ شروع کریں';

  @override
  String get resetLessonBody => 'کیا آپ اس سبق کی ساری پیش رفت ری سیٹ کرنا چاہتے ہیں؟';

  @override
  String get cancelLabel => 'منسوخ کریں';

  @override
  String get yesLabel => 'جی ہاں';

  @override
  String get errorResettingLesson => 'سبق ری سیٹ کرنے میں خرابی';

  @override
  String get startLabel => 'شروع کریں';

  @override
  String get submitLabel => 'جمع کروائیں';

  @override
  String get nextLabel => 'اگلا';

  @override
  String get voiceErrorMicDeniedTitle => 'مائیکروفون مسترد کر دیا گیا';

  @override
  String get voiceErrorMicDeniedBody => 'ریکارڈنگ کے لیے مائیکروفون تک رسائی ضروری ہے۔ براہ کرم سیٹنگز میں اجازت دیں۔';

  @override
  String get voiceErrorMicDeniedSemanticLabel => 'مائیکروفون اجازت مسترد ہونے کا ڈائیلاگ';

  @override
  String get voiceErrorRecorderStartTitle => 'ریکارڈنگ کی خرابی';

  @override
  String get voiceErrorRecorderStartBody => 'ہم ریکارڈر شروع نہیں کر سکے۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get voiceErrorRecorderStartSemanticLabel => 'ریکارڈر شروع کرنے میں خرابی کا ڈائیلاگ';

  @override
  String get voiceErrorRecorderStopTitle => 'ریکارڈنگ روکنے میں خرابی';

  @override
  String get voiceErrorRecorderStopBody => 'ہم ریکارڈر کو درست طور پر روک نہیں سکے۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get voiceErrorRecorderStopSemanticLabel => 'ریکارڈر روکنے میں خرابی کا ڈائیلاگ';

  @override
  String get voiceErrorNoSoundTitle => 'کوئی آواز ریکارڈ نہیں ہوئی';

  @override
  String get voiceErrorNoSoundBody => 'آپ کی ریکارڈنگ خاموش یا بہت مدھم تھی۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get voiceErrorNoSoundSemanticLabel => 'کوئی آواز ریکارڈ نہیں ہوئی ڈائیلاگ';

  @override
  String get voiceErrorTranscriptionTitle => 'ٹرانسکرپشن کی خرابی';

  @override
  String get voiceErrorTranscriptionBody => 'ہم آپ کی ریکارڈنگ کا ٹرانسکرپٹ نہیں کر سکے۔ براہ کرم اپنا کنیکشن چیک کریں اور دوبارہ کوشش کریں۔';

  @override
  String get voiceErrorTranscriptionSemanticLabel => 'ٹرانسکرپشن کی خرابی کا ڈائیلاگ';

  @override
  String get tapColoredWordsHint => 'درست ورژن دیکھنے کے لیے نمایاں کردہ الفاظ پر ٹیپ کریں۔';

  @override
  String get emptyInputWarning => 'سبمٹ کرنے سے پہلے کچھ متن درج کریں';

  @override
  String get getHintLabel => 'اشارہ حاصل کریں';

  @override
  String get removeHintLabel => 'اشارہ ہٹائیں';

  @override
  String get typeTheMissingWordsLabel => 'غائب شدہ لفظ(الفاظ) درج کریں';

  @override
  String get difficultyLabel => 'مشکل کی سطح';

  @override
  String get repeatCountLabel => 'تکرار کی تعداد';

  @override
  String get backButtonLabel => 'واپس';

  @override
  String get toggleTranslationLabel => 'ان لائن ترجمہ دکھائیں/چھپائیں';

  @override
  String get openTranslationScreenLabel => 'ترجمہ اسکرین کھولیں';

  @override
  String get restartLessonSemanticLabel => 'سبق دوبارہ شروع کریں';

  @override
  String get verseDisplayAreaLabel => 'قرآن کی آیات دکھانے کا علاقہ';

  @override
  String get playAudioSemanticLabel => 'آیت کا آڈیو چلائیں';

  @override
  String get openGratitudeSemanticLabel => 'شکر کا موڈل کھولیں';

  @override
  String get voiceUsageSemanticLabel => 'آواز کا استعمال (منٹوں میں)';

  @override
  String get voiceRecordSemanticLabel => 'آواز کی ریکارڈنگ شروع یا بند کریں';

  @override
  String get commentC => 'نئی ہوم اسکرین کے اسٹرنگز';

  @override
  String get homeTitle => 'ہوم';

  @override
  String get noPathsLabel => 'کوئی درست راستے دستیاب نہیں۔';

  @override
  String errorLoadingActivePath(Object err) {
    return 'فعال راستہ لوڈ کرنے میں خرابی: $err';
  }

  @override
  String get verticalLessonIconsGoToTheme => 'تھیم پر جائیں';

  @override
  String get homePathCardLabel => 'تھیم اسکرین کھولنے کے لیے ٹیپ کریں';

  @override
  String get arrowForwardSemanticLabel => 'تفصیلات کھولیں';

  @override
  String get noTrackProgressLabel => 'یہ راستہ پیش رفت کو ٹریک نہیں کرتا۔';

  @override
  String get premiumRequiredLabel => 'پیش رفت کی خصوصیت کھولنے کے لیے اپ گریڈ کریں۔ مزید فیچرز بنانے میں ہماری مدد کریں!';

  @override
  String get completedLabel => 'مکمل ہوا';

  @override
  String get fabLogGratitudeLabel => 'شکر نوٹ کرنے کے لیے ٹیپ کریں';

  @override
  String get errorNavigatingToLesson => 'سبق پر جانے میں خرابی';

  @override
  String get commentD => 'پروفائل اسکرین کے اسٹرنگز';

  @override
  String get profileTitle => 'پروفائل';

  @override
  String get profileBackArrowLabel => 'پچھلی اسکرین پر واپس جائیں';

  @override
  String get profileAvatarSemanticLabel => 'صارف کا اوتار';

  @override
  String get profileEnterYourName => 'اپنا نام درج کریں';

  @override
  String get nameEntryNotificationFrequencyDropdownLabel => 'نوٹیفکیشن کی تکرار';

  @override
  String get nameEntryNotificationFrequencyWeekly => 'ہفتہ وار';

  @override
  String get nameEntryNotificationFrequencyNone => 'کوئی نہیں';

  @override
  String get notificationPermissionPrompt => 'ہم آپ کو ہلکی یاد دہانیاں بھیجنا چاہتے ہیں تاکہ آپ اپنی شکر یا سبق کی تکمیل مکمل کریں - اگر آپ عادت بنانے میں ہماری مدد چاہتے ہیں تو براہ کرم نوٹیفکیشنز کی اجازت دیں 😃۔';

  @override
  String get profileNameSave => 'محفوظ کریں';

  @override
  String get profileNameCancel => 'منسوخ کریں';

  @override
  String get profileNameGuest => 'مہمان';

  @override
  String get profileNameEdit => 'تدوین';

  @override
  String get profilePreferredLanguage => 'زبان:';

  @override
  String get okLabel => 'ٹھیک ہے';

  @override
  String get profileReciterLabel => 'قاری';

  @override
  String get profileFontLabel => 'فونٹ:';

  @override
  String get profileReciterMishary => 'مشاری راشد العفاسی';

  @override
  String get profileReciterShatri => 'ابو بکر الشاطری';

  @override
  String get profileReciterQatami => 'ناصر القطامی';

  @override
  String get profileUpgradePremiumTitle => 'مزید شخصی تبدیلیاں کھولیں!';

  @override
  String get profileUpgradePremiumBody => 'فونٹس اور قاری کو تبدیل کرنے سے لطف اندوز ہونے کے لیے پرو پر اپ گریڈ کریں۔ ہمارے مسلسل اقدامات کی حمایت کریں اور اپنے تجربے کو مزید ذاتی بنائیں!';

  @override
  String get profileWeeksProgress => 'ماشاء اللہ، یہ ہے آپ کی اس ہفتے کی پیش رفت:';

  @override
  String get profileGratefulnessCalendar => 'شکرگزاری کیلنڈر';

  @override
  String get profileQuranLearningCalendar => 'قرآن سیکھنے کا کیلنڈر';

  @override
  String get profilePrevWeekSemantic => 'گزشتہ ہفتے پر جائیں';

  @override
  String get profileNextWeekSemantic => 'اگلے ہفتے پر جائیں';

  @override
  String get profileNotificationFrequency => 'نوٹیفکیشن کی تکرار';

  @override
  String get commentE => 'شکرگزاری لاگ اسکرین کے اسٹرنگز';

  @override
  String get gratitudeLogTitle => 'میرا شکرگزاری لاگ';

  @override
  String get gratitudeLogBackArrowSemantic => 'ہوم پر واپس جائیں';

  @override
  String get gratitudeLogClearAllSemantic => 'شکرگزاری کی تمام اندراجات صاف کریں';

  @override
  String get gratitudeLogAddSemantic => 'نئی شکرگزاری اندراج شامل کریں';

  @override
  String get gratitudeLogClearDialogTitle => 'شکرگزاری لاگ صاف کریں';

  @override
  String get gratitudeLogClearDialogBody => 'کیا آپ واقعی اپنی تمام شکرگزاری اندراجات کو صاف کرنا چاہتے ہیں؟ یہ عمل واپس نہیں کیا جا سکتا۔';

  @override
  String get gratitudeLogClearConfirm => 'جی ہاں، صاف کریں';

  @override
  String gratitudeLogStreak(Object days) {
    return '⭐ شکرگزاری سلسلہ: $days دن';
  }

  @override
  String get gratitudeLogStreakLoading => 'سلسلہ گِنا جا رہا ہے...';

  @override
  String get gratitudeLogStreakError => 'سلسلے کا حساب لگانے میں ناکام۔';

  @override
  String gratitudeLogTotalDays(Object count) {
    return 'مجموعی شکرگزاری کے دن: $count';
  }

  @override
  String get gratitudeLogDataLoading => 'شکرگزاری کا ڈیٹا لوڈ ہو رہا ہے...';

  @override
  String get gratitudeLogDataError => 'شکرگزاری کا ڈیٹا لوڈ کرنے میں ناکام۔';

  @override
  String get gratitudeLogCardSemantic => 'شکرگزاری اندراج کارڈ';

  @override
  String get gratitudeLogItemIcon => 'شکرگزاری آئیکن';

  @override
  String get gratitudeLogEmptyIconSemantic => 'اپنی پہلی شکرگزاری شامل کرنے کے لیے ٹیپ کریں';

  @override
  String get gratitudeLogEmptyMessage => 'تاحال کوئی شکرگزاری اندراج نہیں۔\nپہلی شکرگزاری شامل کرنے کے لیے “+” پر ٹیپ کریں!';

  @override
  String get gratitudeLogEntriesAdded => 'شکرگزاری کامیابی سے شامل کی گئی!';

  @override
  String get gratitudeLogEntriesFailed => 'شکرگزاری شامل کرنے میں ناکام۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get commentF => 'سبق کی تکمیل کی اسکرین کے اسٹرنگز';

  @override
  String get lessonCompletedTitle => 'سبق مکمل ہوا';

  @override
  String get lessonCompletedBackArrowSemantic => 'ہوم پر واپس جائیں';

  @override
  String get lessonCompletedMashaAllah => 'ماشاء اللہ!';

  @override
  String get lessonCompletedMashaAllahSemantic => 'مبارک باد کا متن';

  @override
  String get lessonCompletedMessage => 'آپ نے یہ سبق مکمل کر لیا ہے!';

  @override
  String get lessonCompletedImageSemantic => 'حدہد قرآن کی عکاسی';

  @override
  String get lessonCompletedGoBackSemantic => 'راستے کے انتخاب پر واپس جائیں';

  @override
  String get lessonCompletedGoBackButton => 'راستے پر واپس جائیں';

  @override
  String get lessonCompletedRestartSemantic => 'سبق دوبارہ شروع کریں';

  @override
  String get lessonCompletedRestartButton => 'سبق دوبارہ شروع کریں';

  @override
  String get lessonCompletedEncouragement => 'اسی جذبے سے کام جاری رکھیں!';

  @override
  String get commentG => 'تھیم اسکرین کے اسٹرنگز';

  @override
  String get themeScreenTitle => 'تھیمز';

  @override
  String get themeNameCoreRecitation => 'روزانہ ضروری تلاوت';

  @override
  String get themeNameBeginJourney => 'سفر کا آغاز';

  @override
  String get themeNameMercyAndHope => 'رحمت اور امید';

  @override
  String get themeNameGratitudeReflection => 'شکر اور غور و فکر';

  @override
  String get themeNameStoriesReminders => 'کہانیاں، اسباق اور یاددہانیاں';

  @override
  String get themeNamePatience => 'صبر (Ṣabr)';

  @override
  String get themeNameUserCreated => 'صارف کی تیار کردہ';

  @override
  String get themeScreenNoThemesLabel => 'کوئی تھیم دستیاب نہیں';

  @override
  String get themeScreenBackArrowSemantic => 'پیچھے جائیں';

  @override
  String get themeScreenThemeCardSemantic => 'تھیم کے راستے کھولنے کے لیے ٹیپ کریں';

  @override
  String get themeScreenLockIconSemantic => 'تھیم مقفل ہے۔ اپ گریڈ درکار ہے۔';

  @override
  String get pathListExploreOtherThemes => 'دوسری تھیمز دریافت کریں';

  @override
  String get themeScreenUserCreatedSubtitle => 'آپ کے ذریعے بنائی گئی—جیسے چاہیں ذاتی بنائیں۔';

  @override
  String get themeSubtitleCoreRecitation => 'روزمرہ کی نمازوں اور تحفظ کے لیے ضروری سورتیں۔';

  @override
  String get themeSubtitleBeginJourney => 'آپ کے قرآنی سفر کی ابتدا کے لیے مختصر سورتیں۔';

  @override
  String get themeSubtitleMercyAndHope => 'اللہ کی رحمت اور امید افزائی کے پہلوؤں پر غور کریں۔';

  @override
  String get themeSubtitleGratitudeReflection => 'منتخب شدہ آیات کے ذریعے شکر اور اندرونی غور کو فروغ دیں۔';

  @override
  String get themeSubtitleStoriesReminders => 'قرآنی قصص دریافت کریں جو رہنمائی اور یاد دہانی فراہم کرتے ہیں۔';

  @override
  String get themeSubtitlePatience => 'صبر اور استقامت پر زور دینے والی سورتیں اور آیات۔';

  @override
  String get themeSubtitleDefault => 'روحانی ترقی کے لیے منتخب کردہ سورتوں کا مخصوص مجموعہ۔';

  @override
  String get themeScreenRequiredPremium => 'پریمیم درکار ہے';

  @override
  String get themeScreenRequiredPremiumPlus => 'پریمیم پلس درکار ہے';

  @override
  String get commentH => 'Path List اسکرین کے اسٹرنگز';

  @override
  String get pathListScreenTitle => 'تھیم کے راستے';

  @override
  String get pathListScreenBackArrowSemantic => 'واپس جائیں';

  @override
  String get pathListScreenAddIconSemantic => 'نیا راستہ شامل کریں';

  @override
  String get pathListAddNewPathTooltip => 'نیا راستہ شامل کریں';

  @override
  String get pathListScreenAddIconSemanticEmpty => 'اپنا پہلا راستہ شامل کرنے کے لیے ٹیپ کریں';

  @override
  String get pathListEmptyMessage => 'تاحال کوئی راستے نہیں۔\nاپنا پہلا راستہ بنانے کے لیے “+” کو ٹیپ کریں!';

  @override
  String get pathListUnavailableLabel => 'یہ راستہ اس وقت دستیاب نہیں';

  @override
  String get pathListThemeLabel => 'تھیم';

  @override
  String get pathListPathCardSemantic => 'راستے کی تفصیلات کھولنے کے لیے ٹیپ کریں';

  @override
  String get pathListCompleteIconSemantic => 'راستہ مکمل ہوا';

  @override
  String get pathListInProgressIconSemantic => 'راستہ جاری ہے';

  @override
  String get pathListInvalidIconSemantic => 'راستہ غلط یا دستیاب نہیں';

  @override
  String get pathListErrorLoadingPaths => 'راستے لوڈ کرتے وقت خرابی:';

  @override
  String get commentI => 'Path Detail اسکرین کے اسٹرنگز';

  @override
  String get pathDetailScreenTitle => 'راستے کی تفصیلات';

  @override
  String get pathDetailScreenBackArrowSemantic => 'راستوں کی فہرست پر واپس جائیں';

  @override
  String get pathDetailScreenNotFound => 'راستہ نہیں ملا۔';

  @override
  String get pathDetailScreenFailToUpdate => 'راستے کی پیش رفت اپ ڈیٹ کرنے میں ناکامی:';

  @override
  String get pathDetailScreenProgressDisabled => 'اس راستے کے لیے پیش رفت غیر فعال ہے۔';

  @override
  String get pathDetailScreenLessonsHeading => 'اسبا‍ق:';

  @override
  String get pathDetailScreenNoLessonsLabel => 'کوئی سبق دستیاب نہیں۔';

  @override
  String get pathDetailScreenErrorLoading => 'راستہ یا اسباق لوڈ کرنے میں خرابی:';

  @override
  String get pathDetailScreenLessonCardSemantic => 'سبق کی تفصیلات کھولنے کے لیے ٹیپ کریں';

  @override
  String get pathDetailScreenLessonCompleteIconSemantic => 'سبق مکمل ہوا';

  @override
  String get pathDetailScreenLessonInProgressIconSemantic => 'سبق جاری ہے';

  @override
  String get pathDetailScreenLessonInvalidIconSemantic => 'سبق غلط یا دستیاب نہیں';

  @override
  String get pathDetailScreenLessonProgressUnavailable => 'پیش رفت دستیاب نہیں';

  @override
  String get pathDetailScreenLessonNoProgress => 'اس راستے کے لیے کوئی پیش رفت نہیں ہے';

  @override
  String get pathDetailScreenLessonUpgrade => 'پیش رفت کی خصوصیات کے لیے اپ گریڈ کریں۔';

  @override
  String pathDetailScreenLessonProgressLabel(Object progress) {
    return 'پیش رفت: $progress%';
  }

  @override
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah) {
    return 'سبق $lessonIndex: $surahName - آیت $startAyah-$endAyah';
  }

  @override
  String get commentJ => 'نیا راستہ بنانے کی اسکرین کے اسٹرنگز';

  @override
  String get createPathTitle => 'نیا راستہ بنائیں';

  @override
  String get createPathBackArrowSemantic => 'پچھلی اسکرین پر واپس جائیں';

  @override
  String get createPathNameLabel => 'راستے کا نام';

  @override
  String get createPathNameValidation => 'براہ کرم راستے کا نام درج کریں';

  @override
  String get createPathDescriptionLabel => 'تفصیل';

  @override
  String get createPathDescriptionValidation => 'براہ کرم تفصیل درج کریں';

  @override
  String get createPathSurahSelectorLabel => 'سورۃ منتخب کریں:';

  @override
  String get createPathStartAyahLabel => 'آغاز کی آیت';

  @override
  String get createPathNumAyahsLabel => 'راستے میں شامل کی جانے والی آیات کی تعداد';

  @override
  String get createPathEndAyahLabel => 'اختتامی آیت';

  @override
  String get createPathWordsPerLessonLabel => 'ہر سبق میں کتنے الفاظ';

  @override
  String get createPathWordsSuffix => 'الفاظ';

  @override
  String get createPathInvalidRange => 'غلط رینج';

  @override
  String get createPathAyahsSuffix => 'آیات';

  @override
  String get createPathCreateButton => 'راستہ بنائیں';

  @override
  String get createPathSubmitSemantic => 'راستہ بنانے کے لیے ٹیپ کریں';

  @override
  String get commentK => 'ترجمہ اسکرین کے اسٹرنگز';

  @override
  String get translationScreenTitle => 'ترجمہ';

  @override
  String get translationScreenBackArrowSemantic => 'سبق پر واپس جائیں';

  @override
  String get translationScreenLoadingSemantic => 'ترجمے لوڈ ہو رہے ہیں';

  @override
  String get translationScreenNoTranslations => 'کوئی ترجمہ دستیاب نہیں۔';

  @override
  String get translationScreenReturnButton => 'سبق پر واپس جائیں';

  @override
  String get translationScreenReturnSemantic => 'سبق پر واپس جانے کے لیے ٹیپ کریں';

  @override
  String get translationScreenLoadError => 'ترجمے لوڈ کرنے میں خرابی:';

  @override
  String get commentL => 'زبان کے انتخاب کی اسکرین کے اسٹرنگز';

  @override
  String get languageSelectionScreenSemantic => 'زبان کے انتخاب کی اسکرین';

  @override
  String get languageSelectionTitle => 'اپنی زبان منتخب کریں';

  @override
  String get languageSelectionBackSemantic => 'واپس';

  @override
  String get languageSelectionSkipSemantic => 'انتخاب چھوڑ دیں';

  @override
  String get languageSelectionInstructions => 'براہ کرم اپنی ترجیحی زبان منتخب کریں:';

  @override
  String get languageSelectionNextSemantic => 'زبان کے انتخاب کی تصدیق کرنے کے لیے ٹیپ کریں';

  @override
  String get languageSelectionNextLabel => 'اگلا';

  @override
  String get languageSelectionImageSemantic => 'حدہد قرآن کی عکاسی';

  @override
  String get commentM => 'ویلکم اسکرین کے اسٹرنگز';

  @override
  String get welcomeScreenSemantic => 'آن بورڈنگ ویلکم اسکرین';

  @override
  String get welcomeScreenLogoSemantic => 'حدہد قرآن کی عکاسی';

  @override
  String get welcomeScreenSkipSemantic => 'ویلکم مرحلے کو چھوڑ دیں';

  @override
  String get welcomeScreenNextSemantic => 'اگلے آن بورڈنگ مرحلے کی طرف بڑھیں';

  @override
  String get commentN => 'حدہد انفو اسکرین کے اسٹرنگز';

  @override
  String get hudhudInfoSemantic => 'حدہد معلوماتی اسکرین';

  @override
  String get hudhudInfoAppBarTitle => 'حدہد سے ملیے';

  @override
  String get hudhudInfoIllustrationSemantic => 'حدہد کی عکاسی';

  @override
  String get hudhudInfoBody1 => 'حدہد جسے hoopoe برڈ کے نام سے بھی جانا جاتا ہے، نے مشاہدہ کرنے اور پیغامات پہنچانے کے ذریعے حضرت سلیمان علیہ السلام کی مدد میں ایک خاص کردار ادا کیا۔';

  @override
  String get hudhudInfoBody2 => 'حدہد کی کہانی ہمیں یاد دلاتی ہے کہ ایک چھوٹا سا جاندار بھی صحیح چیزوں پر غور، تجسس اور عملی اقدام کے ذریعے بہت بڑا اثر ڈال سکتا ہے۔ اپنے سفر میں ہم قرآن کی خوبصورتی پر مسلسل توجہ مرکوز کر سکتے ہیں اور ہر لمحے کی پیش رفت پر شکر کو شامل کر سکتے ہیں۔';

  @override
  String get hudhudInfoBody3 => 'حدہد کی مثال پر عمل کر کے—ہمہ وقت باخبر اور مصروف رہتے ہوئے—ہم قرآن کے ساتھ اپنے تعلق کو گہرا کر سکتے ہیں اور روزمرہ زندگی میں شکر کے احساس کو پروان چڑھا سکتے ہیں۔';

  @override
  String get hudhudInfoNextLabel => 'اگلا';

  @override
  String get hudhudInfoNextSemantic => 'اگلے حصے کی طرف بڑھیں';

  @override
  String get hudhudInfoSkipSemantic => 'حدہد کی معلوماتی مرحلہ چھوڑ دیں';

  @override
  String get commentO => 'سبسکرپشن ٹیئر اسکرین کے اسٹرنگز';

  @override
  String get subscriptionTierScreenSemantic => 'سبسکرپشن کی سطح منتخب کرنے کی اسکرین';

  @override
  String get subscriptionTierScreenAppBarTitle => 'اپنا پلان منتخب کریں';

  @override
  String get subscriptionTierScreenSkipSemantic => 'سبسکرپشن ٹیئر کے انتخاب کو چھوڑ دیں';

  @override
  String get subscriptionTierScreenFreeLabel => 'مفت';

  @override
  String get subscriptionTierScreenSmileySemantic => 'مسکراہٹ والا چہرہ آئیکن';

  @override
  String get subscriptionTierScreenDonationText => 'موصول ہونے والے فنڈز کا ایک حصہ Almubtasim انیشی ایٹو کو جائے گا جو Islamic Relief کے ذریعے یتیموں کی مدد کرتا ہے۔';

  @override
  String get subscriptionTierScreenConfirmSemantic => 'سبسکرپشن ٹیئر کے انتخاب کی تصدیق کریں';

  @override
  String get subscriptionTierScreenNextLabel => 'اگلا';

  @override
  String subscriptionTierScreenRadioSemantic(Object title) {
    return '$title سبسکرپشن ٹیئر منتخب کرنے کے لیے ٹیپ کریں';
  }

  @override
  String get commentP => 'ہدف کے انتخاب کی اسکرین کے اسٹرنگز';

  @override
  String get goalSelectionScreenSemantic => 'ہدف کے انتخاب کی اسکرین';

  @override
  String get goalSelectionScreenAppBarTitle => 'اپنے اہداف منتخب کریں';

  @override
  String get goalSelectionScreenSkipSemantic => 'ہدف کا انتخاب چھوڑ دیں';

  @override
  String get goalSelectionScreenIntroText => 'مندرجہ ذیل میں سے کون سے اہداف آپ کی توجہ کا باعث ہیں؟ آپ متعدد اختیارات منتخب کر سکتے ہیں۔';

  @override
  String get goalSelectionScreenNextSemantic => 'ہدف انتخاب کی تصدیق کریں';

  @override
  String get goalSelectionScreenNextLabel => 'اگلا';

  @override
  String goalSelectionTileSemantic(Object goalTitle) {
    return '$goalTitle ہدف کا آپشن منتخب یا اَن سیلیکٹ کرنے کے لیے ٹیپ کریں';
  }

  @override
  String get goalConnectQuranTitle => 'قرآن سے مزید جڑیں';

  @override
  String get goalConnectQuranDesc => 'تلاوت یا غور و فکر کے ذریعے اپنے تعلق کو بہتر بنائیں۔';

  @override
  String get goalMemorizeQuranTitle => 'قرآن حفظ کریں';

  @override
  String get goalMemorizeQuranDesc => 'حفظ کا سفر شروع کریں۔';

  @override
  String get goalBeMoreGratefulTitle => 'زندگی میں مزید شکر گزار اور خوش رہیں';

  @override
  String get goalBeMoreGratefulDesc => 'روزمرہ کی شکرگزاری کی مشق پر توجہ دیں۔';

  @override
  String get goalBuildConsistencyTitle => 'استقامت قائم کریں';

  @override
  String get goalBuildConsistencyDesc => 'روزانہ یا ہفتہ وار عادت تشکیل دیں۔';

  @override
  String get goalImproveArabicTitle => 'اپنی عربی بہتر کریں';

  @override
  String get goalImproveArabicDesc => 'تحریری یا زبانی زبان کی مہارت پر توجہ دیں۔';

  @override
  String get goalDeepenTafsirTitle => 'تفسیر میں گہرائی پیدا کریں';

  @override
  String get goalDeepenTafsirDesc => 'تفسیر اور قرآن کے گہرے مفاہیم کا مطالعہ کریں۔';

  @override
  String get goalOtherTitle => 'دیگر';

  @override
  String get goalOtherDesc => 'کوئی بھی ذاتی مقصد حاصل کریں۔';

  @override
  String get commentQ => 'سطح کے انتخاب کی اسکرین کے اسٹرنگز';

  @override
  String get levelSelectionScreenSemantic => 'سطح کے انتخاب کی اسکرین';

  @override
  String get levelSelectionScreenAppBarTitle => 'اپنی سطح منتخب کریں';

  @override
  String get levelSelectionScreenSkipSemantic => 'سطح کے انتخاب کو چھوڑ دیں';

  @override
  String get levelSelectionScreenIntroText => 'براہ کرم وہ آپشن منتخب کریں جو آپ کی موجودہ تلاوت کی سطح کو بہتر طور پر بیان کرتا ہو:';

  @override
  String get levelStarterLabel => 'شروعاتی';

  @override
  String get levelStarterDescription => 'نئے یا کبھی کبھار سیکھنے والے جو قرآن کی تلاوت کا آغاز کر رہے ہیں۔';

  @override
  String get levelAdvancedLabel => 'ایڈوانسڈ';

  @override
  String get levelAdvancedDescription => 'عربی متن پڑھنے میں آسانی، کچھ تجوید کی واقفیت رکھتے ہیں۔';

  @override
  String get levelQariLabel => 'قاری';

  @override
  String get levelQariDescription => 'ماہر قاری جن کی تجوید میں عمدہ دسترس ہے۔';

  @override
  String get levelSelectionNextSemantic => 'سطح کے انتخاب کی تصدیق کریں';

  @override
  String get levelSelectionNextLabel => 'اگلا';

  @override
  String levelSelectionTileSemantic(Object levelTitle) {
    return '$levelTitle تلاوت کی سطح کا آپشن منتخب کرنے کے لیے ٹیپ کریں';
  }

  @override
  String get commentR => 'آن بورڈنگ مکمل ہونے کی اسکرین کے اسٹرنگز';

  @override
  String get onboardingCompletionScreenSemantic => 'آن بورڈنگ مکمل ہونے کی اسکرین';

  @override
  String get onboardingCompletionScreenAppBarTitle => 'سب سیٹ!';

  @override
  String get onboardingCompletionScreenImageSemantic => 'حدہد قرآن کی عکاسی';

  @override
  String get onboardingCompletionScreenBody1 => 'مبارک ہو! آپ نے کامیابی سے سیٹ اپ مکمل کر لیا ہے۔ ہمیں امید ہے کہ یہ سفر آپ کو قرآن کے قریب کرے گا اور اللہ کے لیے آپ کا شکر بڑھائے گا۔\n\nاللہ کرے یہ ایپ آپ کی زندگی اور ان لوگوں کی زندگیوں میں برکت اور ترقی کا ذریعہ بنے جن تک آپ پہنچیں۔';

  @override
  String get onboardingCompletionScreenBody2 => 'جب آپ تیار ہوں، تو نیچے دیے گئے بٹن پر ٹیپ کریں۔ بنیادی حفظ اور پیش رفت کی خصوصیات آپ کی منتظر ہیں۔ آپ شکر کو لاگ کر سکتے ہیں یا نیویگیشن بار سے ایک راستہ منتخب کر سکتے ہیں۔';

  @override
  String get onboardingCompletionScreenBody3 => 'یہ ابھی ابتدائی ورژن ہے — ہم آپ کی حمایت اور صبر کے شکر گزار ہیں اور بہت جلد مزید خصوصیات دینے کی امید رکھتے ہیں ان شاء اللہ!';

  @override
  String get onboardingCompletionScreenBeginSemantic => 'ایپ کا استعمال شروع کریں';

  @override
  String get onboardingCompletionScreenBeginLabel => 'آیئے شروع کریں';

  @override
  String get commentS => 'نام درج کرنے کی اسکرین کے اسٹرنگز';

  @override
  String get nameEntryScreenSemantic => 'نام درج کرنے کی اسکرین';

  @override
  String get nameEntryScreenAppBarTitle => 'آپ کا پروفائل';

  @override
  String get nameEntryScreenSkipSemantic => 'اپنا نام درج کرنے کو چھوڑ دیں';

  @override
  String get nameEntryScreenIntroText => 'آپ کا نام کیا ہے؟';

  @override
  String get nameEntryTextFieldSemantic => 'نام درج کرنے کا ٹیکسٹ فیلڈ';

  @override
  String get nameEntryNextSemantic => 'نام درج کرنے کی تصدیق کریں';

  @override
  String get nameEntryNextLabel => 'اگلا';

  @override
  String get commentT => 'VerticalLessonIcons کے اسٹرنگز';

  @override
  String get verticalLessonIconsSemantic => 'عمودی سبق کے آئیکنز کا کنٹینر';

  @override
  String get verticalLessonIconsNoLessons => 'کوئی سبق نہیں ملا۔';

  @override
  String get verticalLessonIconsLoadingSurah => 'سورۃ کی تفصیلات لوڈ ہو رہی ہیں';

  @override
  String get verticalLessonIconsErrorSurah => 'سورۃ کی تفصیلات لوڈ کرنے میں خرابی';

  @override
  String get verticalLessonIconsSurahHeaderSemantic => 'سورۃ کی تفصیلات کی سرخی';

  @override
  String get verticalLessonIconsHudhudIconSemantic => 'حدہد ہیلپر آئیکن';

  @override
  String get verticalLessonIconsNextPageSemantic => 'اگلے صفحے کا تیر';

  @override
  String get verticalLessonIconsPreviousPageSemantic => 'پچھلے صفحے کا تیر';

  @override
  String get verticalLessonIconsLoadingProgress => 'سبق کی پیش رفت لوڈ ہو رہی ہے';

  @override
  String get verticalLessonIconsErrorProgress => 'پیش رفت لوڈ کرنے میں خرابی';

  @override
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent) {
    return 'سبق آئیکن, $surahAyahRange, پیش رفت $percent%';
  }

  @override
  String get verticalLessonIconsCompletedSemantic => 'سبق مکمل ہوا';

  @override
  String get verticalLessonIconsDialogTitle => 'سپورٹ اور اپ گریڈ';

  @override
  String get verticalLessonIconsDialogOk => 'ٹھیک ہے';

  @override
  String get commentU => 'نیویگیشن بار کے اسٹرنگز';

  @override
  String get navBarSemanticLabel => 'نیچے کا نیویگیشن بار';

  @override
  String get navHomeLabel => 'ہوم';

  @override
  String get navHomeSemantic => 'ہوم ٹیب';

  @override
  String get navQuranLabel => 'قرآن';

  @override
  String get navQuranSemantic => 'قرآن ٹیب';

  @override
  String get navGratitudeLabel => 'شکرگزاری';

  @override
  String get navGratitudeSemantic => 'شکرگزاری ٹیب';

  @override
  String get navProfileLabel => 'پروفائل';

  @override
  String get navProfileSemantic => 'پروفائل ٹیب';

  @override
  String get commentV => 'ٹاپ بار کے اسٹرنگز';

  @override
  String get topBarSemanticLabel => 'اوپر کا نیویگیشن بار';

  @override
  String topBarTitleSemantic(Object title) {
    return 'ٹاپ بار کا عنوان: $title';
  }

  @override
  String topBarStreakIconSemantic(Object days) {
    return 'سلسلے کا آئیکن: $days دن';
  }

  @override
  String get topBarStreakDialogBody => 'یہ ظاہر کرتا ہے کہ آپ نے کتنے مسلسل دن قرآن کی تلاوت کی یا شکر لکھا ہے۔ سلسلے کو برقرار رکھنے یا بڑھانے کے لیے جاری رکھیں!';

  @override
  String get topBarHudhudIconSemantic => 'حدہد آئیکن، سپورٹ کے لیے ٹیپ کریں';

  @override
  String get topBarHudhudDialogTitle => 'سپورٹ اور اپ گریڈ';

  @override
  String get topBarHudhudDialogBody => 'تمام خصوصیات مفت ورژن میں دستیاب ہیں، لیکن اگر آپ چاہیں تو مزید فیچرز کی تیاری میں ہماری مدد کرسکتے ہیں۔ آپ کی سبسکرپشن کا ایک حصہ Islamic Relief کو عطیہ کیا جاتا ہے۔ جزاک اللہ خیراً!';

  @override
  String get commentW => 'شکر کا موڈل کے اسٹرنگز';

  @override
  String get gratitudeModalSemantic => 'شکر کا موڈل ڈائیلاگ';

  @override
  String get gratitudeModalTitle => 'ان آیات کی بنیاد پر آج آپ کس چیز پر شکر ادا کرتے ہیں؟';

  @override
  String gratitudeModalHint(Object index) {
    return 'الحمد للہ (یہاں شکر درج کریں) #$index';
  }

  @override
  String gratitudeModalTextFieldSemantic(Object index) {
    return '#$index نمبر کی شکر درج کریں';
  }

  @override
  String get gratitudeModalEmptyWarning => 'برائے مہربانی کم از کم ایک شکر درج کریں۔';

  @override
  String get gratitudeModalSubmitError => 'شکر نوٹ کرنے میں ناکامی۔ دوبارہ کوشش کریں۔';

  @override
  String get dailyVoiceLimitReachedTitle => 'ماشاء اللہ!';

  @override
  String get dailyVoiceLimitReachedMessage => 'آپ نے قرآن کی آواز میں تلاوت کے 10 منٹ مکمل کر لیے ہیں۔ براہ کرم تحریری مشق جاری رکھیں اور کل دوبارہ تلاوت کریں۔';

  @override
  String get upgradeVoiceUsageTitle => 'پریمیم میں اپ گریڈ کریں';

  @override
  String get gratitudeModalLoadingSemantic => 'شکر کا اندراج جاری ہے';

  @override
  String get commentX => '== نئے کیز: submission_feedback_modal, progress_bar, surah_selector ==';

  @override
  String get submissionFeedbackModalSemanticLabel => 'جمع کروانے کا فیڈبیک ڈائیلاگ';

  @override
  String get submissionFeedbackModalTitle => 'جمع کروانے کا فیڈبیک';

  @override
  String get submissionFeedbackModalNoNew => 'کوئی نئی شکرگزاری جمع نہیں ہوئی۔';

  @override
  String get submissionFeedbackModalYouSubmitted => 'آپ نے یہ شکر درج کی ہیں:';

  @override
  String submissionFeedbackModalStreak(Object days) {
    return 'موجودہ شکرگزاری سلسلہ: $days دن';
  }

  @override
  String submissionFeedbackModalTotalDays(Object count) {
    return 'مجموعی شکرگزاری کے دن: $count';
  }

  @override
  String get submissionFeedbackModalLoading => 'آپ کا شکرگزاری ڈیٹا لوڈ ہو رہا ہے...';

  @override
  String get submissionFeedbackModalError => 'شکرگزاری کا ڈیٹا لوڈ نہیں کر سکے۔';

  @override
  String get submissionFeedbackModalViewLog => 'لاگ دیکھیں';

  @override
  String get submissionFeedbackModalClose => 'بند کریں';

  @override
  String progressBarSemanticLabel(Object percent) {
    return 'پیش رفت: $percent%';
  }

  @override
  String get surahSelectorSemanticLabel => 'ایک سورہ منتخب کریں';

  @override
  String get commentZ => 'سسٹم ڈیفائن کیے گئے راستوں کے لیے لوکلائزایبل راستوں کے نام اور وضاحتیں';

  @override
  String get pathNameFatihah => 'سورہ الفاتحہ';

  @override
  String get pathDescFatihah => 'مکمل سورہ (1:1–7)۔ ہر رکعت کے لیے ضروری۔';

  @override
  String get pathNameKafirun => 'سورہ الکافرون';

  @override
  String get pathDescKafirun => 'مکمل سورہ (109:1–6)۔ توحید کا بیان۔';

  @override
  String get pathNameIkhlas => 'سورہ الاخلاص';

  @override
  String get pathDescIkhlas => 'مکمل سورہ (112:1–4)۔ اللہ کی توحید۔';

  @override
  String get pathNameFalaq => 'سورہ الفلق';

  @override
  String get pathDescFalaq => 'مکمل سورہ (113:1–5)۔ بیرونی برائیوں سے پناہ مانگنا۔';

  @override
  String get pathNameNas => 'سورہ الناس';

  @override
  String get pathDescNas => 'مکمل سورہ (114:1–6)۔ اندرونی وسوسوں سے پناہ مانگنا۔';

  @override
  String get pathNameAsrBegin => 'سورہ العصر';

  @override
  String get pathDescAsrBegin => '(103:1–3)۔ صرف 3 آیات لیکن “صبر” کے لیے بنیادی۔';

  @override
  String get pathNameTakathur => 'سورہ التکاثر';

  @override
  String get pathDescTakathur => '(102:1–8) دنیاوی مقابلہ بازی اور احتساب کے بارے میں۔';

  @override
  String get pathNameFil => 'سورہ الفیل';

  @override
  String get pathDescFil => '(105:1–5)۔ اصحاب فیل کا واقعہ؛ 5 مختصر آیات۔';

  @override
  String get pathNameQuraysh => 'سورہ قریش';

  @override
  String get pathDescQuraysh => '(106:1–4)۔ محفوظ سفر پر شکر کا بیان۔';

  @override
  String get pathNameRahmanA => 'الرحمن A';

  @override
  String get pathDescRahmanA => '(55:1–13): قرآن کی تعلیم اور انسان کی تخلیق۔';

  @override
  String get pathNameRahmanB => 'الرحمن B';

  @override
  String get pathDescRahmanB => '(55:26–36): انسان اور جن کی جواب دہی۔';

  @override
  String get pathNameYasinBlock => 'سورہ یٰس (حصہ)';

  @override
  String get pathDescYasinBlock => '(36:1–12)۔ نبی ﷺ کے پیغام اور تنبیہہ کا تعارف۔';

  @override
  String get pathNameMulkBlock => 'سورہ الملک (حصہ)';

  @override
  String get pathDescMulkBlock => '(67:1–15)۔ اللہ کی بادشاہی اور تدبر پر زور۔';

  @override
  String get pathNameBaqarah21_29 => 'البقرہ (2:21–29)';

  @override
  String get pathDescBaqarah21_29 => '9 آیات، تخلیق اور شکر پر غور۔';

  @override
  String get pathNameNahl66_72 => 'النحل (16:66–72)';

  @override
  String get pathDescNahl66_72 => '7 آیات، نعمتوں کا بیان: مویشی، پھل وغیرہ۔';

  @override
  String get pathNameAdDuha => 'سورہ الضحیٰ';

  @override
  String get pathDescAdDuha => '(93:1–11) 11 آیات پر مشتمل امید اور تسلی۔';

  @override
  String get pathNameKahfCave => 'الکہف: غار کے نوجوان';

  @override
  String get pathDescKahfCave => '(18:9–16) غار میں پناہ لینے والے نوجوان مومنوں کی کہانی۔';

  @override
  String get pathNameKahfMusa => 'الکہف: موسیٰ اور خضر';

  @override
  String get pathDescKahfMusa => '(18:60–70) صبر اور پوشیدہ حکمت پر زور۔';

  @override
  String get pathNameWaqiah => 'الواقعہ (56:1–15)';

  @override
  String get pathDescWaqiah => '15 آیات، قیامت کے اچانک آنے کے متعلق۔';

  @override
  String get pathNameAsrPatience => 'سورہ العصر (صبر)';

  @override
  String get pathDescAsrPatience => '(103:1–3) دوبارہ، 3 آیات، صبر کے حوالے سے مشہور۔';

  @override
  String get pathNameBaq153_157 => 'البقرہ (2:153–157)';

  @override
  String get pathDescBaq153_157 => '5 آیات: “صبر اور نماز سے مدد چاہو۔”';

  @override
  String get pathNameYusuf7_14 => 'سورہ یوسف (12:7–14)';

  @override
  String get pathDescYusuf7_14 => 'حضرت یوسف کے بھائیوں کی حسد۔ صبر کی آزمائش۔';

  @override
  String get pathNameYusuf83_92 => 'سورہ یوسف (12:83–92)';

  @override
  String get pathDescYusuf83_92 => 'حضرت یعقوب کا غم اور حضرت یوسف کی بخشش (10 آیات)۔';

  @override
  String get pathNameInshirah => 'سورہ الانشراح (94:1–8)';

  @override
  String get pathDescInshirah => '8 آیات: مصیبت کے بعد آسانی کی یقین دہانی۔ صبر اور امید سے جڑا ہوا۔';

  @override
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah) {
    return 'سورہ $surahName, آیت $startAyah-$endAyah';
  }

  @override
  String get finishLabel => 'مکمل کریں';

  @override
  String get twoWordMultipleChoiceLabel => 'درست دو الفاظ منتخب کریں';

  @override
  String get singleWordMultipleChoiceLabel => 'درست لفظ منتخب کریں';

  @override
  String get correctAnswerLabel => 'درست!';

  @override
  String get incorrectAnswerLabel => 'غلط!';

  @override
  String get lessonCompletedLabel => 'سبق مکمل ہوا!';

  @override
  String get profileAnalyticsScoreLabel => 'تجزیات اور اسکور';

  @override
  String get profileDailyLabel => 'روزانہ';

  @override
  String get profileWeeklyLabel => 'ہفتہ وار';

  @override
  String get profileMonthlyLabel => 'ماہانہ';

  @override
  String get profileTotalLabel => 'کل';

  @override
  String get profileViewChart => 'چارٹ دیکھیں';

  @override
  String get profileCloseLabel => 'بند کریں';

  @override
  String get profileScoreChartTitle => 'اسکور چارٹ';

  @override
  String get profileScoreChartHistory => 'تاریخچہ';

  @override
  String get profileNoData => 'کوئی ڈیٹا نہیں';

  @override
  String get topBarDailyScoreLabel => '⭐ آج';

  @override
  String topBarDailyScoreSemantic(Object score) {
    return 'آپ کا روزانہ اسکور $score ہے';
  }

  @override
  String get profilePremiumNeeded => 'براہ کرم ترقی کریں تاکہ آپ ترقی کا کیلنڈر دیکھ سکیں اور انشاءاللہ مزید خصوصیات کی تعمیر میں ہماری مدد کریں!';

  @override
  String get levelMultipleChoiceLabel => 'کثیر انتخاب';

  @override
  String get levelMultipleChoiceDescription => 'ایک یا دو لفظ پر مشتمل کثیر انتخابی مراحل، جو جوڑوں کو اختیاری طور پر چھوڑنے کی سہولت رکھتے ہیں۔';

  @override
  String get levelBeginnerLabel => 'ابتدائی';

  @override
  String get levelBeginnerDescription => 'الفاظ کو بتدریج حذف کرنا، گروہ بندی کے ساتھ، تاکہ آہستہ آہستہ حفظ کرنے میں آسانی ہو۔';

  @override
  String get subscriptionTierScreenPremiumLabel => 'Plus';

  @override
  String get featureUnavailableOffline => 'یہ فیچر آف لائن دستیاب نہیں۔ براہ کرم کنیکٹ کریں یا پلس یا پرو بیٹا میں اپ گریڈ کرکے آف لائن موڈ کو فعال کریں۔';

  @override
  String submissionFeedbackModalTotalCount(Object count) {
    return 'شکرگزاری کے درج کردہ اندراجات کی کل تعداد: $count';
  }

  @override
  String get notificationDailyTitle => 'ہلکی سی قرآن پاک یاد دہانی';

  @override
  String get notificationWeeklyTitle => 'ہفتہ وار قرآن جائزہ';

  @override
  String get notificationWeeklyBody => 'اپنی پیشرفت پر غور کریں اور شکرگزاری کی مشق کرتے ہوئے قرآن پاک کا ایک نیا حصہ یاد کریں۔';

  @override
  String get notificationChannelDailyRemindersName => 'روزانہ یاد دہانیاں';

  @override
  String get notificationChannelDailyRemindersDesc => 'روزانہ قرآن پاک حفظ کی یاد دہانیاں';

  @override
  String get notificationChannelWeeklyRemindersName => 'ہفتہ وار یاد دہانیاں';

  @override
  String get notificationChannelWeeklyRemindersDesc => 'قرآن پاک کے ہفتہ وار حفظ جائزے کی یاد دہانیاں';

  @override
  String get nameEntryNotificationFrequencyDaily => 'روزانہ';

  @override
  String get topBarStreakDialogTitle => 'سلسلہ';

  @override
  String get fillInTheBlanksLabel => 'خالی جگہیں پُر کریں';

  @override
  String get loadingDataLabel => 'لوڈ ہو رہا ہے…';

  @override
  String ayahRangeLabel(Object start, Object end) {
    return 'آیت $start - $end';
  }

  @override
  String get nextPageSemanticLabel => 'اگلا صفحہ';

  @override
  String get prevPageSemanticLabel => 'پچھلا صفحہ';

  @override
  String pageXOfYLabel(Object current, Object total) {
    return 'صفحہ $current کا $total';
  }

  @override
  String verseSemanticLabel(Object ayahNumber, Object surahName) {
    return 'آیت نمبر $ayahNumber، سورۃ $surahName سے';
  }

  @override
  String get ayahLabel => 'آیت';

  @override
  String get goToSurahViewLabel => 'سورۃ ویو';

  @override
  String get clickOnAyaToOpenLesson => 'سبق شروع کرنے کے لیے نیچے دی گئی کسی بھی آیت پر کلک کریں';

  @override
  String get difficultyChoosingScreenIntro => 'اپنی ترجیح منتخب کریں: ملٹی پل چوائس یا خالی جگہیں پُر کریں، اور ہر مرحلے اور آڈیو پلے کو کتنی بار دہرایا جائے۔';

  @override
  String get upgradeVoiceUsageMessage => 'صوتی فیچر کو آزمانے اور اسے بہتر بنانے میں ہماری مدد کرنے کے لیے Pro Beta میں اپ گریڈ کریں!';

  @override
  String get restorePurchasesLabel => 'خریداریوں کو بحال کریں';

  @override
  String get subscriptionTierScreenMonthly => 'ماہانہ';

  @override
  String get subscriptionTierScreenYearly => 'سالانہ';

  @override
  String get subscriptionTierScreenFreePrice => 'مفت';

  @override
  String get subscriptionTierScreenPremiumMonthlyPrice => 'اب \$3/ماہ (پہلے \$5)';

  @override
  String get subscriptionTierScreenPremiumYearlyPrice => 'اب \$28/سال (پہلے \$60)';

  @override
  String get subscriptionTierScreenPremiumPlusMonthlyPrice => 'اب \$7/ماہ (پہلے \$10)';

  @override
  String get subscriptionTierScreenPremiumPlusYearlyPrice => 'اب \$45/سال (پہلے \$84)';

  @override
  String get subscriptionPurchaseError => 'سبسکرپشن خریدنے میں خرابی پیش آگئی';

  @override
  String get topBarExplorePlansLabel => 'منصوبے دریافت کریں';

  @override
  String get topBarBackHomeLabel => 'واپس ہوم پر';

  @override
  String get profileRequiresPlanUpdate => 'پلان اپ ڈیٹ درکار ہے';

  @override
  String get subscriptionTierScreenPremiumDescription => 'مفت ورژن میں شامل سب کچھ، مزید آف لائن اسباق کا سیکھنا اور فیڈبیک، سابقہ تجزیات، نیز ترقی کے اشارے، پروفائل، اور قرآن کی حسبِ ضرورت تخصیص۔ مزید خصوصیات کی تیاری میں ہمارا ساتھ دیں!';

  @override
  String get subscriptionAutoRenewNotice => 'سبسکرپشن خود کار طریقے سے تجدید ہوگی، اور اگلی مدت کے بل سے بچنے کے لیے منسوخ کی جاسکتی ہے۔ جمع شدہ رقوم کا ایک حصہ المبتسم انیشی ایٹیو 😀 کے ذریعے Islamic Relief کو عطیہ کیا جائے گا۔';

  @override
  String get subscriptionTierScreenSubscribeLabel => 'سبسکرائب کریں';

  @override
  String get subscriptionTierScreenFinalMessage => 'ہم آپ کی سپورٹ کی قدر کرتے ہیں!';

  @override
  String get subscriptionPurchaseRestoreSuccess => 'آپ کی خریداریوں کو کامیابی کے ساتھ بحال کر دیا گیا ہے۔';

  @override
  String get subscriptionTierScreenRestoreLabel => 'خریداریوں کو بحال کریں';

  @override
  String get arabicLabel => 'عربی';

  @override
  String get transliterationLabel => 'انگریزی';

  @override
  String get surahSearchScreenTitle => 'سورہ تلاش کریں';

  @override
  String get genericBack => 'واپس';

  @override
  String get surahSearchSelectSurah => 'ایک سورہ منتخب کریں:';

  @override
  String get surahSearchExistingPaths => 'اس سورۃ کے لیے دستیاب راستے';

  @override
  String get surahSearchNoMatches => 'کوئی موجودہ راستہ نہیں ملا۔';

  @override
  String get surahSearchHideCreateForm => 'تخلیق فارم چھپائیں';

  @override
  String get surahSearchShowCreateForm => 'سورۃ کے لیے نیا راستہ بنائیں';

  @override
  String get createPathTrackProgress => 'ترقی کو ٹریک کریں؟';

  @override
  String get themeScreenSearchIconSemantic => 'سورتوں کی تلاش';

  @override
  String get pathListSearchIconSemantic => 'سورتوں کی تلاش';

  @override
  String get pathLessonsSearchIconSemantic => 'سورتوں کی تلاش';

  @override
  String get playAllSurahSemantic => 'پوری سورۃ چلائیں';

  @override
  String get toggleTransliterationLabel => 'ترجمہ حرفی کو ٹوگل کریں';

  @override
  String get englishLabel => 'انگریزی';

  @override
  String get subscriptionTierScreenPremiumPlusLabel => 'ہماری مدد کریں (سالانہ)';

  @override
  String get subscriptionTierScreenFreeDescription => 'تمام خصوصیات مفت اور اشتہارات سے پاک ہیں!';

  @override
  String get subscriptionTierScreenPremiumPlusDescription => 'نئی خصوصیات اور بہتری کے لیے مالی معاونت کریں! نیز، تھوڑا سا سرمایہ لگانا عادت ڈالنے میں مددگار ثابت ہوسکتا ہے!';

  @override
  String get subscriptionTierScreenSupportLabel => 'سالانہ سپورٹ';

  @override
  String get verticalLessonIconsDialogBody => 'تمام خصوصیات مفت ورژن میں دستیاب ہیں، لیکن اگر آپ چاہیں تو مزید فیچرز کی تیاری میں ہماری مدد کرسکتے ہیں۔ آپ کی سبسکرپشن کا ایک حصہ Islamic Relief کو عطیہ کیا جاتا ہے۔ جزاک اللہ خیراً!';

  @override
  String get welcomeBody => 'ہُدہُد نے نبی سلیمان [علیہ السلام] کی مدد میں ایک اہم کردار ادا کیا، پیغامات کی ترسیل اور مشاہدے کے ذریعے۔\n\nوہ آپ کو آپ کے سفر کے کسی بھی مرحلے پر ہو، جانچتا نہیں، بلکہ قرآن کی خوبصورتی دریافت کرنے اور ہر لمحے کو شکرگزاری کے ذریعے قیمتی بنانے میں آپ کی رہنمائی کرنے کے لیے پُرجوش ہے۔';

  @override
  String get surahSearchByName => 'نام کے ذریعے تلاش کریں (انگریزی یا عربی)';

  @override
  String get surahSearchHintAnyName => 'کوئی بھی سورت کا نام ٹائپ کریں...';

  @override
  String get surahSearchFieldLabel => 'سورت تلاش کریں';

  @override
  String get surahSearchInvalidLessonsError => 'ایک یا زائد اسباق نامعتبر ہیں۔ راستہ تخلیق نہیں ہوسکتا۔';

  @override
  String get surahSearchUserSurahPrefix => 'صارف کی سورت';

  @override
  String get notificationDailyBody => 'قرآن کے ذریعے چند لمحات کے لیے سکون حاصل کریں اور خود کو یاد دلائیں کہ آج آپ کس بات پر شکر گزار ہیں۔';
}
