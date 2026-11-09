import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get commentA => 'Uygulama açılış (Onboarding) metinleri';

  @override
  String get appBarTitleWelcome => 'Hoş Geldiniz';

  @override
  String get skipLabel => 'Atla';

  @override
  String get welcomeHeadline => 'Hudhud ile Kur’an’a Hoş Geldiniz!';

  @override
  String get getStartedLabel => 'Başla';

  @override
  String get commentB => 'Ders ekranı metinleri';

  @override
  String get lessonScreenAppBarTitle => 'Ders';

  @override
  String get noAyahAvailable => 'Çalınacak ayet bulunamadı.';

  @override
  String audioNotFound(Object url) {
    return 'Ses dosyası burada bulunamadı: $url';
  }

  @override
  String get restartLessonTitle => 'Dersi Yeniden Başlat';

  @override
  String get resetLessonBody => 'Bu dersteki tüm ilerlemenizi sıfırlamak istiyor musunuz?';

  @override
  String get cancelLabel => 'İptal';

  @override
  String get yesLabel => 'Evet';

  @override
  String get errorResettingLesson => 'Ders sıfırlanırken hata oluştu';

  @override
  String get startLabel => 'Başla';

  @override
  String get submitLabel => 'Gönder';

  @override
  String get nextLabel => 'İleri';

  @override
  String get voiceErrorMicDeniedTitle => 'Mikrofon İzni Reddedildi';

  @override
  String get voiceErrorMicDeniedBody => 'Kayıt için mikrofon erişimi gereklidir. Lütfen Ayarlar’dan izin veriniz.';

  @override
  String get voiceErrorMicDeniedSemanticLabel => 'Mikrofon izni reddedildi diyalogu';

  @override
  String get voiceErrorRecorderStartTitle => 'Kayıt Hatası';

  @override
  String get voiceErrorRecorderStartBody => 'Kaydedici başlatılamadı. Lütfen tekrar deneyin.';

  @override
  String get voiceErrorRecorderStartSemanticLabel => 'Kayıt başlatma hatası diyalogu';

  @override
  String get voiceErrorRecorderStopTitle => 'Kaydı Durdurma Hatası';

  @override
  String get voiceErrorRecorderStopBody => 'Kaydedici düzgün şekilde durdurulamadı. Lütfen tekrar deneyin.';

  @override
  String get voiceErrorRecorderStopSemanticLabel => 'Kaydı durdurma hatası diyalogu';

  @override
  String get voiceErrorNoSoundTitle => 'Ses Algılanmadı';

  @override
  String get voiceErrorNoSoundBody => 'Kaydınız sessiz veya çok kısık. Lütfen tekrar deneyin.';

  @override
  String get voiceErrorNoSoundSemanticLabel => 'Ses algılanmadı diyalogu';

  @override
  String get voiceErrorTranscriptionTitle => 'Dönüştürme Hatası';

  @override
  String get voiceErrorTranscriptionBody => 'Kaydınızı dönüştüremedik. Lütfen bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get voiceErrorTranscriptionSemanticLabel => 'Dönüştürme hatası diyalogu';

  @override
  String get tapColoredWordsHint => 'Düzeltilmiş versiyonunu görmek için vurgulu kelimelere dokunun.';

  @override
  String get emptyInputWarning => 'Göndermeden önce bir şeyler yazmalısınız';

  @override
  String get getHintLabel => 'İpucu Al';

  @override
  String get removeHintLabel => 'İpucunu Kaldır';

  @override
  String get typeTheMissingWordsLabel => 'Eksik kelime(leri) yazın';

  @override
  String get difficultyLabel => 'Zorluk Derecesi';

  @override
  String get repeatCountLabel => 'Tekrar Sayısı';

  @override
  String get backButtonLabel => 'Geri';

  @override
  String get toggleTranslationLabel => 'Çeviriyi göster/gizle';

  @override
  String get openTranslationScreenLabel => 'Çeviri ekranını aç';

  @override
  String get restartLessonSemanticLabel => 'Dersi yeniden başlat';

  @override
  String get verseDisplayAreaLabel => 'Kur’an ayetlerini gösterme alanı';

  @override
  String get playAudioSemanticLabel => 'Ayet sesini oynat';

  @override
  String get openGratitudeSemanticLabel => 'Şükür penceresini aç';

  @override
  String get voiceUsageSemanticLabel => 'Sesli kullanım süresi (dakika)';

  @override
  String get voiceRecordSemanticLabel => 'Ses kaydını başlat veya durdur';

  @override
  String get commentC => 'Yeni ANA SAYFA ekranı metinleri';

  @override
  String get homeTitle => 'Ana Sayfa';

  @override
  String get noPathsLabel => 'Uygun bir yol bulunamadı.';

  @override
  String errorLoadingActivePath(Object err) {
    return 'Etkin yol yüklenirken hata oluştu: $err';
  }

  @override
  String get verticalLessonIconsGoToTheme => 'Temaya Git';

  @override
  String get homePathCardLabel => 'Tema ekranını açmak için dokunun';

  @override
  String get arrowForwardSemanticLabel => 'Ayrıntıları aç';

  @override
  String get noTrackProgressLabel => 'Bu yol ilerlemeyi kaydetmez.';

  @override
  String get premiumRequiredLabel => 'İlerleme takibini etkinleştirmek için yükseltin. Bizi daha fazla özellik sunmamızda destekleyin!';

  @override
  String get completedLabel => 'tamamlandı';

  @override
  String get fabLogGratitudeLabel => 'Şükür girişi yapmak için dokunun';

  @override
  String get errorNavigatingToLesson => 'Ders ekranına geçilirken hata oluştu';

  @override
  String get commentD => 'Profil ekranı metinleri';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileBackArrowLabel => 'Önceki ekrana dön';

  @override
  String get profileAvatarSemanticLabel => 'Kullanıcı avatarı';

  @override
  String get profileEnterYourName => 'İsminizi girin';

  @override
  String get nameEntryNotificationFrequencyDropdownLabel => 'Bildirim Sıklığı';

  @override
  String get nameEntryNotificationFrequencyWeekly => 'Haftalık';

  @override
  String get nameEntryNotificationFrequencyNone => 'Yok';

  @override
  String get notificationPermissionPrompt => 'Şükür veya ders gönderimlerini tamamlaman için nazik hatırlatmalar göndermek istiyoruz - alışkanlık edinmen için bize bildirim izni verebilirsin 😃.';

  @override
  String get profileNameSave => 'Kaydet';

  @override
  String get profileNameCancel => 'İptal';

  @override
  String get profileNameGuest => 'Misafir';

  @override
  String get profileNameEdit => 'Düzenle';

  @override
  String get profilePreferredLanguage => 'Dil:';

  @override
  String get okLabel => 'Tamam';

  @override
  String get profileReciterLabel => 'Kâri';

  @override
  String get profileFontLabel => 'Yazı Tipi:';

  @override
  String get profileReciterMishary => 'Mishary Raşid El-Afasi';

  @override
  String get profileReciterShatri => 'Ebu Bekr Eş-Şatri';

  @override
  String get profileReciterQatami => 'Nasser El-Ketami';

  @override
  String get profileUpgradePremiumTitle => 'Daha Fazla Kişiselleştirme Açın!';

  @override
  String get profileUpgradePremiumBody => 'Yazı tipi ve kâri değiştirme özelliğinin keyfini çıkarmak için Pro’ya yükseltin. Sürekli gelişim çalışmalarımızı destekleyin ve deneyiminizi daha da kişiselleştirin!';

  @override
  String get profileWeeksProgress => 'Maşallah, bu haftaki ilerlemen:';

  @override
  String get profileGratefulnessCalendar => 'Şükür Takvimi';

  @override
  String get profileQuranLearningCalendar => 'Kur’an Öğrenme Takvimi';

  @override
  String get profilePrevWeekSemantic => 'Önceki haftaya git';

  @override
  String get profileNextWeekSemantic => 'Sonraki haftaya git';

  @override
  String get profileNotificationFrequency => 'Bildirim Sıklığı';

  @override
  String get commentE => 'Şükür Kayıt Ekranı metinleri';

  @override
  String get gratitudeLogTitle => 'Şükür Günlüğüm';

  @override
  String get gratitudeLogBackArrowSemantic => 'Ana sayfaya dön';

  @override
  String get gratitudeLogClearAllSemantic => 'Tüm şükür kayıtlarını sil';

  @override
  String get gratitudeLogAddSemantic => 'Yeni şükür girişi ekle';

  @override
  String get gratitudeLogClearDialogTitle => 'Şükür Günlüğünü Temizle';

  @override
  String get gratitudeLogClearDialogBody => 'Tüm şükür kayıtlarını silmek istediğinize emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get gratitudeLogClearConfirm => 'Evet, Temizle';

  @override
  String gratitudeLogStreak(Object days) {
    return '⭐ Şükür Serisi: $days gün';
  }

  @override
  String get gratitudeLogStreakLoading => 'Seri hesaplanıyor...';

  @override
  String get gratitudeLogStreakError => 'Seri hesaplanamadı.';

  @override
  String gratitudeLogTotalDays(Object count) {
    return 'Toplam Şükür Yapılan Gün: $count';
  }

  @override
  String get gratitudeLogDataLoading => 'Şükür verileri yükleniyor...';

  @override
  String get gratitudeLogDataError => 'Şükür verileri yüklenemedi.';

  @override
  String get gratitudeLogCardSemantic => 'Şükür girişi kartı';

  @override
  String get gratitudeLogItemIcon => 'Şükür simgesi';

  @override
  String get gratitudeLogEmptyIconSemantic => 'İlk şükür girişini eklemek için dokunun';

  @override
  String get gratitudeLogEmptyMessage => 'Henüz şükür kaydı yok.\nİlk şükrünü eklemek için “+” düğmesine dokun!';

  @override
  String get gratitudeLogEntriesAdded => 'Şükür kaydı başarıyla eklendi!';

  @override
  String get gratitudeLogEntriesFailed => 'Şükür eklenemedi. Lütfen tekrar deneyin.';

  @override
  String get commentF => 'Ders Tamamlama Ekranı metinleri';

  @override
  String get lessonCompletedTitle => 'Ders Tamamlandı';

  @override
  String get lessonCompletedBackArrowSemantic => 'Ana sayfaya dön';

  @override
  String get lessonCompletedMashaAllah => 'Maşallah!';

  @override
  String get lessonCompletedMashaAllahSemantic => 'Tebrik metni';

  @override
  String get lessonCompletedMessage => 'Bu dersi tamamladınız!';

  @override
  String get lessonCompletedImageSemantic => 'Hudhud Kur’an illüstrasyonu';

  @override
  String get lessonCompletedGoBackSemantic => 'Yol seçimine dön';

  @override
  String get lessonCompletedGoBackButton => 'Yola Geri Dön';

  @override
  String get lessonCompletedRestartSemantic => 'Dersi yeniden başlat';

  @override
  String get lessonCompletedRestartButton => 'Dersi Yeniden Başlat';

  @override
  String get lessonCompletedEncouragement => 'Maşallah böyle devam edin!';

  @override
  String get commentG => 'Tema Ekranı metinleri';

  @override
  String get themeScreenTitle => 'Temalar';

  @override
  String get themeNameCoreRecitation => 'Günlük Temel Okuma';

  @override
  String get themeNameBeginJourney => 'Yolculuğa Başlangıç';

  @override
  String get themeNameMercyAndHope => 'Rahmet ve Umut';

  @override
  String get themeNameGratitudeReflection => 'Şükür ve Tefekkür';

  @override
  String get themeNameStoriesReminders => 'Kıssalar, Dersler ve Hatırlatmalar';

  @override
  String get themeNamePatience => 'Sabır (Ṣabr)';

  @override
  String get themeNameUserCreated => 'Kullanıcı Oluşturdu';

  @override
  String get themeScreenNoThemesLabel => 'Tema Yok';

  @override
  String get themeScreenBackArrowSemantic => 'Geri dön';

  @override
  String get themeScreenThemeCardSemantic => 'Temanın yollarını açmak için dokunun';

  @override
  String get themeScreenLockIconSemantic => 'Tema kilitli. Yükseltme gerekli.';

  @override
  String get pathListExploreOtherThemes => 'Diğer Temaları Keşfet';

  @override
  String get themeScreenUserCreatedSubtitle => 'Senin oluşturduğun—dilediğin gibi kişiselleştirebilirsin.';

  @override
  String get themeSubtitleCoreRecitation => 'Günlük namazlarda ve korunmada vazgeçilmez sureler.';

  @override
  String get themeSubtitleBeginJourney => 'Kur’an yolculuğuna başlayanlar için kısa sureler.';

  @override
  String get themeSubtitleMercyAndHope => 'Allah’ın merhameti ve umut verici yönleri üzerine tefekkür.';

  @override
  String get themeSubtitleGratitudeReflection => 'Teşekkür ve içgörü odaklı ayetlerle şükrü artırın.';

  @override
  String get themeSubtitleStoriesReminders => 'Farklı kıssa ve hikmetli öğütlerle Kur’an’ı keşfedin.';

  @override
  String get themeSubtitlePatience => 'Sabır ve sebatı teşvik eden sure ve pasajlar.';

  @override
  String get themeSubtitleDefault => 'Derin manevi gelişim için özel sure koleksiyonu.';

  @override
  String get themeScreenRequiredPremium => 'Premium Gerekli';

  @override
  String get themeScreenRequiredPremiumPlus => 'Premium Plus Gerekli';

  @override
  String get commentH => 'Yol Listesi Ekranı metinleri';

  @override
  String get pathListScreenTitle => 'Temanın Yolları';

  @override
  String get pathListScreenBackArrowSemantic => 'Geri dön';

  @override
  String get pathListScreenAddIconSemantic => 'Yeni yol ekle';

  @override
  String get pathListAddNewPathTooltip => 'Yeni Yol Ekle';

  @override
  String get pathListScreenAddIconSemanticEmpty => 'İlk yolunuzu eklemek için dokunun';

  @override
  String get pathListEmptyMessage => 'Henüz yol yok.\nİlk yolu oluşturmak için “+” düğmesine dokun!';

  @override
  String get pathListUnavailableLabel => 'Bu yol şu anda kullanılamıyor';

  @override
  String get pathListThemeLabel => 'Tema';

  @override
  String get pathListPathCardSemantic => 'Yol ayrıntılarını açmak için dokunun';

  @override
  String get pathListCompleteIconSemantic => 'Yol tamamlandı';

  @override
  String get pathListInProgressIconSemantic => 'Yol devam ediyor';

  @override
  String get pathListInvalidIconSemantic => 'Yol geçersiz veya kullanılamıyor';

  @override
  String get pathListErrorLoadingPaths => 'Yollar yüklenirken hata oluştu:';

  @override
  String get commentI => 'Yol Detay Ekranı metinleri';

  @override
  String get pathDetailScreenTitle => 'Yol Detayları';

  @override
  String get pathDetailScreenBackArrowSemantic => 'Yol listesine dön';

  @override
  String get pathDetailScreenNotFound => 'Yol bulunamadı.';

  @override
  String get pathDetailScreenFailToUpdate => 'Yol ilerlemesi güncellenemedi:';

  @override
  String get pathDetailScreenProgressDisabled => 'Bu yol için ilerleme kapalı.';

  @override
  String get pathDetailScreenLessonsHeading => 'Dersler:';

  @override
  String get pathDetailScreenNoLessonsLabel => 'Ders bulunamadı.';

  @override
  String get pathDetailScreenErrorLoading => 'Yol veya dersleri yüklerken hata oluştu:';

  @override
  String get pathDetailScreenLessonCardSemantic => 'Ders ayrıntılarını açmak için dokunun';

  @override
  String get pathDetailScreenLessonCompleteIconSemantic => 'Ders tamamlandı';

  @override
  String get pathDetailScreenLessonInProgressIconSemantic => 'Ders devam ediyor';

  @override
  String get pathDetailScreenLessonInvalidIconSemantic => 'Ders geçersiz veya kullanılamıyor';

  @override
  String get pathDetailScreenLessonProgressUnavailable => 'İlerleme bilgisi yok';

  @override
  String get pathDetailScreenLessonNoProgress => 'Bu yol için ilerleme kaydı tutulmuyor';

  @override
  String get pathDetailScreenLessonUpgrade => 'İlerleme özelliği için yükseltme yapın.';

  @override
  String pathDetailScreenLessonProgressLabel(Object progress) {
    return 'İlerleme: $progress%';
  }

  @override
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah) {
    return 'Ders $lessonIndex: $surahName - Ayet $startAyah-$endAyah';
  }

  @override
  String get commentJ => 'Yeni Yol Oluştur Ekranı metinleri';

  @override
  String get createPathTitle => 'Yeni Yol Oluştur';

  @override
  String get createPathBackArrowSemantic => 'Önceki ekrana dön';

  @override
  String get createPathNameLabel => 'Yol Adı';

  @override
  String get createPathNameValidation => 'Bir yol adı girin';

  @override
  String get createPathDescriptionLabel => 'Açıklama';

  @override
  String get createPathDescriptionValidation => 'Bir açıklama girin';

  @override
  String get createPathSurahSelectorLabel => 'Sure Seçin:';

  @override
  String get createPathStartAyahLabel => 'Başlangıç Ayeti';

  @override
  String get createPathNumAyahsLabel => 'Yola Eklenecek Ayet Sayısı';

  @override
  String get createPathEndAyahLabel => 'Bitiş Ayeti';

  @override
  String get createPathWordsPerLessonLabel => 'Her Dersteki Kelime Sayısı';

  @override
  String get createPathWordsSuffix => 'kelime';

  @override
  String get createPathInvalidRange => 'Geçersiz aralık';

  @override
  String get createPathAyahsSuffix => 'Ayet';

  @override
  String get createPathCreateButton => 'Yol Oluştur';

  @override
  String get createPathSubmitSemantic => 'Yol oluşturmak için dokunun';

  @override
  String get commentK => 'Çeviri Ekranı metinleri';

  @override
  String get translationScreenTitle => 'Çeviri';

  @override
  String get translationScreenBackArrowSemantic => 'Derse geri dön';

  @override
  String get translationScreenLoadingSemantic => 'Çeviriler yükleniyor';

  @override
  String get translationScreenNoTranslations => 'Hiç çeviri bulunamadı.';

  @override
  String get translationScreenReturnButton => 'Derse Dön';

  @override
  String get translationScreenReturnSemantic => 'Derse geri dönmek için dokunun';

  @override
  String get translationScreenLoadError => 'Çeviriler yüklenirken hata oluştu:';

  @override
  String get commentL => 'Dil Seçimi Ekranı metinleri';

  @override
  String get languageSelectionScreenSemantic => 'Dil Seçimi Ekranı';

  @override
  String get languageSelectionTitle => 'Dilinizi Seçin';

  @override
  String get languageSelectionBackSemantic => 'Geri';

  @override
  String get languageSelectionSkipSemantic => 'Seçimi atla';

  @override
  String get languageSelectionInstructions => 'Tercih ettiğiniz dili seçin:';

  @override
  String get languageSelectionNextSemantic => 'Dil seçimini onaylamak için dokunun';

  @override
  String get languageSelectionNextLabel => 'İleri';

  @override
  String get languageSelectionImageSemantic => 'Hudhud Kur’an illüstrasyonu';

  @override
  String get commentM => 'Karşılama (Welcome) Ekranı metinleri';

  @override
  String get welcomeScreenSemantic => 'Onboarding Karşılama Ekranı';

  @override
  String get welcomeScreenLogoSemantic => 'Hudhud Kur’an illüstrasyonu';

  @override
  String get welcomeScreenSkipSemantic => 'Karşılama adımını atla';

  @override
  String get welcomeScreenNextSemantic => 'Sonraki onboarding adımına geç';

  @override
  String get commentN => 'Hudhud Bilgi Ekranı metinleri';

  @override
  String get hudhudInfoSemantic => 'Hudhud Bilgilendirme Ekranı';

  @override
  String get hudhudInfoAppBarTitle => 'Hudhud’u Tanı';

  @override
  String get hudhudInfoIllustrationSemantic => 'Hudhud illüstrasyonu';

  @override
  String get hudhudInfoBody1 => 'Hudhud (ibibik kuşu), Süleyman (AS) Peygamber’e gözlem yaparak ve mesajlar taşıyarak yardımcı olmuş özel bir kuştur.';

  @override
  String get hudhudInfoBody2 => 'Hudhud’un hikâyesi bize küçük bir canlının bile dikkatli, meraklı ve doğru şeylere odaklanarak büyük bir etki yapabileceğini hatırlatır. Biz de bu yolculukta Kur’an’ın güzelliğine odaklanabilir, her ilerleme anını fark edip şükür alışkanlığımızı artırabiliriz.';

  @override
  String get hudhudInfoBody3 => 'Hudhud’un örneğini izleyerek—dikkatli ve ilgili kalarak—Kur’an’la olan bağımızı derinleştirmeyi ve günlük yaşamda şükür duygusunu pekiştirmeyi hedefliyoruz.';

  @override
  String get hudhudInfoNextLabel => 'İleri';

  @override
  String get hudhudInfoNextSemantic => 'Sonraki bölüme geç';

  @override
  String get hudhudInfoSkipSemantic => 'Hudhud bilgisi adımını atla';

  @override
  String get commentO => 'Abonelik Seviyesi Ekranı metinleri';

  @override
  String get subscriptionTierScreenSemantic => 'Abonelik Seviyesi Seçimi Ekranı';

  @override
  String get subscriptionTierScreenAppBarTitle => 'Planınızı Seçin';

  @override
  String get subscriptionTierScreenSkipSemantic => 'Abonelik seviyesi seçimini atla';

  @override
  String get subscriptionTierScreenFreeLabel => 'Ücretsiz';

  @override
  String get subscriptionTierScreenSmileySemantic => 'Gülen yüz simgesi';

  @override
  String get subscriptionTierScreenDonationText => 'Gelirin bir kısmı, İslami Yardım ile yetimlere destek veren Almubtasim Girişimi’ne bağışlanacaktır.';

  @override
  String get subscriptionTierScreenConfirmSemantic => 'Abonelik seviyesi seçimini onayla';

  @override
  String get subscriptionTierScreenNextLabel => 'İleri';

  @override
  String subscriptionTierScreenRadioSemantic(Object title) {
    return '$title abonelik seviyesini seçmek için dokunun';
  }

  @override
  String get commentP => 'Hedef Seçimi Ekranı metinleri';

  @override
  String get goalSelectionScreenSemantic => 'Hedef Seçimi Ekranı';

  @override
  String get goalSelectionScreenAppBarTitle => 'Hedeflerinizi Seçin';

  @override
  String get goalSelectionScreenSkipSemantic => 'Hedef seçimini atla';

  @override
  String get goalSelectionScreenIntroText => 'Aşağıdaki hedeflerden hangileri ilginizi çekiyor? Birden fazla seçenek belirleyebilirsiniz.';

  @override
  String get goalSelectionScreenNextSemantic => 'Hedef seçimlerini onayla';

  @override
  String get goalSelectionScreenNextLabel => 'İleri';

  @override
  String goalSelectionTileSemantic(Object goalTitle) {
    return '$goalTitle hedef seçeneğini seçmek veya kaldırmak için dokunun';
  }

  @override
  String get goalConnectQuranTitle => 'Kur’an’la Bağımı Güçlendirmek';

  @override
  String get goalConnectQuranDesc => 'Okuma veya tefekkürle ilişkini derinleştir.';

  @override
  String get goalMemorizeQuranTitle => 'Kur’an’ı Ezberlemek';

  @override
  String get goalMemorizeQuranDesc => 'Ezber yolculuğuna başla.';

  @override
  String get goalBeMoreGratefulTitle => 'Daha Fazla Şükredip Mutlu Olmak';

  @override
  String get goalBeMoreGratefulDesc => 'Günlük şükür pratiğine odaklan.';

  @override
  String get goalBuildConsistencyTitle => 'Düzenlilik Kazanmak';

  @override
  String get goalBuildConsistencyDesc => 'Günlük veya haftalık bir alışkanlık geliştir.';

  @override
  String get goalImproveArabicTitle => 'Arapçamı Geliştirmek';

  @override
  String get goalImproveArabicDesc => 'Yazılı veya sözlü dil becerilerine odaklan.';

  @override
  String get goalDeepenTafsirTitle => 'Tefsiri Derinlemesine Öğrenmek';

  @override
  String get goalDeepenTafsirDesc => 'Kur’an yorumlarını ve derin manalarını incele.';

  @override
  String get goalOtherTitle => 'Diğer';

  @override
  String get goalOtherDesc => 'Kişisel başka bir hedefi sürdür.';

  @override
  String get commentQ => 'Seviye Seçimi Ekranı metinleri';

  @override
  String get levelSelectionScreenSemantic => 'Seviye Seçimi Ekranı';

  @override
  String get levelSelectionScreenAppBarTitle => 'Seviyenizi Seçin';

  @override
  String get levelSelectionScreenSkipSemantic => 'Seviye seçimini atla';

  @override
  String get levelSelectionScreenIntroText => 'Mevcut okuma seviyenizi en iyi yansıtan seçeneği seçin:';

  @override
  String get levelStarterLabel => 'Başlangıç';

  @override
  String get levelStarterDescription => 'Kur’an okumasına yeni veya ara sıra bakan, keşif aşamasında.';

  @override
  String get levelAdvancedLabel => 'İleri Düzey';

  @override
  String get levelAdvancedDescription => 'Arapça metin okumada rahat, biraz tecvid bilgisi olan.';

  @override
  String get levelQariLabel => 'Kâri';

  @override
  String get levelQariDescription => 'Tecvidi sağlam, kıraat konusunda yetkin.';

  @override
  String get levelSelectionNextSemantic => 'Seviye seçimini onayla';

  @override
  String get levelSelectionNextLabel => 'İleri';

  @override
  String levelSelectionTileSemantic(Object levelTitle) {
    return '$levelTitle okuma seviyesi seçeneğini seçmek için dokunun';
  }

  @override
  String get commentR => 'Onboarding Tamamlama Ekranı metinleri';

  @override
  String get onboardingCompletionScreenSemantic => 'Onboarding Tamamlama Ekranı';

  @override
  String get onboardingCompletionScreenAppBarTitle => 'Her Şey Hazır!';

  @override
  String get onboardingCompletionScreenImageSemantic => 'Hudhud Kur’an illüstrasyonu';

  @override
  String get onboardingCompletionScreenBody1 => 'Tebrikler! Kurulumu başarıyla tamamladınız. Bu yolculuğun sizi Kur’an’a daha da yakınlaştırmasını ve Allah’a şükrünüzü artırmasını dileriz.\n\nBu uygulamanın hayatınıza ve dokunduğunuz insanların hayatına bereket ve büyüme getirmesini temenni ediyoruz.';

  @override
  String get onboardingCompletionScreenBody2 => 'Hazır olduğunuzda aşağıdaki butona dokunarak devam edebilirsiniz. Ana ezber ve ilerleme özellikleri sizi bekliyor; şükür girişi yapabilir veya Navigasyon Çubuğu’ndan bir yol seçebilirsiniz.';

  @override
  String get onboardingCompletionScreenBody3 => 'Bu erken bir sürümdür — desteğiniz ve sabrınız için minnettarız; yakında inşallah daha fazla özellik sunmaya çalışacağız!';

  @override
  String get onboardingCompletionScreenBeginSemantic => 'Uygulamayı kullanmaya başla';

  @override
  String get onboardingCompletionScreenBeginLabel => 'Haydi Başlayalım';

  @override
  String get commentS => 'İsim Girişi Ekranı metinleri';

  @override
  String get nameEntryScreenSemantic => 'İsim Girişi Ekranı';

  @override
  String get nameEntryScreenAppBarTitle => 'Profiliniz';

  @override
  String get nameEntryScreenSkipSemantic => 'İsim girişi adımını atla';

  @override
  String get nameEntryScreenIntroText => 'İsminiz nedir?';

  @override
  String get nameEntryTextFieldSemantic => 'İsim girişi metin alanı';

  @override
  String get nameEntryNextSemantic => 'İsim girişini onayla';

  @override
  String get nameEntryNextLabel => 'İleri';

  @override
  String get commentT => 'Dikey Ders İkonları metinleri';

  @override
  String get verticalLessonIconsSemantic => 'Dikey Ders İkonları Konteyneri';

  @override
  String get verticalLessonIconsNoLessons => 'Ders bulunamadı.';

  @override
  String get verticalLessonIconsLoadingSurah => 'Sure ayrıntıları yükleniyor';

  @override
  String get verticalLessonIconsErrorSurah => 'Sure ayrıntıları yüklenirken hata oluştu';

  @override
  String get verticalLessonIconsSurahHeaderSemantic => 'Sure ayrıntıları başlığı';

  @override
  String get verticalLessonIconsHudhudIconSemantic => 'Hudhud yardımcı ikonu';

  @override
  String get verticalLessonIconsNextPageSemantic => 'Sonraki sayfa oku';

  @override
  String get verticalLessonIconsPreviousPageSemantic => 'Önceki sayfa oku';

  @override
  String get verticalLessonIconsLoadingProgress => 'Ders ilerlemesi yükleniyor';

  @override
  String get verticalLessonIconsErrorProgress => 'İlerleme yüklenirken hata oluştu';

  @override
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent) {
    return 'Ders ikonu, $surahAyahRange, ilerleme $percent%';
  }

  @override
  String get verticalLessonIconsCompletedSemantic => 'Ders tamamlandı';

  @override
  String get verticalLessonIconsDialogTitle => 'Destek & Yükseltme';

  @override
  String get verticalLessonIconsDialogOk => 'Tamam';

  @override
  String get commentU => 'Alt Navbar metinleri';

  @override
  String get navBarSemanticLabel => 'Alt gezinme çubuğu';

  @override
  String get navHomeLabel => 'Ana Sayfa';

  @override
  String get navHomeSemantic => 'Ana Sayfa sekmesi';

  @override
  String get navQuranLabel => 'Kur’an';

  @override
  String get navQuranSemantic => 'Kur’an sekmesi';

  @override
  String get navGratitudeLabel => 'Şükür';

  @override
  String get navGratitudeSemantic => 'Şükür sekmesi';

  @override
  String get navProfileLabel => 'Profil';

  @override
  String get navProfileSemantic => 'Profil sekmesi';

  @override
  String get commentV => 'Üst Bar metinleri';

  @override
  String get topBarSemanticLabel => 'Üst gezinme çubuğu';

  @override
  String topBarTitleSemantic(Object title) {
    return 'Üst bar başlığı: $title';
  }

  @override
  String topBarStreakIconSemantic(Object days) {
    return 'Seri ikonu: $days gün';
  }

  @override
  String get topBarStreakDialogBody => 'Bu, kaç gündür üst üste Kur’an okuduğunuzu veya şükür yazdığınızı gösterir. Seriyi korumak ve büyütmek için devam edin!';

  @override
  String get topBarHudhudIconSemantic => 'Hudhud ikonu, destek için dokunun';

  @override
  String get topBarHudhudDialogTitle => 'Destek & Yükseltme';

  @override
  String get topBarHudhudDialogBody => 'Tüm özellikler ücretsiz sürümde mevcuttur ancak dilerseniz daha fazla özellik geliştirmemize destek olabilirsiniz. Aboneliğinizin bir kısmı Islamic Relief’e bağışlanır. Jazāk Allāhu Khayran!';

  @override
  String get commentW => 'Şükür Modal penceresi metinleri';

  @override
  String get gratitudeModalSemantic => 'Şükür Modal Penceresi';

  @override
  String get gratitudeModalTitle => 'Bu ayetlere göre bugün neye şükrediyorsunuz?';

  @override
  String gratitudeModalHint(Object index) {
    return 'Elhamdülillah (şükrünüzü girin) #$index';
  }

  @override
  String gratitudeModalTextFieldSemantic(Object index) {
    return '#$index numaralı şükür girişi';
  }

  @override
  String get gratitudeModalEmptyWarning => 'En az bir şükür girişi yapmalısınız.';

  @override
  String get gratitudeModalSubmitError => 'Şükür kaydı yapılamadı. Lütfen tekrar deneyin.';

  @override
  String get dailyVoiceLimitReachedTitle => 'Maşallah!';

  @override
  String get dailyVoiceLimitReachedMessage => 'Kur’an sesli okuma için 10 dakikanızı doldurdunuz. Lütfen yazılı çalışmaya devam edin ve yarın okumaya devam edin.';

  @override
  String get upgradeVoiceUsageTitle => 'Premium’a Yükselt';

  @override
  String get gratitudeModalLoadingSemantic => 'Şükür gönderimi devam ediyor';

  @override
  String get commentX => '== YENİ ANAHTARLAR: submission_feedback_modal, progress_bar, surah_selector ==';

  @override
  String get submissionFeedbackModalSemanticLabel => 'Gönderim geri bildirimi diyalogu';

  @override
  String get submissionFeedbackModalTitle => 'Gönderim Geri Bildirimi';

  @override
  String get submissionFeedbackModalNoNew => 'Yeni şükür eklenmedi.';

  @override
  String get submissionFeedbackModalYouSubmitted => 'Bu şükürleri eklediniz:';

  @override
  String submissionFeedbackModalStreak(Object days) {
    return 'Mevcut şükür serisi: $days gün';
  }

  @override
  String submissionFeedbackModalTotalDays(Object count) {
    return 'Toplam şükür yapılan gün: $count';
  }

  @override
  String get submissionFeedbackModalLoading => 'Şükür verileriniz yükleniyor...';

  @override
  String get submissionFeedbackModalError => 'Şükür verileri yüklenemedi.';

  @override
  String get submissionFeedbackModalViewLog => 'Kaydı Gör';

  @override
  String get submissionFeedbackModalClose => 'Kapat';

  @override
  String progressBarSemanticLabel(Object percent) {
    return 'İlerleme: $percent%';
  }

  @override
  String get surahSelectorSemanticLabel => 'Bir Sure Seçin';

  @override
  String get commentZ => 'Sistem tarafından tanımlanmış yollar için yerelleştirilebilir Yol İsimleri ve Açıklamaları';

  @override
  String get pathNameFatihah => 'Fâtiha Sûresi';

  @override
  String get pathDescFatihah => 'Tam sure (1:1–7). Her rekâtta vazgeçilmez.';

  @override
  String get pathNameKafirun => 'Kâfirûn Sûresi';

  @override
  String get pathDescKafirun => 'Tam sure (109:1–6). Tevhid beyanı.';

  @override
  String get pathNameIkhlas => 'İhlâs Sûresi';

  @override
  String get pathDescIkhlas => 'Tam sure (112:1–4). Allah’ın tevhidi.';

  @override
  String get pathNameFalaq => 'Felak Sûresi';

  @override
  String get pathDescFalaq => 'Tam sure (113:1–5). Dış kötülüklerden sığınma.';

  @override
  String get pathNameNas => 'Nâs Sûresi';

  @override
  String get pathDescNas => 'Tam sure (114:1–6). İçsel vesveselerden sığınma.';

  @override
  String get pathNameAsrBegin => 'Asr Sûresi';

  @override
  String get pathDescAsrBegin => '(103:1–3). Yalnızca 3 ayet ama “sabır” için temel.';

  @override
  String get pathNameTakathur => 'Tekâsür Sûresi';

  @override
  String get pathDescTakathur => '(102:1–8) Dünyadaki rekabet ve hesap günü üzerine.';

  @override
  String get pathNameFil => 'Fîl Sûresi';

  @override
  String get pathDescFil => '(105:1–5). Fil vakası; 5 kısa ayet.';

  @override
  String get pathNameQuraysh => 'Kureyş Sûresi';

  @override
  String get pathDescQuraysh => '(106:1–4). Güvenli yolculuklar için şükür.';

  @override
  String get pathNameRahmanA => 'Rahmân Sûresi A';

  @override
  String get pathDescRahmanA => '(55:1–13): Kur’an öğretileri & insanın yaratılışı.';

  @override
  String get pathNameRahmanB => 'Rahmân Sûresi B';

  @override
  String get pathDescRahmanB => '(55:26–36): İnsan ve cin sorumluluğu.';

  @override
  String get pathNameYasinBlock => 'Yâ Sîn Sûresi (Blok)';

  @override
  String get pathDescYasinBlock => '(36:1–12). Peygamber’in mesajına giriş & uyarılar.';

  @override
  String get pathNameMulkBlock => 'Mülk Sûresi (Blok)';

  @override
  String get pathDescMulkBlock => '(67:1–15). Allah’ın hükümranlığı ve tefekkür.';

  @override
  String get pathNameBaqarah21_29 => 'Bakara Sûresi (2:21–29)';

  @override
  String get pathDescBaqarah21_29 => '9 ayet, yaratılış & şükür tefekkürü.';

  @override
  String get pathNameNahl66_72 => 'Nahl Sûresi (16:66–72)';

  @override
  String get pathDescNahl66_72 => '7 ayet, nimetlerin (hayvanlar, meyveler vb.) hatırlatılması.';

  @override
  String get pathNameAdDuha => 'Duha Sûresi';

  @override
  String get pathDescAdDuha => '(93:1–11) 11 ayet umut & teselli içeriyor.';

  @override
  String get pathNameKahfCave => 'Kehf Sûresi: Mağara Gençleri';

  @override
  String get pathDescKahfCave => '(18:9–16) Mağaraya sığınan genç müminlerin kıssası.';

  @override
  String get pathNameKahfMusa => 'Kehf Sûresi: Mûsâ & Hızır';

  @override
  String get pathDescKahfMusa => '(18:60–70) Sabır & gizli hikmet vurgusu.';

  @override
  String get pathNameWaqiah => 'Vâkıa Sûresi (56:1–15)';

  @override
  String get pathDescWaqiah => '15 ayet, kıyametin ansızın gelişini anlatır.';

  @override
  String get pathNameAsrPatience => 'Asr Sûresi (Sabır)';

  @override
  String get pathDescAsrPatience => '(103:1–3) yine 3 ayet, sabır hakkında meşhur.';

  @override
  String get pathNameBaq153_157 => 'Bakara Sûresi (2:153–157)';

  @override
  String get pathDescBaq153_157 => '5 ayet: “Sabır ve namazla yardım isteyin.”';

  @override
  String get pathNameYusuf7_14 => 'Yûsuf Sûresi (12:7–14)';

  @override
  String get pathDescYusuf7_14 => 'Yûsuf’un kardeşlerinin kıskançlığı. Sabır imtihanı.';

  @override
  String get pathNameYusuf83_92 => 'Yûsuf Sûresi (12:83–92)';

  @override
  String get pathDescYusuf83_92 => 'Ya‘kûb’un hüznü & Yûsuf’un affı (10 ayet).';

  @override
  String get pathNameInshirah => 'İnşirâh Sûresi (94:1–8)';

  @override
  String get pathDescInshirah => '8 ayet: zorluktan sonra ferahlık müjdesi. Sabır & umutla ilişkili.';

  @override
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah) {
    return 'Sure $surahName, Ayet $startAyah-$endAyah';
  }

  @override
  String get finishLabel => 'Bitir';

  @override
  String get twoWordMultipleChoiceLabel => 'Doğru iki kelimeyi seçin';

  @override
  String get singleWordMultipleChoiceLabel => 'Doğru kelimeyi seçin';

  @override
  String get correctAnswerLabel => 'Doğru!';

  @override
  String get incorrectAnswerLabel => 'Yanlış!';

  @override
  String get lessonCompletedLabel => 'Ders tamamlandı!';

  @override
  String get profileAnalyticsScoreLabel => 'Analiz ve Skor';

  @override
  String get profileDailyLabel => 'Günlük';

  @override
  String get profileWeeklyLabel => 'Haftalık';

  @override
  String get profileMonthlyLabel => 'Aylık';

  @override
  String get profileTotalLabel => 'Toplam';

  @override
  String get profileViewChart => 'Grafiği görüntüle';

  @override
  String get profileCloseLabel => 'Kapat';

  @override
  String get profileScoreChartTitle => 'Skor Grafiği';

  @override
  String get profileScoreChartHistory => 'Geçmiş';

  @override
  String get profileNoData => 'Veri yok';

  @override
  String get topBarDailyScoreLabel => '⭐ Bugün';

  @override
  String topBarDailyScoreSemantic(Object score) {
    return 'Günlük skorunuz $score';
  }

  @override
  String get profilePremiumNeeded => 'Lütfen ilerleme takvimini görmek ve inşallah daha fazla özellik geliştirmemize destek olmak için yükseltin!';

  @override
  String get levelMultipleChoiceLabel => 'Çoktan Seçmeli';

  @override
  String get levelMultipleChoiceDescription => 'Tek veya iki kelimelik çoktan seçmeli adımlar, çiftleri isteğe bağlı olarak atlama seçeneğiyle.';

  @override
  String get levelBeginnerLabel => 'Başlangıç';

  @override
  String get levelBeginnerDescription => 'Gruplandırılmış dizilerde aşamalı kelime kaldırma ile kademeli ezberleme.';

  @override
  String get subscriptionTierScreenPremiumLabel => 'Plus';

  @override
  String get featureUnavailableOffline => 'Özellik çevrimdışıyken kullanılamıyor. Bağlanın veya Plus ya da Pro Beta\'ya yükselterek çevrimdışı modu etkinleştirin.';

  @override
  String submissionFeedbackModalTotalCount(Object count) {
    return 'Girilen teşekkürlerin toplam sayısı: $count';
  }

  @override
  String get notificationDailyTitle => 'Nazik Günlük Kur\'an Hatırlatıcısı';

  @override
  String get notificationWeeklyTitle => 'Haftalık Kur\'an Kontrolü';

  @override
  String get notificationWeeklyBody => 'İlerlemenizi gözden geçirin ve şükran pratiği yaparken Kur\'an\'dan yeni bir bölüm ezberleyin.';

  @override
  String get notificationChannelDailyRemindersName => 'Günlük Hatırlatmalar';

  @override
  String get notificationChannelDailyRemindersDesc => 'Günlük Kur\'an ezberi için hatırlatmalar';

  @override
  String get notificationChannelWeeklyRemindersName => 'Haftalık Hatırlatmalar';

  @override
  String get notificationChannelWeeklyRemindersDesc => 'Haftalık Kur\'an ezberi kontrolü için hatırlatmalar';

  @override
  String get nameEntryNotificationFrequencyDaily => 'Günlük';

  @override
  String get topBarStreakDialogTitle => 'Seri';

  @override
  String get fillInTheBlanksLabel => 'Boşlukları doldur';

  @override
  String get loadingDataLabel => 'Yükleniyor…';

  @override
  String ayahRangeLabel(Object start, Object end) {
    return 'Ayet $start - $end';
  }

  @override
  String get nextPageSemanticLabel => 'Sonraki sayfa';

  @override
  String get prevPageSemanticLabel => 'Önceki sayfa';

  @override
  String pageXOfYLabel(Object current, Object total) {
    return 'Sayfa $current / $total';
  }

  @override
  String verseSemanticLabel(Object ayahNumber, Object surahName) {
    return 'Ayet $ayahNumber, $surahName Suresi\'nden';
  }

  @override
  String get ayahLabel => 'Ayet';

  @override
  String get goToSurahViewLabel => 'Sure Görüntüle';

  @override
  String get clickOnAyaToOpenLesson => 'Derse başlamak için aşağıdaki herhangi bir ayete tıklayın';

  @override
  String get difficultyChoosingScreenIntro => 'Tercihinizi seçin: çoktan seçmeli veya boşluk doldurma ve her adım ve ses çalma kaç kez tekrar edecek.';

  @override
  String get upgradeVoiceUsageMessage => 'Sesli özelliği denemek ve geliştirmemize yardımcı olmak için Pro Beta\'ya yükseltin!';

  @override
  String get restorePurchasesLabel => 'Satın Alımları Geri Yükle';

  @override
  String get subscriptionTierScreenMonthly => 'Aylık';

  @override
  String get subscriptionTierScreenYearly => 'Yıllık';

  @override
  String get subscriptionTierScreenFreePrice => 'Ücretsiz';

  @override
  String get subscriptionTierScreenPremiumMonthlyPrice => 'Şimdi aylık 3 \$ (önceden 5 \$)';

  @override
  String get subscriptionTierScreenPremiumYearlyPrice => 'Şimdi yıllık 28 \$ (önceden 60 \$)';

  @override
  String get subscriptionTierScreenPremiumPlusMonthlyPrice => 'Şimdi aylık 7 \$ (önceden 10 \$)';

  @override
  String get subscriptionTierScreenPremiumPlusYearlyPrice => 'Şimdi yıllık 45 \$ (önceden 84 \$)';

  @override
  String get subscriptionPurchaseError => 'Abonelik satın alırken hata oluştu';

  @override
  String get topBarExplorePlansLabel => 'Planları Keşfet';

  @override
  String get topBarBackHomeLabel => 'Ana Sayfaya Dön';

  @override
  String get profileRequiresPlanUpdate => 'Plan güncellemesi gerekiyor';

  @override
  String get subscriptionTierScreenPremiumDescription => 'Ücretsiz sürümdeki her şeyin yanı sıra çevrimdışı ders öğrenimi ve geri bildirim, geçmiş analizler, ayrıca ilerleme çubukları, profil ve Kur’an özelleştirmesi. Daha fazla özellik geliştirmemize destek olun!';

  @override
  String get subscriptionAutoRenewNotice => 'Abonelik otomatik olarak yenilenir ve bir sonraki dönem için ücretlendirilmemek adına iptal edilebilir. Fonların bir kısmı Almubtasim Girişimi 😀 aracılığıyla Islamic Relief’e bağışlanacaktır.';

  @override
  String get subscriptionTierScreenSubscribeLabel => 'Abone Ol';

  @override
  String get subscriptionTierScreenFinalMessage => 'Desteğiniz için teşekkür ederiz!';

  @override
  String get subscriptionPurchaseRestoreSuccess => 'Satın almalarınız başarıyla geri yüklendi.';

  @override
  String get subscriptionTierScreenRestoreLabel => 'Satın Alımları Geri Yükle';

  @override
  String get arabicLabel => 'Arapça';

  @override
  String get transliterationLabel => 'İngilizce';

  @override
  String get surahSearchScreenTitle => 'Sure Arama';

  @override
  String get genericBack => 'Geri';

  @override
  String get surahSearchSelectSurah => 'Bir Sure Seçin:';

  @override
  String get surahSearchExistingPaths => 'Bu Sure İçin Mevcut Yollar';

  @override
  String get surahSearchNoMatches => 'Mevcut yol bulunamadı.';

  @override
  String get surahSearchHideCreateForm => 'Oluşturma Formunu Gizle';

  @override
  String get surahSearchShowCreateForm => 'Sure için Yeni Yol Oluştur';

  @override
  String get createPathTrackProgress => 'İlerlemeyi takip et?';

  @override
  String get themeScreenSearchIconSemantic => 'Sûreleri ara';

  @override
  String get pathListSearchIconSemantic => 'Sûreleri ara';

  @override
  String get pathLessonsSearchIconSemantic => 'Sûreleri ara';

  @override
  String get playAllSurahSemantic => 'Tüm sureyi oynat';

  @override
  String get toggleTransliterationLabel => 'Transliterasyonu değiştir';

  @override
  String get englishLabel => 'İngilizce';

  @override
  String get subscriptionTierScreenPremiumPlusLabel => 'Bize Destek Ol (Yıllık)';

  @override
  String get subscriptionTierScreenFreeDescription => 'Tüm özellikler ücretsiz ve reklamsız!';

  @override
  String get subscriptionTierScreenPremiumPlusDescription => 'Yeni özelliklerin ve iyileştirmelerin finansmanına yardımcı olun! Ayrıca, küçük bir yatırım alışkanlık edinmenize de yardımcı olabilir!';

  @override
  String get subscriptionTierScreenSupportLabel => 'Yıllık Destek';

  @override
  String get verticalLessonIconsDialogBody => 'Tüm özellikler ücretsiz sürümde mevcuttur ancak dilerseniz daha fazla özellik geliştirmemize destek olabilirsiniz. Aboneliğinizin bir kısmı Islamic Relief’e bağışlanır. Jazāk Allāhu Khayran!';

  @override
  String get welcomeBody => 'Hudhud, gözlem yaparak ve mesajlar taşıyarak Hz. Süleyman’a [AS] özel bir rol oynamıştır.\n\nO, yolculuğunuzun neresinde olursanız olun sizi yargılamaz ve Kur’an’ın güzelliğini keşfedip her anı şükran hatırlatmalarıyla değerlendirmeniz için sizi yönlendirmekten memnuniyet duyar.';

  @override
  String get surahSearchByName => 'İsimle ara (İngilizce veya Arapça)';

  @override
  String get surahSearchHintAnyName => 'Herhangi bir sure adı yazın...';

  @override
  String get surahSearchFieldLabel => 'Sure Ara';

  @override
  String get surahSearchInvalidLessonsError => 'Bir veya daha fazla ders geçersiz. Yol oluşturulamadı.';

  @override
  String get surahSearchUserSurahPrefix => 'Kullanıcı Suresi';

  @override
  String get notificationDailyBody => 'Kur’an ile biraz huzur bulmak için kısa bir mola verin ve bugün neden minnettar olduğunuzu kendinize hatırlatın.';
}
