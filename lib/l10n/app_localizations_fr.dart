import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get commentA => 'Clés d\'Onboarding';

  @override
  String get appBarTitleWelcome => 'Bienvenue';

  @override
  String get skipLabel => 'Ignorer';

  @override
  String get welcomeHeadline => 'Bienvenue dans Quran avec Hudhud !';

  @override
  String get getStartedLabel => 'Commencer';

  @override
  String get commentB => 'Clés d\'écran de leçon';

  @override
  String get lessonScreenAppBarTitle => 'Leçon';

  @override
  String get noAyahAvailable => 'Aucune āyah disponible à lire.';

  @override
  String audioNotFound(Object url) {
    return 'Audio introuvable à l’adresse $url';
  }

  @override
  String get restartLessonTitle => 'Redémarrer la leçon';

  @override
  String get resetLessonBody => 'Réinitialiser toute votre progression pour cette leçon ?';

  @override
  String get cancelLabel => 'Annuler';

  @override
  String get yesLabel => 'Oui';

  @override
  String get errorResettingLesson => 'Erreur lors de la réinitialisation de la leçon';

  @override
  String get startLabel => 'Démarrer';

  @override
  String get submitLabel => 'Envoyer';

  @override
  String get nextLabel => 'Suivant';

  @override
  String get voiceErrorMicDeniedTitle => 'Microphone refusé';

  @override
  String get voiceErrorMicDeniedBody => 'L’enregistrement requiert l’accès au microphone. Veuillez accorder l’autorisation dans les paramètres.';

  @override
  String get voiceErrorMicDeniedSemanticLabel => 'Dialogue d’autorisation de microphone refusée';

  @override
  String get voiceErrorRecorderStartTitle => 'Erreur d’enregistrement';

  @override
  String get voiceErrorRecorderStartBody => 'Nous n\'avons pas pu démarrer l’enregistreur. Veuillez réessayer.';

  @override
  String get voiceErrorRecorderStartSemanticLabel => 'Dialogue d’erreur de démarrage de l’enregistreur';

  @override
  String get voiceErrorRecorderStopTitle => 'Erreur à l’arrêt de l’enregistrement';

  @override
  String get voiceErrorRecorderStopBody => 'Nous n’avons pas pu arrêter correctement l’enregistreur. Veuillez réessayer.';

  @override
  String get voiceErrorRecorderStopSemanticLabel => 'Dialogue d’erreur à l’arrêt de l’enregistreur';

  @override
  String get voiceErrorNoSoundTitle => 'Aucun son détecté';

  @override
  String get voiceErrorNoSoundBody => 'Votre enregistrement était silencieux ou trop faible. Veuillez réessayer.';

  @override
  String get voiceErrorNoSoundSemanticLabel => 'Dialogue aucun son détecté';

  @override
  String get voiceErrorTranscriptionTitle => 'Erreur de transcription';

  @override
  String get voiceErrorTranscriptionBody => 'Nous n’avons pas pu transcrire votre enregistrement. Veuillez vérifier votre connexion et réessayer.';

  @override
  String get voiceErrorTranscriptionSemanticLabel => 'Dialogue d’erreur de transcription';

  @override
  String get tapColoredWordsHint => 'Appuyez sur les mots surlignés pour voir la version corrigée.';

  @override
  String get emptyInputWarning => 'Vous devez saisir quelque chose avant d’envoyer';

  @override
  String get getHintLabel => 'Obtenir un indice';

  @override
  String get removeHintLabel => 'Retirer l’indice';

  @override
  String get typeTheMissingWordsLabel => 'Tapez le(s) mot(s) manquant(s)';

  @override
  String get difficultyLabel => 'Difficulté';

  @override
  String get repeatCountLabel => 'Nb de répétitions';

  @override
  String get backButtonLabel => 'Retour';

  @override
  String get toggleTranslationLabel => 'Basculer la traduction intégrée';

  @override
  String get openTranslationScreenLabel => 'Ouvrir l’écran de traduction';

  @override
  String get restartLessonSemanticLabel => 'Redémarrer la leçon';

  @override
  String get verseDisplayAreaLabel => 'Zone d’affichage des versets du Coran';

  @override
  String get playAudioSemanticLabel => 'Lire l’audio de l’āyah';

  @override
  String get openGratitudeSemanticLabel => 'Ouvrir la fenêtre modale de gratitude';

  @override
  String get voiceUsageSemanticLabel => 'Utilisation vocale en minutes';

  @override
  String get voiceRecordSemanticLabel => 'Démarrer ou arrêter l’enregistrement vocal';

  @override
  String get commentC => 'Nouvelles chaînes pour l’écran d’accueil (HOME)';

  @override
  String get homeTitle => 'Accueil';

  @override
  String get noPathsLabel => 'Aucun parcours valide disponible.';

  @override
  String errorLoadingActivePath(Object err) {
    return 'Erreur lors du chargement du parcours actif : $err';
  }

  @override
  String get verticalLessonIconsGoToTheme => 'Aller au thème';

  @override
  String get homePathCardLabel => 'Appuyez pour ouvrir l’écran du thème';

  @override
  String get arrowForwardSemanticLabel => 'Ouvrir les détails';

  @override
  String get noTrackProgressLabel => 'Ce parcours ne suit pas la progression.';

  @override
  String get premiumRequiredLabel => 'Mettez à niveau pour débloquer la fonctionnalité de progression. Soutenez-nous pour créer plus de fonctionnalités !';

  @override
  String get completedLabel => 'terminé';

  @override
  String get fabLogGratitudeLabel => 'Appuyez pour enregistrer une gratitude';

  @override
  String get errorNavigatingToLesson => 'Erreur lors de la navigation vers la leçon';

  @override
  String get commentD => 'Chaînes de l’écran du profil';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileBackArrowLabel => 'Retour à l’écran précédent';

  @override
  String get profileAvatarSemanticLabel => 'Avatar de l’utilisateur';

  @override
  String get profileEnterYourName => 'Saisissez votre nom';

  @override
  String get nameEntryNotificationFrequencyDropdownLabel => 'Fréquence des notifications';

  @override
  String get nameEntryNotificationFrequencyWeekly => 'Hebdomadaire';

  @override
  String get nameEntryNotificationFrequencyNone => 'Aucun';

  @override
  String get notificationPermissionPrompt => 'Nous aimerions vous envoyer de doux rappels pour compléter votre gratitude ou vos leçons – veuillez autoriser les notifications si vous souhaitez que nous vous aidions à bâtir cette habitude 😃.';

  @override
  String get profileNameSave => 'Enregistrer';

  @override
  String get profileNameCancel => 'Annuler';

  @override
  String get profileNameGuest => 'Invité';

  @override
  String get profileNameEdit => 'Modifier';

  @override
  String get profilePreferredLanguage => 'Langue :';

  @override
  String get okLabel => 'OK';

  @override
  String get profileReciterLabel => 'Récitateur';

  @override
  String get profileFontLabel => 'Police :';

  @override
  String get profileReciterMishary => 'Mishary Rashid Al-Afasy';

  @override
  String get profileReciterShatri => 'Abu Bakr Al-Shatri';

  @override
  String get profileReciterQatami => 'Nasser Al Qatami';

  @override
  String get profileUpgradePremiumTitle => 'Débloquez plus de personnalisation !';

  @override
  String get profileUpgradePremiumBody => 'Vous pouvez profiter de la modification des polices et du choix des récitateurs en passant à la version Pro. Soutenez nos efforts continus et personnalisez encore plus votre expérience !';

  @override
  String get profileWeeksProgress => 'MashaAllah, voici votre progression de la semaine :';

  @override
  String get profileGratefulnessCalendar => 'Calendrier de gratitude';

  @override
  String get profileQuranLearningCalendar => 'Calendrier d’apprentissage du Coran';

  @override
  String get profilePrevWeekSemantic => 'Aller à la semaine précédente';

  @override
  String get profileNextWeekSemantic => 'Aller à la semaine suivante';

  @override
  String get profileNotificationFrequency => 'Fréquence des notifications';

  @override
  String get commentE => 'Chaînes de l’écran du Journal de gratitude';

  @override
  String get gratitudeLogTitle => 'Mon journal de gratitude';

  @override
  String get gratitudeLogBackArrowSemantic => 'Retour à l’accueil';

  @override
  String get gratitudeLogClearAllSemantic => 'Effacer toutes les entrées de gratitude';

  @override
  String get gratitudeLogAddSemantic => 'Ajouter une nouvelle entrée de gratitude';

  @override
  String get gratitudeLogClearDialogTitle => 'Effacer le journal de gratitude';

  @override
  String get gratitudeLogClearDialogBody => 'Êtes-vous sûr de vouloir effacer toutes vos entrées de gratitude ? Cette action est irréversible.';

  @override
  String get gratitudeLogClearConfirm => 'Oui, effacer';

  @override
  String gratitudeLogStreak(Object days) {
    return '⭐ Série de gratitude : $days jours';
  }

  @override
  String get gratitudeLogStreakLoading => 'Calcul de la série en cours…';

  @override
  String get gratitudeLogStreakError => 'Échec du calcul de la série.';

  @override
  String gratitudeLogTotalDays(Object count) {
    return 'Total de jours de gratitude : $count';
  }

  @override
  String get gratitudeLogDataLoading => 'Chargement des données de gratitude…';

  @override
  String get gratitudeLogDataError => 'Échec du chargement des données de gratitude.';

  @override
  String get gratitudeLogCardSemantic => 'Carte d’entrée de gratitude';

  @override
  String get gratitudeLogItemIcon => 'Icône de gratitude';

  @override
  String get gratitudeLogEmptyIconSemantic => 'Appuyez pour ajouter votre première gratitude';

  @override
  String get gratitudeLogEmptyMessage => 'Aucune entrée de gratitude pour le moment.\nAppuyez sur « + » pour ajouter votre première gratitude !';

  @override
  String get gratitudeLogEntriesAdded => 'Les gratitudes ont été ajoutées avec succès !';

  @override
  String get gratitudeLogEntriesFailed => 'Échec de l’ajout de gratitudes. Veuillez réessayer.';

  @override
  String get commentF => 'Chaînes de l’écran d’achèvement de la leçon';

  @override
  String get lessonCompletedTitle => 'Leçon terminée';

  @override
  String get lessonCompletedBackArrowSemantic => 'Retour à l’accueil';

  @override
  String get lessonCompletedMashaAllah => 'MashaAllah !';

  @override
  String get lessonCompletedMashaAllahSemantic => 'Texte de félicitations';

  @override
  String get lessonCompletedMessage => 'Vous avez terminé cette leçon !';

  @override
  String get lessonCompletedImageSemantic => 'Illustration Hudhud et Coran';

  @override
  String get lessonCompletedGoBackSemantic => 'Retour à la sélection du parcours';

  @override
  String get lessonCompletedGoBackButton => 'Retour au parcours';

  @override
  String get lessonCompletedRestartSemantic => 'Redémarrer la leçon';

  @override
  String get lessonCompletedRestartButton => 'Redémarrer la leçon';

  @override
  String get lessonCompletedEncouragement => 'Continuez votre excellent travail !';

  @override
  String get commentG => 'Chaînes de l’écran Thème';

  @override
  String get themeScreenTitle => 'Thèmes';

  @override
  String get themeNameCoreRecitation => 'Récitation quotidienne principale';

  @override
  String get themeNameBeginJourney => 'Commencer le voyage';

  @override
  String get themeNameMercyAndHope => 'Miséricorde et Espoir';

  @override
  String get themeNameGratitudeReflection => 'Gratitude et réflexion';

  @override
  String get themeNameStoriesReminders => 'Histoires, leçons et rappels';

  @override
  String get themeNamePatience => 'Patience (Ṣabr)';

  @override
  String get themeNameUserCreated => 'Créé par l’utilisateur';

  @override
  String get themeScreenNoThemesLabel => 'Aucun thème disponible';

  @override
  String get themeScreenBackArrowSemantic => 'Revenir en arrière';

  @override
  String get themeScreenThemeCardSemantic => 'Appuyez pour ouvrir les parcours du thème';

  @override
  String get themeScreenLockIconSemantic => 'Thème verrouillé. Mise à niveau requise.';

  @override
  String get pathListExploreOtherThemes => 'Explorer d’autres thèmes';

  @override
  String get themeScreenUserCreatedSubtitle => 'Créé par vous — personnalisez-le comme vous le souhaitez.';

  @override
  String get themeSubtitleCoreRecitation => 'Sourates essentielles pour les prières quotidiennes et la protection.';

  @override
  String get themeSubtitleBeginJourney => 'Sourates courtes pour débuter votre parcours coranique.';

  @override
  String get themeSubtitleMercyAndHope => 'Réfléchissez à la compassion d’Allah et cultivez l’espoir.';

  @override
  String get themeSubtitleGratitudeReflection => 'Favorisez la reconnaissance et l’introspection à travers des āyāt sélectionnées.';

  @override
  String get themeSubtitleStoriesReminders => 'Explorez des récits coraniques qui guident et rappellent.';

  @override
  String get themeSubtitlePatience => 'Sourates et passages qui soulignent la patience et la persévérance.';

  @override
  String get themeSubtitleDefault => 'Un ensemble dédié de sourates pour un approfondissement spirituel.';

  @override
  String get themeScreenRequiredPremium => 'Nécessite Premium';

  @override
  String get themeScreenRequiredPremiumPlus => 'Nécessite Pro Beta';

  @override
  String get commentH => 'Chaînes de l’écran Liste des parcours (Path List)';

  @override
  String get pathListScreenTitle => 'Parcours du thème';

  @override
  String get pathListScreenBackArrowSemantic => 'Revenir en arrière';

  @override
  String get pathListScreenAddIconSemantic => 'Ajouter un nouveau parcours';

  @override
  String get pathListAddNewPathTooltip => 'Ajouter un nouveau parcours';

  @override
  String get pathListScreenAddIconSemanticEmpty => 'Appuyez pour ajouter votre premier parcours';

  @override
  String get pathListEmptyMessage => 'Aucun parcours pour le moment.\nAppuyez sur « + » pour créer votre premier parcours !';

  @override
  String get pathListUnavailableLabel => 'Ce parcours n’est pas disponible pour le moment';

  @override
  String get pathListThemeLabel => 'Thème';

  @override
  String get pathListPathCardSemantic => 'Appuyez pour ouvrir les détails du parcours';

  @override
  String get pathListCompleteIconSemantic => 'Parcours terminé';

  @override
  String get pathListInProgressIconSemantic => 'Parcours en cours';

  @override
  String get pathListInvalidIconSemantic => 'Parcours invalide ou indisponible';

  @override
  String get pathListErrorLoadingPaths => 'Erreur lors du chargement des parcours :';

  @override
  String get commentI => 'Chaînes de l’écran Détails du parcours (Path Detail)';

  @override
  String get pathDetailScreenTitle => 'Détails du parcours';

  @override
  String get pathDetailScreenBackArrowSemantic => 'Retour à la liste des parcours';

  @override
  String get pathDetailScreenNotFound => 'Parcours introuvable.';

  @override
  String get pathDetailScreenFailToUpdate => 'Échec de la mise à jour de la progression du parcours :';

  @override
  String get pathDetailScreenProgressDisabled => 'Le suivi de progression est désactivé pour ce parcours.';

  @override
  String get pathDetailScreenLessonsHeading => 'Leçons :';

  @override
  String get pathDetailScreenNoLessonsLabel => 'Aucune leçon disponible.';

  @override
  String get pathDetailScreenErrorLoading => 'Erreur lors du chargement du parcours ou des leçons :';

  @override
  String get pathDetailScreenLessonCardSemantic => 'Appuyez pour ouvrir les détails de la leçon';

  @override
  String get pathDetailScreenLessonCompleteIconSemantic => 'Leçon terminée';

  @override
  String get pathDetailScreenLessonInProgressIconSemantic => 'Leçon en cours';

  @override
  String get pathDetailScreenLessonInvalidIconSemantic => 'Leçon invalide ou indisponible';

  @override
  String get pathDetailScreenLessonProgressUnavailable => 'Progression indisponible';

  @override
  String get pathDetailScreenLessonNoProgress => 'Pas de progression pour ce parcours';

  @override
  String get pathDetailScreenLessonUpgrade => 'Mettez à niveau pour la fonctionnalité de progression.';

  @override
  String pathDetailScreenLessonProgressLabel(Object progress) {
    return 'Progression : $progress %';
  }

  @override
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah) {
    return 'Leçon $lessonIndex : $surahName – Āyah $startAyah-$endAyah';
  }

  @override
  String get commentJ => 'Chaînes de l’écran Créer un parcours (Create Path)';

  @override
  String get createPathTitle => 'Créer un nouveau parcours';

  @override
  String get createPathBackArrowSemantic => 'Retour à l’écran précédent';

  @override
  String get createPathNameLabel => 'Nom du parcours';

  @override
  String get createPathNameValidation => 'Entrez un nom de parcours';

  @override
  String get createPathDescriptionLabel => 'Description';

  @override
  String get createPathDescriptionValidation => 'Entrez une description';

  @override
  String get createPathSurahSelectorLabel => 'Sélectionner la sourate :';

  @override
  String get createPathStartAyahLabel => 'Āyah de début';

  @override
  String get createPathNumAyahsLabel => 'Nombre d’āyāt dans le parcours';

  @override
  String get createPathEndAyahLabel => 'Āyah de fin';

  @override
  String get createPathWordsPerLessonLabel => 'Mots par leçon';

  @override
  String get createPathWordsSuffix => 'mots';

  @override
  String get createPathInvalidRange => 'Plage invalide';

  @override
  String get createPathAyahsSuffix => 'Āyāt';

  @override
  String get createPathCreateButton => 'Créer le parcours';

  @override
  String get createPathSubmitSemantic => 'Appuyez pour créer le parcours';

  @override
  String get commentK => 'Chaînes de l’écran de Traduction';

  @override
  String get translationScreenTitle => 'Traduction';

  @override
  String get translationScreenBackArrowSemantic => 'Retour à la leçon';

  @override
  String get translationScreenLoadingSemantic => 'Chargement des traductions';

  @override
  String get translationScreenNoTranslations => 'Aucune traduction disponible.';

  @override
  String get translationScreenReturnButton => 'Retour à la leçon';

  @override
  String get translationScreenReturnSemantic => 'Appuyez pour revenir à la leçon';

  @override
  String get translationScreenLoadError => 'Erreur lors du chargement des traductions :';

  @override
  String get commentL => 'Chaînes de l’écran de Sélection de langue';

  @override
  String get languageSelectionScreenSemantic => 'Écran de sélection de langue';

  @override
  String get languageSelectionTitle => 'Sélectionnez votre langue';

  @override
  String get languageSelectionBackSemantic => 'Retour';

  @override
  String get languageSelectionSkipSemantic => 'Ignorer la sélection';

  @override
  String get languageSelectionInstructions => 'Veuillez choisir votre langue préférée :';

  @override
  String get languageSelectionNextSemantic => 'Appuyez pour confirmer le choix de la langue';

  @override
  String get languageSelectionNextLabel => 'Suivant';

  @override
  String get languageSelectionImageSemantic => 'Illustration Hudhud et Coran';

  @override
  String get commentM => 'Chaînes de l’écran de Bienvenue (Onboarding)';

  @override
  String get welcomeScreenSemantic => 'Écran de bienvenue de l’onboarding';

  @override
  String get welcomeScreenLogoSemantic => 'Illustration Hudhud et Coran';

  @override
  String get welcomeScreenSkipSemantic => 'Ignorer l’étape de bienvenue';

  @override
  String get welcomeScreenNextSemantic => 'Passer à l’étape suivante de l’onboarding';

  @override
  String get commentN => 'Chaînes de l’écran d’information sur Hudhud';

  @override
  String get hudhudInfoSemantic => 'Écran d’information sur Hudhud';

  @override
  String get hudhudInfoAppBarTitle => 'Rencontrez Hudhud';

  @override
  String get hudhudInfoIllustrationSemantic => 'Illustration de Hudhud';

  @override
  String get hudhudInfoBody1 => 'Hudhud, également connu sous le nom de huppe, a joué un rôle spécial en aidant le prophète Soulaymân [AS] en observant et en transmettant des messages.';

  @override
  String get hudhudInfoBody2 => 'L’histoire de Hudhud nous rappelle que même une petite créature peut avoir un grand impact en étant observatrice, curieuse et proactive pour ce qui est juste. Dans notre parcours, nous pouvons porter notre attention constante sur la beauté du Coran et intégrer des rappels de gratitude pour apprécier chaque instant de progression.';

  @override
  String get hudhudInfoBody3 => 'En suivant l’exemple de Hudhud — rester vigilant et engagé — nous espérons approfondir notre lien avec le Coran et favoriser un sentiment de gratitude dans la vie de tous les jours.';

  @override
  String get hudhudInfoNextLabel => 'Suivant';

  @override
  String get hudhudInfoNextSemantic => 'Passer à la section suivante';

  @override
  String get hudhudInfoSkipSemantic => 'Ignorer l’étape d’information sur Hudhud';

  @override
  String get commentO => 'Chaînes de l’écran de Sélection de forfait (Subscription Tier)';

  @override
  String get subscriptionTierScreenSemantic => 'Écran de sélection du forfait d’abonnement';

  @override
  String get subscriptionTierScreenAppBarTitle => 'Choisissez votre abonnement';

  @override
  String get subscriptionTierScreenSkipSemantic => 'Ignorer la sélection du forfait';

  @override
  String get subscriptionTierScreenFreeLabel => 'Gratuit';

  @override
  String get subscriptionTierScreenSmileySemantic => 'Icône de visage souriant';

  @override
  String get subscriptionTierScreenDonationText => 'Une partie des fonds est reversée à l’initiative Almubtasim, qui aide les orphelins via Islamic Relief.';

  @override
  String get subscriptionTierScreenConfirmSemantic => 'Confirmer la sélection du forfait d’abonnement';

  @override
  String get subscriptionTierScreenNextLabel => 'Suivant';

  @override
  String subscriptionTierScreenRadioSemantic(Object title) {
    return 'Appuyez pour sélectionner le forfait d’abonnement $title';
  }

  @override
  String get commentP => 'Chaînes de l’écran de Sélection d’objectif (Goal Selection)';

  @override
  String get goalSelectionScreenSemantic => 'Écran de sélection d’objectifs';

  @override
  String get goalSelectionScreenAppBarTitle => 'Sélectionnez vos objectifs';

  @override
  String get goalSelectionScreenSkipSemantic => 'Ignorer la sélection d’objectifs';

  @override
  String get goalSelectionScreenIntroText => 'Parmi les objectifs suivants, lesquels vous intéressent ? Vous pouvez en sélectionner plusieurs.';

  @override
  String get goalSelectionScreenNextSemantic => 'Confirmer les sélections d’objectifs';

  @override
  String get goalSelectionScreenNextLabel => 'Suivant';

  @override
  String goalSelectionTileSemantic(Object goalTitle) {
    return 'Appuyez pour sélectionner ou désélectionner l’objectif $goalTitle';
  }

  @override
  String get goalConnectQuranTitle => 'Se rapprocher davantage du Coran';

  @override
  String get goalConnectQuranDesc => 'Renforcez votre relation par la lecture ou la réflexion.';

  @override
  String get goalMemorizeQuranTitle => 'Mémoriser le Coran';

  @override
  String get goalMemorizeQuranDesc => 'Entreprenez un parcours de mémorisation.';

  @override
  String get goalBeMoreGratefulTitle => 'Être plus reconnaissant et heureux dans la vie';

  @override
  String get goalBeMoreGratefulDesc => 'Concentrez-vous sur les pratiques de gratitude au quotidien.';

  @override
  String get goalBuildConsistencyTitle => 'Construire de la régularité';

  @override
  String get goalBuildConsistencyDesc => 'Établissez une habitude quotidienne ou hebdomadaire.';

  @override
  String get goalImproveArabicTitle => 'Améliorer mon arabe';

  @override
  String get goalImproveArabicDesc => 'Concentrez-vous sur les compétences écrites ou orales.';

  @override
  String get goalDeepenTafsirTitle => 'Approfondir le Tafsîr';

  @override
  String get goalDeepenTafsirDesc => 'Étudiez le commentaire et les sens plus profonds du Coran.';

  @override
  String get goalOtherTitle => 'Autre';

  @override
  String get goalOtherDesc => 'Poursuivez tout autre objectif personnel.';

  @override
  String get commentQ => 'Chaînes de l’écran de Sélection de niveau';

  @override
  String get levelSelectionScreenSemantic => 'Écran de sélection de niveau';

  @override
  String get levelSelectionScreenAppBarTitle => 'Sélectionnez votre niveau';

  @override
  String get levelSelectionScreenSkipSemantic => 'Ignorer la sélection de niveau';

  @override
  String get levelSelectionScreenIntroText => 'Veuillez sélectionner l’option qui décrit le mieux votre niveau actuel de récitation :';

  @override
  String get levelStarterLabel => 'Débutant';

  @override
  String get levelStarterDescription => 'Nouvel apprenant ou occasionnel, commençant à explorer la récitation du Coran.';

  @override
  String get levelAdvancedLabel => 'Avancé';

  @override
  String get levelAdvancedDescription => 'À l’aise pour lire le script arabe avec quelques connaissances de tajwîd.';

  @override
  String get levelQariLabel => 'Qari';

  @override
  String get levelQariDescription => 'Compétent en récitation avec une forte maîtrise du tajwîd.';

  @override
  String get levelSelectionNextSemantic => 'Confirmer la sélection du niveau';

  @override
  String get levelSelectionNextLabel => 'Suivant';

  @override
  String levelSelectionTileSemantic(Object levelTitle) {
    return 'Appuyez pour sélectionner l’option de niveau de récitation $levelTitle';
  }

  @override
  String get commentR => 'Chaînes de l’écran d’achèvement de l’onboarding';

  @override
  String get onboardingCompletionScreenSemantic => 'Écran d’achèvement de l’onboarding';

  @override
  String get onboardingCompletionScreenAppBarTitle => 'Tout est prêt !';

  @override
  String get onboardingCompletionScreenImageSemantic => 'Illustration Hudhud et Coran';

  @override
  String get onboardingCompletionScreenBody1 => 'Félicitations ! Vous avez terminé la configuration avec succès. Nous espérons que ce voyage vous rapprochera du Coran et renforcera votre gratitude envers Allah. \n \nPuisse cette application être une source de développement et de bénédictions dans votre vie et celle des personnes que vous touchez.';

  @override
  String get onboardingCompletionScreenBody2 => 'Lorsque vous êtes prêt, appuyez sur le bouton ci-dessous pour continuer. Les principales fonctionnalités de mémorisation et de progression vous attendent, et vous pouvez enregistrer votre gratitude ou choisir un parcours via la barre de navigation.';

  @override
  String get onboardingCompletionScreenBody3 => 'Ceci est une des premières versions — nous apprécions votre soutien et votre patience et espérons vous offrir encore plus de fonctionnalités très prochainement inshAllah !';

  @override
  String get onboardingCompletionScreenBeginSemantic => 'Commencer à utiliser l’app';

  @override
  String get onboardingCompletionScreenBeginLabel => 'Commençons';

  @override
  String get commentS => 'Chaînes de l’écran de saisie du nom';

  @override
  String get nameEntryScreenSemantic => 'Écran de saisie du nom';

  @override
  String get nameEntryScreenAppBarTitle => 'Votre profil';

  @override
  String get nameEntryScreenSkipSemantic => 'Ignorer la saisie de votre nom';

  @override
  String get nameEntryScreenIntroText => 'Quel est votre nom ? ';

  @override
  String get nameEntryTextFieldSemantic => 'Champ de texte pour le nom';

  @override
  String get nameEntryNextSemantic => 'Confirmer la saisie du nom';

  @override
  String get nameEntryNextLabel => 'Suivant';

  @override
  String get commentT => 'Chaînes pour VerticalLessonIcons';

  @override
  String get verticalLessonIconsSemantic => 'Conteneur d’icônes de leçons verticales';

  @override
  String get verticalLessonIconsNoLessons => 'Aucune leçon trouvée.';

  @override
  String get verticalLessonIconsLoadingSurah => 'Chargement des détails de la sourate';

  @override
  String get verticalLessonIconsErrorSurah => 'Erreur lors du chargement des détails de la sourate';

  @override
  String get verticalLessonIconsSurahHeaderSemantic => 'En-tête des détails de la sourate';

  @override
  String get verticalLessonIconsHudhudIconSemantic => 'Icône d’assistant Hudhud';

  @override
  String get verticalLessonIconsNextPageSemantic => 'Flèche page suivante';

  @override
  String get verticalLessonIconsPreviousPageSemantic => 'Flèche page précédente';

  @override
  String get verticalLessonIconsLoadingProgress => 'Chargement de la progression de la leçon';

  @override
  String get verticalLessonIconsErrorProgress => 'Erreur lors du chargement de la progression';

  @override
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent) {
    return 'Icône de leçon, $surahAyahRange, la progression est de $percent %';
  }

  @override
  String get verticalLessonIconsCompletedSemantic => 'Leçon terminée';

  @override
  String get verticalLessonIconsDialogTitle => 'Aide et mise à niveau';

  @override
  String get verticalLessonIconsDialogOk => 'OK';

  @override
  String get commentU => 'Chaînes de la barre de navigation (Navbar)';

  @override
  String get navBarSemanticLabel => 'Barre de navigation inférieure';

  @override
  String get navHomeLabel => 'Accueil';

  @override
  String get navHomeSemantic => 'Onglet Accueil';

  @override
  String get navQuranLabel => 'Coran';

  @override
  String get navQuranSemantic => 'Onglet Coran';

  @override
  String get navGratitudeLabel => 'Gratitude';

  @override
  String get navGratitudeSemantic => 'Onglet Gratitude';

  @override
  String get navProfileLabel => 'Profil';

  @override
  String get navProfileSemantic => 'Onglet Profil';

  @override
  String get commentV => 'Chaînes de la barre supérieure (TopBar)';

  @override
  String get topBarSemanticLabel => 'Barre de navigation supérieure';

  @override
  String topBarTitleSemantic(Object title) {
    return 'Titre de la barre supérieure : $title';
  }

  @override
  String topBarStreakIconSemantic(Object days) {
    return 'Icône de série : $days jours';
  }

  @override
  String get topBarStreakDialogBody => 'Cela montre combien de jours consécutifs vous avez récité ou écrit une gratitude. Continuez ainsi pour maintenir ou augmenter votre série !';

  @override
  String get topBarHudhudIconSemantic => 'Icône Hudhud, appuyez pour du support';

  @override
  String get topBarHudhudDialogTitle => 'Support & Mise à niveau';

  @override
  String get topBarHudhudDialogBody => 'Toutes les fonctionnalités sont disponibles dans la version gratuite, mais si vous le souhaitez, vous pouvez nous soutenir afin de développer davantage de fonctionnalités. Une partie de votre abonnement est versée à Islamic Relief. Jazāk Allāhu Khayran !';

  @override
  String get commentW => 'Chaînes de la fenêtre modale de gratitude';

  @override
  String get gratitudeModalSemantic => 'Dialogue modal de gratitude';

  @override
  String get gratitudeModalTitle => 'Pour quoi êtes-vous reconnaissant aujourd’hui en vous basant sur ces versets ?';

  @override
  String gratitudeModalHint(Object index) {
    return 'Alhamdulilah pour (entrez votre gratitude) #$index';
  }

  @override
  String gratitudeModalTextFieldSemantic(Object index) {
    return 'Entrez la gratitude #$index';
  }

  @override
  String get gratitudeModalEmptyWarning => 'Veuillez saisir au moins une gratitude.';

  @override
  String get gratitudeModalSubmitError => 'Échec de l’enregistrement de la gratitude. Veuillez réessayer.';

  @override
  String get dailyVoiceLimitReachedTitle => 'MachaAllah !';

  @override
  String get dailyVoiceLimitReachedMessage => 'Vous avez complété 10 minutes de récitation vocale du Coran. Veuillez continuer à réviser par écrit et reprendre la récitation demain.';

  @override
  String get upgradeVoiceUsageTitle => 'Mettez à niveau vers Premium';

  @override
  String get gratitudeModalLoadingSemantic => 'Soumission de gratitude en cours';

  @override
  String get commentX => '== NOUVELLES CLÉS pour submission_feedback_modal, progress_bar, surah_selector ==';

  @override
  String get submissionFeedbackModalSemanticLabel => 'Dialogue de commentaires de soumission';

  @override
  String get submissionFeedbackModalTitle => 'Commentaires de soumission';

  @override
  String get submissionFeedbackModalNoNew => 'Aucune nouvelle gratitude n’a été soumise.';

  @override
  String get submissionFeedbackModalYouSubmitted => 'Vous avez soumis ces gratitudes :';

  @override
  String submissionFeedbackModalStreak(Object days) {
    return 'Série de gratitude actuelle : $days jours';
  }

  @override
  String submissionFeedbackModalTotalDays(Object count) {
    return 'Nombre total de jours de gratitude : $count';
  }

  @override
  String get submissionFeedbackModalLoading => 'Chargement de vos données de gratitude…';

  @override
  String get submissionFeedbackModalError => 'Impossible de charger les données de gratitude.';

  @override
  String get submissionFeedbackModalViewLog => 'Afficher le journal';

  @override
  String get submissionFeedbackModalClose => 'Fermer';

  @override
  String progressBarSemanticLabel(Object percent) {
    return 'Progression : $percent %';
  }

  @override
  String get surahSelectorSemanticLabel => 'Sélectionner une sourate';

  @override
  String get commentZ => 'Noms et Descriptions de parcours localisables pour les parcours définis par le système';

  @override
  String get pathNameFatihah => 'Sourate Al-Fātiḥah';

  @override
  String get pathDescFatihah => 'Sourate complète (1:1–7). Essentielle dans chaque rakʿah.';

  @override
  String get pathNameKafirun => 'Sourate Al-Kāfirūn';

  @override
  String get pathDescKafirun => 'Sourate complète (109:1–6). Déclaration du Tawḥīd.';

  @override
  String get pathNameIkhlas => 'Sourate Al-Ikhlāṣ';

  @override
  String get pathDescIkhlas => 'Sourate complète (112:1–4). Tawḥīd d’Allah.';

  @override
  String get pathNameFalaq => 'Sourate Al-Falaq';

  @override
  String get pathDescFalaq => 'Sourate complète (113:1–5). Protection contre le mal extérieur.';

  @override
  String get pathNameNas => 'Sourate An-Nās';

  @override
  String get pathDescNas => 'Sourate complète (114:1–6). Protection contre les murmures intérieurs.';

  @override
  String get pathNameAsrBegin => 'Sourate Al-ʿAṣr';

  @override
  String get pathDescAsrBegin => '(103:1–3). Seulement 3 versets mais essentiels pour la « patience ».';

  @override
  String get pathNameTakathur => 'Sourate At-Takāthur';

  @override
  String get pathDescTakathur => '(102:1–8) Au sujet de la compétition mondaine et de la responsabilité.';

  @override
  String get pathNameFil => 'Sourate Al-Fīl';

  @override
  String get pathDescFil => '(105:1–5). L’incident de l’éléphant ; 5 versets courts.';

  @override
  String get pathNameQuraysh => 'Sourate Quraysh';

  @override
  String get pathDescQuraysh => '(106:1–4). Sur la gratitude pour les voyages en sécurité.';

  @override
  String get pathNameRahmanA => 'Ar-Raḥmān A';

  @override
  String get pathDescRahmanA => '(55:1–13) : Enseignement du Coran et création de l’humanité.';

  @override
  String get pathNameRahmanB => 'Ar-Raḥmān B';

  @override
  String get pathDescRahmanB => '(55:26–36) : Responsabilité des humains et des jinns.';

  @override
  String get pathNameYasinBlock => 'Sourate Yā Sīn (Bloc)';

  @override
  String get pathDescYasinBlock => '(36:1–12). Introduction au message du Prophète et avertissements.';

  @override
  String get pathNameMulkBlock => 'Sourate Al-Mulk (Bloc)';

  @override
  String get pathDescMulkBlock => '(67:1–15). Souligne la souveraineté d’Allah et l’importance de la réflexion.';

  @override
  String get pathNameBaqarah21_29 => 'Al-Baqarah (2:21–29)';

  @override
  String get pathDescBaqarah21_29 => '9 versets sur la création et la réflexion pour la gratitude.';

  @override
  String get pathNameNahl66_72 => 'An-Naḥl (16:66–72)';

  @override
  String get pathDescNahl66_72 => '7 versets énumérant les bienfaits : bétail, fruits, etc.';

  @override
  String get pathNameAdDuha => 'Sourate Aḍ-Ḍuḥā';

  @override
  String get pathDescAdDuha => '(93:1–11) 11 versets d’espoir et d’assurance.';

  @override
  String get pathNameKahfCave => 'Al-Kahf : Les Jeunes de la Caverne';

  @override
  String get pathDescKahfCave => '(18:9–16) L’histoire des jeunes croyants dans une caverne.';

  @override
  String get pathNameKahfMusa => 'Al-Kahf : Mūsā & Al-Khiḍr';

  @override
  String get pathDescKahfMusa => '(18:60–70) Souligne la patience et la sagesse cachée.';

  @override
  String get pathNameWaqiah => 'Al-Wāqiʿah (56:1–15)';

  @override
  String get pathDescWaqiah => '15 versets sur l’arrivée soudaine de l’Heure.';

  @override
  String get pathNameAsrPatience => 'Sourate Al-ʿAṣr (Patience)';

  @override
  String get pathDescAsrPatience => '(103:1–3) encore 3 versets, connus pour parler de patience.';

  @override
  String get pathNameBaq153_157 => 'Al-Baqarah (2:153–157)';

  @override
  String get pathDescBaq153_157 => '5 versets : « Cherchez aide dans la patience et la prière. »';

  @override
  String get pathNameYusuf7_14 => 'Sourate Yūsuf (12:7–14)';

  @override
  String get pathDescYusuf7_14 => 'La jalousie des frères de Yusuf. Épreuve de patience.';

  @override
  String get pathNameYusuf83_92 => 'Sourate Yūsuf (12:83–92)';

  @override
  String get pathDescYusuf83_92 => 'La tristesse de Yaʿqūb et le pardon de Yusuf (10 versets).';

  @override
  String get pathNameInshirah => 'Sourate Al-Inshirāḥ (94:1–8)';

  @override
  String get pathDescInshirah => '8 versets : réconfort après l’adversité. Relié à la patience et à l’espoir.';

  @override
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah) {
    return 'Sourate $surahName, Āyah $startAyah-$endAyah';
  }

  @override
  String get finishLabel => 'Terminer';

  @override
  String get twoWordMultipleChoiceLabel => 'Sélectionnez les deux mots corrects';

  @override
  String get singleWordMultipleChoiceLabel => 'Sélectionnez le mot correct';

  @override
  String get correctAnswerLabel => 'Correct !';

  @override
  String get incorrectAnswerLabel => 'Incorrect !';

  @override
  String get lessonCompletedLabel => 'Leçon terminée !';

  @override
  String get profileAnalyticsScoreLabel => 'Analyses & score';

  @override
  String get profileDailyLabel => 'Quotidien';

  @override
  String get profileWeeklyLabel => 'Hebdomadaire';

  @override
  String get profileMonthlyLabel => 'Mensuel';

  @override
  String get profileTotalLabel => 'Total';

  @override
  String get profileViewChart => 'Voir le graphique';

  @override
  String get profileCloseLabel => 'Fermer';

  @override
  String get profileScoreChartTitle => 'Graphique des scores';

  @override
  String get profileScoreChartHistory => 'Historique';

  @override
  String get profileNoData => 'Aucune donnée';

  @override
  String get topBarDailyScoreLabel => '⭐ Aujourd’hui ';

  @override
  String topBarDailyScoreSemantic(Object score) {
    return 'Votre score quotidien est $score';
  }

  @override
  String get profilePremiumNeeded => 'Veuillez passer à la version supérieure pour afficher le calendrier de progression et nous soutenir dans le développement de nouvelles fonctionnalités, Incha’Allah !';

  @override
  String get levelMultipleChoiceLabel => 'Choix multiples';

  @override
  String get levelMultipleChoiceDescription => 'Étapes QCM à un ou deux mots, avec possibilité de sauter des paires.';

  @override
  String get levelBeginnerLabel => 'Débutant';

  @override
  String get levelBeginnerDescription => 'Suppression progressive de mots dans des séquences groupées pour une mémorisation progressive.';

  @override
  String get subscriptionTierScreenPremiumLabel => 'Plus';

  @override
  String get featureUnavailableOffline => 'Fonctionnalité indisponible hors ligne. Connectez-vous ou débloquez le mode hors ligne en passant à Plus ou Pro Beta.';

  @override
  String submissionFeedbackModalTotalCount(Object count) {
    return 'Nombre total de remerciements saisis : $count';
  }

  @override
  String get notificationDailyTitle => 'Rappel doux du Coran';

  @override
  String get notificationWeeklyTitle => 'Bilan hebdomadaire du Coran';

  @override
  String get notificationWeeklyBody => 'Réfléchissez à vos progrès et mémorisez une nouvelle partie du Coran tout en pratiquant la gratitude.';

  @override
  String get notificationChannelDailyRemindersName => 'Rappels quotidiens';

  @override
  String get notificationChannelDailyRemindersDesc => 'Rappels pour la mémorisation quotidienne du Coran';

  @override
  String get notificationChannelWeeklyRemindersName => 'Rappels hebdomadaires';

  @override
  String get notificationChannelWeeklyRemindersDesc => 'Rappels pour la vérification hebdomadaire de la mémorisation du Coran';

  @override
  String get nameEntryNotificationFrequencyDaily => 'Quotidien';

  @override
  String get topBarStreakDialogTitle => 'Série';

  @override
  String get fillInTheBlanksLabel => 'Remplir les blancs';

  @override
  String get loadingDataLabel => 'Chargement…';

  @override
  String ayahRangeLabel(Object start, Object end) {
    return 'Ayah $start - $end';
  }

  @override
  String get nextPageSemanticLabel => 'Page suivante';

  @override
  String get prevPageSemanticLabel => 'Page précédente';

  @override
  String pageXOfYLabel(Object current, Object total) {
    return 'Page $current sur $total';
  }

  @override
  String verseSemanticLabel(Object ayahNumber, Object surahName) {
    return 'Ayah $ayahNumber de la sourate $surahName';
  }

  @override
  String get ayahLabel => 'Ayah';

  @override
  String get goToSurahViewLabel => 'Vue de la sourate';

  @override
  String get clickOnAyaToOpenLesson => 'Cliquez sur n’importe quelle ayah ci-dessous pour démarrer une leçon';

  @override
  String get difficultyChoosingScreenIntro => 'Sélectionnez votre préférence : choix multiples ou remplir les blancs, et le nombre de répétitions de chaque étape et lecture audio.';

  @override
  String get upgradeVoiceUsageMessage => 'Passez à Pro Beta pour essayer la fonctionnalité vocale et nous aider à l’améliorer !';

  @override
  String get restorePurchasesLabel => 'Restaurer les achats';

  @override
  String get subscriptionTierScreenMonthly => 'Mensuel';

  @override
  String get subscriptionTierScreenYearly => 'Annuel';

  @override
  String get subscriptionTierScreenFreePrice => 'Gratuit';

  @override
  String get subscriptionTierScreenPremiumMonthlyPrice => 'Maintenant 3 \$/mois (au lieu de 5 \$)';

  @override
  String get subscriptionTierScreenPremiumYearlyPrice => 'Maintenant 28 \$/an (au lieu de 60 \$)';

  @override
  String get subscriptionTierScreenPremiumPlusMonthlyPrice => 'Maintenant 7 \$/mois (au lieu de 10 \$)';

  @override
  String get subscriptionTierScreenPremiumPlusYearlyPrice => 'Maintenant 45 \$/an (au lieu de 84 \$)';

  @override
  String get subscriptionPurchaseError => 'Erreur lors de l’achat de l’abonnement';

  @override
  String get topBarExplorePlansLabel => 'Découvrir les forfaits';

  @override
  String get topBarBackHomeLabel => 'Retour à l’accueil';

  @override
  String get profileRequiresPlanUpdate => 'Nécessite une mise à jour de l’abonnement';

  @override
  String get subscriptionTierScreenPremiumDescription => 'Tout ce qui est disponible dans la version gratuite, plus l’apprentissage hors ligne et les retours, l’analyse historique, ainsi que les barres de progression, le profil et la personnalisation du Coran. Soutenez-nous pour développer plus de fonctionnalités !';

  @override
  String get subscriptionAutoRenewNotice => 'L’abonnement se renouvelle automatiquement et peut être annulé pour éviter d’être facturé lors de la prochaine période. Une partie des fonds sera versée à Islamic Relief via l’initiative Almubtasim 😀.';

  @override
  String get subscriptionTierScreenSubscribeLabel => 'S’abonner';

  @override
  String get subscriptionTierScreenFinalMessage => 'Nous apprécions votre soutien !';

  @override
  String get subscriptionPurchaseRestoreSuccess => 'Vos achats ont été restaurés avec succès.';

  @override
  String get subscriptionTierScreenRestoreLabel => 'Restaurer les achats';

  @override
  String get arabicLabel => 'Arabe';

  @override
  String get transliterationLabel => 'Anglais';

  @override
  String get surahSearchScreenTitle => 'Recherche de Sourate';

  @override
  String get genericBack => 'Retour';

  @override
  String get surahSearchSelectSurah => 'Sélectionnez une Sourate :';

  @override
  String get surahSearchExistingPaths => 'Chemins existants pour cette Sourate';

  @override
  String get surahSearchNoMatches => 'Aucun chemin existant trouvé.';

  @override
  String get surahSearchHideCreateForm => 'Masquer le formulaire de création';

  @override
  String get surahSearchShowCreateForm => 'Créer un nouveau chemin pour la Sourate';

  @override
  String get createPathTrackProgress => 'Suivre la progression ?';

  @override
  String get themeScreenSearchIconSemantic => 'Rechercher des sourates';

  @override
  String get pathListSearchIconSemantic => 'Rechercher des sourates';

  @override
  String get pathLessonsSearchIconSemantic => 'Rechercher des sourates';

  @override
  String get playAllSurahSemantic => 'Lire la sourate entière';

  @override
  String get toggleTransliterationLabel => 'Basculer la translittération';

  @override
  String get englishLabel => 'Anglais';

  @override
  String get subscriptionTierScreenPremiumPlusLabel => 'Nous soutenir (Annuel)';

  @override
  String get subscriptionTierScreenFreeDescription => 'Toutes les fonctionnalités sont gratuites et sans publicité !';

  @override
  String get subscriptionTierScreenPremiumPlusDescription => 'Aidez à financer de nouvelles fonctionnalités et améliorations ! De plus, investir une petite somme peut aider à ancrer l’habitude !';

  @override
  String get subscriptionTierScreenSupportLabel => 'Soutien Annuel';

  @override
  String get verticalLessonIconsDialogBody => 'Toutes les fonctionnalités sont disponibles dans la version gratuite, mais si vous le souhaitez, vous pouvez nous soutenir afin de développer davantage de fonctionnalités. Une partie de votre abonnement est versée à Islamic Relief. Jazāk Allāhu Khayran !';

  @override
  String get welcomeBody => 'Hudhud a joué un rôle spécial en aidant le prophète Souleiman [AS] en observant et en transmettant des messages.\n\nIl ne vous juge pas, peu importe où vous en êtes dans votre cheminement, et il est enthousiaste à l’idée de vous guider pour découvrir la beauté du Coran et intégrer des rappels de gratitude afin de profiter de chaque instant avec lui.';

  @override
  String get surahSearchByName => 'Rechercher par nom (en anglais ou en arabe)';

  @override
  String get surahSearchHintAnyName => 'Tapez le nom de n’importe quelle sourate...';

  @override
  String get surahSearchFieldLabel => 'Rechercher une sourate';

  @override
  String get surahSearchInvalidLessonsError => 'Une ou plusieurs leçons ne sont pas valides. Impossible de créer le chemin.';

  @override
  String get surahSearchUserSurahPrefix => 'Sourate utilisateur';

  @override
  String get notificationDailyBody => 'Prenez un instant pour trouver la paix grâce au Coran et rappelez-vous pourquoi vous êtes reconnaissant aujourd’hui.';
}
