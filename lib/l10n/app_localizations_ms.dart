import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get commentA => 'Kunci pengenalan (Onboarding)';

  @override
  String get appBarTitleWelcome => 'Selamat Datang';

  @override
  String get skipLabel => 'Langkau';

  @override
  String get welcomeHeadline => 'Selamat Datang ke Al-Quran bersama Hudhud!';

  @override
  String get getStartedLabel => 'Mula';

  @override
  String get commentB => 'Kunci skrin Pelajaran';

  @override
  String get lessonScreenAppBarTitle => 'Pelajaran';

  @override
  String get noAyahAvailable => 'Tiada ayat tersedia untuk dimainkan.';

  @override
  String audioNotFound(Object url) {
    return 'Audio tidak dijumpai di $url';
  }

  @override
  String get restartLessonTitle => 'Mulakan Semula Pelajaran';

  @override
  String get resetLessonBody => 'Tetapkan semula semua kemajuan anda untuk pelajaran ini?';

  @override
  String get cancelLabel => 'Batal';

  @override
  String get yesLabel => 'Ya';

  @override
  String get errorResettingLesson => 'Ralat menetapkan semula pelajaran';

  @override
  String get startLabel => 'Mula';

  @override
  String get submitLabel => 'Hantar';

  @override
  String get nextLabel => 'Seterusnya';

  @override
  String get voiceErrorMicDeniedTitle => 'Mikrofon Ditolak';

  @override
  String get voiceErrorMicDeniedBody => 'Rakaman memerlukan akses mikrofon. Sila berikan kebenaran dalam Tetapan.';

  @override
  String get voiceErrorMicDeniedSemanticLabel => 'Dialog kebenaran mikrofon ditolak';

  @override
  String get voiceErrorRecorderStartTitle => 'Ralat Rakaman';

  @override
  String get voiceErrorRecorderStartBody => 'Kami tidak dapat memulakan perakam. Sila cuba lagi.';

  @override
  String get voiceErrorRecorderStartSemanticLabel => 'Dialog ralat memulakan perakam';

  @override
  String get voiceErrorRecorderStopTitle => 'Ralat Berhenti Merakam';

  @override
  String get voiceErrorRecorderStopBody => 'Kami tidak dapat menghentikan perakam dengan betul. Sila cuba lagi.';

  @override
  String get voiceErrorRecorderStopSemanticLabel => 'Dialog ralat memberhentikan perakam';

  @override
  String get voiceErrorNoSoundTitle => 'Tiada Bunyi Dikesan';

  @override
  String get voiceErrorNoSoundBody => 'Rakaman anda senyap atau terlalu perlahan. Sila cuba lagi.';

  @override
  String get voiceErrorNoSoundSemanticLabel => 'Dialog tiada bunyi dikesan';

  @override
  String get voiceErrorTranscriptionTitle => 'Ralat Transkripsi';

  @override
  String get voiceErrorTranscriptionBody => 'Kami tidak dapat mentranskripsikan rakaman anda. Sila semak sambungan anda dan cuba lagi.';

  @override
  String get voiceErrorTranscriptionSemanticLabel => 'Dialog ralat transkripsi';

  @override
  String get tapColoredWordsHint => 'Ketik perkataan yang diserlahkan untuk melihat versi yang dibetulkan.';

  @override
  String get emptyInputWarning => 'Anda mesti memasukkan sesuatu sebelum menghantar';

  @override
  String get getHintLabel => 'Dapatkan Petunjuk';

  @override
  String get removeHintLabel => 'Buang Petunjuk';

  @override
  String get typeTheMissingWordsLabel => 'Taip perkataan yang tertinggal';

  @override
  String get difficultyLabel => 'Kesukaran';

  @override
  String get repeatCountLabel => '# Ulangan';

  @override
  String get backButtonLabel => 'Kembali';

  @override
  String get toggleTranslationLabel => 'Tukar terjemahan sebaris';

  @override
  String get openTranslationScreenLabel => 'Buka skrin terjemahan';

  @override
  String get restartLessonSemanticLabel => 'Mulakan semula pelajaran';

  @override
  String get verseDisplayAreaLabel => 'Kawasan paparan ayat Quran';

  @override
  String get playAudioSemanticLabel => 'Mainkan audio ayat';

  @override
  String get openGratitudeSemanticLabel => 'Buka mod kesyukuran';

  @override
  String get voiceUsageSemanticLabel => 'Penggunaan suara dalam minit';

  @override
  String get voiceRecordSemanticLabel => 'Mulakan atau hentikan rakaman suara';

  @override
  String get commentC => 'String SKRIN HOME baharu';

  @override
  String get homeTitle => 'Laman Utama';

  @override
  String get noPathsLabel => 'Tiada laluan yang sah.';

  @override
  String errorLoadingActivePath(Object err) {
    return 'Ralat memuatkan laluan aktif: $err';
  }

  @override
  String get verticalLessonIconsGoToTheme => 'Pergi ke Tema';

  @override
  String get homePathCardLabel => 'Ketik untuk membuka skrin tema';

  @override
  String get arrowForwardSemanticLabel => 'Buka butiran';

  @override
  String get noTrackProgressLabel => 'Laluan ini tidak menjejak kemajuan.';

  @override
  String get premiumRequiredLabel => 'Tingkatkan untuk membuka fungsi kemajuan. Sokong kami menghasilkan lebih banyak ciri!';

  @override
  String get completedLabel => 'selesai';

  @override
  String get fabLogGratitudeLabel => 'Ketik untuk catat kesyukuran';

  @override
  String get errorNavigatingToLesson => 'Ralat menavigasi ke pelajaran';

  @override
  String get commentD => 'String skrin Profil';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileBackArrowLabel => 'Kembali ke skrin sebelumnya';

  @override
  String get profileAvatarSemanticLabel => 'Avatar pengguna';

  @override
  String get profileEnterYourName => 'Masukkan nama anda';

  @override
  String get nameEntryNotificationFrequencyDropdownLabel => 'Kekerapan Pemberitahuan';

  @override
  String get nameEntryNotificationFrequencyWeekly => 'Mingguan';

  @override
  String get nameEntryNotificationFrequencyNone => 'Tiada';

  @override
  String get notificationPermissionPrompt => 'Kami ingin menghantar peringatan lembut untuk melengkapkan kesyukuran atau penghantaran pelajaran anda - sila benarkan pemberitahuan jika anda ingin kami membantu membina tabiat 😃.';

  @override
  String get profileNameSave => 'Simpan';

  @override
  String get profileNameCancel => 'Batal';

  @override
  String get profileNameGuest => 'Tetamu';

  @override
  String get profileNameEdit => 'Sunting';

  @override
  String get profilePreferredLanguage => 'Bahasa:';

  @override
  String get okLabel => 'OK';

  @override
  String get profileReciterLabel => 'Qari';

  @override
  String get profileFontLabel => 'Fon:';

  @override
  String get profileReciterMishary => 'Mishary Rashid Al-Afasy';

  @override
  String get profileReciterShatri => 'Abu Bakr Al-Shatri';

  @override
  String get profileReciterQatami => 'Nasser Al Qatami';

  @override
  String get profileUpgradePremiumTitle => 'Buka Lebih Banyak Penyesuaian!';

  @override
  String get profileUpgradePremiumBody => 'Anda boleh menikmati penukaran fon dan qari dengan menaik taraf ke Pro. Sokong usaha berterusan kami dan peribadikan pengalaman anda dengan lebih jauh!';

  @override
  String get profileWeeksProgress => 'MasyaAllah, berikut adalah kemajuan anda minggu ini:';

  @override
  String get profileGratefulnessCalendar => 'Kalendar Kesyukuran';

  @override
  String get profileQuranLearningCalendar => 'Kalendar Pembelajaran Al-Quran';

  @override
  String get profilePrevWeekSemantic => 'Pergi ke minggu sebelumnya';

  @override
  String get profileNextWeekSemantic => 'Pergi ke minggu seterusnya';

  @override
  String get profileNotificationFrequency => 'Kekerapan Pemberitahuan';

  @override
  String get commentE => 'String Skrin Log Kesyukuran';

  @override
  String get gratitudeLogTitle => 'Log Kesyukuran Saya';

  @override
  String get gratitudeLogBackArrowSemantic => 'Kembali ke laman utama';

  @override
  String get gratitudeLogClearAllSemantic => 'Padam semua entri kesyukuran';

  @override
  String get gratitudeLogAddSemantic => 'Tambah entri kesyukuran baharu';

  @override
  String get gratitudeLogClearDialogTitle => 'Kosongkan Log Kesyukuran';

  @override
  String get gratitudeLogClearDialogBody => 'Adakah anda pasti ingin mengosongkan semua entri kesyukuran anda? Tindakan ini tidak boleh dibatalkan.';

  @override
  String get gratitudeLogClearConfirm => 'Ya, Kosongkan';

  @override
  String gratitudeLogStreak(Object days) {
    return '⭐ Rentetan Kesyukuran: $days hari';
  }

  @override
  String get gratitudeLogStreakLoading => 'Mengira rentetan...';

  @override
  String get gratitudeLogStreakError => 'Gagal mengira rentetan.';

  @override
  String gratitudeLogTotalDays(Object count) {
    return 'Jumlah Hari Kesyukuran: $count';
  }

  @override
  String get gratitudeLogDataLoading => 'Memuatkan data kesyukuran...';

  @override
  String get gratitudeLogDataError => 'Gagal memuatkan data kesyukuran.';

  @override
  String get gratitudeLogCardSemantic => 'Kad entri kesyukuran';

  @override
  String get gratitudeLogItemIcon => 'Ikon kesyukuran';

  @override
  String get gratitudeLogEmptyIconSemantic => 'Ketik untuk menambah kesyukuran pertama anda';

  @override
  String get gratitudeLogEmptyMessage => 'Tiada entri kesyukuran setakat ini.\nKetik “+” untuk menambah kesyukuran pertama anda!';

  @override
  String get gratitudeLogEntriesAdded => 'Kesyukuran berjaya ditambah!';

  @override
  String get gratitudeLogEntriesFailed => 'Gagal menambah kesyukuran. Sila cuba lagi.';

  @override
  String get commentF => 'String Skrin Penyelesaian Pelajaran';

  @override
  String get lessonCompletedTitle => 'Pelajaran Selesai';

  @override
  String get lessonCompletedBackArrowSemantic => 'Kembali ke laman utama';

  @override
  String get lessonCompletedMashaAllah => 'MashaAllah!';

  @override
  String get lessonCompletedMashaAllahSemantic => 'Teks ucapan tahniah';

  @override
  String get lessonCompletedMessage => 'Anda telah menamatkan pelajaran ini!';

  @override
  String get lessonCompletedImageSemantic => 'Ilustrasi Hudhud Quran';

  @override
  String get lessonCompletedGoBackSemantic => 'Kembali ke pemilihan laluan';

  @override
  String get lessonCompletedGoBackButton => 'Kembali ke Laluan';

  @override
  String get lessonCompletedRestartSemantic => 'Mulakan semula pelajaran';

  @override
  String get lessonCompletedRestartButton => 'Mulakan Semula Pelajaran';

  @override
  String get lessonCompletedEncouragement => 'Teruskan usaha yang baik!';

  @override
  String get commentG => 'String Skrin Tema';

  @override
  String get themeScreenTitle => 'Tema';

  @override
  String get themeNameCoreRecitation => 'Tilawah Harian Teras';

  @override
  String get themeNameBeginJourney => 'Memulakan Perjalanan';

  @override
  String get themeNameMercyAndHope => 'Rahmat dan Harapan';

  @override
  String get themeNameGratitudeReflection => 'Kesyukuran dan Renungan';

  @override
  String get themeNameStoriesReminders => 'Kisah, Pelajaran, dan Peringatan';

  @override
  String get themeNamePatience => 'Kesabaran (Ṣabr)';

  @override
  String get themeNameUserCreated => 'Dicipta Pengguna';

  @override
  String get themeScreenNoThemesLabel => 'Tiada Tema Tersedia';

  @override
  String get themeScreenBackArrowSemantic => 'Kembali';

  @override
  String get themeScreenThemeCardSemantic => 'Ketik untuk membuka laluan tema';

  @override
  String get themeScreenLockIconSemantic => 'Tema terkunci. Memerlukan naik taraf.';

  @override
  String get pathListExploreOtherThemes => 'Teroka Tema Lain';

  @override
  String get themeScreenUserCreatedSubtitle => 'Dicipta oleh anda—peribadikannya sesuka anda.';

  @override
  String get themeSubtitleCoreRecitation => 'Surah penting untuk solat harian dan perlindungan.';

  @override
  String get themeSubtitleBeginJourney => 'Surah-surah pendek untuk memulakan perjalanan Al-Quran anda.';

  @override
  String get themeSubtitleMercyAndHope => 'Renungkan belas kasihan Allah dan pupuk harapan.';

  @override
  String get themeSubtitleGratitudeReflection => 'Tingkatkan rasa syukur dan muhasabah melalui ayat-ayat terpilih.';

  @override
  String get themeSubtitleStoriesReminders => 'Terokai kisah Al-Quran yang memandu dan mengingatkan.';

  @override
  String get themeSubtitlePatience => 'Surah dan petikan yang menekankan kesabaran dan ketabahan.';

  @override
  String get themeSubtitleDefault => 'Set surah khusus untuk pertumbuhan rohani yang lebih mendalam.';

  @override
  String get themeScreenRequiredPremium => 'Memerlukan Premium';

  @override
  String get themeScreenRequiredPremiumPlus => 'Memerlukan Premium Plus';

  @override
  String get commentH => 'String Skrin Senarai Laluan (Path List)';

  @override
  String get pathListScreenTitle => 'Laluan untuk Tema';

  @override
  String get pathListScreenBackArrowSemantic => 'Kembali';

  @override
  String get pathListScreenAddIconSemantic => 'Tambah laluan baharu';

  @override
  String get pathListAddNewPathTooltip => 'Tambah Laluan Baharu';

  @override
  String get pathListScreenAddIconSemanticEmpty => 'Ketik untuk menambah laluan pertama anda';

  @override
  String get pathListEmptyMessage => 'Tiada laluan setakat ini.\nKetik “+” untuk mencipta laluan pertama anda!';

  @override
  String get pathListUnavailableLabel => 'Laluan ini tidak tersedia buat masa ini';

  @override
  String get pathListThemeLabel => 'Tema';

  @override
  String get pathListPathCardSemantic => 'Ketik untuk membuka butiran laluan';

  @override
  String get pathListCompleteIconSemantic => 'Laluan selesai';

  @override
  String get pathListInProgressIconSemantic => 'Laluan dalam proses';

  @override
  String get pathListInvalidIconSemantic => 'Laluan tidak sah atau tidak tersedia';

  @override
  String get pathListErrorLoadingPaths => 'Ralat memuatkan laluan:';

  @override
  String get commentI => 'String Skrin Butiran Laluan (Path Detail)';

  @override
  String get pathDetailScreenTitle => 'Butiran Laluan';

  @override
  String get pathDetailScreenBackArrowSemantic => 'Kembali ke senarai laluan';

  @override
  String get pathDetailScreenNotFound => 'Laluan tidak dijumpai.';

  @override
  String get pathDetailScreenFailToUpdate => 'Gagal mengemas kini kemajuan laluan:';

  @override
  String get pathDetailScreenProgressDisabled => 'Kemajuan dimatikan untuk laluan ini.';

  @override
  String get pathDetailScreenLessonsHeading => 'Pelajaran:';

  @override
  String get pathDetailScreenNoLessonsLabel => 'Tiada pelajaran tersedia.';

  @override
  String get pathDetailScreenErrorLoading => 'Ralat memuatkan laluan atau pelajaran:';

  @override
  String get pathDetailScreenLessonCardSemantic => 'Ketik untuk membuka butiran pelajaran';

  @override
  String get pathDetailScreenLessonCompleteIconSemantic => 'Pelajaran selesai';

  @override
  String get pathDetailScreenLessonInProgressIconSemantic => 'Pelajaran dalam proses';

  @override
  String get pathDetailScreenLessonInvalidIconSemantic => 'Pelajaran tidak sah atau tidak tersedia';

  @override
  String get pathDetailScreenLessonProgressUnavailable => 'Kemajuan tidak tersedia';

  @override
  String get pathDetailScreenLessonNoProgress => 'Tiada kemajuan untuk laluan ini';

  @override
  String get pathDetailScreenLessonUpgrade => 'Tingkatkan untuk fungsi kemajuan.';

  @override
  String pathDetailScreenLessonProgressLabel(Object progress) {
    return 'Kemajuan: $progress%';
  }

  @override
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah) {
    return 'Pelajaran $lessonIndex: $surahName - Ayat $startAyah-$endAyah';
  }

  @override
  String get commentJ => 'String Skrin Cipta Laluan (Create Path)';

  @override
  String get createPathTitle => 'Cipta Laluan Baharu';

  @override
  String get createPathBackArrowSemantic => 'Kembali ke skrin sebelumnya';

  @override
  String get createPathNameLabel => 'Nama Laluan';

  @override
  String get createPathNameValidation => 'Masukkan nama laluan';

  @override
  String get createPathDescriptionLabel => 'Penerangan';

  @override
  String get createPathDescriptionValidation => 'Masukkan penerangan';

  @override
  String get createPathSurahSelectorLabel => 'Pilih Surah:';

  @override
  String get createPathStartAyahLabel => 'Ayat Mula';

  @override
  String get createPathNumAyahsLabel => 'Bilangan Ayat dalam Laluan';

  @override
  String get createPathEndAyahLabel => 'Ayat Akhir';

  @override
  String get createPathWordsPerLessonLabel => 'Bilangan Perkataan setiap Pelajaran';

  @override
  String get createPathWordsSuffix => 'perkataan';

  @override
  String get createPathInvalidRange => 'Julat tidak sah';

  @override
  String get createPathAyahsSuffix => 'Ayat';

  @override
  String get createPathCreateButton => 'Cipta Laluan';

  @override
  String get createPathSubmitSemantic => 'Ketik untuk mencipta laluan';

  @override
  String get commentK => 'String Skrin Terjemahan (Translation Screen)';

  @override
  String get translationScreenTitle => 'Terjemahan';

  @override
  String get translationScreenBackArrowSemantic => 'Kembali ke pelajaran';

  @override
  String get translationScreenLoadingSemantic => 'Memuatkan terjemahan';

  @override
  String get translationScreenNoTranslations => 'Tiada terjemahan tersedia.';

  @override
  String get translationScreenReturnButton => 'Kembali ke Pelajaran';

  @override
  String get translationScreenReturnSemantic => 'Ketik untuk kembali ke pelajaran';

  @override
  String get translationScreenLoadError => 'Ralat memuatkan terjemahan:';

  @override
  String get commentL => 'String Skrin Pilih Bahasa (Language Selection)';

  @override
  String get languageSelectionScreenSemantic => 'Skrin Pilihan Bahasa';

  @override
  String get languageSelectionTitle => 'Pilih Bahasa Anda';

  @override
  String get languageSelectionBackSemantic => 'Kembali';

  @override
  String get languageSelectionSkipSemantic => 'Langkau pemilihan';

  @override
  String get languageSelectionInstructions => 'Sila pilih bahasa pilihan anda:';

  @override
  String get languageSelectionNextSemantic => 'Ketik untuk sahkan pilihan bahasa';

  @override
  String get languageSelectionNextLabel => 'Seterusnya';

  @override
  String get languageSelectionImageSemantic => 'Ilustrasi Hudhud Quran';

  @override
  String get commentM => 'String Skrin Selamat Datang (Welcome Screen)';

  @override
  String get welcomeScreenSemantic => 'Skrin Onboarding Selamat Datang';

  @override
  String get welcomeScreenLogoSemantic => 'Ilustrasi Hudhud Quran';

  @override
  String get welcomeScreenSkipSemantic => 'Langkau langkah selamat datang';

  @override
  String get welcomeScreenNextSemantic => 'Teruskan ke langkah onboarding seterusnya';

  @override
  String get commentN => 'String Skrin Info Hudhud (Hudhud Info)';

  @override
  String get hudhudInfoSemantic => 'Skrin Maklumat Hudhud';

  @override
  String get hudhudInfoAppBarTitle => 'Kenali Hudhud';

  @override
  String get hudhudInfoIllustrationSemantic => 'Ilustrasi Hudhud';

  @override
  String get hudhudInfoBody1 => 'Hudhud, juga dikenali sebagai burung hud-hud, memainkan peranan istimewa dalam membantu Nabi Sulaiman [AS] dengan memerhati dan menyampaikan mesej.';

  @override
  String get hudhudInfoBody2 => 'Kisah Hudhud mengingatkan kita bahawa makhluk kecil sekalipun mampu memberi impak besar dengan menjadi pemerhati, ingin tahu, dan proaktif mengenai perkara yang betul. Dalam perjalanan kita, kita boleh memberikan tumpuan berterusan pada keindahan Al-Quran, dan menggabungkan peringatan kesyukuran untuk menghargai setiap kemajuan.';

  @override
  String get hudhudInfoBody3 => 'Dengan mencontohi Hudhud—sentiasa peka dan terlibat—kami berharap dapat memperdalam hubungan kita dengan Al-Quran dan memupuk rasa kesyukuran dalam kehidupan seharian.';

  @override
  String get hudhudInfoNextLabel => 'Seterusnya';

  @override
  String get hudhudInfoNextSemantic => 'Teruskan ke bahagian seterusnya';

  @override
  String get hudhudInfoSkipSemantic => 'Langkau langkah info Hudhud';

  @override
  String get commentO => 'String Skrin Pilihan Tahap Langganan (Subscription Tier)';

  @override
  String get subscriptionTierScreenSemantic => 'Skrin Pemilihan Tahap Langganan';

  @override
  String get subscriptionTierScreenAppBarTitle => 'Pilih Pelan Anda';

  @override
  String get subscriptionTierScreenSkipSemantic => 'Langkau pemilihan tahap langganan';

  @override
  String get subscriptionTierScreenFreeLabel => 'Percuma';

  @override
  String get subscriptionTierScreenSmileySemantic => 'Ikon muka tersenyum';

  @override
  String get subscriptionTierScreenDonationText => 'Sebahagian dana akan disalurkan ke Inisiatif Almubtasim, membantu anak yatim melalui Islamic Relief.';

  @override
  String get subscriptionTierScreenConfirmSemantic => 'Sahkan pemilihan tahap langganan';

  @override
  String get subscriptionTierScreenNextLabel => 'Seterusnya';

  @override
  String subscriptionTierScreenRadioSemantic(Object title) {
    return 'Ketik untuk memilih tahap langganan $title';
  }

  @override
  String get commentP => 'String Skrin Pilihan Matlamat (Goal Selection)';

  @override
  String get goalSelectionScreenSemantic => 'Skrin Pemilihan Matlamat';

  @override
  String get goalSelectionScreenAppBarTitle => 'Pilih Matlamat Anda';

  @override
  String get goalSelectionScreenSkipSemantic => 'Langkau pemilihan matlamat';

  @override
  String get goalSelectionScreenIntroText => 'Antara matlamat berikut, yang manakah menarik minat anda? Anda boleh pilih lebih daripada satu.';

  @override
  String get goalSelectionScreenNextSemantic => 'Sahkan pemilihan matlamat';

  @override
  String get goalSelectionScreenNextLabel => 'Seterusnya';

  @override
  String goalSelectionTileSemantic(Object goalTitle) {
    return 'Ketik untuk pilih atau batal pilih pilihan matlamat $goalTitle';
  }

  @override
  String get goalConnectQuranTitle => 'Berhubung lebih jauh dengan Al-Quran';

  @override
  String get goalConnectQuranDesc => 'Perkukuh hubungan anda melalui pembacaan atau renungan.';

  @override
  String get goalMemorizeQuranTitle => 'Menghafaz Al-Quran';

  @override
  String get goalMemorizeQuranDesc => 'Mulakan perjalanan hafazan.';

  @override
  String get goalBeMoreGratefulTitle => 'Lebih bersyukur dan gembira dalam hidup';

  @override
  String get goalBeMoreGratefulDesc => 'Fokus pada amalan kesyukuran harian.';

  @override
  String get goalBuildConsistencyTitle => 'Bina konsistensi';

  @override
  String get goalBuildConsistencyDesc => 'Bina tabiat harian atau mingguan.';

  @override
  String get goalImproveArabicTitle => 'Perbaiki bahasa Arab saya';

  @override
  String get goalImproveArabicDesc => 'Fokus pada kemahiran bahasa Arab bertulis atau lisan.';

  @override
  String get goalDeepenTafsirTitle => 'Mendalami Tafsir';

  @override
  String get goalDeepenTafsirDesc => 'Kaji huraian dan makna lebih mendalam Al-Quran.';

  @override
  String get goalOtherTitle => 'Lain-lain';

  @override
  String get goalOtherDesc => 'Capai apa-apa matlamat peribadi lain.';

  @override
  String get commentQ => 'String Skrin Pemilihan Tahap (Level Selection)';

  @override
  String get levelSelectionScreenSemantic => 'Skrin Pemilihan Tahap';

  @override
  String get levelSelectionScreenAppBarTitle => 'Pilih Tahap Anda';

  @override
  String get levelSelectionScreenSkipSemantic => 'Langkau pemilihan tahap';

  @override
  String get levelSelectionScreenIntroText => 'Sila pilih pilihan yang paling menggambarkan tahap bacaan anda sekarang:';

  @override
  String get levelStarterLabel => 'Permulaan';

  @override
  String get levelStarterDescription => 'Pembelajar baru atau santai, mula meneroka bacaan Al-Quran.';

  @override
  String get levelAdvancedLabel => 'Lanjutan';

  @override
  String get levelAdvancedDescription => 'Selesa membaca teks Arab dengan sedikit pengetahuan tajwid.';

  @override
  String get levelQariLabel => 'Qari';

  @override
  String get levelQariDescription => 'Cekap dalam bacaan dengan kecekapan tajwid yang kukuh.';

  @override
  String get levelSelectionNextSemantic => 'Sahkan pemilihan tahap';

  @override
  String get levelSelectionNextLabel => 'Seterusnya';

  @override
  String levelSelectionTileSemantic(Object levelTitle) {
    return 'Ketik untuk memilih pilihan tahap bacaan $levelTitle';
  }

  @override
  String get commentR => 'String Skrin Penyelesaian Onboarding';

  @override
  String get onboardingCompletionScreenSemantic => 'Skrin Penyelesaian Onboarding';

  @override
  String get onboardingCompletionScreenAppBarTitle => 'Semua Selesai!';

  @override
  String get onboardingCompletionScreenImageSemantic => 'Ilustrasi Hudhud Quran';

  @override
  String get onboardingCompletionScreenBody1 => 'Tahniah! Anda telah berjaya melengkapkan tetapan. Kami berharap perjalanan ini akan mendekatkan anda dengan Al-Quran dan meningkatkan kesyukuran anda kepada Allah. \n\nSemoga aplikasi ini menjadi sumber pertumbuhan dan keberkatan dalam hidup anda dan mereka yang anda sentuh.';

  @override
  String get onboardingCompletionScreenBody2 => 'Bila-bila masa anda bersedia, ketik butang di bawah untuk meneruskan. Ciri hafalan dan kemajuan utama sedang menanti, dan anda boleh merekod kesyukuran atau memilih laluan dari Navbar.';

  @override
  String get onboardingCompletionScreenBody3 => 'Ini ialah versi awal — kami hargai sokongan dan kesabaran anda dan berharap untuk menawarkan lebih banyak ciri tidak lama lagi insyaAllah!';

  @override
  String get onboardingCompletionScreenBeginSemantic => 'Mulakan menggunakan aplikasi';

  @override
  String get onboardingCompletionScreenBeginLabel => 'Mari Mula';

  @override
  String get commentS => 'String Skrin Masukkan Nama (Name Entry)';

  @override
  String get nameEntryScreenSemantic => 'Skrin Masukkan Nama';

  @override
  String get nameEntryScreenAppBarTitle => 'Profil anda';

  @override
  String get nameEntryScreenSkipSemantic => 'Langkau memasukkan nama anda';

  @override
  String get nameEntryScreenIntroText => 'Siapa nama anda?';

  @override
  String get nameEntryTextFieldSemantic => 'Medan teks input nama';

  @override
  String get nameEntryNextSemantic => 'Sahkan masukan nama';

  @override
  String get nameEntryNextLabel => 'Seterusnya';

  @override
  String get commentT => 'String VerticalLessonIcons';

  @override
  String get verticalLessonIconsSemantic => 'Kontena Ikon Pelajaran Menegak';

  @override
  String get verticalLessonIconsNoLessons => 'Tiada pelajaran dijumpai.';

  @override
  String get verticalLessonIconsLoadingSurah => 'Memuatkan butiran Surah';

  @override
  String get verticalLessonIconsErrorSurah => 'Ralat memuatkan butiran surah';

  @override
  String get verticalLessonIconsSurahHeaderSemantic => 'Pengepala butiran Surah';

  @override
  String get verticalLessonIconsHudhudIconSemantic => 'Ikon pembantu Hudhud';

  @override
  String get verticalLessonIconsNextPageSemantic => 'Anak panah halaman seterusnya';

  @override
  String get verticalLessonIconsPreviousPageSemantic => 'Anak panah halaman sebelumnya';

  @override
  String get verticalLessonIconsLoadingProgress => 'Memuatkan kemajuan pelajaran';

  @override
  String get verticalLessonIconsErrorProgress => 'Ralat memuatkan kemajuan';

  @override
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent) {
    return 'Ikon pelajaran, $surahAyahRange, kemajuan $percent%';
  }

  @override
  String get verticalLessonIconsCompletedSemantic => 'Pelajaran selesai';

  @override
  String get verticalLessonIconsDialogTitle => 'Sokongan & Naik Taraf';

  @override
  String get verticalLessonIconsDialogOk => 'OK';

  @override
  String get commentU => 'String Navbar';

  @override
  String get navBarSemanticLabel => 'Bar navigasi bawah';

  @override
  String get navHomeLabel => 'Utama';

  @override
  String get navHomeSemantic => 'Tab Utama';

  @override
  String get navQuranLabel => 'Al-Quran';

  @override
  String get navQuranSemantic => 'Tab Quran';

  @override
  String get navGratitudeLabel => 'Kesyukuran';

  @override
  String get navGratitudeSemantic => 'Tab Kesyukuran';

  @override
  String get navProfileLabel => 'Profil';

  @override
  String get navProfileSemantic => 'Tab Profil';

  @override
  String get commentV => 'String TopBar';

  @override
  String get topBarSemanticLabel => 'Bar navigasi atas';

  @override
  String topBarTitleSemantic(Object title) {
    return 'Tajuk bar atas: $title';
  }

  @override
  String topBarStreakIconSemantic(Object days) {
    return 'Ikon rentetan: $days hari';
  }

  @override
  String get topBarStreakDialogBody => 'Ia menunjukkan berapa hari berturut-turut anda membaca atau menulis kesyukuran. Teruskan untuk mengekalkan atau menambah rentetan anda!';

  @override
  String get topBarHudhudIconSemantic => 'Ikon Hudhud, ketik untuk sokongan';

  @override
  String get topBarHudhudDialogTitle => 'Sokongan & Naik Taraf';

  @override
  String get topBarHudhudDialogBody => 'Semua ciri disediakan dalam versi percuma, tetapi jika anda mahu, anda boleh menyokong kami untuk membina lebih banyak ciri. Sebahagian daripada langganan anda akan didermakan kepada Islamic Relief. Jazāk Allāhu Khayran!';

  @override
  String get commentW => 'String Gratitude Modal';

  @override
  String get gratitudeModalSemantic => 'Dialog Mod Kesyukuran';

  @override
  String get gratitudeModalTitle => 'Apa yang anda syukuri hari ini berdasarkan ayat-ayat ini?';

  @override
  String gratitudeModalHint(Object index) {
    return 'Alhamdulillah untuk (masukkan kesyukuran) #$index';
  }

  @override
  String gratitudeModalTextFieldSemantic(Object index) {
    return 'Masukkan kesyukuran #$index';
  }

  @override
  String get gratitudeModalEmptyWarning => 'Sila masukkan sekurang-kurangnya satu kesyukuran.';

  @override
  String get gratitudeModalSubmitError => 'Gagal merekod kesyukuran. Sila cuba lagi.';

  @override
  String get dailyVoiceLimitReachedTitle => 'MashaAllah!';

  @override
  String get dailyVoiceLimitReachedMessage => 'Anda telah melengkapkan 10 minit bacaan suara Al-Quran. Sila teruskan ulang kaji dengan menulis, dan sambung bacaan esok.';

  @override
  String get upgradeVoiceUsageTitle => 'Naik Taraf ke Premium';

  @override
  String get gratitudeModalLoadingSemantic => 'Penghantaran kesyukuran sedang diproses';

  @override
  String get commentX => '== KUNCI BARU untuk submission_feedback_modal, progress_bar, surah_selector ==';

  @override
  String get submissionFeedbackModalSemanticLabel => 'Dialog maklum balas penghantaran';

  @override
  String get submissionFeedbackModalTitle => 'Maklum Balas Penghantaran';

  @override
  String get submissionFeedbackModalNoNew => 'Tiada kesyukuran baharu yang dihantar.';

  @override
  String get submissionFeedbackModalYouSubmitted => 'Anda telah menghantar kesyukuran ini:';

  @override
  String submissionFeedbackModalStreak(Object days) {
    return 'Rentetan kesyukuran semasa: $days hari';
  }

  @override
  String submissionFeedbackModalTotalDays(Object count) {
    return 'Jumlah hari kesyukuran: $count';
  }

  @override
  String get submissionFeedbackModalLoading => 'Memuatkan data kesyukuran anda...';

  @override
  String get submissionFeedbackModalError => 'Tidak dapat memuatkan data kesyukuran.';

  @override
  String get submissionFeedbackModalViewLog => 'Lihat Log';

  @override
  String get submissionFeedbackModalClose => 'Tutup';

  @override
  String progressBarSemanticLabel(Object percent) {
    return 'Kemajuan: $percent%';
  }

  @override
  String get surahSelectorSemanticLabel => 'Pilih Surah';

  @override
  String get commentZ => 'Nama Laluan & Penerangan boleh dilokalkan untuk laluan yang ditakrifkan oleh sistem';

  @override
  String get pathNameFatihah => 'Surah Al-Fātiḥah';

  @override
  String get pathDescFatihah => 'Keseluruhan Surah (1:1–7). Penting untuk setiap rakaat.';

  @override
  String get pathNameKafirun => 'Surah Al-Kāfirūn';

  @override
  String get pathDescKafirun => 'Keseluruhan Surah (109:1–6). Pernyataan Tauhid.';

  @override
  String get pathNameIkhlas => 'Surah Al-Ikhlāṣ';

  @override
  String get pathDescIkhlas => 'Keseluruhan Surah (112:1–4). Tauhid Allah.';

  @override
  String get pathNameFalaq => 'Surah Al-Falaq';

  @override
  String get pathDescFalaq => 'Keseluruhan Surah (113:1–5). Mohon perlindungan dari kejahatan luar.';

  @override
  String get pathNameNas => 'Surah An-Nās';

  @override
  String get pathDescNas => 'Keseluruhan Surah (114:1–6). Mohon perlindungan dari bisikan dalaman.';

  @override
  String get pathNameAsrBegin => 'Surah Al-ʿAṣr';

  @override
  String get pathDescAsrBegin => '(103:1–3). Hanya 3 ayat namun berpusat pada “kesabaran”.';

  @override
  String get pathNameTakathur => 'Surah At-Takāthur';

  @override
  String get pathDescTakathur => '(102:1–8) tentang persaingan duniawi dan akauntabiliti.';

  @override
  String get pathNameFil => 'Surah Al-Fīl';

  @override
  String get pathDescFil => '(105:1–5). Peristiwa tentera bergajah; 5 ayat pendek.';

  @override
  String get pathNameQuraysh => 'Surah Quraysh';

  @override
  String get pathDescQuraysh => '(106:1–4). Tentang kesyukuran atas perjalanan selamat.';

  @override
  String get pathNameRahmanA => 'Ar-Raḥmān A';

  @override
  String get pathDescRahmanA => '(55:1–13): Pengajaran Al-Quran & penciptaan manusia.';

  @override
  String get pathNameRahmanB => 'Ar-Raḥmān B';

  @override
  String get pathDescRahmanB => '(55:26–36): Akauntabiliti manusia & jin.';

  @override
  String get pathNameYasinBlock => 'Surah Yā Sīn (Blok)';

  @override
  String get pathDescYasinBlock => '(36:1–12). Pengenalan pada mesej Nabi & amaran.';

  @override
  String get pathNameMulkBlock => 'Surah Al-Mulk (Blok)';

  @override
  String get pathDescMulkBlock => '(67:1–15). Menekankan kekuasaan Allah & renungan.';

  @override
  String get pathNameBaqarah21_29 => 'Al-Baqarah (2:21–29)';

  @override
  String get pathDescBaqarah21_29 => '9 ayat tentang penciptaan & renungan untuk kesyukuran.';

  @override
  String get pathNameNahl66_72 => 'An-Naḥl (16:66–72)';

  @override
  String get pathDescNahl66_72 => '7 ayat menyenaraikan nikmat: ternakan, buah-buahan, dsb.';

  @override
  String get pathNameAdDuha => 'Surah Aḍ-Ḍuḥā';

  @override
  String get pathDescAdDuha => '(93:1–11) 11 ayat tentang harapan & jaminan.';

  @override
  String get pathNameKahfCave => 'Al-Kahf: Pemuda Gua';

  @override
  String get pathDescKahfCave => '(18:9–16) Kisah pemuda beriman dalam gua.';

  @override
  String get pathNameKahfMusa => 'Al-Kahf: Mūsā & Al-Khiḍr';

  @override
  String get pathDescKahfMusa => '(18:60–70) Menekankan kesabaran & hikmah tersembunyi.';

  @override
  String get pathNameWaqiah => 'Al-Wāqiʿah (56:1–15)';

  @override
  String get pathDescWaqiah => '15 ayat tentang kedatangan Hari Kiamat secara tiba-tiba.';

  @override
  String get pathNameAsrPatience => 'Surah Al-ʿAṣr (Kesabaran)';

  @override
  String get pathDescAsrPatience => '(103:1–3) sekali lagi, 3 ayat, terkenal tentang kesabaran.';

  @override
  String get pathNameBaq153_157 => 'Al-Baqarah (2:153–157)';

  @override
  String get pathDescBaq153_157 => '5 ayat: “Mintalah pertolongan dengan sabar & solat.”';

  @override
  String get pathNameYusuf7_14 => 'Sūrah Yūsuf (12:7–14)';

  @override
  String get pathDescYusuf7_14 => 'Kecemburuan saudara-saudara Yusuf. Kesabaran diuji.';

  @override
  String get pathNameYusuf83_92 => 'Sūrah Yūsuf (12:83–92)';

  @override
  String get pathDescYusuf83_92 => 'Kesedihan Yaʿqūb & keampunan Yusuf (10 ayat).';

  @override
  String get pathNameInshirah => 'Surah Al-Inshirāḥ (94:1–8)';

  @override
  String get pathDescInshirah => '8 ayat: keyakinan selepas kesusahan. Dikaitkan dengan kesabaran & harapan.';

  @override
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah) {
    return 'Surah $surahName, Ayat $startAyah-$endAyah';
  }

  @override
  String get finishLabel => 'Tamat';

  @override
  String get twoWordMultipleChoiceLabel => 'Pilih dua perkataan yang betul';

  @override
  String get singleWordMultipleChoiceLabel => 'Pilih perkataan yang betul';

  @override
  String get correctAnswerLabel => 'Betul!';

  @override
  String get incorrectAnswerLabel => 'Salah!';

  @override
  String get lessonCompletedLabel => 'Pelajaran selesai!';

  @override
  String get profileAnalyticsScoreLabel => 'Analitis & Skor';

  @override
  String get profileDailyLabel => 'Harian';

  @override
  String get profileWeeklyLabel => 'Mingguan';

  @override
  String get profileMonthlyLabel => 'Bulanan';

  @override
  String get profileTotalLabel => 'Jumlah';

  @override
  String get profileViewChart => 'Lihat carta';

  @override
  String get profileCloseLabel => 'Tutup';

  @override
  String get profileScoreChartTitle => 'Carta Skor';

  @override
  String get profileScoreChartHistory => 'Sejarah';

  @override
  String get profileNoData => 'Tiada data';

  @override
  String get topBarDailyScoreLabel => '⭐ Hari Ini';

  @override
  String topBarDailyScoreSemantic(Object score) {
    return 'Skor harian anda adalah $score';
  }

  @override
  String get profilePremiumNeeded => 'Sila naik taraf untuk melihat kalendar kemajuan dan sokong kami membina lebih banyak ciri, insya-Allah!';

  @override
  String get levelMultipleChoiceLabel => 'Pelbagai Pilihan';

  @override
  String get levelMultipleChoiceDescription => 'Langkah pilihan pelbagai satu atau dua perkataan dengan pilihan untuk melangkau pasangan.';

  @override
  String get levelBeginnerLabel => 'Pemula';

  @override
  String get levelBeginnerDescription => 'Penghapusan perkataan secara progresif dalam urutan berkumpulan untuk penghafalan secara beransur-ansur.';

  @override
  String get subscriptionTierScreenPremiumLabel => 'Plus';

  @override
  String get featureUnavailableOffline => 'Ciri tidak tersedia di luar talian. Sila sambungkan atau buka kunci mod luar talian dengan menaik taraf ke Plus atau Pro Beta.';

  @override
  String submissionFeedbackModalTotalCount(Object count) {
    return 'Jumlah keseluruhan catatan penghargaan: $count';
  }

  @override
  String get notificationDailyTitle => 'Peringatan Al-Quran Harian yang Lembut';

  @override
  String get notificationWeeklyTitle => 'Semakan Mingguan Al-Quran';

  @override
  String get notificationWeeklyBody => 'Renungkan perkembangan anda dan hafal bahagian baru Al-Quran sambil berlatih kesyukuran.';

  @override
  String get notificationChannelDailyRemindersName => 'Peringatan Harian';

  @override
  String get notificationChannelDailyRemindersDesc => 'Peringatan untuk hafalan harian Al-Quran';

  @override
  String get notificationChannelWeeklyRemindersName => 'Peringatan Mingguan';

  @override
  String get notificationChannelWeeklyRemindersDesc => 'Peringatan untuk semakan mingguan hafalan Al-Quran';

  @override
  String get nameEntryNotificationFrequencyDaily => 'Harian';

  @override
  String get topBarStreakDialogTitle => 'Rentetan';

  @override
  String get fillInTheBlanksLabel => 'Isi tempat kosong';

  @override
  String get loadingDataLabel => 'Sedang memuat…';

  @override
  String ayahRangeLabel(Object start, Object end) {
    return 'Ayat $start - $end';
  }

  @override
  String get nextPageSemanticLabel => 'Halaman seterusnya';

  @override
  String get prevPageSemanticLabel => 'Halaman sebelumnya';

  @override
  String pageXOfYLabel(Object current, Object total) {
    return 'Halaman $current daripada $total';
  }

  @override
  String verseSemanticLabel(Object ayahNumber, Object surahName) {
    return 'Ayat $ayahNumber daripada surah $surahName';
  }

  @override
  String get ayahLabel => 'Ayat';

  @override
  String get goToSurahViewLabel => 'Papar Surah';

  @override
  String get clickOnAyaToOpenLesson => 'Klik pada mana-mana ayat di bawah untuk memulakan pelajaran';

  @override
  String get difficultyChoosingScreenIntro => 'Pilih keutamaan anda: pilihan berganda atau isi tempat kosong, dan berapa kali setiap langkah dan audio diulang.';

  @override
  String get upgradeVoiceUsageMessage => 'Naik taraf ke Pro Beta untuk mencuba ciri suara dan bantu kami menambahbaiknya!';

  @override
  String get restorePurchasesLabel => 'Pulihkan Pembelian';

  @override
  String get subscriptionTierScreenMonthly => 'Bulanan';

  @override
  String get subscriptionTierScreenYearly => 'Tahunan';

  @override
  String get subscriptionTierScreenFreePrice => 'Percuma';

  @override
  String get subscriptionTierScreenPremiumMonthlyPrice => 'Kini \$3/bulan (dahulunya \$5)';

  @override
  String get subscriptionTierScreenPremiumYearlyPrice => 'Kini \$28/tahun (dahulunya \$60)';

  @override
  String get subscriptionTierScreenPremiumPlusMonthlyPrice => 'Kini \$7/bulan (dahulunya \$10)';

  @override
  String get subscriptionTierScreenPremiumPlusYearlyPrice => 'Kini \$45/tahun (dahulunya \$84)';

  @override
  String get subscriptionPurchaseError => 'Ralat semasa membeli langganan';

  @override
  String get topBarExplorePlansLabel => 'Teroka Pelan';

  @override
  String get topBarBackHomeLabel => 'Kembali ke Laman Utama';

  @override
  String get profileRequiresPlanUpdate => 'Memerlukan kemas kini pelan';

  @override
  String get subscriptionTierScreenPremiumDescription => 'Segala yang terdapat dalam versi percuma, ditambah pembelajaran pelajaran luar talian dan maklum balas, analitik sejarah serta bar kemajuan, profil, dan penyesuaian Al-Quran. Sokong kami untuk membina lebih banyak ciri!';

  @override
  String get subscriptionAutoRenewNotice => 'Langganan akan diperbaharui secara automatik dan boleh dibatalkan supaya anda tidak dicaj untuk tempoh seterusnya. Sebahagian dana akan disumbangkan kepada Islamic Relief melalui Inisiatif Almubtasim 😀.';

  @override
  String get subscriptionTierScreenSubscribeLabel => 'Langgan';

  @override
  String get subscriptionTierScreenFinalMessage => 'Kami hargai sokongan anda!';

  @override
  String get subscriptionPurchaseRestoreSuccess => 'Pembelian anda berjaya dipulihkan.';

  @override
  String get subscriptionTierScreenRestoreLabel => 'Pulihkan Pembelian';

  @override
  String get arabicLabel => 'Arab';

  @override
  String get transliterationLabel => 'Inggeris';

  @override
  String get surahSearchScreenTitle => 'Carian Surah';

  @override
  String get genericBack => 'Kembali';

  @override
  String get surahSearchSelectSurah => 'Pilih Surah:';

  @override
  String get surahSearchExistingPaths => 'Path Sedia Ada untuk Surah Ini';

  @override
  String get surahSearchNoMatches => 'Tiada path sedia ada ditemui.';

  @override
  String get surahSearchHideCreateForm => 'Sorokkan Borang Cipta';

  @override
  String get surahSearchShowCreateForm => 'Cipta Path Baharu untuk Surah';

  @override
  String get createPathTrackProgress => 'Jejak Perkembangan?';

  @override
  String get themeScreenSearchIconSemantic => 'Cari Surah';

  @override
  String get pathListSearchIconSemantic => 'Cari Surah';

  @override
  String get pathLessonsSearchIconSemantic => 'Cari Surah';

  @override
  String get playAllSurahSemantic => 'Mainkan seluruh surah';

  @override
  String get toggleTransliterationLabel => 'Togol transliterasi';

  @override
  String get englishLabel => 'Inggeris';

  @override
  String get subscriptionTierScreenPremiumPlusLabel => 'Sokong Kami (Tahunan)';

  @override
  String get subscriptionTierScreenFreeDescription => 'Semua ciri adalah percuma dan tiada iklan!';

  @override
  String get subscriptionTierScreenPremiumPlusDescription => 'Bantu membiayai ciri dan penambahbaikan baharu! Selain itu, pelaburan kecil boleh membantu anda membina tabiat!';

  @override
  String get subscriptionTierScreenSupportLabel => 'Sokongan Tahunan';

  @override
  String get verticalLessonIconsDialogBody => 'Semua ciri disediakan dalam versi percuma, tetapi jika anda mahu, anda boleh menyokong kami untuk membina lebih banyak ciri. Sebahagian daripada langganan anda akan didermakan kepada Islamic Relief. Jazāk Allāhu Khayran!';

  @override
  String get welcomeBody => 'Hudhud memainkan peranan istimewa dalam membantu Nabi Sulaiman [AS] dengan memerhati dan membawa mesej.\n\nDia tidak akan menilai anda di mana jua anda berada dalam perjalanan anda, dan teruja untuk membimbing anda menerokai keindahan Al-Quran serta menggabungkan peringatan kesyukuran bagi menghargai setiap detik bersamanya.';

  @override
  String get surahSearchByName => 'Cari berdasarkan nama (Inggeris atau Arab)';

  @override
  String get surahSearchHintAnyName => 'Taip mana-mana nama surah...';

  @override
  String get surahSearchFieldLabel => 'Cari Surah';

  @override
  String get surahSearchInvalidLessonsError => 'Satu atau lebih pelajaran tidak sah. Tidak dapat mencipta path.';

  @override
  String get surahSearchUserSurahPrefix => 'Surah Pengguna';

  @override
  String get notificationDailyBody => 'Luangkan sedikit masa untuk mencari ketenangan melalui Al-Quran dan ingatkan diri anda mengapa anda bersyukur hari ini.';
}
