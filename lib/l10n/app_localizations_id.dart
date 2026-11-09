import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get commentA => 'Kunci-kunci Onboarding';

  @override
  String get appBarTitleWelcome => 'Selamat Datang';

  @override
  String get skipLabel => 'Lewati';

  @override
  String get welcomeHeadline => 'Selamat Datang di Quran bersama Hudhud!';

  @override
  String get getStartedLabel => 'Mulai';

  @override
  String get commentB => 'Kunci-kunci layar Pelajaran';

  @override
  String get lessonScreenAppBarTitle => 'Pelajaran';

  @override
  String get noAyahAvailable => 'Tidak ada ayat yang tersedia untuk diputar.';

  @override
  String audioNotFound(Object url) {
    return 'Audio tidak ditemukan di $url';
  }

  @override
  String get restartLessonTitle => 'Mulai Ulang Pelajaran';

  @override
  String get resetLessonBody => 'Atur ulang semua kemajuan Anda untuk pelajaran ini?';

  @override
  String get cancelLabel => 'Batal';

  @override
  String get yesLabel => 'Ya';

  @override
  String get errorResettingLesson => 'Terjadi kesalahan saat mengatur ulang pelajaran';

  @override
  String get startLabel => 'Mulai';

  @override
  String get submitLabel => 'Kirim';

  @override
  String get nextLabel => 'Berikutnya';

  @override
  String get voiceErrorMicDeniedTitle => 'Mikrofon Ditolak';

  @override
  String get voiceErrorMicDeniedBody => 'Perekaman membutuhkan akses mikrofon. Silakan izinkan di Pengaturan.';

  @override
  String get voiceErrorMicDeniedSemanticLabel => 'Dialog izin mikrofon ditolak';

  @override
  String get voiceErrorRecorderStartTitle => 'Kesalahan Perekaman';

  @override
  String get voiceErrorRecorderStartBody => 'Kami tidak dapat memulai perekam. Silakan coba lagi.';

  @override
  String get voiceErrorRecorderStartSemanticLabel => 'Dialog kesalahan memulai perekam';

  @override
  String get voiceErrorRecorderStopTitle => 'Kesalahan Menghentikan Perekaman';

  @override
  String get voiceErrorRecorderStopBody => 'Kami tidak dapat menghentikan perekam dengan benar. Silakan coba lagi.';

  @override
  String get voiceErrorRecorderStopSemanticLabel => 'Dialog kesalahan menghentikan perekam';

  @override
  String get voiceErrorNoSoundTitle => 'Tidak Ada Suara Terdeteksi';

  @override
  String get voiceErrorNoSoundBody => 'Rekaman Anda hening atau terlalu pelan. Silakan coba lagi.';

  @override
  String get voiceErrorNoSoundSemanticLabel => 'Dialog tidak ada suara terdeteksi';

  @override
  String get voiceErrorTranscriptionTitle => 'Kesalahan Transkripsi';

  @override
  String get voiceErrorTranscriptionBody => 'Kami tidak dapat mentranskripsi rekaman Anda. Silakan periksa koneksi dan coba lagi.';

  @override
  String get voiceErrorTranscriptionSemanticLabel => 'Dialog kesalahan transkripsi';

  @override
  String get tapColoredWordsHint => 'Ketuk kata yang disorot untuk melihat versi yang dikoreksi.';

  @override
  String get emptyInputWarning => 'Anda harus memasukkan sesuatu sebelum mengirim';

  @override
  String get getHintLabel => 'Dapatkan Petunjuk';

  @override
  String get removeHintLabel => 'Hapus Petunjuk';

  @override
  String get typeTheMissingWordsLabel => 'Ketik kata yang hilang';

  @override
  String get difficultyLabel => 'Tingkat Kesulitan';

  @override
  String get repeatCountLabel => '# dari Pengulangan';

  @override
  String get backButtonLabel => 'Kembali';

  @override
  String get toggleTranslationLabel => 'Tampilkan/sembunyikan terjemahan inline';

  @override
  String get openTranslationScreenLabel => 'Buka layar terjemahan';

  @override
  String get restartLessonSemanticLabel => 'Mulai ulang pelajaran';

  @override
  String get verseDisplayAreaLabel => 'Area tampilan ayat Al-Qur’an';

  @override
  String get playAudioSemanticLabel => 'Putar audio ayat';

  @override
  String get openGratitudeSemanticLabel => 'Buka modal syukur';

  @override
  String get voiceUsageSemanticLabel => 'Pemakaian suara dalam menit';

  @override
  String get voiceRecordSemanticLabel => 'Mulai atau hentikan perekaman suara';

  @override
  String get commentC => 'String layar HOME baru';

  @override
  String get homeTitle => 'Beranda';

  @override
  String get noPathsLabel => 'Tidak ada jalur yang valid.';

  @override
  String errorLoadingActivePath(Object err) {
    return 'Kesalahan memuat jalur aktif: $err';
  }

  @override
  String get verticalLessonIconsGoToTheme => 'Pergi ke Tema';

  @override
  String get homePathCardLabel => 'Ketuk untuk membuka layar tema';

  @override
  String get arrowForwardSemanticLabel => 'Buka detail';

  @override
  String get noTrackProgressLabel => 'Jalur ini tidak merekam progres.';

  @override
  String get premiumRequiredLabel => 'Tingkatkan untuk membuka fitur pencatatan progres. Bantu kami membuat lebih banyak fitur!';

  @override
  String get completedLabel => 'selesai';

  @override
  String get fabLogGratitudeLabel => 'Ketuk untuk mencatat rasa syukur';

  @override
  String get errorNavigatingToLesson => 'Kesalahan saat menuju ke pelajaran';

  @override
  String get commentD => 'String layar Profil';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileBackArrowLabel => 'Kembali ke layar sebelumnya';

  @override
  String get profileAvatarSemanticLabel => 'Avatar pengguna';

  @override
  String get profileEnterYourName => 'Masukkan nama Anda';

  @override
  String get nameEntryNotificationFrequencyDropdownLabel => 'Frekuensi Notifikasi';

  @override
  String get nameEntryNotificationFrequencyWeekly => 'Mingguan';

  @override
  String get nameEntryNotificationFrequencyNone => 'Tidak ada';

  @override
  String get notificationPermissionPrompt => 'Kami ingin mengirim pengingat lembut untuk menyelesaikan catatan syukur atau pelajaran Anda - mohon izinkan notifikasi jika Anda ingin kami membantu membangun kebiasaan 😃.';

  @override
  String get profileNameSave => 'Simpan';

  @override
  String get profileNameCancel => 'Batal';

  @override
  String get profileNameGuest => 'Tamu';

  @override
  String get profileNameEdit => 'Ubah';

  @override
  String get profilePreferredLanguage => 'Bahasa:';

  @override
  String get okLabel => 'OK';

  @override
  String get profileReciterLabel => 'Qari';

  @override
  String get profileFontLabel => 'Font:';

  @override
  String get profileReciterMishary => 'Mishary Rashid Al-Afasy';

  @override
  String get profileReciterShatri => 'Abu Bakr Al-Shatri';

  @override
  String get profileReciterQatami => 'Nasser Al Qatami';

  @override
  String get profileUpgradePremiumTitle => 'Buka Lebih Banyak Personalisasi!';

  @override
  String get profileUpgradePremiumBody => 'Anda dapat menikmati perubahan font dan qari dengan upgrade ke Pro. Dukung upaya berkelanjutan kami dan sesuaikan pengalaman Anda lebih lanjut!';

  @override
  String get profileWeeksProgress => 'MasyaAllah, ini progres Anda selama seminggu:';

  @override
  String get profileGratefulnessCalendar => 'Kalender Kesyukuran';

  @override
  String get profileQuranLearningCalendar => 'Kalender Belajar Quran';

  @override
  String get profilePrevWeekSemantic => 'Pergi ke minggu sebelumnya';

  @override
  String get profileNextWeekSemantic => 'Pergi ke minggu berikutnya';

  @override
  String get profileNotificationFrequency => 'Frekuensi Notifikasi';

  @override
  String get commentE => 'String Layar Log Syukur';

  @override
  String get gratitudeLogTitle => 'Catatan Syukur Saya';

  @override
  String get gratitudeLogBackArrowSemantic => 'Kembali ke beranda';

  @override
  String get gratitudeLogClearAllSemantic => 'Hapus semua entri syukur';

  @override
  String get gratitudeLogAddSemantic => 'Tambah entri syukur baru';

  @override
  String get gratitudeLogClearDialogTitle => 'Hapus Catatan Syukur';

  @override
  String get gratitudeLogClearDialogBody => 'Apakah Anda yakin ingin menghapus semua entri syukur? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get gratitudeLogClearConfirm => 'Ya, Hapus';

  @override
  String gratitudeLogStreak(Object days) {
    return '⭐ Rangkaian Syukur: $days hari';
  }

  @override
  String get gratitudeLogStreakLoading => 'Menghitung rangkaian...';

  @override
  String get gratitudeLogStreakError => 'Gagal menghitung rangkaian.';

  @override
  String gratitudeLogTotalDays(Object count) {
    return 'Total Hari Syukur: $count';
  }

  @override
  String get gratitudeLogDataLoading => 'Memuat data syukur...';

  @override
  String get gratitudeLogDataError => 'Gagal memuat data syukur.';

  @override
  String get gratitudeLogCardSemantic => 'Kartu entri syukur';

  @override
  String get gratitudeLogItemIcon => 'Ikon syukur';

  @override
  String get gratitudeLogEmptyIconSemantic => 'Ketuk untuk menambahkan syukur pertama Anda';

  @override
  String get gratitudeLogEmptyMessage => 'Belum ada entri syukur.\nKetuk “+” untuk menambahkan syukur pertama Anda!';

  @override
  String get gratitudeLogEntriesAdded => 'Syukur berhasil ditambahkan!';

  @override
  String get gratitudeLogEntriesFailed => 'Gagal menambahkan syukur. Silakan coba lagi.';

  @override
  String get commentF => 'String Layar Penyelesaian Pelajaran';

  @override
  String get lessonCompletedTitle => 'Pelajaran Selesai';

  @override
  String get lessonCompletedBackArrowSemantic => 'Kembali ke beranda';

  @override
  String get lessonCompletedMashaAllah => 'MashaAllah!';

  @override
  String get lessonCompletedMashaAllahSemantic => 'Teks selamat';

  @override
  String get lessonCompletedMessage => 'Anda telah menyelesaikan pelajaran ini!';

  @override
  String get lessonCompletedImageSemantic => 'Ilustrasi Hudhud Quran';

  @override
  String get lessonCompletedGoBackSemantic => 'Kembali ke pemilihan jalur';

  @override
  String get lessonCompletedGoBackButton => 'Kembali ke Jalur';

  @override
  String get lessonCompletedRestartSemantic => 'Mulai ulang pelajaran';

  @override
  String get lessonCompletedRestartButton => 'Mulai Ulang Pelajaran';

  @override
  String get lessonCompletedEncouragement => 'Pertahankan kerja bagusmu!';

  @override
  String get commentG => 'String Layar Tema';

  @override
  String get themeScreenTitle => 'Tema';

  @override
  String get themeNameCoreRecitation => 'Tilawah Harian Inti';

  @override
  String get themeNameBeginJourney => 'Memulai Perjalanan';

  @override
  String get themeNameMercyAndHope => 'Rahmat dan Harapan';

  @override
  String get themeNameGratitudeReflection => 'Syukur dan Renungan';

  @override
  String get themeNameStoriesReminders => 'Kisah, Pelajaran, dan Peringatan';

  @override
  String get themeNamePatience => 'Kesabaran (Ṣabr)';

  @override
  String get themeNameUserCreated => 'Dibuat Pengguna';

  @override
  String get themeScreenNoThemesLabel => 'Tidak Ada Tema Tersedia';

  @override
  String get themeScreenBackArrowSemantic => 'Kembali';

  @override
  String get themeScreenThemeCardSemantic => 'Ketuk untuk membuka jalur tema';

  @override
  String get themeScreenLockIconSemantic => 'Tema terkunci. Membutuhkan upgrade.';

  @override
  String get pathListExploreOtherThemes => 'Jelajahi Tema Lain';

  @override
  String get themeScreenUserCreatedSubtitle => 'Dibuat oleh Anda—personalisasi sesuka Anda.';

  @override
  String get themeSubtitleCoreRecitation => 'Surah penting untuk shalat harian dan perlindungan.';

  @override
  String get themeSubtitleBeginJourney => 'Surah-surah pendek untuk memulai perjalanan Quran Anda.';

  @override
  String get themeSubtitleMercyAndHope => 'Renungkan kasih sayang Allah dan tumbuhkan harapan.';

  @override
  String get themeSubtitleGratitudeReflection => 'Kembangkan rasa syukur dan perenungan melalui ayat-ayat pilihan.';

  @override
  String get themeSubtitleStoriesReminders => 'Jelajahi narasi Al-Qur\'an yang membimbing dan mengingatkan.';

  @override
  String get themeSubtitlePatience => 'Surah dan ayat yang menekankan kesabaran dan ketabahan.';

  @override
  String get themeSubtitleDefault => 'Kumpulan surah khusus untuk pertumbuhan spiritual yang lebih mendalam.';

  @override
  String get themeScreenRequiredPremium => 'Membutuhkan Premium';

  @override
  String get themeScreenRequiredPremiumPlus => 'Membutuhkan Premium Plus';

  @override
  String get commentH => 'String Layar Daftar Jalur (Path List)';

  @override
  String get pathListScreenTitle => 'Jalur untuk Tema';

  @override
  String get pathListScreenBackArrowSemantic => 'Kembali';

  @override
  String get pathListScreenAddIconSemantic => 'Tambah jalur baru';

  @override
  String get pathListAddNewPathTooltip => 'Tambah Jalur Baru';

  @override
  String get pathListScreenAddIconSemanticEmpty => 'Ketuk untuk menambahkan jalur pertama Anda';

  @override
  String get pathListEmptyMessage => 'Belum ada jalur.\nKetuk “+” untuk membuat jalur pertama Anda!';

  @override
  String get pathListUnavailableLabel => 'Jalur ini saat ini tidak tersedia';

  @override
  String get pathListThemeLabel => 'Tema';

  @override
  String get pathListPathCardSemantic => 'Ketuk untuk membuka detail jalur';

  @override
  String get pathListCompleteIconSemantic => 'Jalur selesai';

  @override
  String get pathListInProgressIconSemantic => 'Jalur dalam progres';

  @override
  String get pathListInvalidIconSemantic => 'Jalur tidak valid atau tidak tersedia';

  @override
  String get pathListErrorLoadingPaths => 'Kesalahan memuat jalur:';

  @override
  String get commentI => 'String Layar Detail Jalur (Path Detail)';

  @override
  String get pathDetailScreenTitle => 'Detail Jalur';

  @override
  String get pathDetailScreenBackArrowSemantic => 'Kembali ke daftar jalur';

  @override
  String get pathDetailScreenNotFound => 'Jalur tidak ditemukan.';

  @override
  String get pathDetailScreenFailToUpdate => 'Gagal memperbarui progres jalur:';

  @override
  String get pathDetailScreenProgressDisabled => 'Progres dinonaktifkan untuk jalur ini.';

  @override
  String get pathDetailScreenLessonsHeading => 'Pelajaran:';

  @override
  String get pathDetailScreenNoLessonsLabel => 'Tidak ada pelajaran yang tersedia.';

  @override
  String get pathDetailScreenErrorLoading => 'Kesalahan memuat jalur atau pelajaran:';

  @override
  String get pathDetailScreenLessonCardSemantic => 'Ketuk untuk membuka detail pelajaran';

  @override
  String get pathDetailScreenLessonCompleteIconSemantic => 'Pelajaran selesai';

  @override
  String get pathDetailScreenLessonInProgressIconSemantic => 'Pelajaran dalam progres';

  @override
  String get pathDetailScreenLessonInvalidIconSemantic => 'Pelajaran tidak valid atau tidak tersedia';

  @override
  String get pathDetailScreenLessonProgressUnavailable => 'Progres tidak tersedia';

  @override
  String get pathDetailScreenLessonNoProgress => 'Tidak ada progres untuk jalur ini';

  @override
  String get pathDetailScreenLessonUpgrade => 'Tingkatkan untuk fitur progres.';

  @override
  String pathDetailScreenLessonProgressLabel(Object progress) {
    return 'Progres: $progress%';
  }

  @override
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah) {
    return 'Pelajaran $lessonIndex: $surahName - Ayat $startAyah-$endAyah';
  }

  @override
  String get commentJ => 'String Layar Buat Jalur (Create Path)';

  @override
  String get createPathTitle => 'Buat Jalur Baru';

  @override
  String get createPathBackArrowSemantic => 'Kembali ke layar sebelumnya';

  @override
  String get createPathNameLabel => 'Nama Jalur';

  @override
  String get createPathNameValidation => 'Masukkan nama jalur';

  @override
  String get createPathDescriptionLabel => 'Deskripsi';

  @override
  String get createPathDescriptionValidation => 'Masukkan deskripsi';

  @override
  String get createPathSurahSelectorLabel => 'Pilih Surah:';

  @override
  String get createPathStartAyahLabel => 'Ayat Mulai';

  @override
  String get createPathNumAyahsLabel => 'Jumlah Ayat dalam Jalur';

  @override
  String get createPathEndAyahLabel => 'Ayat Akhir';

  @override
  String get createPathWordsPerLessonLabel => 'Jumlah Kata per Pelajaran';

  @override
  String get createPathWordsSuffix => 'kata';

  @override
  String get createPathInvalidRange => 'Rentang tidak valid';

  @override
  String get createPathAyahsSuffix => 'Ayat';

  @override
  String get createPathCreateButton => 'Buat Jalur';

  @override
  String get createPathSubmitSemantic => 'Ketuk untuk membuat jalur';

  @override
  String get commentK => 'String Layar Terjemahan (Translation Screen)';

  @override
  String get translationScreenTitle => 'Terjemahan';

  @override
  String get translationScreenBackArrowSemantic => 'Kembali ke pelajaran';

  @override
  String get translationScreenLoadingSemantic => 'Memuat terjemahan';

  @override
  String get translationScreenNoTranslations => 'Tidak ada terjemahan yang tersedia.';

  @override
  String get translationScreenReturnButton => 'Kembali ke Pelajaran';

  @override
  String get translationScreenReturnSemantic => 'Ketuk untuk kembali ke pelajaran';

  @override
  String get translationScreenLoadError => 'Kesalahan memuat terjemahan:';

  @override
  String get commentL => 'String Layar Pilihan Bahasa (Language Selection)';

  @override
  String get languageSelectionScreenSemantic => 'Layar Pemilihan Bahasa';

  @override
  String get languageSelectionTitle => 'Pilih Bahasa Anda';

  @override
  String get languageSelectionBackSemantic => 'Kembali';

  @override
  String get languageSelectionSkipSemantic => 'Lewati pemilihan';

  @override
  String get languageSelectionInstructions => 'Silakan pilih bahasa yang Anda inginkan:';

  @override
  String get languageSelectionNextSemantic => 'Ketuk untuk mengonfirmasi pilihan bahasa';

  @override
  String get languageSelectionNextLabel => 'Berikutnya';

  @override
  String get languageSelectionImageSemantic => 'Ilustrasi Hudhud Quran';

  @override
  String get commentM => 'String Layar Sambutan (Welcome Screen)';

  @override
  String get welcomeScreenSemantic => 'Layar Sambutan Onboarding';

  @override
  String get welcomeScreenLogoSemantic => 'Ilustrasi Hudhud Quran';

  @override
  String get welcomeScreenSkipSemantic => 'Lewati langkah sambutan';

  @override
  String get welcomeScreenNextSemantic => 'Lanjutkan ke langkah onboarding berikutnya';

  @override
  String get commentN => 'String Layar Info Hudhud (Hudhud Info)';

  @override
  String get hudhudInfoSemantic => 'Layar Informasi Hudhud';

  @override
  String get hudhudInfoAppBarTitle => 'Temui Hudhud';

  @override
  String get hudhudInfoIllustrationSemantic => 'Ilustrasi Hudhud';

  @override
  String get hudhudInfoBody1 => 'Hudhud, juga dikenal sebagai burung hoopoe, memiliki peran istimewa dalam membantu Nabi Sulaiman [AS] dengan mengamati dan membawa pesan.';

  @override
  String get hudhudInfoBody2 => 'Kisah Hudhud mengingatkan kita bahwa bahkan makhluk kecil pun dapat membawa dampak besar dengan bersikap waspada, ingin tahu, dan proaktif terhadap hal yang benar. Dalam perjalanan kita, kita dapat memberikan perhatian yang konsisten pada keindahan Al-Qur\'an, dan mengintegrasikan pengingat syukur untuk menghargai setiap momen kemajuan.';

  @override
  String get hudhudInfoBody3 => 'Dengan mengikuti teladan Hudhud—tetap waspada dan terlibat—kami berharap dapat memperdalam koneksi kita dengan Al-Qur\'an dan menumbuhkan rasa syukur dalam kehidupan sehari-hari.';

  @override
  String get hudhudInfoNextLabel => 'Berikutnya';

  @override
  String get hudhudInfoNextSemantic => 'Lanjut ke bagian berikutnya';

  @override
  String get hudhudInfoSkipSemantic => 'Lewati langkah info Hudhud';

  @override
  String get commentO => 'String Layar Pilihan Tingkat Langganan (Subscription Tier)';

  @override
  String get subscriptionTierScreenSemantic => 'Layar Pemilihan Tingkat Langganan';

  @override
  String get subscriptionTierScreenAppBarTitle => 'Pilih Paket Anda';

  @override
  String get subscriptionTierScreenSkipSemantic => 'Lewati pemilihan tingkat langganan';

  @override
  String get subscriptionTierScreenFreeLabel => 'Gratis';

  @override
  String get subscriptionTierScreenSmileySemantic => 'Ikon wajah tersenyum';

  @override
  String get subscriptionTierScreenDonationText => 'Sebagian dana akan disalurkan ke Almubtasim Initiative, membantu anak yatim melalui Islamic Relief.';

  @override
  String get subscriptionTierScreenConfirmSemantic => 'Konfirmasi pemilihan tingkat langganan';

  @override
  String get subscriptionTierScreenNextLabel => 'Berikutnya';

  @override
  String subscriptionTierScreenRadioSemantic(Object title) {
    return 'Ketuk untuk memilih tier langganan $title';
  }

  @override
  String get commentP => 'String Layar Pilihan Tujuan (Goal Selection)';

  @override
  String get goalSelectionScreenSemantic => 'Layar Pemilihan Tujuan';

  @override
  String get goalSelectionScreenAppBarTitle => 'Pilih Tujuan Anda';

  @override
  String get goalSelectionScreenSkipSemantic => 'Lewati pemilihan tujuan';

  @override
  String get goalSelectionScreenIntroText => 'Tujuan mana di bawah ini yang menarik bagi Anda? Anda dapat memilih beberapa opsi.';

  @override
  String get goalSelectionScreenNextSemantic => 'Konfirmasi pemilihan tujuan';

  @override
  String get goalSelectionScreenNextLabel => 'Berikutnya';

  @override
  String goalSelectionTileSemantic(Object goalTitle) {
    return 'Ketuk untuk memilih atau membatalkan pilihan tujuan $goalTitle';
  }

  @override
  String get goalConnectQuranTitle => 'Menjalin hubungan lebih jauh dengan Al-Qur\'an';

  @override
  String get goalConnectQuranDesc => 'Perkuat hubungan Anda melalui membaca atau refleksi.';

  @override
  String get goalMemorizeQuranTitle => 'Menghafal Al-Qur\'an';

  @override
  String get goalMemorizeQuranDesc => 'Mulailah perjalanan hafalan.';

  @override
  String get goalBeMoreGratefulTitle => 'Lebih bersyukur dan bahagia dalam hidup';

  @override
  String get goalBeMoreGratefulDesc => 'Fokus pada praktik syukur sehari-hari.';

  @override
  String get goalBuildConsistencyTitle => 'Bangun konsistensi';

  @override
  String get goalBuildConsistencyDesc => 'Kembangkan kebiasaan harian atau mingguan.';

  @override
  String get goalImproveArabicTitle => 'Tingkatkan bahasa Arab saya';

  @override
  String get goalImproveArabicDesc => 'Fokus pada kemampuan menulis atau berbicara bahasa Arab.';

  @override
  String get goalDeepenTafsirTitle => 'Perdalam Tafsir';

  @override
  String get goalDeepenTafsirDesc => 'Pelajari tafsir dan pemahaman yang lebih mendalam tentang Al-Qur\'an.';

  @override
  String get goalOtherTitle => 'Lainnya';

  @override
  String get goalOtherDesc => 'Kejarlah tujuan pribadi lainnya.';

  @override
  String get commentQ => 'String Layar Pilihan Level (Level Selection)';

  @override
  String get levelSelectionScreenSemantic => 'Layar Pemilihan Level';

  @override
  String get levelSelectionScreenAppBarTitle => 'Pilih Level Anda';

  @override
  String get levelSelectionScreenSkipSemantic => 'Lewati pemilihan level';

  @override
  String get levelSelectionScreenIntroText => 'Silakan pilih opsi yang paling menggambarkan tingkat tilawah Anda saat ini:';

  @override
  String get levelStarterLabel => 'Pemula';

  @override
  String get levelStarterDescription => 'Pembelajar baru atau kasual, mulai menjelajahi tilawah Al-Qur\'an.';

  @override
  String get levelAdvancedLabel => 'Lanjutan';

  @override
  String get levelAdvancedDescription => 'Nyaman membaca tulisan Arab dengan pengetahuan tajwid tertentu.';

  @override
  String get levelQariLabel => 'Qari';

  @override
  String get levelQariDescription => 'Terampil dalam tilawah dengan penguasaan tajwid yang kuat.';

  @override
  String get levelSelectionNextSemantic => 'Konfirmasi pemilihan level';

  @override
  String get levelSelectionNextLabel => 'Berikutnya';

  @override
  String levelSelectionTileSemantic(Object levelTitle) {
    return 'Ketuk untuk memilih opsi level tilawah $levelTitle';
  }

  @override
  String get commentR => 'String Layar Penyelesaian Onboarding';

  @override
  String get onboardingCompletionScreenSemantic => 'Layar Penyelesaian Onboarding';

  @override
  String get onboardingCompletionScreenAppBarTitle => 'Semua Siap!';

  @override
  String get onboardingCompletionScreenImageSemantic => 'Ilustrasi Hudhud Quran';

  @override
  String get onboardingCompletionScreenBody1 => 'Selamat! Anda telah berhasil menyelesaikan pengaturan. Kami harap perjalanan ini akan mendekatkan Anda pada Al-Qur\'an dan meningkatkan rasa syukur Anda kepada Allah.\n\nSemoga aplikasi ini menjadi sumber pertumbuhan dan berkah dalam hidup Anda serta orang-orang di sekitar Anda.';

  @override
  String get onboardingCompletionScreenBody2 => 'Kapan pun Anda siap, ketuk tombol di bawah untuk melanjutkan. Fitur utama hafalan dan progres sudah menunggu, dan Anda dapat mencatat syukur atau memilih jalur dari Navbar.';

  @override
  String get onboardingCompletionScreenBody3 => 'Ini adalah versi awal — kami menghargai dukungan dan kesabaran Anda, dan semoga segera menambahkan lebih banyak fitur insya Allah!';

  @override
  String get onboardingCompletionScreenBeginSemantic => 'Mulai menggunakan aplikasi';

  @override
  String get onboardingCompletionScreenBeginLabel => 'Mari Mulai';

  @override
  String get commentS => 'String Layar Entri Nama (Name Entry)';

  @override
  String get nameEntryScreenSemantic => 'Layar Entri Nama';

  @override
  String get nameEntryScreenAppBarTitle => 'Profil Anda';

  @override
  String get nameEntryScreenSkipSemantic => 'Lewati memasukkan nama';

  @override
  String get nameEntryScreenIntroText => 'Siapa nama Anda?';

  @override
  String get nameEntryTextFieldSemantic => 'Kolom teks masukan nama';

  @override
  String get nameEntryNextSemantic => 'Konfirmasi entri nama';

  @override
  String get nameEntryNextLabel => 'Berikutnya';

  @override
  String get commentT => 'String VerticalLessonIcons';

  @override
  String get verticalLessonIconsSemantic => 'Container Ikon Pelajaran Vertikal';

  @override
  String get verticalLessonIconsNoLessons => 'Tidak ada pelajaran yang ditemukan.';

  @override
  String get verticalLessonIconsLoadingSurah => 'Memuat detail Surah';

  @override
  String get verticalLessonIconsErrorSurah => 'Kesalahan memuat detail surah';

  @override
  String get verticalLessonIconsSurahHeaderSemantic => 'Header detail Surah';

  @override
  String get verticalLessonIconsHudhudIconSemantic => 'Ikon asisten Hudhud';

  @override
  String get verticalLessonIconsNextPageSemantic => 'Panah halaman berikutnya';

  @override
  String get verticalLessonIconsPreviousPageSemantic => 'Panah halaman sebelumnya';

  @override
  String get verticalLessonIconsLoadingProgress => 'Memuat progres pelajaran';

  @override
  String get verticalLessonIconsErrorProgress => 'Kesalahan memuat progres';

  @override
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent) {
    return 'Ikon pelajaran, $surahAyahRange, progres $percent%';
  }

  @override
  String get verticalLessonIconsCompletedSemantic => 'Pelajaran selesai';

  @override
  String get verticalLessonIconsDialogTitle => 'Dukungan & Upgrade';

  @override
  String get verticalLessonIconsDialogOk => 'OK';

  @override
  String get commentU => 'String Navbar';

  @override
  String get navBarSemanticLabel => 'Bilah navigasi bawah';

  @override
  String get navHomeLabel => 'Beranda';

  @override
  String get navHomeSemantic => 'Tab Beranda';

  @override
  String get navQuranLabel => 'Qur\'an';

  @override
  String get navQuranSemantic => 'Tab Quran';

  @override
  String get navGratitudeLabel => 'Syukur';

  @override
  String get navGratitudeSemantic => 'Tab Syukur';

  @override
  String get navProfileLabel => 'Profil';

  @override
  String get navProfileSemantic => 'Tab Profil';

  @override
  String get commentV => 'String TopBar';

  @override
  String get topBarSemanticLabel => 'Bilah navigasi atas';

  @override
  String topBarTitleSemantic(Object title) {
    return 'Judul bilah atas: $title';
  }

  @override
  String topBarStreakIconSemantic(Object days) {
    return 'Ikon rangkaian: $days hari';
  }

  @override
  String get topBarStreakDialogBody => 'Ini menunjukkan berapa hari berturut-turut Anda telah membaca atau menulis syukur. Pertahankan agar rangkaian Anda tetap atau bertambah!';

  @override
  String get topBarHudhudIconSemantic => 'Ikon Hudhud, ketuk untuk dukungan';

  @override
  String get topBarHudhudDialogTitle => 'Dukungan & Upgrade';

  @override
  String get topBarHudhudDialogBody => 'Semua fitur tersedia dalam versi gratis, tetapi jika Anda berkenan, Anda dapat mendukung kami untuk membangun lebih banyak fitur. Sebagian dari langganan Anda didonasikan ke Islamic Relief. Jazāk Allāhu Khayran!';

  @override
  String get commentW => 'String Gratitude Modal';

  @override
  String get gratitudeModalSemantic => 'Dialog Modal Syukur';

  @override
  String get gratitudeModalTitle => 'Berdasarkan ayat-ayat ini, apa yang Anda syukuri hari ini?';

  @override
  String gratitudeModalHint(Object index) {
    return 'Alhamdulillah untuk (masukkan syukur) #$index';
  }

  @override
  String gratitudeModalTextFieldSemantic(Object index) {
    return 'Masukkan syukur #$index';
  }

  @override
  String get gratitudeModalEmptyWarning => 'Harap masukkan setidaknya satu syukur.';

  @override
  String get gratitudeModalSubmitError => 'Gagal mencatat syukur. Silakan coba lagi.';

  @override
  String get dailyVoiceLimitReachedTitle => 'MashaAllah!';

  @override
  String get dailyVoiceLimitReachedMessage => 'Anda telah menyelesaikan 10 menit resitasi suara Al-Qur\'an. Silakan lanjutkan dengan menulis, dan lanjutkan membaca besok.';

  @override
  String get upgradeVoiceUsageTitle => 'Tingkatkan ke Premium';

  @override
  String get gratitudeModalLoadingSemantic => 'Pengiriman syukur sedang diproses';

  @override
  String get commentX => '== KUNCI BARU untuk submission_feedback_modal, progress_bar, surah_selector ==';

  @override
  String get submissionFeedbackModalSemanticLabel => 'Dialog umpan balik pengiriman';

  @override
  String get submissionFeedbackModalTitle => 'Umpan Balik Pengiriman';

  @override
  String get submissionFeedbackModalNoNew => 'Tidak ada syukur baru yang dikirim.';

  @override
  String get submissionFeedbackModalYouSubmitted => 'Anda telah mengirim syukur berikut:';

  @override
  String submissionFeedbackModalStreak(Object days) {
    return 'Rangkaian syukur saat ini: $days hari';
  }

  @override
  String submissionFeedbackModalTotalDays(Object count) {
    return 'Total hari syukur: $count';
  }

  @override
  String get submissionFeedbackModalLoading => 'Memuat data syukur Anda...';

  @override
  String get submissionFeedbackModalError => 'Tidak dapat memuat data syukur.';

  @override
  String get submissionFeedbackModalViewLog => 'Lihat Log';

  @override
  String get submissionFeedbackModalClose => 'Tutup';

  @override
  String progressBarSemanticLabel(Object percent) {
    return 'Progres: $percent%';
  }

  @override
  String get surahSelectorSemanticLabel => 'Pilih sebuah Surah';

  @override
  String get commentZ => 'Nama Jalur & Deskripsi yang dapat dilokalkan untuk jalur bawaan sistem';

  @override
  String get pathNameFatihah => 'Surah Al-Fātiḥah';

  @override
  String get pathDescFatihah => 'Keseluruhan Surah (1:1–7). Esensial untuk setiap rakaat.';

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
  String get pathDescFalaq => 'Keseluruhan Surah (113:1–5). Memohon perlindungan dari kejahatan luar.';

  @override
  String get pathNameNas => 'Surah An-Nās';

  @override
  String get pathDescNas => 'Keseluruhan Surah (114:1–6). Memohon perlindungan dari bisikan batin.';

  @override
  String get pathNameAsrBegin => 'Surah Al-ʿAṣr';

  @override
  String get pathDescAsrBegin => '(103:1–3). Hanya 3 ayat namun penting tentang \'kesabaran\'.';

  @override
  String get pathNameTakathur => 'Surah At-Takāthur';

  @override
  String get pathDescTakathur => '(102:1–8) tentang persaingan duniawi dan pertanggungjawaban.';

  @override
  String get pathNameFil => 'Surah Al-Fīl';

  @override
  String get pathDescFil => '(105:1–5). Kisah pasukan bergajah; hanya 5 ayat pendek.';

  @override
  String get pathNameQuraysh => 'Surah Quraysh';

  @override
  String get pathDescQuraysh => '(106:1–4). Tentang syukur atas perjalanan yang aman.';

  @override
  String get pathNameRahmanA => 'Ar-Raḥmān A';

  @override
  String get pathDescRahmanA => '(55:1–13): Pengajaran Al-Qur\'an & penciptaan manusia.';

  @override
  String get pathNameRahmanB => 'Ar-Raḥmān B';

  @override
  String get pathDescRahmanB => '(55:26–36): Pertanggungjawaban manusia & jin.';

  @override
  String get pathNameYasinBlock => 'Surah Yā Sīn (Bagian)';

  @override
  String get pathDescYasinBlock => '(36:1–12). Pendahuluan tentang risalah Nabi & peringatan.';

  @override
  String get pathNameMulkBlock => 'Surah Al-Mulk (Bagian)';

  @override
  String get pathDescMulkBlock => '(67:1–15). Menekankan kekuasaan Allah & perenungan.';

  @override
  String get pathNameBaqarah21_29 => 'Al-Baqarah (2:21–29)';

  @override
  String get pathDescBaqarah21_29 => '9 ayat tentang penciptaan & refleksi untuk bersyukur.';

  @override
  String get pathNameNahl66_72 => 'An-Naḥl (16:66–72)';

  @override
  String get pathDescNahl66_72 => '7 ayat yang merinci nikmat: ternak, buah-buahan, dll.';

  @override
  String get pathNameAdDuha => 'Surah Aḍ-Ḍuḥā';

  @override
  String get pathDescAdDuha => '(93:1–11) 11 ayat yang membawa harapan & kepastian.';

  @override
  String get pathNameKahfCave => 'Al-Kahf: Pemuda di Gua';

  @override
  String get pathDescKahfCave => '(18:9–16) Kisah para pemuda beriman di dalam gua.';

  @override
  String get pathNameKahfMusa => 'Al-Kahf: Mūsā & Al-Khiḍr';

  @override
  String get pathDescKahfMusa => '(18:60–70) Menekankan kesabaran & hikmah tersembunyi.';

  @override
  String get pathNameWaqiah => 'Al-Wāqiʿah (56:1–15)';

  @override
  String get pathDescWaqiah => '15 ayat tentang datangnya Kiamat secara tiba-tiba.';

  @override
  String get pathNameAsrPatience => 'Surah Al-ʿAṣr (Kesabaran)';

  @override
  String get pathDescAsrPatience => '(103:1–3) sekali lagi, 3 ayat yang terkenal tentang kesabaran.';

  @override
  String get pathNameBaq153_157 => 'Al-Baqarah (2:153–157)';

  @override
  String get pathDescBaq153_157 => '5 ayat: “Mintalah pertolongan dengan sabar & shalat.”';

  @override
  String get pathNameYusuf7_14 => 'Sūrah Yūsuf (12:7–14)';

  @override
  String get pathDescYusuf7_14 => 'Kecemburuan saudara-saudara Yusuf. Ujian kesabaran.';

  @override
  String get pathNameYusuf83_92 => 'Sūrah Yūsuf (12:83–92)';

  @override
  String get pathDescYusuf83_92 => 'Kesedihan Yaʿqūb & pemaafan Yusuf (10 ayat).';

  @override
  String get pathNameInshirah => 'Surah Al-Inshirāḥ (94:1–8)';

  @override
  String get pathDescInshirah => '8 ayat: peneguhan setelah kesulitan. Terkait dengan kesabaran & harapan.';

  @override
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah) {
    return 'Surah $surahName, Ayat $startAyah-$endAyah';
  }

  @override
  String get finishLabel => 'Selesai';

  @override
  String get twoWordMultipleChoiceLabel => 'Pilih dua kata yang benar';

  @override
  String get singleWordMultipleChoiceLabel => 'Pilih kata yang benar';

  @override
  String get correctAnswerLabel => 'Benar!';

  @override
  String get incorrectAnswerLabel => 'Salah!';

  @override
  String get lessonCompletedLabel => 'Pelajaran selesai!';

  @override
  String get profileAnalyticsScoreLabel => 'Analitik & Skor';

  @override
  String get profileDailyLabel => 'Harian';

  @override
  String get profileWeeklyLabel => 'Mingguan';

  @override
  String get profileMonthlyLabel => 'Bulanan';

  @override
  String get profileTotalLabel => 'Total';

  @override
  String get profileViewChart => 'Lihat grafik';

  @override
  String get profileCloseLabel => 'Tutup';

  @override
  String get profileScoreChartTitle => 'Grafik Skor';

  @override
  String get profileScoreChartHistory => 'Riwayat';

  @override
  String get profileNoData => 'Tidak ada data';

  @override
  String get topBarDailyScoreLabel => '⭐ Hari Ini';

  @override
  String topBarDailyScoreSemantic(Object score) {
    return 'Skor harian Anda adalah $score';
  }

  @override
  String get profilePremiumNeeded => 'Silakan tingkatkan untuk melihat kalender kemajuan dan dukung kami dalam membangun lebih banyak fitur, insya Allah!';

  @override
  String get levelMultipleChoiceLabel => 'Pilihan Ganda';

  @override
  String get levelMultipleChoiceDescription => 'Langkah pilihan ganda satu kata atau dua kata dengan opsi melewati pasangan.';

  @override
  String get levelBeginnerLabel => 'Pemula';

  @override
  String get levelBeginnerDescription => 'Penghapusan kata secara bertahap dalam urutan berkelompok untuk membantu menghafal secara bertahap.';

  @override
  String get subscriptionTierScreenPremiumLabel => 'Plus';

  @override
  String get featureUnavailableOffline => 'Fitur tidak tersedia saat offline. Hubungkan atau buka mode offline dengan meningkatkan ke Plus atau Pro Beta.';

  @override
  String submissionFeedbackModalTotalCount(Object count) {
    return 'Jumlah total ucapan terima kasih yang dimasukkan: $count';
  }

  @override
  String get notificationDailyTitle => 'Pengingat Quran Harian yang Lembut';

  @override
  String get notificationWeeklyTitle => 'Pemeriksaan Mingguan Quran';

  @override
  String get notificationWeeklyBody => 'Renungkan progres Anda dan hafalkan bagian baru dari Quran sambil tetap bersyukur.';

  @override
  String get notificationChannelDailyRemindersName => 'Pengingat Harian';

  @override
  String get notificationChannelDailyRemindersDesc => 'Pengingat untuk hafalan harian Quran';

  @override
  String get notificationChannelWeeklyRemindersName => 'Pengingat Mingguan';

  @override
  String get notificationChannelWeeklyRemindersDesc => 'Pengingat untuk pemeriksaan hafalan Quran mingguan';

  @override
  String get nameEntryNotificationFrequencyDaily => 'Harian';

  @override
  String get topBarStreakDialogTitle => 'Rentetan';

  @override
  String get fillInTheBlanksLabel => 'Isi bagian kosong';

  @override
  String get loadingDataLabel => 'Memuat…';

  @override
  String ayahRangeLabel(Object start, Object end) {
    return 'Ayat $start - $end';
  }

  @override
  String get nextPageSemanticLabel => 'Halaman berikutnya';

  @override
  String get prevPageSemanticLabel => 'Halaman sebelumnya';

  @override
  String pageXOfYLabel(Object current, Object total) {
    return 'Halaman $current dari $total';
  }

  @override
  String verseSemanticLabel(Object ayahNumber, Object surahName) {
    return 'Ayat $ayahNumber dari surah $surahName';
  }

  @override
  String get ayahLabel => 'Ayat';

  @override
  String get goToSurahViewLabel => 'Lihat Surah';

  @override
  String get clickOnAyaToOpenLesson => 'Klik ayat mana pun di bawah ini untuk memulai pelajaran';

  @override
  String get difficultyChoosingScreenIntro => 'Pilih preferensi Anda: pilihan ganda atau isi bagian kosong, dan berapa kali setiap langkah dan audio diputar ulang.';

  @override
  String get upgradeVoiceUsageMessage => 'Tingkatkan ke Pro Beta untuk mencoba fitur suara dan bantu kami meningkatkannya!';

  @override
  String get restorePurchasesLabel => 'Pulihkan Pembelian';

  @override
  String get subscriptionTierScreenMonthly => 'Bulanan';

  @override
  String get subscriptionTierScreenYearly => 'Tahunan';

  @override
  String get subscriptionTierScreenFreePrice => 'Gratis';

  @override
  String get subscriptionTierScreenPremiumMonthlyPrice => 'Sekarang \$3/bulan (dulunya \$5)';

  @override
  String get subscriptionTierScreenPremiumYearlyPrice => 'Sekarang \$28/tahun (dulunya \$60)';

  @override
  String get subscriptionTierScreenPremiumPlusMonthlyPrice => 'Sekarang \$7/bulan (dulunya \$10)';

  @override
  String get subscriptionTierScreenPremiumPlusYearlyPrice => 'Sekarang \$45/tahun (dulunya \$84)';

  @override
  String get subscriptionPurchaseError => 'Terjadi kesalahan saat membeli langganan';

  @override
  String get topBarExplorePlansLabel => 'Jelajahi Paket';

  @override
  String get topBarBackHomeLabel => 'Kembali ke Beranda';

  @override
  String get profileRequiresPlanUpdate => 'Memerlukan pembaruan paket';

  @override
  String get subscriptionTierScreenPremiumDescription => 'Semua yang ada di versi gratis, ditambah pembelajaran pelajaran offline dan umpan balik, analitik historis, serta bilah kemajuan, profil, dan kustomisasi Al-Qur’an. Dukung kami membangun lebih banyak fitur!';

  @override
  String get subscriptionAutoRenewNotice => 'Langganan akan diperbarui otomatis dan dapat dibatalkan agar Anda tidak dikenai biaya untuk periode berikutnya. Sebagian dana akan disumbangkan ke Islamic Relief melalui Inisiatif Almubtasim 😀.';

  @override
  String get subscriptionTierScreenSubscribeLabel => 'Berlangganan';

  @override
  String get subscriptionTierScreenFinalMessage => 'Kami menghargai dukungan Anda!';

  @override
  String get subscriptionPurchaseRestoreSuccess => 'Pembelian Anda berhasil dipulihkan.';

  @override
  String get subscriptionTierScreenRestoreLabel => 'Pulihkan Pembelian';

  @override
  String get arabicLabel => 'Arab';

  @override
  String get transliterationLabel => 'Inggris';

  @override
  String get surahSearchScreenTitle => 'Pencarian Surah';

  @override
  String get genericBack => 'Kembali';

  @override
  String get surahSearchSelectSurah => 'Pilih Surah:';

  @override
  String get surahSearchExistingPaths => 'Path yang Tersedia untuk Surah Ini';

  @override
  String get surahSearchNoMatches => 'Tidak ada path yang ditemukan.';

  @override
  String get surahSearchHideCreateForm => 'Sembunyikan Formulir Pembuatan';

  @override
  String get surahSearchShowCreateForm => 'Buat Path Baru untuk Surah';

  @override
  String get createPathTrackProgress => 'Lacak Kemajuan?';

  @override
  String get themeScreenSearchIconSemantic => 'Cari Surah';

  @override
  String get pathListSearchIconSemantic => 'Cari Surah';

  @override
  String get pathLessonsSearchIconSemantic => 'Cari Surah';

  @override
  String get playAllSurahSemantic => 'Putar seluruh surah';

  @override
  String get toggleTransliterationLabel => 'Toggle transliterasi';

  @override
  String get englishLabel => 'Inggris';

  @override
  String get subscriptionTierScreenPremiumPlusLabel => 'Dukung Kami (Tahunan)';

  @override
  String get subscriptionTierScreenFreeDescription => 'Semua fitur gratis dan tanpa iklan!';

  @override
  String get subscriptionTierScreenPremiumPlusDescription => 'Bantu mendanai fitur baru dan perbaikan! Selain itu, investasi kecil dapat membantu membangun kebiasaan Anda!';

  @override
  String get subscriptionTierScreenSupportLabel => 'Dukung Tahunan';

  @override
  String get verticalLessonIconsDialogBody => 'Semua fitur tersedia dalam versi gratis, tetapi jika Anda berkenan, Anda dapat mendukung kami untuk membangun lebih banyak fitur. Sebagian dari langganan Anda didonasikan ke Islamic Relief. Jazāk Allāhu Khayran!';

  @override
  String get welcomeBody => 'Hudhud memiliki peran khusus dalam membantu Nabi Sulaiman [AS] dengan mengamati dan membawa pesan.\n\nDia tidak menghakimi Anda di mana pun Anda berada dalam perjalanan, dan bersemangat untuk memandu Anda menemukan keindahan Al-Qur’an serta mengintegrasikan pengingat rasa syukur untuk menghargai setiap momen dengannya.';

  @override
  String get surahSearchByName => 'Cari berdasarkan nama (Inggris atau Arab)';

  @override
  String get surahSearchHintAnyName => 'Ketik nama surah apa saja...';

  @override
  String get surahSearchFieldLabel => 'Cari Surah';

  @override
  String get surahSearchInvalidLessonsError => 'Satu atau lebih pelajaran tidak valid. Tidak dapat membuat path.';

  @override
  String get surahSearchUserSurahPrefix => 'Surah Pengguna';

  @override
  String get notificationDailyBody => 'Luangkan waktu sejenak untuk menemukan ketenangan melalui Al-Qur’an dan ingatkan diri Anda mengapa Anda bersyukur hari ini.';
}
