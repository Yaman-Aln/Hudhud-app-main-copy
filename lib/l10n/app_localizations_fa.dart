import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get commentA => 'کلیدهای خوشامدگویی (Onboarding)';

  @override
  String get appBarTitleWelcome => 'خوش آمدید';

  @override
  String get skipLabel => 'رد کردن';

  @override
  String get welcomeHeadline => 'به «قرآن با هدهد» خوش آمدید!';

  @override
  String get getStartedLabel => 'شروع';

  @override
  String get commentB => 'کلیدهای صفحه درس';

  @override
  String get lessonScreenAppBarTitle => 'درس';

  @override
  String get noAyahAvailable => 'هیچ آیهای برای پخش موجود نیست.';

  @override
  String audioNotFound(Object url) {
    return 'فایل صوتی در آدرس $url یافت نشد';
  }

  @override
  String get restartLessonTitle => 'شروع مجدد درس';

  @override
  String get resetLessonBody => 'همه پیشرفت شما در این درس بازنشانی شود؟';

  @override
  String get cancelLabel => 'لغو';

  @override
  String get yesLabel => 'بله';

  @override
  String get errorResettingLesson => 'خطا در بازنشانی درس';

  @override
  String get startLabel => 'شروع';

  @override
  String get submitLabel => 'ارسال';

  @override
  String get nextLabel => 'بعدی';

  @override
  String get voiceErrorMicDeniedTitle => 'دسترسی میکروفون رد شد';

  @override
  String get voiceErrorMicDeniedBody => 'برای ضبط صدا نیاز به دسترسی میکروفون است. لطفاً در تنظیمات اجازه دسترسی را صادر کنید.';

  @override
  String get voiceErrorMicDeniedSemanticLabel => 'گفت‌وگوی عدم دسترسی به میکروفون';

  @override
  String get voiceErrorRecorderStartTitle => 'خطا در ضبط صدا';

  @override
  String get voiceErrorRecorderStartBody => 'قادر به شروع ضبط نبودیم. لطفاً دوباره تلاش کنید.';

  @override
  String get voiceErrorRecorderStartSemanticLabel => 'گفت‌وگوی خطای شروع ضبط';

  @override
  String get voiceErrorRecorderStopTitle => 'خطا در توقف ضبط';

  @override
  String get voiceErrorRecorderStopBody => 'ضبط‌کننده به‌درستی متوقف نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get voiceErrorRecorderStopSemanticLabel => 'گفت‌وگوی خطای توقف ضبط';

  @override
  String get voiceErrorNoSoundTitle => 'صوتی شناسایی نشد';

  @override
  String get voiceErrorNoSoundBody => 'ضبط شما بی‌صدا یا خیلی آرام بود. لطفاً دوباره تلاش کنید.';

  @override
  String get voiceErrorNoSoundSemanticLabel => 'گفت‌وگوی عدم تشخیص صدا';

  @override
  String get voiceErrorTranscriptionTitle => 'خطا در تبدیل گفتار به متن';

  @override
  String get voiceErrorTranscriptionBody => 'قادر به تبدیل صدای شما نبودیم. لطفاً اتصال خود را بررسی کرده و دوباره تلاش کنید.';

  @override
  String get voiceErrorTranscriptionSemanticLabel => 'گفت‌وگوی خطای تبدیل گفتار به متن';

  @override
  String get tapColoredWordsHint => 'برای مشاهده نسخه تصحیح‌شده، روی واژه‌های رنگی ضربه بزنید.';

  @override
  String get emptyInputWarning => 'قبل از ارسال باید چیزی وارد کنید';

  @override
  String get getHintLabel => 'دریافت راهنما';

  @override
  String get removeHintLabel => 'حذف راهنما';

  @override
  String get typeTheMissingWordsLabel => 'کلمه(های) جاافتاده را وارد کنید';

  @override
  String get difficultyLabel => 'درجه سختی';

  @override
  String get repeatCountLabel => 'تعداد تکرار';

  @override
  String get backButtonLabel => 'بازگشت';

  @override
  String get toggleTranslationLabel => 'ترجمه درون‌خطی را تغییر بده';

  @override
  String get openTranslationScreenLabel => 'باز کردن صفحه ترجمه';

  @override
  String get restartLessonSemanticLabel => 'شروع مجدد درس';

  @override
  String get verseDisplayAreaLabel => 'ناحیه نمایش آیات قرآن';

  @override
  String get playAudioSemanticLabel => 'پخش صوت آیه';

  @override
  String get openGratitudeSemanticLabel => 'باز کردن پنجره شکرگزاری';

  @override
  String get voiceUsageSemanticLabel => 'استفاده صوتی به دقیقه';

  @override
  String get voiceRecordSemanticLabel => 'شروع یا توقف ضبط صدا';

  @override
  String get commentC => 'رشته‌های صفحه اصلی (HOME)';

  @override
  String get homeTitle => 'خانه';

  @override
  String get noPathsLabel => 'مسیر معتبری در دسترس نیست.';

  @override
  String errorLoadingActivePath(Object err) {
    return 'خطا در بارگذاری مسیر فعال: $err';
  }

  @override
  String get verticalLessonIconsGoToTheme => 'رفتن به موضوع';

  @override
  String get homePathCardLabel => 'برای باز کردن صفحه موضوع ضربه بزنید';

  @override
  String get arrowForwardSemanticLabel => 'باز کردن جزئیات';

  @override
  String get noTrackProgressLabel => 'این مسیر پیشرفت را ثبت نمی‌کند.';

  @override
  String get premiumRequiredLabel => 'برای فعال کردن قابلیت ثبت پیشرفت ارتقا دهید. از ما حمایت کنید تا قابلیت‌های بیشتری اضافه کنیم!';

  @override
  String get completedLabel => 'تکمیل‌شده';

  @override
  String get fabLogGratitudeLabel => 'برای ثبت شکرگزاری ضربه بزنید';

  @override
  String get errorNavigatingToLesson => 'خطا در رفتن به صفحه درس';

  @override
  String get commentD => 'رشته‌های صفحه نمایه (Profile)';

  @override
  String get profileTitle => 'نمایه';

  @override
  String get profileBackArrowLabel => 'بازگشت به صفحه قبلی';

  @override
  String get profileAvatarSemanticLabel => 'تصویر آواتار کاربر';

  @override
  String get profileEnterYourName => 'نام خود را وارد کنید';

  @override
  String get nameEntryNotificationFrequencyDropdownLabel => 'میزان اعلان‌ها';

  @override
  String get nameEntryNotificationFrequencyWeekly => 'هفتگی';

  @override
  String get nameEntryNotificationFrequencyNone => 'بدون اعلان';

  @override
  String get notificationPermissionPrompt => 'مایلیم یادآوری‌های ملایمی ارسال کنیم تا شکرگزاری یا تکالیف درس‌تان را تکمیل کنید — اگر مایلید به ایجاد عادت کمک کنیم لطفاً اجازه ارسال اعلان‌ها را بدهید 😃.';

  @override
  String get profileNameSave => 'ذخیره';

  @override
  String get profileNameCancel => 'لغو';

  @override
  String get profileNameGuest => 'میهمان';

  @override
  String get profileNameEdit => 'ویرایش';

  @override
  String get profilePreferredLanguage => 'زبان:';

  @override
  String get okLabel => 'باشه';

  @override
  String get profileReciterLabel => 'قاری';

  @override
  String get profileFontLabel => 'فونت:';

  @override
  String get profileReciterMishary => 'مشاری راشد العفاسی';

  @override
  String get profileReciterShatri => 'ابوبکر الشاطری';

  @override
  String get profileReciterQatami => 'ناصر القطامی';

  @override
  String get profileUpgradePremiumTitle => 'شخصی‌سازی بیشتر را باز کنید!';

  @override
  String get profileUpgradePremiumBody => 'با ارتقا به نسخه حرفه‌ای، امکان تغییر فونت و قاری را خواهید داشت. از تلاش پیوسته ما حمایت کنید و تجربه خود را بیشتر شخصی‌سازی نمایید!';

  @override
  String get profileWeeksProgress => 'ماشاءالله، پیشرفت هفته شما:';

  @override
  String get profileGratefulnessCalendar => 'تقویم شکرگزاری';

  @override
  String get profileQuranLearningCalendar => 'تقویم یادگیری قرآن';

  @override
  String get profilePrevWeekSemantic => 'رفتن به هفته قبل';

  @override
  String get profileNextWeekSemantic => 'رفتن به هفته بعد';

  @override
  String get profileNotificationFrequency => 'میزان اعلان‌ها';

  @override
  String get commentE => 'رشته‌های صفحه ثبت شکرگزاری (Gratitude Log)';

  @override
  String get gratitudeLogTitle => 'دفترچه شکرگزاری من';

  @override
  String get gratitudeLogBackArrowSemantic => 'بازگشت به خانه';

  @override
  String get gratitudeLogClearAllSemantic => 'حذف همه موارد شکرگزاری';

  @override
  String get gratitudeLogAddSemantic => 'افزودن مورد شکرگزاری جدید';

  @override
  String get gratitudeLogClearDialogTitle => 'حذف دفترچه شکرگزاری';

  @override
  String get gratitudeLogClearDialogBody => 'آیا مطمئن هستید که می‌خواهید همه موارد شکرگزاری خود را پاک کنید؟ این عمل قابل بازگشت نیست.';

  @override
  String get gratitudeLogClearConfirm => 'بله، حذف شود';

  @override
  String gratitudeLogStreak(Object days) {
    return '⭐ رکورد شکرگزاری: $days روز';
  }

  @override
  String get gratitudeLogStreakLoading => 'در حال محاسبه رکورد...';

  @override
  String get gratitudeLogStreakError => 'محاسبه رکورد با شکست مواجه شد.';

  @override
  String gratitudeLogTotalDays(Object count) {
    return 'مجموع روزهای شکرگزاری: $count';
  }

  @override
  String get gratitudeLogDataLoading => 'در حال بارگیری اطلاعات شکرگزاری...';

  @override
  String get gratitudeLogDataError => 'خطا در بارگیری اطلاعات شکرگزاری.';

  @override
  String get gratitudeLogCardSemantic => 'کارت مورد شکرگزاری';

  @override
  String get gratitudeLogItemIcon => 'آیکون شکرگزاری';

  @override
  String get gratitudeLogEmptyIconSemantic => 'برای افزودن اولین شکرگزاری ضربه بزنید';

  @override
  String get gratitudeLogEmptyMessage => 'هنوز هیچ مورد شکرگزاری ثبت نشده است.\nبرای افزودن اولین شکرگزاری، روی «+» ضربه بزنید!';

  @override
  String get gratitudeLogEntriesAdded => 'موارد شکرگزاری با موفقیت اضافه شد!';

  @override
  String get gratitudeLogEntriesFailed => 'افزودن شکرگزاری‌ها ناموفق بود. لطفاً دوباره تلاش کنید.';

  @override
  String get commentF => 'رشته‌های صفحه اتمام درس (Lesson Completion)';

  @override
  String get lessonCompletedTitle => 'درس کامل شد';

  @override
  String get lessonCompletedBackArrowSemantic => 'بازگشت به صفحه اصلی';

  @override
  String get lessonCompletedMashaAllah => 'ماشاءالله!';

  @override
  String get lessonCompletedMashaAllahSemantic => 'متن تبریک';

  @override
  String get lessonCompletedMessage => 'شما این درس را به پایان رساندید!';

  @override
  String get lessonCompletedImageSemantic => 'تصویر هدهد و قرآن';

  @override
  String get lessonCompletedGoBackSemantic => 'بازگشت به انتخاب مسیر';

  @override
  String get lessonCompletedGoBackButton => 'بازگشت به مسیر';

  @override
  String get lessonCompletedRestartSemantic => 'شروع مجدد درس';

  @override
  String get lessonCompletedRestartButton => 'شروع مجدد درس';

  @override
  String get lessonCompletedEncouragement => 'همین‌طور ادامه بدهید!';

  @override
  String get commentG => 'رشته‌های صفحه موضوعات (Theme Screen)';

  @override
  String get themeScreenTitle => 'موضوعات';

  @override
  String get themeNameCoreRecitation => 'تلاوت روزانه اصلی';

  @override
  String get themeNameBeginJourney => 'شروع سفر';

  @override
  String get themeNameMercyAndHope => 'رحمت و امید';

  @override
  String get themeNameGratitudeReflection => 'شکرگزاری و تأمل';

  @override
  String get themeNameStoriesReminders => 'داستان‌ها، درس‌ها و یادآوری‌ها';

  @override
  String get themeNamePatience => 'صبر (Sabr)';

  @override
  String get themeNameUserCreated => 'ایجاد شده توسط کاربر';

  @override
  String get themeScreenNoThemesLabel => 'هیچ موضوعی در دسترس نیست';

  @override
  String get themeScreenBackArrowSemantic => 'بازگشت';

  @override
  String get themeScreenThemeCardSemantic => 'برای باز کردن مسیرهای این موضوع ضربه بزنید';

  @override
  String get themeScreenLockIconSemantic => 'موضوع قفل است. نیاز به ارتقا دارد.';

  @override
  String get pathListExploreOtherThemes => 'کاوش سایر موضوعات';

  @override
  String get themeScreenUserCreatedSubtitle => 'توسط شما ایجاد شده — مطابق سلیقه‌تان شخصی‌سازی کنید.';

  @override
  String get themeSubtitleCoreRecitation => 'سوره‌های اصلی برای نمازهای روزانه و محافظت.';

  @override
  String get themeSubtitleBeginJourney => 'سوره‌های کوتاه برای آغاز سفر قرآنی.';

  @override
  String get themeSubtitleMercyAndHope => 'تأمل در مهربانی الهی و پرورش امید.';

  @override
  String get themeSubtitleGratitudeReflection => 'ایجاد شکرگزاری و تفکر از طریق آیات منتخب.';

  @override
  String get themeSubtitleStoriesReminders => 'روایت‌های قرآنی برای راهنمایی و یادآوری.';

  @override
  String get themeSubtitlePatience => 'سوره‌ها و آیاتی در تأکید بر صبر و استقامت.';

  @override
  String get themeSubtitleDefault => 'مجموعه ویژه سوره‌ها برای رشد معنوی عمیق‌تر.';

  @override
  String get themeScreenRequiredPremium => 'نیاز به پریمیوم';

  @override
  String get themeScreenRequiredPremiumPlus => 'نیاز به پریمیوم پلاس';

  @override
  String get commentH => 'رشته‌های صفحه فهرست مسیرها (Path List Screen)';

  @override
  String get pathListScreenTitle => 'مسیرهای این موضوع';

  @override
  String get pathListScreenBackArrowSemantic => 'بازگشت';

  @override
  String get pathListScreenAddIconSemantic => 'افزودن مسیر جدید';

  @override
  String get pathListAddNewPathTooltip => 'افزودن مسیر جدید';

  @override
  String get pathListScreenAddIconSemanticEmpty => 'برای افزودن اولین مسیر ضربه بزنید';

  @override
  String get pathListEmptyMessage => 'هیچ مسیری وجود ندارد.\nبرای ایجاد اولین مسیر، روی «+» ضربه بزنید!';

  @override
  String get pathListUnavailableLabel => 'این مسیر در حال حاضر قابل استفاده نیست';

  @override
  String get pathListThemeLabel => 'موضوع';

  @override
  String get pathListPathCardSemantic => 'برای باز کردن جزئیات مسیر ضربه بزنید';

  @override
  String get pathListCompleteIconSemantic => 'مسیر تکمیل شده';

  @override
  String get pathListInProgressIconSemantic => 'مسیر در حال پیشرفت';

  @override
  String get pathListInvalidIconSemantic => 'مسیر نامعتبر یا غیرقابل استفاده';

  @override
  String get pathListErrorLoadingPaths => 'خطا در بارگذاری مسیرها:';

  @override
  String get commentI => 'رشته‌های صفحه جزئیات مسیر (Path Detail Screen)';

  @override
  String get pathDetailScreenTitle => 'جزئیات مسیر';

  @override
  String get pathDetailScreenBackArrowSemantic => 'بازگشت به فهرست مسیرها';

  @override
  String get pathDetailScreenNotFound => 'مسیر پیدا نشد.';

  @override
  String get pathDetailScreenFailToUpdate => 'به‌روزرسانی پیشرفت مسیر ناموفق بود:';

  @override
  String get pathDetailScreenProgressDisabled => 'برای این مسیر پیشرفت فعال نیست.';

  @override
  String get pathDetailScreenLessonsHeading => 'درس‌ها:';

  @override
  String get pathDetailScreenNoLessonsLabel => 'هیچ درسی موجود نیست.';

  @override
  String get pathDetailScreenErrorLoading => 'خطا در بارگذاری مسیر یا درس‌ها:';

  @override
  String get pathDetailScreenLessonCardSemantic => 'برای باز کردن جزئیات درس ضربه بزنید';

  @override
  String get pathDetailScreenLessonCompleteIconSemantic => 'درس تکمیل شده';

  @override
  String get pathDetailScreenLessonInProgressIconSemantic => 'درس در حال پیشرفت';

  @override
  String get pathDetailScreenLessonInvalidIconSemantic => 'درس نامعتبر یا غیرقابل استفاده';

  @override
  String get pathDetailScreenLessonProgressUnavailable => 'پیشرفت در دسترس نیست';

  @override
  String get pathDetailScreenLessonNoProgress => 'برای این مسیر پیشرفتی ثبت نمی‌شود';

  @override
  String get pathDetailScreenLessonUpgrade => 'برای قابلیت ثبت پیشرفت، ارتقا دهید.';

  @override
  String pathDetailScreenLessonProgressLabel(Object progress) {
    return 'پیشرفت: $progress%';
  }

  @override
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah) {
    return 'درس $lessonIndex: $surahName - آیه $startAyah-$endAyah';
  }

  @override
  String get commentJ => 'رشته‌های صفحه ایجاد مسیر (Create Path Screen)';

  @override
  String get createPathTitle => 'ایجاد مسیر جدید';

  @override
  String get createPathBackArrowSemantic => 'بازگشت به صفحه قبلی';

  @override
  String get createPathNameLabel => 'نام مسیر';

  @override
  String get createPathNameValidation => 'یک نام برای مسیر وارد کنید';

  @override
  String get createPathDescriptionLabel => 'توضیحات';

  @override
  String get createPathDescriptionValidation => 'یک توضیح وارد کنید';

  @override
  String get createPathSurahSelectorLabel => 'سوره را انتخاب کنید:';

  @override
  String get createPathStartAyahLabel => 'آیه شروع';

  @override
  String get createPathNumAyahsLabel => 'تعداد آیه در مسیر';

  @override
  String get createPathEndAyahLabel => 'آیه پایان';

  @override
  String get createPathWordsPerLessonLabel => 'تعداد کلمه در هر درس';

  @override
  String get createPathWordsSuffix => 'کلمه';

  @override
  String get createPathInvalidRange => 'محدوده نامعتبر';

  @override
  String get createPathAyahsSuffix => 'آیه';

  @override
  String get createPathCreateButton => 'ایجاد مسیر';

  @override
  String get createPathSubmitSemantic => 'برای ایجاد مسیر ضربه بزنید';

  @override
  String get commentK => 'رشته‌های صفحه ترجمه (Translation Screen)';

  @override
  String get translationScreenTitle => 'ترجمه';

  @override
  String get translationScreenBackArrowSemantic => 'بازگشت به درس';

  @override
  String get translationScreenLoadingSemantic => 'در حال بارگیری ترجمه‌ها';

  @override
  String get translationScreenNoTranslations => 'هیچ ترجمه‌ای در دسترس نیست.';

  @override
  String get translationScreenReturnButton => 'بازگشت به درس';

  @override
  String get translationScreenReturnSemantic => 'برای بازگشت به درس ضربه بزنید';

  @override
  String get translationScreenLoadError => 'خطا در بارگیری ترجمه‌ها:';

  @override
  String get commentL => 'رشته‌های صفحه انتخاب زبان (Language Selection Screen)';

  @override
  String get languageSelectionScreenSemantic => 'صفحه انتخاب زبان';

  @override
  String get languageSelectionTitle => 'زبان خود را انتخاب کنید';

  @override
  String get languageSelectionBackSemantic => 'بازگشت';

  @override
  String get languageSelectionSkipSemantic => 'رد کردن انتخاب زبان';

  @override
  String get languageSelectionInstructions => 'لطفاً زبان مورد نظر خود را انتخاب کنید:';

  @override
  String get languageSelectionNextSemantic => 'تأیید انتخاب زبان';

  @override
  String get languageSelectionNextLabel => 'بعدی';

  @override
  String get languageSelectionImageSemantic => 'تصویر هدهد و قرآن';

  @override
  String get commentM => 'رشته‌های صفحه خوش‌آمدگویی (Welcome Screen)';

  @override
  String get welcomeScreenSemantic => 'صفحه خوش‌آمدگویی در آنبوردینگ';

  @override
  String get welcomeScreenLogoSemantic => 'تصویر هدهد و قرآن';

  @override
  String get welcomeScreenSkipSemantic => 'رد کردن مرحله خوش‌آمدگویی';

  @override
  String get welcomeScreenNextSemantic => 'ادامه به مرحله بعد آنبوردینگ';

  @override
  String get commentN => 'رشته‌های صفحه معرفی هدهد (Hudhud Info Screen)';

  @override
  String get hudhudInfoSemantic => 'صفحه اطلاعات هدهد';

  @override
  String get hudhudInfoAppBarTitle => 'آشنایی با هدهد';

  @override
  String get hudhudInfoIllustrationSemantic => 'تصویر هدهد';

  @override
  String get hudhudInfoBody1 => 'هدهد (مرغ سلیمان) نقشی ویژه در کمک به حضرت سلیمان (ع) داشت و با مشاهده و رساندن پیام‌ها فعال بود.';

  @override
  String get hudhudInfoBody2 => 'یادآوری داستان هدهد نشان می‌دهد حتی یک موجود کوچک هم با دقت و کنجکاوی می‌تواند اثر بزرگی داشته باشد. ما نیز می‌توانیم توجه پیوسته خود را به زیبایی قرآن معطوف کنیم و یادآوری‌های شکرگزاری را در هر لحظه از پیشرفتمان بگنجانیم.';

  @override
  String get hudhudInfoBody3 => 'با پیروی از الگوی هدهد—حفظ هوشیاری و مشارکت—امیدواریم ارتباطمان را با قرآن عمیق‌تر کرده و حس شکرگزاری را در زندگی روزمره تقویت کنیم.';

  @override
  String get hudhudInfoNextLabel => 'بعدی';

  @override
  String get hudhudInfoNextSemantic => 'رفتن به بخش بعدی';

  @override
  String get hudhudInfoSkipSemantic => 'رد کردن مرحله معرفی هدهد';

  @override
  String get commentO => 'رشته‌های صفحه انتخاب طرح اشتراک (Subscription Tier Screen)';

  @override
  String get subscriptionTierScreenSemantic => 'صفحه انتخاب اشتراک';

  @override
  String get subscriptionTierScreenAppBarTitle => 'انتخاب پلن';

  @override
  String get subscriptionTierScreenSkipSemantic => 'رد کردن انتخاب پلن اشتراک';

  @override
  String get subscriptionTierScreenFreeLabel => 'رایگان';

  @override
  String get subscriptionTierScreenSmileySemantic => 'آیکون شکلک خندان';

  @override
  String get subscriptionTierScreenDonationText => 'بخشی از منابع مالی به ابتکار «المبتسم» اختصاص می‌یابد که از طریق سازمان Islamic Relief از یتیمان حمایت می‌کند.';

  @override
  String get subscriptionTierScreenConfirmSemantic => 'تأیید انتخاب پلن اشتراک';

  @override
  String get subscriptionTierScreenNextLabel => 'بعدی';

  @override
  String subscriptionTierScreenRadioSemantic(Object title) {
    return 'برای انتخاب پلن اشتراک $title ضربه بزنید';
  }

  @override
  String get commentP => 'رشته‌های صفحه انتخاب هدف (Goal Selection Screen)';

  @override
  String get goalSelectionScreenSemantic => 'صفحه انتخاب اهداف';

  @override
  String get goalSelectionScreenAppBarTitle => 'اهداف خود را انتخاب کنید';

  @override
  String get goalSelectionScreenSkipSemantic => 'رد کردن انتخاب اهداف';

  @override
  String get goalSelectionScreenIntroText => 'کدام یک از اهداف زیر برایتان جذاب است؟ می‌توانید چند گزینه را انتخاب کنید.';

  @override
  String get goalSelectionScreenNextSemantic => 'تأیید اهداف انتخابی';

  @override
  String get goalSelectionScreenNextLabel => 'بعدی';

  @override
  String goalSelectionTileSemantic(Object goalTitle) {
    return 'برای انتخاب/لغو انتخاب هدف $goalTitle ضربه بزنید';
  }

  @override
  String get goalConnectQuranTitle => 'ارتباط بیشتر با قرآن';

  @override
  String get goalConnectQuranDesc => 'از طریق تلاوت یا تدبر، رابطه خود را تقویت کنید.';

  @override
  String get goalMemorizeQuranTitle => 'حفظ قرآن';

  @override
  String get goalMemorizeQuranDesc => 'شروع سفر حفظ قرآن.';

  @override
  String get goalBeMoreGratefulTitle => 'شکرگزاری و شادی بیشتر در زندگی';

  @override
  String get goalBeMoreGratefulDesc => 'تمرکز بر تمرین شکرگزاری روزمره.';

  @override
  String get goalBuildConsistencyTitle => 'ایجاد تداوم';

  @override
  String get goalBuildConsistencyDesc => 'عادت روزانه یا هفتگی ایجاد کنید.';

  @override
  String get goalImproveArabicTitle => 'بهبود زبان عربی';

  @override
  String get goalImproveArabicDesc => 'بر مهارت‌های نوشتاری یا گفتاری عربی تمرکز کنید.';

  @override
  String get goalDeepenTafsirTitle => 'تعمیق در تفسیر';

  @override
  String get goalDeepenTafsirDesc => 'مطالعه تفسیر و معانی عمیق‌تر قرآن.';

  @override
  String get goalOtherTitle => 'سایر';

  @override
  String get goalOtherDesc => 'سایر اهداف شخصی خود را دنبال کنید.';

  @override
  String get commentQ => 'رشته‌های صفحه انتخاب سطح (Level Selection Screen)';

  @override
  String get levelSelectionScreenSemantic => 'صفحه انتخاب سطح تلاوت';

  @override
  String get levelSelectionScreenAppBarTitle => 'سطح خود را انتخاب کنید';

  @override
  String get levelSelectionScreenSkipSemantic => 'رد کردن انتخاب سطح';

  @override
  String get levelSelectionScreenIntroText => 'گزینه‌ای را انتخاب کنید که بهترین توصیف سطح تلاوت کنونی شماست:';

  @override
  String get levelStarterLabel => 'مبتدی';

  @override
  String get levelStarterDescription => 'تازه‌کار یا یادگیرنده گاه‌به‌گاه که در حال آشنایی با تلاوت قرآن است.';

  @override
  String get levelAdvancedLabel => 'پیشرفته';

  @override
  String get levelAdvancedDescription => 'در خواندن متن عربی راحت است و کمی آشنایی با تجوید دارد.';

  @override
  String get levelQariLabel => 'قاری';

  @override
  String get levelQariDescription => 'در تلاوت مهارت بالایی داشته و احکام تجوید را به‌خوبی رعایت می‌کند.';

  @override
  String get levelSelectionNextSemantic => 'تأیید انتخاب سطح تلاوت';

  @override
  String get levelSelectionNextLabel => 'بعدی';

  @override
  String levelSelectionTileSemantic(Object levelTitle) {
    return 'برای انتخاب سطح تلاوت $levelTitle ضربه بزنید';
  }

  @override
  String get commentR => 'رشته‌های صفحه اتمام آنبوردینگ (Onboarding Completion)';

  @override
  String get onboardingCompletionScreenSemantic => 'صفحه تکمیل آنبوردینگ';

  @override
  String get onboardingCompletionScreenAppBarTitle => 'همه چیز آماده است!';

  @override
  String get onboardingCompletionScreenImageSemantic => 'تصویر هدهد و قرآن';

  @override
  String get onboardingCompletionScreenBody1 => 'تبریک! شما با موفقیت تنظیمات اولیه را انجام دادید. امیدواریم این مسیر شما را به قرآن نزدیک‌تر کرده و شکرگزاری شما را در برابر خداوند افزایش دهد.\n\nان‌شاءالله این برنامه منبعی برای رشد و برکت در زندگی شما و اطرافیانتان باشد.';

  @override
  String get onboardingCompletionScreenBody2 => 'هر زمان آماده بودید روی دکمه زیر بزنید. قابلیت‌های اصلی حفظ و پیشرفت منتظر شما هستند، و می‌توانید شکرگزاری خود را ثبت کرده یا مسیری را از نوار پایین انتخاب کنید.';

  @override
  String get onboardingCompletionScreenBody3 => 'این نسخه اولیه است — از حمایت و صبوری شما سپاسگزاریم و امیدواریم خیلی زود قابلیت‌های بیشتری ارائه دهیم ان‌شاءالله!';

  @override
  String get onboardingCompletionScreenBeginSemantic => 'شروع استفاده از برنامه';

  @override
  String get onboardingCompletionScreenBeginLabel => 'بیایید شروع کنیم';

  @override
  String get commentS => 'رشته‌های صفحه ورود نام کاربری (Name Entry Screen)';

  @override
  String get nameEntryScreenSemantic => 'صفحه ورود نام';

  @override
  String get nameEntryScreenAppBarTitle => 'نمایه شما';

  @override
  String get nameEntryScreenSkipSemantic => 'رد کردن وارد کردن نام';

  @override
  String get nameEntryScreenIntroText => 'نام شما چیست؟';

  @override
  String get nameEntryTextFieldSemantic => 'فیلد متن ورود نام';

  @override
  String get nameEntryNextSemantic => 'تأیید نام واردشده';

  @override
  String get nameEntryNextLabel => 'بعدی';

  @override
  String get commentT => 'رشته‌های آیکون‌های عمودی درس (VerticalLessonIcons)';

  @override
  String get verticalLessonIconsSemantic => 'کانتینر آیکون‌های عمودی درس';

  @override
  String get verticalLessonIconsNoLessons => 'هیچ درسی یافت نشد.';

  @override
  String get verticalLessonIconsLoadingSurah => 'در حال بارگیری جزئیات سوره';

  @override
  String get verticalLessonIconsErrorSurah => 'خطا در بارگیری جزئیات سوره';

  @override
  String get verticalLessonIconsSurahHeaderSemantic => 'سربرگ جزئیات سوره';

  @override
  String get verticalLessonIconsHudhudIconSemantic => 'آیکون راهنمای هدهد';

  @override
  String get verticalLessonIconsNextPageSemantic => 'فلش به پایین برای صفحه بعدی';

  @override
  String get verticalLessonIconsPreviousPageSemantic => 'فلش به بالا برای صفحه قبلی';

  @override
  String get verticalLessonIconsLoadingProgress => 'در حال بارگیری پیشرفت درس';

  @override
  String get verticalLessonIconsErrorProgress => 'خطا در بارگیری پیشرفت';

  @override
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent) {
    return 'آیکون درس، $surahAyahRange، پیشرفت $percent%';
  }

  @override
  String get verticalLessonIconsCompletedSemantic => 'درس تکمیل شده';

  @override
  String get verticalLessonIconsDialogTitle => 'حمایت و ارتقا';

  @override
  String get verticalLessonIconsDialogOk => 'باشه';

  @override
  String get commentU => 'رشته‌های نوار ناوبری (Navbar)';

  @override
  String get navBarSemanticLabel => 'نوار ناوبری پایین';

  @override
  String get navHomeLabel => 'خانه';

  @override
  String get navHomeSemantic => 'برگه خانه';

  @override
  String get navQuranLabel => 'قرآن';

  @override
  String get navQuranSemantic => 'برگه قرآن';

  @override
  String get navGratitudeLabel => 'شکرگزاری';

  @override
  String get navGratitudeSemantic => 'برگه شکرگزاری';

  @override
  String get navProfileLabel => 'نمایه';

  @override
  String get navProfileSemantic => 'برگه نمایه';

  @override
  String get commentV => 'رشته‌های نوار بالای صفحه (TopBar)';

  @override
  String get topBarSemanticLabel => 'نوار ناوبری بالایی';

  @override
  String topBarTitleSemantic(Object title) {
    return 'عنوان نوار بالا: $title';
  }

  @override
  String topBarStreakIconSemantic(Object days) {
    return 'آیکون رکورد: $days روز';
  }

  @override
  String get topBarStreakDialogBody => 'این عدد نشان می‌دهد چند روز متوالی تلاوت داشته‌اید یا شکرگزاری نوشته‌اید. برای حفظ یا افزایش رکورد خود ادامه دهید!';

  @override
  String get topBarHudhudIconSemantic => 'آیکون هدهد، برای حمایت ضربه بزنید';

  @override
  String get topBarHudhudDialogTitle => 'حمایت و ارتقا';

  @override
  String get topBarHudhudDialogBody => 'همه امکانات در نسخه رایگان موجود است، اما اگر مایل باشید، می‌توانید برای توسعه قابلیت‌های بیشتر از ما حمایت کنید. بخشی از اشتراک شما به سازمان Islamic Relief اهدا می‌شود. جزاک الله خیراً!';

  @override
  String get commentW => 'رشته‌های پنجره شکرگزاری (Gratitude Modal)';

  @override
  String get gratitudeModalSemantic => 'پنجره شکرگزاری';

  @override
  String get gratitudeModalTitle => 'بر اساس این آیات، امروز بابت چه چیزی شکرگزار هستید؟';

  @override
  String gratitudeModalHint(Object index) {
    return 'الحمدلله برای (مورد شکرگزاری را وارد کنید) #$index';
  }

  @override
  String gratitudeModalTextFieldSemantic(Object index) {
    return 'ورود شکرگزاری شماره $index';
  }

  @override
  String get gratitudeModalEmptyWarning => 'لطفاً حداقل یک شکرگزاری وارد کنید.';

  @override
  String get gratitudeModalSubmitError => 'ثبت شکرگزاری ناموفق بود. لطفاً دوباره تلاش کنید.';

  @override
  String get dailyVoiceLimitReachedTitle => 'ماشاءالله!';

  @override
  String get dailyVoiceLimitReachedMessage => '۱۰ دقیقه از تلاوت صوتی قرآن را امروز تکمیل کرده‌اید. لطفاً از طریق نوشتن مرور کنید و ادامه تلاوت را به فردا موکول نمایید.';

  @override
  String get upgradeVoiceUsageTitle => 'ارتقا به پریمیوم';

  @override
  String get gratitudeModalLoadingSemantic => 'در حال ثبت شکرگزاری...';

  @override
  String get commentX => '== کلیدهای جدید برای submission_feedback_modal، progress_bar، surah_selector ==';

  @override
  String get submissionFeedbackModalSemanticLabel => 'پنجره بازخورد پس از ارسال';

  @override
  String get submissionFeedbackModalTitle => 'بازخورد ارسال';

  @override
  String get submissionFeedbackModalNoNew => 'هیچ شکرگزاری جدیدی ارسال نشد.';

  @override
  String get submissionFeedbackModalYouSubmitted => 'شما این موارد شکرگزاری را ثبت کردید:';

  @override
  String submissionFeedbackModalStreak(Object days) {
    return 'رکورد شکرگزاری فعلی: $days روز';
  }

  @override
  String submissionFeedbackModalTotalDays(Object count) {
    return 'مجموع روزهای شکرگزاری: $count';
  }

  @override
  String get submissionFeedbackModalLoading => 'در حال بارگیری داده شکرگزاری شما...';

  @override
  String get submissionFeedbackModalError => 'امکان بارگیری داده شکرگزاری وجود نداشت.';

  @override
  String get submissionFeedbackModalViewLog => 'مشاهده لاگ';

  @override
  String get submissionFeedbackModalClose => 'بستن';

  @override
  String progressBarSemanticLabel(Object percent) {
    return 'پیشرفت: $percent%';
  }

  @override
  String get surahSelectorSemanticLabel => 'انتخاب یک سوره';

  @override
  String get commentZ => 'نام‌ها و توضیحات مسیر قابل بومی‌سازی برای مسیرهای سیستم';

  @override
  String get pathNameFatihah => 'سوره الفاتحة';

  @override
  String get pathDescFatihah => 'کل سوره (۱:۱–۷). ضروری در هر رکعت.';

  @override
  String get pathNameKafirun => 'سوره الکافرون';

  @override
  String get pathDescKafirun => 'کل سوره (۱۰۹:۱–۶). بیان توحید.';

  @override
  String get pathNameIkhlas => 'سوره الإخلاص';

  @override
  String get pathDescIkhlas => 'کل سوره (۱۱۲:۱–۴). توحید خداوند.';

  @override
  String get pathNameFalaq => 'سوره الفلق';

  @override
  String get pathDescFalaq => 'کل سوره (۱۱۳:۱–۵). پناه بردن از بدی‌های بیرونی.';

  @override
  String get pathNameNas => 'سوره الناس';

  @override
  String get pathDescNas => 'کل سوره (۱۱۴:۱–۶). پناه بردن از وسوسه‌های درونی.';

  @override
  String get pathNameAsrBegin => 'سوره العصر';

  @override
  String get pathDescAsrBegin => '(۱۰۳:۱–۳). فقط ۳ آیه، اما محوریت «صبر».';

  @override
  String get pathNameTakathur => 'سوره التکاثر';

  @override
  String get pathDescTakathur => '(۱۰۲:۱–۸) درباره رقابت دنیوی و حساب‌رسی آخرت.';

  @override
  String get pathNameFil => 'سوره الفیل';

  @override
  String get pathDescFil => '(۱۰۵:۱–۵). ماجرای اصحاب فیل؛ ۵ آیه کوتاه.';

  @override
  String get pathNameQuraysh => 'سوره قریش';

  @override
  String get pathDescQuraysh => '(۱۰۶:۱–۴). در باب شکر به‌خاطر سفرهای امن.';

  @override
  String get pathNameRahmanA => 'الرحمن (بخش الف)';

  @override
  String get pathDescRahmanA => '(۵۵:۱–۱۳): آموزش قرآن و خلقت انسان.';

  @override
  String get pathNameRahmanB => 'الرحمن (بخش ب)';

  @override
  String get pathDescRahmanB => '(۵۵:۲۶–۳۶): مسئولیت انسان و جن.';

  @override
  String get pathNameYasinBlock => 'سوره یس (بخش)';

  @override
  String get pathDescYasinBlock => '(۳۶:۱–۱۲). مقدمه پیام پیامبر و هشدارها.';

  @override
  String get pathNameMulkBlock => 'سوره الملک (بخش)';

  @override
  String get pathDescMulkBlock => '(۶۷:۱–۱۵). بر پادشاهی خداوند و تفکر تأکید دارد.';

  @override
  String get pathNameBaqarah21_29 => 'البقرة (۲:۲۱–۲۹)';

  @override
  String get pathDescBaqarah21_29 => '۹ آیه درباره خلقت و اندیشه برای شکرگزاری.';

  @override
  String get pathNameNahl66_72 => 'النحل (۱۶:۶۶–۷۲)';

  @override
  String get pathDescNahl66_72 => '۷ آیه که نعمت‌ها را یاد می‌کند: دام، میوه‌ها و غیره.';

  @override
  String get pathNameAdDuha => 'سوره الضحى';

  @override
  String get pathDescAdDuha => '(۹۳:۱–۱۱)، ۱۱ آیه امید و دلگرمی.';

  @override
  String get pathNameKahfCave => 'الکهف: ماجرای اصحاب کهف';

  @override
  String get pathDescKahfCave => '(۱۸:۹–۱۶)، داستان جوانان مؤمن در غار.';

  @override
  String get pathNameKahfMusa => 'الکهف: موسی و خضر';

  @override
  String get pathDescKahfMusa => '(۱۸:۶۰–۷۰)، تأکید بر صبر و حکمت پنهان.';

  @override
  String get pathNameWaqiah => 'الواقعة (۵۶:۱–۱۵)';

  @override
  String get pathDescWaqiah => '۱۵ آیه درباره فرا رسیدن ناگهانی قیامت.';

  @override
  String get pathNameAsrPatience => 'سوره العصر (صبر)';

  @override
  String get pathDescAsrPatience => '(۱۰۳:۱–۳) مجدداً، ۳ آیه معروف در مورد صبر.';

  @override
  String get pathNameBaq153_157 => 'البقرة (۲:۱۵۳–۱۵۷)';

  @override
  String get pathDescBaq153_157 => '۵ آیه: «از صبر و نماز یاری بجویید.»';

  @override
  String get pathNameYusuf7_14 => 'یوسف (۱۲:۷–۱۴)';

  @override
  String get pathDescYusuf7_14 => 'حسادت برادران یوسف. آزمون صبر.';

  @override
  String get pathNameYusuf83_92 => 'یوسف (۱۲:۸۳–۹۲)';

  @override
  String get pathDescYusuf83_92 => 'غم یعقوب و بخشش یوسف (۱۰ آیه).';

  @override
  String get pathNameInshirah => 'سوره الانشراح (۹۴:۱–۸)';

  @override
  String get pathDescInshirah => '۸ آیه: آرامش پس از سختی. مرتبط با صبر و امید.';

  @override
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah) {
    return 'سوره $surahName، آیه $startAyah-$endAyah';
  }

  @override
  String get finishLabel => 'پایان';

  @override
  String get twoWordMultipleChoiceLabel => 'دو کلمهٔ صحیح را انتخاب کنید';

  @override
  String get singleWordMultipleChoiceLabel => 'کلمهٔ صحیح را انتخاب کنید';

  @override
  String get correctAnswerLabel => 'درست!';

  @override
  String get incorrectAnswerLabel => 'نادرست!';

  @override
  String get lessonCompletedLabel => 'درس به پایان رسید!';

  @override
  String get profileAnalyticsScoreLabel => 'تحلیل‌ها و امتیاز';

  @override
  String get profileDailyLabel => 'روزانه';

  @override
  String get profileWeeklyLabel => 'هفتگی';

  @override
  String get profileMonthlyLabel => 'ماهانه';

  @override
  String get profileTotalLabel => 'مجموع';

  @override
  String get profileViewChart => 'نمایش نمودار';

  @override
  String get profileCloseLabel => 'بستن';

  @override
  String get profileScoreChartTitle => 'نمودار امتیاز';

  @override
  String get profileScoreChartHistory => 'تاریخچه';

  @override
  String get profileNoData => 'بدون داده';

  @override
  String get topBarDailyScoreLabel => '⭐ امروز';

  @override
  String topBarDailyScoreSemantic(Object score) {
    return 'امتیاز روزانهٔ شما $score است';
  }

  @override
  String get profilePremiumNeeded => 'لطفاً برای مشاهدهٔ تقویم پیشرفت ارتقا دهید و ما را در توسعهٔ ویژگی‌های بیشتر ان‌شاءالله یاری کنید!';

  @override
  String get levelMultipleChoiceLabel => 'چندگزینه‌ای';

  @override
  String get levelMultipleChoiceDescription => 'مراحل چندگزینه‌ای تک‌واژه‌ای یا دوواژه‌ای با امکان عبور اختیاری از جفت‌ها.';

  @override
  String get levelBeginnerLabel => 'مبتدی';

  @override
  String get levelBeginnerDescription => 'حذف تدریجی واژه‌ها در توالی‌های گروهی برای حفظ تدریجی.';

  @override
  String get subscriptionTierScreenPremiumLabel => 'Plus';

  @override
  String get featureUnavailableOffline => 'این قابلیت به‌صورت آفلاین در دسترس نیست. لطفاً اتصال خود را برقرار کنید یا با ارتقاء به Plus یا Pro Beta، حالت آفلاین را فعال کنید.';

  @override
  String submissionFeedbackModalTotalCount(Object count) {
    return 'تعداد کل ثبت‌های قدردانی: $count';
  }

  @override
  String get notificationDailyTitle => 'یادآوری ملایم قرآن';

  @override
  String get notificationWeeklyTitle => 'بررسی هفتگی قرآن';

  @override
  String get notificationWeeklyBody => 'در مورد پیشرفت خود تأمل کنید و همراه با تمرین شکرگزاری، بخشی جدید از قرآن را حفظ کنید.';

  @override
  String get notificationChannelDailyRemindersName => 'یادآوری‌های روزانه';

  @override
  String get notificationChannelDailyRemindersDesc => 'یادآوری‌ها برای حفظ روزانه قرآن';

  @override
  String get notificationChannelWeeklyRemindersName => 'یادآوری‌های هفتگی';

  @override
  String get notificationChannelWeeklyRemindersDesc => 'یادآوری‌ها برای بررسی هفتگی حفظ قرآن';

  @override
  String get nameEntryNotificationFrequencyDaily => 'روزانه';

  @override
  String get topBarStreakDialogTitle => 'رکورد مداومت';

  @override
  String get fillInTheBlanksLabel => 'جای‌خالی‌ها را پر کنید';

  @override
  String get loadingDataLabel => 'در حال بارگذاری…';

  @override
  String ayahRangeLabel(Object start, Object end) {
    return 'آیه $start - $end';
  }

  @override
  String get nextPageSemanticLabel => 'صفحه بعد';

  @override
  String get prevPageSemanticLabel => 'صفحه قبل';

  @override
  String pageXOfYLabel(Object current, Object total) {
    return 'صفحه $current از $total';
  }

  @override
  String verseSemanticLabel(Object ayahNumber, Object surahName) {
    return 'آیه $ayahNumber از سوره $surahName';
  }

  @override
  String get ayahLabel => 'آیه';

  @override
  String get goToSurahViewLabel => 'مشاهده سوره';

  @override
  String get clickOnAyaToOpenLesson => 'روی هر آیه در زیر کلیک کنید تا درس را شروع کنید';

  @override
  String get difficultyChoosingScreenIntro => 'ترجیح خود را انتخاب کنید: چهارگزینه‌ای یا پر کردن جای‌خالی، و تعداد تکرار هر مرحله و پخش صوت را تنظیم کنید.';

  @override
  String get upgradeVoiceUsageMessage => 'با ارتقاء به Pro Beta قابلیت صوتی را امتحان کنید و به ما در بهبود آن کمک کنید!';

  @override
  String get restorePurchasesLabel => 'بازیابی خریدها';

  @override
  String get subscriptionTierScreenMonthly => 'ماهانه';

  @override
  String get subscriptionTierScreenYearly => 'سالانه';

  @override
  String get subscriptionTierScreenFreePrice => 'رایگان';

  @override
  String get subscriptionTierScreenPremiumMonthlyPrice => 'اکنون ۳ دلار/ماه (قبلاً ۵ دلار)';

  @override
  String get subscriptionTierScreenPremiumYearlyPrice => 'اکنون ۲۸ دلار/سال (قبلاً ۶۰ دلار)';

  @override
  String get subscriptionTierScreenPremiumPlusMonthlyPrice => 'اکنون ۷ دلار/ماه (قبلاً ۱۰ دلار)';

  @override
  String get subscriptionTierScreenPremiumPlusYearlyPrice => 'اکنون ۴۵ دلار/سال (قبلاً ۸۴ دلار)';

  @override
  String get subscriptionPurchaseError => 'خطا در خرید اشتراک';

  @override
  String get topBarExplorePlansLabel => 'مشاهده طرح‌ها';

  @override
  String get topBarBackHomeLabel => 'بازگشت به خانه';

  @override
  String get profileRequiresPlanUpdate => 'نیاز به به‌روزرسانی طرح دارد';

  @override
  String get subscriptionTierScreenPremiumDescription => 'هرآنچه در نسخه رایگان است به‌علاوه یادگیری آفلاین درس‌ها و دریافت بازخورد، تحلیل‌های تاریخی، همچنین نوارهای پیشرفت، پروفایل و شخصی‌سازی قرآن. با حمایت شما می‌توانیم امکانات بیشتری بسازیم!';

  @override
  String get subscriptionAutoRenewNotice => 'اشتراک به‌صورت خودکار تمدید می‌شود و می‌توانید آن را لغو کنید تا برای دوره بعدی هزینه‌ای دریافت نشود. بخشی از مبالغ از طریق ابتکار Almubtasim 😀 به Islamic Relief اهدا خواهد شد.';

  @override
  String get subscriptionTierScreenSubscribeLabel => 'اشتراک';

  @override
  String get subscriptionTierScreenFinalMessage => 'ما قدردان حمایت شما هستیم!';

  @override
  String get subscriptionPurchaseRestoreSuccess => 'خریدهای شما با موفقیت بازیابی شدند.';

  @override
  String get subscriptionTierScreenRestoreLabel => 'بازیابی خریدها';

  @override
  String get arabicLabel => 'عربی';

  @override
  String get transliterationLabel => 'انگلیسی';

  @override
  String get surahSearchScreenTitle => 'جستجوی سوره';

  @override
  String get genericBack => 'بازگشت';

  @override
  String get surahSearchSelectSurah => 'یک سوره را انتخاب کنید:';

  @override
  String get surahSearchExistingPaths => 'مسیرهای موجود برای این سوره';

  @override
  String get surahSearchNoMatches => 'هیچ مسیری یافت نشد.';

  @override
  String get surahSearchHideCreateForm => 'مخفی کردن فرم ایجاد';

  @override
  String get surahSearchShowCreateForm => 'ایجاد مسیر جدید برای سوره';

  @override
  String get createPathTrackProgress => 'ردیابی پیشرفت؟';

  @override
  String get themeScreenSearchIconSemantic => 'جستجوی سوره‌ها';

  @override
  String get pathListSearchIconSemantic => 'جستجوی سوره‌ها';

  @override
  String get pathLessonsSearchIconSemantic => 'جستجوی سوره‌ها';

  @override
  String get playAllSurahSemantic => 'پخش کل سوره';

  @override
  String get toggleTransliterationLabel => 'تغییر وضعیت آوانویسی';

  @override
  String get englishLabel => 'انگلیسی';

  @override
  String get subscriptionTierScreenPremiumPlusLabel => 'حمایت از ما (سالانه)';

  @override
  String get subscriptionTierScreenFreeDescription => 'همه امکانات رایگان و بدون تبلیغات!';

  @override
  String get subscriptionTierScreenPremiumPlusDescription => 'در تامین هزینه امکانات و بهبود آن‌ها کمک کنید! همچنین سرمایه‌گذاری اندک می‌تواند در ایجاد عادت کمک کند!';

  @override
  String get subscriptionTierScreenSupportLabel => 'حمایت سالانه';

  @override
  String get verticalLessonIconsDialogBody => 'همه امکانات در نسخه رایگان موجود است، اما اگر مایل باشید، می‌توانید برای توسعه قابلیت‌های بیشتر از ما حمایت کنید. بخشی از اشتراک شما به سازمان Islamic Relief اهدا می‌شود. جزاک الله خیراً!';

  @override
  String get welcomeBody => 'هدهد نقش ویژه‌ای در یاری به حضرت سلیمان [علیه‌السلام] داشت، با مشاهده و رساندن پیام‌ها.\n\nاو بدون در نظر گرفتن جایگاه شما در مسیرتان، قضاوتی ندارد و مشتاق است در مسیر کشف زیبایی قرآن و اضافه‌کردن یادآوری‌های شکرگزاری برای قدردانی از هر لحظه با شما همراه باشد.';

  @override
  String get surahSearchByName => 'جستجو بر اساس نام (انگلیسی یا عربی)';

  @override
  String get surahSearchHintAnyName => 'نام هر سوره‌ای را وارد کنید...';

  @override
  String get surahSearchFieldLabel => 'جستجوی سوره';

  @override
  String get surahSearchInvalidLessonsError => 'یک یا چند درس نامعتبر است. امکان ساخت مسیر وجود ندارد.';

  @override
  String get surahSearchUserSurahPrefix => 'سوره کاربر';

  @override
  String get notificationDailyBody => 'لحظه‌ای وقت بگذارید تا با قرآن آرامش بیابید و به خود یادآوری کنید چرا امروز شکرگزار هستید.';
}
