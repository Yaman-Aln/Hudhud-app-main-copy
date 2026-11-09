import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get commentA => 'مفاتيح شاشة الترحيب';

  @override
  String get appBarTitleWelcome => 'مرحبا';

  @override
  String get skipLabel => 'تخطي';

  @override
  String get welcomeHeadline => 'مرحبًا بك في تطبيق القرآن مع هدهد!';

  @override
  String get getStartedLabel => 'ابدأ الآن';

  @override
  String get commentB => 'مفاتيح شاشة الدرس';

  @override
  String get lessonScreenAppBarTitle => 'الدرس';

  @override
  String get noAyahAvailable => 'لا توجد آية متاحة للتشغيل.';

  @override
  String audioNotFound(Object url) {
    return 'لم يتم العثور على الصوت في $url';
  }

  @override
  String get restartLessonTitle => 'إعادة بدء الدرس';

  @override
  String get resetLessonBody => 'هل تريد إعادة تعيين تقدمك بالكامل في هذا الدرس؟';

  @override
  String get cancelLabel => 'إلغاء';

  @override
  String get yesLabel => 'نعم';

  @override
  String get errorResettingLesson => 'حدث خطأ أثناء إعادة تعيين الدرس';

  @override
  String get startLabel => 'ابدأ';

  @override
  String get submitLabel => 'إرسال';

  @override
  String get nextLabel => 'التالي';

  @override
  String get voiceErrorMicDeniedTitle => 'تم رفض الوصول للميكروفون';

  @override
  String get voiceErrorMicDeniedBody => 'يتطلب التسجيل الوصول للميكروفون. يرجى منح الإذن في الإعدادات.';

  @override
  String get voiceErrorMicDeniedSemanticLabel => 'مربع حوار رفض إذن الميكروفون';

  @override
  String get voiceErrorRecorderStartTitle => 'خطأ في التسجيل';

  @override
  String get voiceErrorRecorderStartBody => 'تعذر بدء جهاز التسجيل. يرجى المحاولة مرة أخرى.';

  @override
  String get voiceErrorRecorderStartSemanticLabel => 'حوار خطأ بدء التسجيل';

  @override
  String get voiceErrorRecorderStopTitle => 'خطأ عند إيقاف التسجيل';

  @override
  String get voiceErrorRecorderStopBody => 'تعذر إيقاف جهاز التسجيل بشكل صحيح. يرجى المحاولة مرة أخرى.';

  @override
  String get voiceErrorRecorderStopSemanticLabel => 'حوار خطأ إيقاف التسجيل';

  @override
  String get voiceErrorNoSoundTitle => 'لم يتم اكتشاف أي صوت';

  @override
  String get voiceErrorNoSoundBody => 'تسجيلك كان صامتًا أو منخفضًا جدًا. يرجى المحاولة مرة أخرى.';

  @override
  String get voiceErrorNoSoundSemanticLabel => 'مربع حوار عدم اكتشاف الصوت';

  @override
  String get voiceErrorTranscriptionTitle => 'خطأ في تحويل الصوت إلى نص';

  @override
  String get voiceErrorTranscriptionBody => 'تعذر تحويل تسجيلك إلى نص. يرجى التحقق من اتصالك والمحاولة مرة أخرى.';

  @override
  String get voiceErrorTranscriptionSemanticLabel => 'مربع حوار خطأ التحويل النصي';

  @override
  String get tapColoredWordsHint => 'اضغط على الكلمات المميزة للاطلاع على التصحيح.';

  @override
  String get emptyInputWarning => 'يجب إدخال شيء قبل الإرسال';

  @override
  String get getHintLabel => 'أظهر المساعدة';

  @override
  String get removeHintLabel => 'أزل المساعدة';

  @override
  String get typeTheMissingWordsLabel => 'اكتب الكلمة(الكلمات) الناقصة';

  @override
  String get difficultyLabel => 'الصعوبة';

  @override
  String get repeatCountLabel => 'عدد التكرارات';

  @override
  String get backButtonLabel => 'رجوع';

  @override
  String get toggleTranslationLabel => 'تبديل الترجمة الفورية';

  @override
  String get openTranslationScreenLabel => 'فتح شاشة الترجمة';

  @override
  String get restartLessonSemanticLabel => 'إعادة بدء الدرس';

  @override
  String get verseDisplayAreaLabel => 'منطقة عرض الآيات القرآنية';

  @override
  String get playAudioSemanticLabel => 'تشغيل تلاوة الآية';

  @override
  String get openGratitudeSemanticLabel => 'فتح نافذة الامتنان';

  @override
  String get voiceUsageSemanticLabel => 'استخدام الصوت بالدقائق';

  @override
  String get voiceRecordSemanticLabel => 'بدء أو إيقاف التسجيل الصوتي';

  @override
  String get commentC => 'نصوص شاشة الصفحة الرئيسية (Home)';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String get noPathsLabel => 'لا توجد مسارات صالحة متاحة.';

  @override
  String errorLoadingActivePath(Object err) {
    return 'خطأ في تحميل المسار النشط: $err';
  }

  @override
  String get verticalLessonIconsGoToTheme => 'انتقل إلى المحور';

  @override
  String get homePathCardLabel => 'اضغط لفتح شاشة المحور';

  @override
  String get arrowForwardSemanticLabel => 'فتح التفاصيل';

  @override
  String get noTrackProgressLabel => 'هذا المسار لا يتتبع التقدم.';

  @override
  String get premiumRequiredLabel => 'قم بالترقية لإلغاء تأمين ميزة التقدم. ادعمنا لنتمكن من تقديم المزيد!';

  @override
  String get completedLabel => 'مكتمل';

  @override
  String get fabLogGratitudeLabel => 'اضغط لتسجيل الامتنان';

  @override
  String get errorNavigatingToLesson => 'حدث خطأ أثناء الانتقال إلى الدرس';

  @override
  String get commentD => 'نصوص شاشة الملف الشخصي';

  @override
  String get profileTitle => 'ملفي الشخصي';

  @override
  String get profileBackArrowLabel => 'الرجوع إلى الشاشة السابقة';

  @override
  String get profileAvatarSemanticLabel => 'الصورة الرمزية للمستخدم';

  @override
  String get profileEnterYourName => 'أدخل اسمك';

  @override
  String get nameEntryNotificationFrequencyDropdownLabel => 'تكرار التنبيهات';

  @override
  String get nameEntryNotificationFrequencyWeekly => 'أسبوعيًا';

  @override
  String get nameEntryNotificationFrequencyNone => 'لا يوجد';

  @override
  String get notificationPermissionPrompt => 'نرغب في إرسال تذكيرات لطيفة لإكمال سجلات الامتنان أو الدروس — يرجى السماح بالتنبيهات إذا كنت تريد مساعدتنا في بناء العادة 😃.';

  @override
  String get profileNameSave => 'حفظ';

  @override
  String get profileNameCancel => 'إلغاء';

  @override
  String get profileNameGuest => 'ضيف';

  @override
  String get profileNameEdit => 'تعديل';

  @override
  String get profilePreferredLanguage => 'اللغة:';

  @override
  String get okLabel => 'حسناً';

  @override
  String get profileReciterLabel => 'القارئ';

  @override
  String get profileFontLabel => 'الخط:';

  @override
  String get profileReciterMishary => 'مشاري راشد العفاسي';

  @override
  String get profileReciterShatri => 'أبو بكر الشاطري';

  @override
  String get profileReciterQatami => 'ناصر القطامي';

  @override
  String get profileUpgradePremiumTitle => 'افتح المزيد من خيارات التخصيص!';

  @override
  String get profileUpgradePremiumBody => 'يمكنك الاستمتاع بتغيير الخطوط واختيار القراء عبر الترقية إلى النسخة Pro. ادعم جهودنا المستمرة وتمتع بمزيد من التخصيص!';

  @override
  String get profileWeeksProgress => 'ما شاء الله، هذا إنجازك الأسبوعي:';

  @override
  String get profileGratefulnessCalendar => 'تقويم الامتنان';

  @override
  String get profileQuranLearningCalendar => 'تقويم تعلم القرآن';

  @override
  String get profilePrevWeekSemantic => 'الانتقال إلى الأسبوع السابق';

  @override
  String get profileNextWeekSemantic => 'الانتقال إلى الأسبوع التالي';

  @override
  String get profileNotificationFrequency => 'تكرار التنبيهات';

  @override
  String get commentE => 'نصوص شاشة سجل الامتنان';

  @override
  String get gratitudeLogTitle => 'سجل امتناني';

  @override
  String get gratitudeLogBackArrowSemantic => 'العودة إلى الرئيسية';

  @override
  String get gratitudeLogClearAllSemantic => 'مسح جميع مدخلات الامتنان';

  @override
  String get gratitudeLogAddSemantic => 'إضافة مدخلة امتنان جديدة';

  @override
  String get gratitudeLogClearDialogTitle => 'مسح سجل الامتنان';

  @override
  String get gratitudeLogClearDialogBody => 'هل أنت متأكد من رغبتك بمسح جميع مدخلات الامتنان؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get gratitudeLogClearConfirm => 'نعم، امسح';

  @override
  String gratitudeLogStreak(Object days) {
    return '⭐ سلسلة الامتنان: $days أيام';
  }

  @override
  String get gratitudeLogStreakLoading => 'جاري حساب السلسلة...';

  @override
  String get gratitudeLogStreakError => 'فشل في حساب سلسلة الامتنان.';

  @override
  String gratitudeLogTotalDays(Object count) {
    return 'إجمالي أيام الامتنان: $count';
  }

  @override
  String get gratitudeLogDataLoading => 'جاري تحميل بيانات الامتنان...';

  @override
  String get gratitudeLogDataError => 'فشل في تحميل بيانات الامتنان.';

  @override
  String get gratitudeLogCardSemantic => 'بطاقة مدخلة الامتنان';

  @override
  String get gratitudeLogItemIcon => 'أيقونة الامتنان';

  @override
  String get gratitudeLogEmptyIconSemantic => 'اضغط لإضافة أول امتنان لك';

  @override
  String get gratitudeLogEmptyMessage => 'لا توجد أي مدخلات امتنان بعد.\nاضغط على “+” لإضافة أول امتنان لك!';

  @override
  String get gratitudeLogEntriesAdded => 'تمت إضافة الامتنان بنجاح!';

  @override
  String get gratitudeLogEntriesFailed => 'فشل في إضافة الامتنان. يرجى المحاولة مرة أخرى.';

  @override
  String get commentF => 'نصوص شاشة إتمام الدرس';

  @override
  String get lessonCompletedTitle => 'تم إتمام الدرس';

  @override
  String get lessonCompletedBackArrowSemantic => 'الرجوع إلى الرئيسية';

  @override
  String get lessonCompletedMashaAllah => 'ما شاء الله!';

  @override
  String get lessonCompletedMashaAllahSemantic => 'نص تهنئة';

  @override
  String get lessonCompletedMessage => 'لقد أتممت هذا الدرس!';

  @override
  String get lessonCompletedImageSemantic => 'رسم توضيحي لهدهد والقرآن';

  @override
  String get lessonCompletedGoBackSemantic => 'العودة إلى اختيار المسارات';

  @override
  String get lessonCompletedGoBackButton => 'الرجوع إلى المسار';

  @override
  String get lessonCompletedRestartSemantic => 'إعادة بدء الدرس';

  @override
  String get lessonCompletedRestartButton => 'إعادة بدء الدرس';

  @override
  String get lessonCompletedEncouragement => 'واصل العمل الرائع!';

  @override
  String get commentG => 'نصوص شاشة المحاور (Themes)';

  @override
  String get themeScreenTitle => 'المحاور';

  @override
  String get themeNameCoreRecitation => 'التلاوة اليومية الأساسية';

  @override
  String get themeNameBeginJourney => 'بداية الرحلة';

  @override
  String get themeNameMercyAndHope => 'الرحمة والأمل';

  @override
  String get themeNameGratitudeReflection => 'الشكر والتأمل';

  @override
  String get themeNameStoriesReminders => 'القصص والعبر والتذكير';

  @override
  String get themeNamePatience => 'الصبر';

  @override
  String get themeNameUserCreated => 'منشأ بواسطة المستخدم';

  @override
  String get themeScreenNoThemesLabel => 'لا توجد محاور متاحة';

  @override
  String get themeScreenBackArrowSemantic => 'الرجوع';

  @override
  String get themeScreenThemeCardSemantic => 'اضغط لفتح مسارات المحور';

  @override
  String get themeScreenLockIconSemantic => 'المحور مقفول. يتطلب الترقية.';

  @override
  String get pathListExploreOtherThemes => 'اكتشف محاور أخرى';

  @override
  String get themeScreenUserCreatedSubtitle => 'أنشأته بنفسك — خصصه كما تشاء.';

  @override
  String get themeSubtitleCoreRecitation => 'سور أساسية للصلوات اليومية والحماية.';

  @override
  String get themeSubtitleBeginJourney => 'سور قصيرة لبداية رحلتك مع القرآن.';

  @override
  String get themeSubtitleMercyAndHope => 'تدبر رحمة الله وإحياء الأمل.';

  @override
  String get themeSubtitleGratitudeReflection => 'نمِّ شعور الشكر والتأمل من خلال آيات مختارة.';

  @override
  String get themeSubtitleStoriesReminders => 'استكشف القصص القرآنية للعبرة والتذكير.';

  @override
  String get themeSubtitlePatience => 'آيات تركز على الصبر والمثابرة.';

  @override
  String get themeSubtitleDefault => 'مجموعة من السور لتحقيق نمو روحي أعمق.';

  @override
  String get themeScreenRequiredPremium => 'يتطلب بريميوم';

  @override
  String get themeScreenRequiredPremiumPlus => 'يتطلب بريميوم بلس';

  @override
  String get commentH => 'نصوص شاشة قائمة المسارات (Path List)';

  @override
  String get pathListScreenTitle => 'مسارات المحور';

  @override
  String get pathListScreenBackArrowSemantic => 'الرجوع';

  @override
  String get pathListScreenAddIconSemantic => 'إضافة مسار جديد';

  @override
  String get pathListAddNewPathTooltip => 'إضافة مسار جديد';

  @override
  String get pathListScreenAddIconSemanticEmpty => 'اضغط لإضافة أول مسار';

  @override
  String get pathListEmptyMessage => 'لا توجد أي مسارات حتى الآن.\nاضغط على “+” لإنشاء أول مسار!';

  @override
  String get pathListUnavailableLabel => 'هذا المسار غير متاح حاليًا';

  @override
  String get pathListThemeLabel => 'محور';

  @override
  String get pathListPathCardSemantic => 'اضغط لفتح تفاصيل المسار';

  @override
  String get pathListCompleteIconSemantic => 'المسار مكتمل';

  @override
  String get pathListInProgressIconSemantic => 'المسار قيد التقدم';

  @override
  String get pathListInvalidIconSemantic => 'مسار غير صالح أو غير متاح';

  @override
  String get pathListErrorLoadingPaths => 'خطأ في تحميل المسارات:';

  @override
  String get commentI => 'نصوص شاشة تفاصيل المسار (Path Detail)';

  @override
  String get pathDetailScreenTitle => 'تفاصيل المسار';

  @override
  String get pathDetailScreenBackArrowSemantic => 'الرجوع إلى قائمة المسارات';

  @override
  String get pathDetailScreenNotFound => 'لم يتم العثور على المسار.';

  @override
  String get pathDetailScreenFailToUpdate => 'فشل تحديث تقدم المسار:';

  @override
  String get pathDetailScreenProgressDisabled => 'التتبع غير متوفر لهذا المسار.';

  @override
  String get pathDetailScreenLessonsHeading => 'الدروس:';

  @override
  String get pathDetailScreenNoLessonsLabel => 'لا توجد دروس متاحة.';

  @override
  String get pathDetailScreenErrorLoading => 'خطأ في تحميل المسار أو الدروس:';

  @override
  String get pathDetailScreenLessonCardSemantic => 'اضغط لفتح تفاصيل الدرس';

  @override
  String get pathDetailScreenLessonCompleteIconSemantic => 'الدرس مكتمل';

  @override
  String get pathDetailScreenLessonInProgressIconSemantic => 'الدرس قيد التقدم';

  @override
  String get pathDetailScreenLessonInvalidIconSemantic => 'الدرس غير صالح أو غير متاح';

  @override
  String get pathDetailScreenLessonProgressUnavailable => 'التقدم غير متاح';

  @override
  String get pathDetailScreenLessonNoProgress => 'لا يوجد تتبع للتقدم لهذا المسار';

  @override
  String get pathDetailScreenLessonUpgrade => 'قم بالترقية للحصول على ميزة التقدم.';

  @override
  String pathDetailScreenLessonProgressLabel(Object progress) {
    return 'التقدم: $progress٪';
  }

  @override
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah) {
    return 'الدرس $lessonIndex: $surahName - آية $startAyah-$endAyah';
  }

  @override
  String get commentJ => 'نصوص شاشة إنشاء المسار (Create Path)';

  @override
  String get createPathTitle => 'إنشاء مسار جديد';

  @override
  String get createPathBackArrowSemantic => 'الرجوع إلى الشاشة السابقة';

  @override
  String get createPathNameLabel => 'اسم المسار';

  @override
  String get createPathNameValidation => 'يرجى إدخال اسم للمسار';

  @override
  String get createPathDescriptionLabel => 'الوصف';

  @override
  String get createPathDescriptionValidation => 'يرجى إدخال وصف';

  @override
  String get createPathSurahSelectorLabel => 'اختر سورة:';

  @override
  String get createPathStartAyahLabel => 'بداية الآية';

  @override
  String get createPathNumAyahsLabel => 'عدد الآيات في المسار';

  @override
  String get createPathEndAyahLabel => 'نهاية الآية';

  @override
  String get createPathWordsPerLessonLabel => 'عدد الكلمات في الدرس';

  @override
  String get createPathWordsSuffix => 'كلمة';

  @override
  String get createPathInvalidRange => 'نطاق غير صالح';

  @override
  String get createPathAyahsSuffix => 'آيات';

  @override
  String get createPathCreateButton => 'إنشاء المسار';

  @override
  String get createPathSubmitSemantic => 'اضغط لإنشاء المسار';

  @override
  String get commentK => 'نصوص شاشة الترجمة';

  @override
  String get translationScreenTitle => 'الترجمة';

  @override
  String get translationScreenBackArrowSemantic => 'العودة إلى الدرس';

  @override
  String get translationScreenLoadingSemantic => 'جاري تحميل الترجمات';

  @override
  String get translationScreenNoTranslations => 'لا توجد ترجمات متاحة.';

  @override
  String get translationScreenReturnButton => 'العودة إلى الدرس';

  @override
  String get translationScreenReturnSemantic => 'اضغط للعودة إلى الدرس';

  @override
  String get translationScreenLoadError => 'حدث خطأ في تحميل الترجمات:';

  @override
  String get commentL => 'نصوص شاشة اختيار اللغة';

  @override
  String get languageSelectionScreenSemantic => 'شاشة اختيار اللغة';

  @override
  String get languageSelectionTitle => 'اختر لغتك';

  @override
  String get languageSelectionBackSemantic => 'رجوع';

  @override
  String get languageSelectionSkipSemantic => 'تخطي الاختيار';

  @override
  String get languageSelectionInstructions => 'يرجى اختيار اللغة المفضلة لديك:';

  @override
  String get languageSelectionNextSemantic => 'اضغط لتأكيد اختيار اللغة';

  @override
  String get languageSelectionNextLabel => 'التالي';

  @override
  String get languageSelectionImageSemantic => 'صورة هدهد مع القرآن';

  @override
  String get commentM => 'نصوص شاشة الترحيب';

  @override
  String get welcomeScreenSemantic => 'شاشة ترحيبية في عملية الإعداد';

  @override
  String get welcomeScreenLogoSemantic => 'صورة هدهد مع القرآن';

  @override
  String get welcomeScreenSkipSemantic => 'تخطي خطوة الترحيب';

  @override
  String get welcomeScreenNextSemantic => 'الانتقال إلى الخطوة التالية في الإعداد';

  @override
  String get commentN => 'نصوص شاشة معلومات هدهد';

  @override
  String get hudhudInfoSemantic => 'شاشة معلومات هدهد';

  @override
  String get hudhudInfoAppBarTitle => 'تعرف على هدهد';

  @override
  String get hudhudInfoIllustrationSemantic => 'رسم توضيحي للهدهد';

  @override
  String get hudhudInfoBody1 => 'الهدهد، المعروف أيضًا بطائر الهدهد، لعب دورًا خاصًا في مساعدة النبي سليمان عليه السلام بالمراقبة ونقل الرسائل.';

  @override
  String get hudhudInfoBody2 => 'تذكرنا قصة الهدهد بأن مخلوقًا صغيرًا يمكن أن يكون له تأثير كبير من خلال الملاحظة والفضول والمبادرة بالأمور المهمة. وفي رحلتنا هذه، يمكننا توجيه اهتمامنا المستمر لجمال القرآن، وإدخال تذكيرات الامتنان لتقدير كل لحظة من التقدم.';

  @override
  String get hudhudInfoBody3 => 'باتباع مثال الهدهد—بالبقاء يقظين ومشاركين—نأمل أن نُعمِّق ارتباطنا بالقرآن وننمي شعور الامتنان في حياتنا اليومية.';

  @override
  String get hudhudInfoNextLabel => 'التالي';

  @override
  String get hudhudInfoNextSemantic => 'الانتقال إلى القسم التالي';

  @override
  String get hudhudInfoSkipSemantic => 'تخطي خطوة التعرف على هدهد';

  @override
  String get commentO => 'نصوص شاشة اختيار خطة الاشتراك';

  @override
  String get subscriptionTierScreenSemantic => 'شاشة اختيار فئة الاشتراك';

  @override
  String get subscriptionTierScreenAppBarTitle => 'اختر خطتك';

  @override
  String get subscriptionTierScreenSkipSemantic => 'تخطي اختيار فئة الاشتراك';

  @override
  String get subscriptionTierScreenFreeLabel => 'مجاني';

  @override
  String get subscriptionTierScreenSmileySemantic => 'أيقونة وجه مبتسم';

  @override
  String get subscriptionTierScreenDonationText => 'يُخصص جزء من المساهمات لمبادرة المبُتسم، لدعم الأيتام عبر الإغاثة الإسلامية.';

  @override
  String get subscriptionTierScreenConfirmSemantic => 'تأكيد اختيار فئة الاشتراك';

  @override
  String get subscriptionTierScreenNextLabel => 'التالي';

  @override
  String subscriptionTierScreenRadioSemantic(Object title) {
    return 'اضغط لاختيار فئة الاشتراك $title';
  }

  @override
  String get commentP => 'نصوص شاشة اختيار الأهداف';

  @override
  String get goalSelectionScreenSemantic => 'شاشة اختيار الأهداف';

  @override
  String get goalSelectionScreenAppBarTitle => 'اختر أهدافك';

  @override
  String get goalSelectionScreenSkipSemantic => 'تخطي اختيار الأهداف';

  @override
  String get goalSelectionScreenIntroText => 'ما هي الأهداف التي تهمك؟ يمكنك اختيار أكثر من خيار.';

  @override
  String get goalSelectionScreenNextSemantic => 'تأكيد اختيار الأهداف';

  @override
  String get goalSelectionScreenNextLabel => 'التالي';

  @override
  String goalSelectionTileSemantic(Object goalTitle) {
    return 'اضغط لتحديد أو إلغاء تحديد هدف $goalTitle';
  }

  @override
  String get goalConnectQuranTitle => 'تعميق الارتباط بالقرآن';

  @override
  String get goalConnectQuranDesc => 'تعزيز علاقتك من خلال القراءة أو التدبر.';

  @override
  String get goalMemorizeQuranTitle => 'حفظ القرآن';

  @override
  String get goalMemorizeQuranDesc => 'ابدأ رحلة الحفظ.';

  @override
  String get goalBeMoreGratefulTitle => 'زيادة الامتنان والسعادة في الحياة';

  @override
  String get goalBeMoreGratefulDesc => 'ركز على ممارسة الامتنان اليومي.';

  @override
  String get goalBuildConsistencyTitle => 'بناء الاستمرارية';

  @override
  String get goalBuildConsistencyDesc => 'طوّر عادة يومية أو أسبوعية.';

  @override
  String get goalImproveArabicTitle => 'تحسين لغتي العربية';

  @override
  String get goalImproveArabicDesc => 'ركز على مهارات الكتابة أو النطق بالعربية.';

  @override
  String get goalDeepenTafsirTitle => 'عمق فهم القران';

  @override
  String get goalDeepenTafsirDesc => 'ادرس التعليق والمعاني الأعمق للقرآن.';

  @override
  String get goalOtherTitle => 'هدف اخر';

  @override
  String get goalOtherDesc => 'اسعَ وراء أي هدف شخصي آخر.';

  @override
  String get commentQ => 'نصوص شاشة اختيار المستوى';

  @override
  String get levelSelectionScreenSemantic => 'شاشة اختيار المستوى';

  @override
  String get levelSelectionScreenAppBarTitle => 'اختر مستواك';

  @override
  String get levelSelectionScreenSkipSemantic => 'تخطي اختيار المستوى';

  @override
  String get levelSelectionScreenIntroText => 'اختر الوصف الأقرب لمستوى تلاوتك الحالي:';

  @override
  String get levelStarterLabel => 'مبتدئ';

  @override
  String get levelStarterDescription => 'متعلم جديد أو غير منتظم، في بداية استكشاف تلاوة القرآن.';

  @override
  String get levelAdvancedLabel => 'متقدم';

  @override
  String get levelAdvancedDescription => 'مرتاح في قراءة النص العربي مع بعض معرفة التجويد.';

  @override
  String get levelQariLabel => 'قارئ';

  @override
  String get levelQariDescription => 'متمكن من التلاوة مع إتقان قوي للتجويد.';

  @override
  String get levelSelectionNextSemantic => 'تأكيد اختيار المستوى';

  @override
  String get levelSelectionNextLabel => 'التالي';

  @override
  String levelSelectionTileSemantic(Object levelTitle) {
    return 'اضغط لاختيار مستوى التلاوة $levelTitle';
  }

  @override
  String get commentR => 'نصوص شاشة إتمام عملية الإعداد';

  @override
  String get onboardingCompletionScreenSemantic => 'شاشة إتمام عملية الإعداد';

  @override
  String get onboardingCompletionScreenAppBarTitle => 'كل شيء جاهز!';

  @override
  String get onboardingCompletionScreenImageSemantic => 'صورة هدهد مع القرآن';

  @override
  String get onboardingCompletionScreenBody1 => 'تهانينا! لقد أكملت عملية الإعداد بنجاح. نأمل أن تقربك هذه الرحلة من القرآن وتعزز امتنانك لله. \n \nنسأل الله أن يكون هذا التطبيق مصدر نمو وخير لك ولمن حولك.';

  @override
  String get onboardingCompletionScreenBody2 => 'عندما تكون مستعدًا، اضغط على الزر أدناه للمتابعة. الميزات الرئيسية للحفظ والتقدم بانتظارك، ويمكنك تسجيل امتنانك أو اختيار مسار من الشريط السفلي.';

  @override
  String get onboardingCompletionScreenBody3 => 'هذا إصدار مبكر — نشكرك على دعمك وصبرك ونأمل تزويدك بالمزيد من الميزات قريبًا إن شاء الله!';

  @override
  String get onboardingCompletionScreenBeginSemantic => 'ابدأ استخدام التطبيق';

  @override
  String get onboardingCompletionScreenBeginLabel => 'لنبدأ';

  @override
  String get commentS => 'نصوص شاشة إدخال الاسم';

  @override
  String get nameEntryScreenSemantic => 'شاشة إدخال الاسم';

  @override
  String get nameEntryScreenAppBarTitle => 'ملفك الشخصي';

  @override
  String get nameEntryScreenSkipSemantic => 'تخطي إدخال اسمك';

  @override
  String get nameEntryScreenIntroText => 'ما هو اسمك؟';

  @override
  String get nameEntryTextFieldSemantic => 'حقل نص لإدخال الاسم';

  @override
  String get nameEntryNextSemantic => 'تأكيد إدخال الاسم';

  @override
  String get nameEntryNextLabel => 'التالي';

  @override
  String get commentT => 'نصوص أيقونات الدرس العمودية';

  @override
  String get verticalLessonIconsSemantic => 'حاوية أيقونات الدرس العمودية';

  @override
  String get verticalLessonIconsNoLessons => 'لا توجد دروس.';

  @override
  String get verticalLessonIconsLoadingSurah => 'جاري تحميل تفاصيل السورة';

  @override
  String get verticalLessonIconsErrorSurah => 'خطأ في تحميل تفاصيل السورة';

  @override
  String get verticalLessonIconsSurahHeaderSemantic => 'عنوان تفاصيل السورة';

  @override
  String get verticalLessonIconsHudhudIconSemantic => 'أيقونة الهدهد المساعد';

  @override
  String get verticalLessonIconsNextPageSemantic => 'سهم الصفحة التالية';

  @override
  String get verticalLessonIconsPreviousPageSemantic => 'سهم الصفحة السابقة';

  @override
  String get verticalLessonIconsLoadingProgress => 'جاري تحميل تقدم الدرس';

  @override
  String get verticalLessonIconsErrorProgress => 'خطأ في تحميل التقدم';

  @override
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent) {
    return 'أيقونة الدرس، $surahAyahRange، نسبة التقدم $percent٪';
  }

  @override
  String get verticalLessonIconsCompletedSemantic => 'تم إكمال الدرس';

  @override
  String get verticalLessonIconsDialogTitle => 'الدعم والترقية';

  @override
  String get verticalLessonIconsDialogOk => 'حسناً';

  @override
  String get commentU => 'نصوص شريط التنقل السفلي (Navbar)';

  @override
  String get navBarSemanticLabel => 'شريط التنقل السفلي';

  @override
  String get navHomeLabel => 'الرئيسية';

  @override
  String get navHomeSemantic => 'تبويب الرئيسية';

  @override
  String get navQuranLabel => 'القرآن';

  @override
  String get navQuranSemantic => 'تبويب القرآن';

  @override
  String get navGratitudeLabel => 'امتنان';

  @override
  String get navGratitudeSemantic => 'تبويب الامتنان';

  @override
  String get navProfileLabel => 'ملف شخصي';

  @override
  String get navProfileSemantic => 'تبويب الملف الشخصي';

  @override
  String get commentV => 'نصوص الشريط العلوي (TopBar)';

  @override
  String get topBarSemanticLabel => 'شريط التنقل العلوي';

  @override
  String topBarTitleSemantic(Object title) {
    return 'عنوان الشريط العلوي: $title';
  }

  @override
  String topBarStreakIconSemantic(Object days) {
    return 'أيقونة السلسلة: $days يوم';
  }

  @override
  String get topBarStreakDialogBody => 'هذه الأيقونة تعرض عدد الأيام المتتالية التي قمت فيها بالتلاوة أو كتابة الامتنان. استمر في ذلك للحفاظ على السلسلة أو زيادتها!';

  @override
  String get topBarHudhudIconSemantic => 'أيقونة هدهد، اضغط للحصول على الدعم';

  @override
  String get topBarHudhudDialogTitle => 'الدعم والترقية';

  @override
  String get topBarHudhudDialogBody => 'جميع الميزات متاحة في الإصدار المجاني، ولكن إذا أردت يمكنك دعمنا لتطوير المزيد من الميزات. سيتم التبرع بجزء من اشتراكك لمؤسسة Islamic Relief. جزاك الله خيرًا!';

  @override
  String get commentW => 'نصوص نافذة الامتنان المنبثقة (Modal)';

  @override
  String get gratitudeModalSemantic => 'مربع حوار نافذة الامتنان';

  @override
  String get gratitudeModalTitle => 'على ماذا تشعر بالامتنان اليوم بناءً على هذه الآيات؟';

  @override
  String gratitudeModalHint(Object index) {
    return 'الحمد لله على (أدخل الامتنان) #$index';
  }

  @override
  String gratitudeModalTextFieldSemantic(Object index) {
    return 'أدخل الامتنان رقم #$index';
  }

  @override
  String get gratitudeModalEmptyWarning => 'يرجى إدخال امتنان واحد على الأقل.';

  @override
  String get gratitudeModalSubmitError => 'فشل في حفظ الامتنان. يرجى المحاولة مرة أخرى.';

  @override
  String get dailyVoiceLimitReachedTitle => 'ما شاء الله!';

  @override
  String get dailyVoiceLimitReachedMessage => 'أكملتَ 10 دقائق من تلاوة القرآن بالصوت. يرجى الاستمرار بالمراجعة كتابيًا، ومواصلة التلاوة غدًا.';

  @override
  String get upgradeVoiceUsageTitle => 'الترقية إلى Pro Beta';

  @override
  String get gratitudeModalLoadingSemantic => 'جاري إرسال الامتنان';

  @override
  String get commentX => '== مفاتيح جديدة للنافذة المنبثقة لتغذية الملاحظات بعد الإرسال، شريط التقدم، ومحدد السورة ==';

  @override
  String get submissionFeedbackModalSemanticLabel => 'مربع حوار تغذية راجعة للإرسال';

  @override
  String get submissionFeedbackModalTitle => 'تغذية راجعة للإرسال';

  @override
  String get submissionFeedbackModalNoNew => 'لم يتم إرسال أي امتنانات جديدة.';

  @override
  String get submissionFeedbackModalYouSubmitted => 'لقد أضفت هذه الامتنانات:';

  @override
  String submissionFeedbackModalStreak(Object days) {
    return 'سلسلة الامتنان الحالية: $days يوم';
  }

  @override
  String submissionFeedbackModalTotalDays(Object count) {
    return 'إجمالي أيام الامتنان: $count';
  }

  @override
  String get submissionFeedbackModalLoading => 'جاري تحميل بيانات الامتنان...';

  @override
  String get submissionFeedbackModalError => 'تعذر تحميل بيانات الامتنان.';

  @override
  String get submissionFeedbackModalViewLog => 'عرض السجل';

  @override
  String get submissionFeedbackModalClose => 'إغلاق';

  @override
  String progressBarSemanticLabel(Object percent) {
    return 'التقدم: $percent٪';
  }

  @override
  String get surahSelectorSemanticLabel => 'اختر سورة';

  @override
  String get commentZ => 'أسماء المسارات ووصفها (مُعرفة في النظام) للترجمة';

  @override
  String get pathNameFatihah => 'سورة الفاتحة';

  @override
  String get pathDescFatihah => 'السورة كاملة (1:1–7). أساسية في كل ركعة.';

  @override
  String get pathNameKafirun => 'سورة الكافرون';

  @override
  String get pathDescKafirun => 'السورة كاملة (109:1–6). تأكيد التوحيد.';

  @override
  String get pathNameIkhlas => 'سورة الإخلاص';

  @override
  String get pathDescIkhlas => 'السورة كاملة (112:1–4). توحيد الله.';

  @override
  String get pathNameFalaq => 'سورة الفلق';

  @override
  String get pathDescFalaq => 'السورة كاملة (113:1–5). استعاذة من الشرور الخارجية.';

  @override
  String get pathNameNas => 'سورة الناس';

  @override
  String get pathDescNas => 'السورة كاملة (114:1–6). استعاذة من الوساوس الداخلية.';

  @override
  String get pathNameAsrBegin => 'سورة العصر';

  @override
  String get pathDescAsrBegin => '(103:1–3). ثلاث آيات فقط لكنها جوهر “الصبر”.';

  @override
  String get pathNameTakathur => 'سورة التكاثر';

  @override
  String get pathDescTakathur => '(102:1–8) عن التنافس الدنيوي والمحاسبة.';

  @override
  String get pathNameFil => 'سورة الفيل';

  @override
  String get pathDescFil => '(105:1–5). حادثة أصحاب الفيل؛ خمس آيات قصيرة.';

  @override
  String get pathNameQuraysh => 'سورة قريش';

  @override
  String get pathDescQuraysh => '(106:1–4). عن شكر نعمة رحلة الشتاء والصيف.';

  @override
  String get pathNameRahmanA => 'الرحمن أ';

  @override
  String get pathDescRahmanA => '(55:1–13): تعليم القرآن وخلق الإنسان.';

  @override
  String get pathNameRahmanB => 'الرحمن ب';

  @override
  String get pathDescRahmanB => '(55:26–36): مسؤولية الإنس والجن.';

  @override
  String get pathNameYasinBlock => 'سورة يس (جزء)';

  @override
  String get pathDescYasinBlock => '(36:1–12). مقدمة لرسالة النبي وتحذيراته.';

  @override
  String get pathNameMulkBlock => 'سورة الملك (جزء)';

  @override
  String get pathDescMulkBlock => '(67:1–15). تأكيد سيادة الله ودعوة للتأمل.';

  @override
  String get pathNameBaqarah21_29 => 'البقرة (2:21–29)';

  @override
  String get pathDescBaqarah21_29 => 'تسع آيات عن الخلق والتدبر من أجل الشكر.';

  @override
  String get pathNameNahl66_72 => 'النحل (16:66–72)';

  @override
  String get pathDescNahl66_72 => 'سبع آيات تُعدد النعم: الأنعام والثمار وغيرها.';

  @override
  String get pathNameAdDuha => 'سورة الضحى';

  @override
  String get pathDescAdDuha => '(93:1–11) إحدى عشرة آية تعطي الأمل والطمأنينة.';

  @override
  String get pathNameKahfCave => 'الكهف: فتية الكهف';

  @override
  String get pathDescKahfCave => '(18:9–16) قصة الشباب المؤمنين في الكهف.';

  @override
  String get pathNameKahfMusa => 'الكهف: موسى والخضر';

  @override
  String get pathDescKahfMusa => '(18:60–70) يؤكد على الصبر والحكمة الخفية.';

  @override
  String get pathNameWaqiah => 'الواقعة (56:1–15)';

  @override
  String get pathDescWaqiah => 'خمس عشرة آية حول مجيء الساعة المفاجئ.';

  @override
  String get pathNameAsrPatience => 'سورة العصر (الصبر)';

  @override
  String get pathDescAsrPatience => '(103:1–3) مجددًا، ثلاث آيات تتمحور حول الصبر.';

  @override
  String get pathNameBaq153_157 => 'البقرة (2:153–157)';

  @override
  String get pathDescBaq153_157 => 'خمس آيات: “استعينوا بالصبر والصلاة”.';

  @override
  String get pathNameYusuf7_14 => 'يوسف (12:7–14)';

  @override
  String get pathDescYusuf7_14 => 'غيرة إخوة يوسف. اختبار للصبر.';

  @override
  String get pathNameYusuf83_92 => 'يوسف (12:83–92)';

  @override
  String get pathDescYusuf83_92 => 'حزن يعقوب وعفو يوسف (10 آيات).';

  @override
  String get pathNameInshirah => 'سورة الشرح (94:1–8)';

  @override
  String get pathDescInshirah => 'ثمان آيات: طمأنة بعد العسر. يرتبط بالصبر والأمل.';

  @override
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah) {
    return 'سورة $surahName، آية $startAyah-$endAyah';
  }

  @override
  String get finishLabel => 'إنهاء';

  @override
  String get twoWordMultipleChoiceLabel => 'اختر الكلمتين الصحيحتين';

  @override
  String get singleWordMultipleChoiceLabel => 'اختر الكلمة الصحيحة';

  @override
  String get correctAnswerLabel => 'صحيح!';

  @override
  String get incorrectAnswerLabel => 'غير صحيح!';

  @override
  String get lessonCompletedLabel => 'تم استكمال الدرس!';

  @override
  String get profileAnalyticsScoreLabel => 'التحليلات والنقاط';

  @override
  String get profileDailyLabel => 'يومي';

  @override
  String get profileWeeklyLabel => 'أسبوعي';

  @override
  String get profileMonthlyLabel => 'شهري';

  @override
  String get profileTotalLabel => 'المجموع';

  @override
  String get profileViewChart => 'عرض المخطط';

  @override
  String get profileCloseLabel => 'إغلاق';

  @override
  String get profileScoreChartTitle => 'مخطط الدرجات';

  @override
  String get profileScoreChartHistory => 'السجل';

  @override
  String get profileNoData => 'لا توجد بيانات';

  @override
  String get topBarDailyScoreLabel => '⭐ اليوم';

  @override
  String topBarDailyScoreSemantic(Object score) {
    return 'درجتك اليومية هي $score';
  }

  @override
  String get profilePremiumNeeded => 'يرجى الترقية لعرض تقويم التقدم ودعمنا في بناء مزيد من الميزات إن شاء الله!';

  @override
  String get levelMultipleChoiceLabel => 'اختيار من متعدد';

  @override
  String get levelMultipleChoiceDescription => 'خطوات اختيار من متعدد بكلمة واحدة أو كلمتين مع إمكانية تخطي الاختيارات.';

  @override
  String get levelBeginnerLabel => 'مبتدئ';

  @override
  String get levelBeginnerDescription => 'إزالة تدريجية للكلمات في تسلسلات مجمّعة لتسهيل الحفظ بشكل متدرج.';

  @override
  String get subscriptionTierScreenPremiumLabel => 'Plus';

  @override
  String get featureUnavailableOffline => 'الميزة غير متاحة في وضع عدم الاتصال. يرجى الاتصال أو تمكين وضع عدم الاتصال عن طريق الترقية إلى Plus أو Pro Beta.';

  @override
  String submissionFeedbackModalTotalCount(Object count) {
    return 'إجمالي عدد مداخلات الشكر: $count';
  }

  @override
  String get notificationDailyTitle => 'تذكير لطيف بالقرآن';

  @override
  String get notificationWeeklyTitle => 'مراجعة أسبوعية للقرآن';

  @override
  String get notificationWeeklyBody => 'تأمل في تقدمك واحفظ جزءًا جديدًا من القرآن مع ممارسة الشكر.';

  @override
  String get notificationChannelDailyRemindersName => 'التذكيرات اليومية';

  @override
  String get notificationChannelDailyRemindersDesc => 'تذكيرات لحفظ القرآن يوميًا';

  @override
  String get notificationChannelWeeklyRemindersName => 'التذكيرات الأسبوعية';

  @override
  String get notificationChannelWeeklyRemindersDesc => 'تذكيرات للمراجعة الأسبوعية لحفظ القرآن';

  @override
  String get nameEntryNotificationFrequencyDaily => 'يوميًا';

  @override
  String get topBarStreakDialogTitle => 'السلسلة';

  @override
  String get fillInTheBlanksLabel => 'أكمل الفراغات';

  @override
  String get loadingDataLabel => 'جاري التحميل…';

  @override
  String ayahRangeLabel(Object start, Object end) {
    return 'الآية $start - $end';
  }

  @override
  String get nextPageSemanticLabel => 'الصفحة التالية';

  @override
  String get prevPageSemanticLabel => 'الصفحة السابقة';

  @override
  String pageXOfYLabel(Object current, Object total) {
    return 'الصفحة $current من $total';
  }

  @override
  String verseSemanticLabel(Object ayahNumber, Object surahName) {
    return 'الآية $ayahNumber من سورة $surahName';
  }

  @override
  String get ayahLabel => 'آية';

  @override
  String get goToSurahViewLabel => 'عرض السورة';

  @override
  String get clickOnAyaToOpenLesson => 'انقر على أي آية أدناه لبدء الدرس';

  @override
  String get difficultyChoosingScreenIntro => 'اختر تفضيلاتك: الاختيار من متعدد أو إكمال الفراغات، وعدد مرات تكرار كل خطوة وتشغيل الصوت.';

  @override
  String get upgradeVoiceUsageMessage => 'قم بالترقية إلى Pro Beta لتجربة ميزة الصوت ومساعدتنا في تحسينها!';

  @override
  String get restorePurchasesLabel => 'استعادة المشتريات';

  @override
  String get subscriptionTierScreenMonthly => 'شهريًا';

  @override
  String get subscriptionTierScreenYearly => 'سنويًا';

  @override
  String get subscriptionTierScreenFreePrice => 'مجانًا';

  @override
  String get subscriptionTierScreenPremiumMonthlyPrice => 'الآن 3 دولارات/شهر (كانت 5 دولارات)';

  @override
  String get subscriptionTierScreenPremiumYearlyPrice => 'الآن 28 دولارًا/سنة (كانت 60 دولارًا)';

  @override
  String get subscriptionTierScreenPremiumPlusMonthlyPrice => 'الآن 7 دولارات/شهر (كانت 10 دولارات)';

  @override
  String get subscriptionTierScreenPremiumPlusYearlyPrice => 'الآن 45 دولارًا/سنة (كانت 84 دولارًا)';

  @override
  String get subscriptionPurchaseError => 'حدث خطأ أثناء شراء الاشتراك';

  @override
  String get topBarExplorePlansLabel => 'استكشف الخطط';

  @override
  String get topBarBackHomeLabel => 'العودة إلى الصفحة الرئيسية';

  @override
  String get profileRequiresPlanUpdate => 'يتطلب تحديث الخطة';

  @override
  String get subscriptionTierScreenPremiumDescription => 'كل ما في النسخة المجانية، بالإضافة إلى الدروس في وضع عدم الاتصال والتعليقات، والتحليلات التاريخية، إلى جانب أشرطة التقدم، والملف الشخصي، وتخصيص القرآن. ادعمنا في بناء مزيد من الميزات!';

  @override
  String get subscriptionAutoRenewNotice => 'سيتم تجديد الاشتراك تلقائيًا، ويمكن إلغاؤه لتجنب الرسوم في الفترة القادمة. سيتم التبرع بجزء من الأموال إلى Islamic Relief عبر مبادرة المبتسم 😀.';

  @override
  String get subscriptionTierScreenSubscribeLabel => 'اشترك';

  @override
  String get subscriptionTierScreenFinalMessage => 'نقدّر دعمك!';

  @override
  String get subscriptionPurchaseRestoreSuccess => 'تمت استعادة مشترياتك بنجاح.';

  @override
  String get subscriptionTierScreenRestoreLabel => 'استعادة المشتريات';

  @override
  String get arabicLabel => 'العربية';

  @override
  String get transliterationLabel => 'الإنجليزية';

  @override
  String get surahSearchScreenTitle => 'البحث عن سورة';

  @override
  String get genericBack => 'رجوع';

  @override
  String get surahSearchSelectSurah => 'اختر سورة:';

  @override
  String get surahSearchExistingPaths => 'المسارات الحالية لهذه السورة';

  @override
  String get surahSearchNoMatches => 'لم يتم العثور على أي مسارات حالية.';

  @override
  String get surahSearchHideCreateForm => 'إخفاء نموذج الإنشاء';

  @override
  String get surahSearchShowCreateForm => 'إنشاء مسار جديد للسورة';

  @override
  String get createPathTrackProgress => 'تتبع التقدم؟';

  @override
  String get themeScreenSearchIconSemantic => 'ابحث عن السور';

  @override
  String get pathListSearchIconSemantic => 'ابحث عن السور';

  @override
  String get pathLessonsSearchIconSemantic => 'ابحث عن السور';

  @override
  String get playAllSurahSemantic => 'تشغيل السورة بأكملها';

  @override
  String get toggleTransliterationLabel => 'تبديل الترجمة الحرفية';

  @override
  String get englishLabel => 'الإنجليزية';

  @override
  String get subscriptionTierScreenPremiumPlusLabel => 'ادعمنا (سنويًا)';

  @override
  String get subscriptionTierScreenFreeDescription => 'جميع الميزات مجانية وبدون إعلانات!';

  @override
  String get subscriptionTierScreenPremiumPlusDescription => 'ساعد في تمويل الميزات والتحسينات الجديدة! أيضًا، المساهمة المالية البسيطة قد تساعدك في بناء العادة!';

  @override
  String get subscriptionTierScreenSupportLabel => 'الدعم السنوي';

  @override
  String get verticalLessonIconsDialogBody => 'جميع الميزات متاحة في الإصدار المجاني، ولكن إذا أردت يمكنك دعمنا لتطوير المزيد من الميزات. سيتم التبرع بجزء من اشتراكك لمؤسسة Islamic Relief. جزاك الله خيرًا!';

  @override
  String get welcomeBody => 'لعب الهدهد دورًا مميزًا في مساعدة النبي سليمان [عليه السلام] من خلال المراقبة ونقل الرسائل.\n\nلا يحكم عليك بغض النظر عن موقعك في رحلتك، وهو متحمس لإرشادك في رحلة اكتشاف جمال القرآن ودمج تذكيرات الشكر للتقدير في كل لحظة معه.';

  @override
  String get surahSearchByName => 'ابحث بالاسم (إنجليزي أو عربي)';

  @override
  String get surahSearchHintAnyName => 'اكتب أي اسم سورة...';

  @override
  String get surahSearchFieldLabel => 'ابحث عن سورة';

  @override
  String get surahSearchInvalidLessonsError => 'درس واحد أو أكثر غير صالح. لا يمكن إنشاء المسار.';

  @override
  String get surahSearchUserSurahPrefix => 'سورة المستخدم';

  @override
  String get notificationDailyBody => 'خذ لحظة للعثور على بعض السكينة عبر القرآن وذكّر نفسك بسبب امتنانك اليوم.';
}
