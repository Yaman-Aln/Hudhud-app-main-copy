import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get commentA => 'Claves de pantalla de introducción';

  @override
  String get appBarTitleWelcome => 'Bienvenido';

  @override
  String get skipLabel => 'Omitir';

  @override
  String get welcomeHeadline => '¡Bienvenido a Quran con Hudhud!';

  @override
  String get getStartedLabel => 'Comenzar';

  @override
  String get commentB => 'Claves de pantalla de la lección';

  @override
  String get lessonScreenAppBarTitle => 'Lección';

  @override
  String get noAyahAvailable => 'No hay ninguna aleya disponible para reproducir.';

  @override
  String audioNotFound(Object url) {
    return 'Audio no encontrado en $url';
  }

  @override
  String get restartLessonTitle => 'Reiniciar la lección';

  @override
  String get resetLessonBody => '¿Restablecer todo tu progreso de esta lección?';

  @override
  String get cancelLabel => 'Cancelar';

  @override
  String get yesLabel => 'Sí';

  @override
  String get errorResettingLesson => 'Error al restablecer la lección';

  @override
  String get startLabel => 'Iniciar';

  @override
  String get submitLabel => 'Enviar';

  @override
  String get nextLabel => 'Siguiente';

  @override
  String get voiceErrorMicDeniedTitle => 'Micrófono Denegado';

  @override
  String get voiceErrorMicDeniedBody => 'La grabación requiere acceso al micrófono. Por favor, concede el permiso en Configuración.';

  @override
  String get voiceErrorMicDeniedSemanticLabel => 'Diálogo de permiso de micrófono denegado';

  @override
  String get voiceErrorRecorderStartTitle => 'Error de Grabación';

  @override
  String get voiceErrorRecorderStartBody => 'No se pudo iniciar el grabador. Por favor, inténtalo de nuevo.';

  @override
  String get voiceErrorRecorderStartSemanticLabel => 'Diálogo de error al iniciar el grabador';

  @override
  String get voiceErrorRecorderStopTitle => 'Error al Detener la Grabación';

  @override
  String get voiceErrorRecorderStopBody => 'No se pudo detener correctamente el grabador. Por favor, inténtalo de nuevo.';

  @override
  String get voiceErrorRecorderStopSemanticLabel => 'Diálogo de error al detener el grabador';

  @override
  String get voiceErrorNoSoundTitle => 'No se detectó sonido';

  @override
  String get voiceErrorNoSoundBody => 'Tu grabación estaba en silencio o demasiado baja. Por favor, inténtalo de nuevo.';

  @override
  String get voiceErrorNoSoundSemanticLabel => 'Diálogo sin sonido detectado';

  @override
  String get voiceErrorTranscriptionTitle => 'Error de Transcripción';

  @override
  String get voiceErrorTranscriptionBody => 'No pudimos transcribir tu grabación. Verifica tu conexión e inténtalo de nuevo.';

  @override
  String get voiceErrorTranscriptionSemanticLabel => 'Diálogo de error de transcripción';

  @override
  String get tapColoredWordsHint => 'Toca las palabras resaltadas para ver la versión corregida.';

  @override
  String get emptyInputWarning => 'Debes escribir algo antes de enviar';

  @override
  String get getHintLabel => 'Obtener pista';

  @override
  String get removeHintLabel => 'Quitar pista';

  @override
  String get typeTheMissingWordsLabel => 'Escribe la(s) palabra(s) que faltan';

  @override
  String get difficultyLabel => 'Dificultad';

  @override
  String get repeatCountLabel => '# de Repeticiones';

  @override
  String get backButtonLabel => 'Atrás';

  @override
  String get toggleTranslationLabel => 'Alternar traducción en línea';

  @override
  String get openTranslationScreenLabel => 'Abrir pantalla de traducción';

  @override
  String get restartLessonSemanticLabel => 'Reiniciar la lección';

  @override
  String get verseDisplayAreaLabel => 'Área de visualización de versículos del Corán';

  @override
  String get playAudioSemanticLabel => 'Reproducir audio de la aleya';

  @override
  String get openGratitudeSemanticLabel => 'Abrir ventana modal de gratitud';

  @override
  String get voiceUsageSemanticLabel => 'Uso de voz en minutos';

  @override
  String get voiceRecordSemanticLabel => 'Iniciar o detener la grabación de voz';

  @override
  String get commentC => 'Nuevos textos de la pantalla de INICIO';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get noPathsLabel => 'No hay rutas válidas disponibles.';

  @override
  String errorLoadingActivePath(Object err) {
    return 'Error al cargar la ruta activa: $err';
  }

  @override
  String get verticalLessonIconsGoToTheme => 'Ir al Tema';

  @override
  String get homePathCardLabel => 'Toca para abrir la pantalla del tema';

  @override
  String get arrowForwardSemanticLabel => 'Abrir detalles';

  @override
  String get noTrackProgressLabel => 'Esta ruta no registra el progreso.';

  @override
  String get premiumRequiredLabel => 'Mejora el plan para desbloquear la funcionalidad de progreso. ¡Apóyanos para crear más funciones!';

  @override
  String get completedLabel => 'completado';

  @override
  String get fabLogGratitudeLabel => 'Toca para registrar gratitud';

  @override
  String get errorNavigatingToLesson => 'Error al navegar a la lección';

  @override
  String get commentD => 'Textos de la pantalla de perfil';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileBackArrowLabel => 'Volver a la pantalla anterior';

  @override
  String get profileAvatarSemanticLabel => 'Avatar de usuario';

  @override
  String get profileEnterYourName => 'Ingresa tu nombre';

  @override
  String get nameEntryNotificationFrequencyDropdownLabel => 'Frecuencia de notificaciones';

  @override
  String get nameEntryNotificationFrequencyWeekly => 'Semanal';

  @override
  String get nameEntryNotificationFrequencyNone => 'Ninguno';

  @override
  String get notificationPermissionPrompt => 'Nos gustaría enviarte recordatorios suaves para completar tus envíos de gratitud o lecciones; por favor, permite notificaciones si deseas que te ayudemos a construir el hábito 😃.';

  @override
  String get profileNameSave => 'Guardar';

  @override
  String get profileNameCancel => 'Cancelar';

  @override
  String get profileNameGuest => 'Invitado';

  @override
  String get profileNameEdit => 'Editar';

  @override
  String get profilePreferredLanguage => 'Idioma:';

  @override
  String get okLabel => 'OK';

  @override
  String get profileReciterLabel => 'Recitador';

  @override
  String get profileFontLabel => 'Fuente:';

  @override
  String get profileReciterMishary => 'Mishary Rashid Al-Afasy';

  @override
  String get profileReciterShatri => 'Abu Bakr Al-Shatri';

  @override
  String get profileReciterQatami => 'Nasser Al Qatami';

  @override
  String get profileUpgradePremiumTitle => '¡Desbloquea más personalización!';

  @override
  String get profileUpgradePremiumBody => 'Puedes disfrutar cambiando fuentes y recitadores al mejorar a Pro. ¡Apoya nuestros esfuerzos continuos y personaliza aún más tu experiencia!';

  @override
  String get profileWeeksProgress => 'MashAllah, aquí está tu progreso de la semana:';

  @override
  String get profileGratefulnessCalendar => 'Calendario de Gratitud';

  @override
  String get profileQuranLearningCalendar => 'Calendario de Aprendizaje del Corán';

  @override
  String get profilePrevWeekSemantic => 'Ir a la semana anterior';

  @override
  String get profileNextWeekSemantic => 'Ir a la semana siguiente';

  @override
  String get profileNotificationFrequency => 'Frecuencia de notificaciones';

  @override
  String get commentE => 'Textos de la pantalla de Registro de Gratitud';

  @override
  String get gratitudeLogTitle => 'Mi Registro de Gratitud';

  @override
  String get gratitudeLogBackArrowSemantic => 'Volver a inicio';

  @override
  String get gratitudeLogClearAllSemantic => 'Borrar todas las entradas de gratitud';

  @override
  String get gratitudeLogAddSemantic => 'Agregar nueva entrada de gratitud';

  @override
  String get gratitudeLogClearDialogTitle => 'Borrar Registro de Gratitud';

  @override
  String get gratitudeLogClearDialogBody => '¿Estás seguro de que deseas borrar todas tus entradas de gratitud? Esta acción no se puede deshacer.';

  @override
  String get gratitudeLogClearConfirm => 'Sí, Borrar';

  @override
  String gratitudeLogStreak(Object days) {
    return '⭐ Racha de Gratitud: $days días';
  }

  @override
  String get gratitudeLogStreakLoading => 'Calculando racha...';

  @override
  String get gratitudeLogStreakError => 'No se pudo calcular la racha.';

  @override
  String gratitudeLogTotalDays(Object count) {
    return 'Total de Días de Gratitud: $count';
  }

  @override
  String get gratitudeLogDataLoading => 'Cargando datos de gratitud...';

  @override
  String get gratitudeLogDataError => 'No se pudieron cargar los datos de gratitud.';

  @override
  String get gratitudeLogCardSemantic => 'Tarjeta de entrada de gratitud';

  @override
  String get gratitudeLogItemIcon => 'Ícono de gratitud';

  @override
  String get gratitudeLogEmptyIconSemantic => 'Toca para agregar tu primera gratitud';

  @override
  String get gratitudeLogEmptyMessage => 'Aún no hay entradas de gratitud.\n¡Toca el “+” para agregar tu primera gratitud!';

  @override
  String get gratitudeLogEntriesAdded => '¡Las gratitudes se agregaron con éxito!';

  @override
  String get gratitudeLogEntriesFailed => 'No se pudieron agregar las gratitudes. Por favor, inténtalo de nuevo.';

  @override
  String get commentF => 'Textos de la pantalla de finalización de la lección';

  @override
  String get lessonCompletedTitle => 'Lección Completada';

  @override
  String get lessonCompletedBackArrowSemantic => 'Volver a inicio';

  @override
  String get lessonCompletedMashaAllah => '¡MashaAllah!';

  @override
  String get lessonCompletedMashaAllahSemantic => 'Texto de felicitaciones';

  @override
  String get lessonCompletedMessage => '¡Has completado esta lección!';

  @override
  String get lessonCompletedImageSemantic => 'Ilustración de Hudhud con el Corán';

  @override
  String get lessonCompletedGoBackSemantic => 'Volver a la selección de la ruta';

  @override
  String get lessonCompletedGoBackButton => 'Volver a la Ruta';

  @override
  String get lessonCompletedRestartSemantic => 'Reiniciar la lección';

  @override
  String get lessonCompletedRestartButton => 'Reiniciar Lección';

  @override
  String get lessonCompletedEncouragement => '¡Sigue con el gran trabajo!';

  @override
  String get commentG => 'Textos de la pantalla de Temas';

  @override
  String get themeScreenTitle => 'Temas';

  @override
  String get themeNameCoreRecitation => 'Recitación Diaria Esencial';

  @override
  String get themeNameBeginJourney => 'Iniciando el Viaje';

  @override
  String get themeNameMercyAndHope => 'Misericordia y Esperanza';

  @override
  String get themeNameGratitudeReflection => 'Gratitud y Reflexión';

  @override
  String get themeNameStoriesReminders => 'Historias, Lecciones y Recordatorios';

  @override
  String get themeNamePatience => 'Paciencia (Ṣabr)';

  @override
  String get themeNameUserCreated => 'Creado por el Usuario';

  @override
  String get themeScreenNoThemesLabel => 'No hay temas disponibles';

  @override
  String get themeScreenBackArrowSemantic => 'Volver';

  @override
  String get themeScreenThemeCardSemantic => 'Toca para abrir las rutas del tema';

  @override
  String get themeScreenLockIconSemantic => 'Tema bloqueado. Requiere mejora de plan.';

  @override
  String get pathListExploreOtherThemes => 'Explorar Otros Temas';

  @override
  String get themeScreenUserCreatedSubtitle => 'Creado por ti: personalízalo como quieras.';

  @override
  String get themeSubtitleCoreRecitation => 'Suras esenciales para las oraciones diarias y la protección.';

  @override
  String get themeSubtitleBeginJourney => 'Suras cortas para comenzar tu viaje coránico.';

  @override
  String get themeSubtitleMercyAndHope => 'Reflexiona sobre la compasión de Allah y fomenta la esperanza.';

  @override
  String get themeSubtitleGratitudeReflection => 'Cultiva la gratitud y la introspección a través de aleyas seleccionadas.';

  @override
  String get themeSubtitleStoriesReminders => 'Explora narraciones coránicas que guían y recuerdan.';

  @override
  String get themeSubtitlePatience => 'Suras y pasajes que enfatizan la paciencia y la perseverancia.';

  @override
  String get themeSubtitleDefault => 'Un conjunto dedicado de suras para un crecimiento espiritual más profundo.';

  @override
  String get themeScreenRequiredPremium => 'Requiere Premium';

  @override
  String get themeScreenRequiredPremiumPlus => 'Requiere Pro Beta';

  @override
  String get commentH => 'Textos de la pantalla de lista de rutas (Path List)';

  @override
  String get pathListScreenTitle => 'Rutas del Tema';

  @override
  String get pathListScreenBackArrowSemantic => 'Volver';

  @override
  String get pathListScreenAddIconSemantic => 'Agregar nueva ruta';

  @override
  String get pathListAddNewPathTooltip => 'Agregar Nueva Ruta';

  @override
  String get pathListScreenAddIconSemanticEmpty => 'Toca para agregar tu primera ruta';

  @override
  String get pathListEmptyMessage => 'Aún no hay rutas.\n¡Toca “+” para crear tu primera ruta!';

  @override
  String get pathListUnavailableLabel => 'Esta ruta no está disponible actualmente';

  @override
  String get pathListThemeLabel => 'Tema';

  @override
  String get pathListPathCardSemantic => 'Toca para abrir detalles de la ruta';

  @override
  String get pathListCompleteIconSemantic => 'Ruta completada';

  @override
  String get pathListInProgressIconSemantic => 'Ruta en progreso';

  @override
  String get pathListInvalidIconSemantic => 'Ruta inválida o no disponible';

  @override
  String get pathListErrorLoadingPaths => 'Error al cargar rutas:';

  @override
  String get commentI => 'Textos de la pantalla de Detalles de la Ruta (Path Detail)';

  @override
  String get pathDetailScreenTitle => 'Detalles de la Ruta';

  @override
  String get pathDetailScreenBackArrowSemantic => 'Volver a la lista de rutas';

  @override
  String get pathDetailScreenNotFound => 'Ruta no encontrada.';

  @override
  String get pathDetailScreenFailToUpdate => 'No se pudo actualizar el progreso de la ruta:';

  @override
  String get pathDetailScreenProgressDisabled => 'El progreso está deshabilitado para esta ruta.';

  @override
  String get pathDetailScreenLessonsHeading => 'Lecciones:';

  @override
  String get pathDetailScreenNoLessonsLabel => 'No hay lecciones disponibles.';

  @override
  String get pathDetailScreenErrorLoading => 'Error al cargar la ruta o lecciones:';

  @override
  String get pathDetailScreenLessonCardSemantic => 'Toca para abrir detalles de la lección';

  @override
  String get pathDetailScreenLessonCompleteIconSemantic => 'Lección completada';

  @override
  String get pathDetailScreenLessonInProgressIconSemantic => 'Lección en progreso';

  @override
  String get pathDetailScreenLessonInvalidIconSemantic => 'Lección inválida o no disponible';

  @override
  String get pathDetailScreenLessonProgressUnavailable => 'Progreso no disponible';

  @override
  String get pathDetailScreenLessonNoProgress => 'No hay progreso para esta ruta';

  @override
  String get pathDetailScreenLessonUpgrade => 'Mejora el plan para la funcionalidad de progreso.';

  @override
  String pathDetailScreenLessonProgressLabel(Object progress) {
    return 'Progreso: $progress%';
  }

  @override
  String pathDetailScreenLessonTitle(Object lessonIndex, Object surahName, Object startAyah, Object endAyah) {
    return 'Lección $lessonIndex: $surahName - Aleya $startAyah-$endAyah';
  }

  @override
  String get commentJ => 'Textos de la pantalla de Crear Ruta';

  @override
  String get createPathTitle => 'Crear Nueva Ruta';

  @override
  String get createPathBackArrowSemantic => 'Volver a la pantalla anterior';

  @override
  String get createPathNameLabel => 'Nombre de la Ruta';

  @override
  String get createPathNameValidation => 'Ingresa un nombre para la ruta';

  @override
  String get createPathDescriptionLabel => 'Descripción';

  @override
  String get createPathDescriptionValidation => 'Ingresa una descripción';

  @override
  String get createPathSurahSelectorLabel => 'Selecciona la Sura:';

  @override
  String get createPathStartAyahLabel => 'Aleya de Inicio';

  @override
  String get createPathNumAyahsLabel => 'Número de Aleyas en la Ruta';

  @override
  String get createPathEndAyahLabel => 'Aleya de Fin';

  @override
  String get createPathWordsPerLessonLabel => 'Palabras por Lección';

  @override
  String get createPathWordsSuffix => 'palabras';

  @override
  String get createPathInvalidRange => 'Rango inválido';

  @override
  String get createPathAyahsSuffix => 'Aleyas';

  @override
  String get createPathCreateButton => 'Crear Ruta';

  @override
  String get createPathSubmitSemantic => 'Toca para crear la ruta';

  @override
  String get commentK => 'Textos de la pantalla de Traducción';

  @override
  String get translationScreenTitle => 'Traducción';

  @override
  String get translationScreenBackArrowSemantic => 'Volver a la lección';

  @override
  String get translationScreenLoadingSemantic => 'Cargando traducciones';

  @override
  String get translationScreenNoTranslations => 'No hay traducciones disponibles.';

  @override
  String get translationScreenReturnButton => 'Volver a la Lección';

  @override
  String get translationScreenReturnSemantic => 'Toca para volver a la lección';

  @override
  String get translationScreenLoadError => 'Error al cargar las traducciones:';

  @override
  String get commentL => 'Textos de la pantalla de Selección de Idioma';

  @override
  String get languageSelectionScreenSemantic => 'Pantalla de Selección de Idioma';

  @override
  String get languageSelectionTitle => 'Selecciona tu Idioma';

  @override
  String get languageSelectionBackSemantic => 'Atrás';

  @override
  String get languageSelectionSkipSemantic => 'Omitir selección';

  @override
  String get languageSelectionInstructions => 'Por favor, elige tu idioma preferido:';

  @override
  String get languageSelectionNextSemantic => 'Toca para confirmar la elección de idioma';

  @override
  String get languageSelectionNextLabel => 'Siguiente';

  @override
  String get languageSelectionImageSemantic => 'Ilustración de Hudhud con el Corán';

  @override
  String get commentM => 'Textos de la pantalla de Bienvenida (Onboarding)';

  @override
  String get welcomeScreenSemantic => 'Pantalla de Bienvenida de Onboarding';

  @override
  String get welcomeScreenLogoSemantic => 'Ilustración de Hudhud con el Corán';

  @override
  String get welcomeScreenSkipSemantic => 'Omitir el paso de bienvenida';

  @override
  String get welcomeScreenNextSemantic => 'Proceder al siguiente paso de introducción';

  @override
  String get commentN => 'Textos de la pantalla de Información de Hudhud';

  @override
  String get hudhudInfoSemantic => 'Pantalla de Información de Hudhud';

  @override
  String get hudhudInfoAppBarTitle => 'Conoce a Hudhud';

  @override
  String get hudhudInfoIllustrationSemantic => 'Ilustración de Hudhud';

  @override
  String get hudhudInfoBody1 => 'Hudhud, también conocido como la abubilla, desempeñó un papel especial al ayudar al Profeta Suleiman [AS] al observar y transmitir mensajes.';

  @override
  String get hudhudInfoBody2 => 'La historia de Hudhud nos recuerda que incluso una criatura pequeña puede tener un gran impacto al ser observadora, curiosa y proactiva en lo correcto. En nuestro viaje, podemos poner nuestra atención constante en la belleza del Corán e integrar recordatorios de gratitud para apreciar cada momento de progreso.';

  @override
  String get hudhudInfoBody3 => 'Siguiendo el ejemplo de Hudhud —mantenernos atentos y comprometidos— esperamos profundizar nuestra conexión con el Corán y fomentar un sentido de gratitud en la vida diaria.';

  @override
  String get hudhudInfoNextLabel => 'Siguiente';

  @override
  String get hudhudInfoNextSemantic => 'Proceder a la siguiente sección';

  @override
  String get hudhudInfoSkipSemantic => 'Omitir la información de Hudhud';

  @override
  String get commentO => 'Textos de la pantalla de Selección de Nivel de Suscripción (Subscription Tier)';

  @override
  String get subscriptionTierScreenSemantic => 'Pantalla de Selección de Nivel de Suscripción';

  @override
  String get subscriptionTierScreenAppBarTitle => 'Elige tu Plan';

  @override
  String get subscriptionTierScreenSkipSemantic => 'Omitir la selección de nivel de suscripción';

  @override
  String get subscriptionTierScreenFreeLabel => 'Gratis';

  @override
  String get subscriptionTierScreenSmileySemantic => 'Ícono de cara sonriente';

  @override
  String get subscriptionTierScreenDonationText => 'Una parte de los fondos se destinará a la Iniciativa Almubtasim, ayudando a huérfanos a través de Islamic Relief.';

  @override
  String get subscriptionTierScreenConfirmSemantic => 'Confirmar selección de nivel de suscripción';

  @override
  String get subscriptionTierScreenNextLabel => 'Siguiente';

  @override
  String subscriptionTierScreenRadioSemantic(Object title) {
    return 'Toca para seleccionar el nivel de suscripción $title';
  }

  @override
  String get commentP => 'Textos de la pantalla de Selección de Metas';

  @override
  String get goalSelectionScreenSemantic => 'Pantalla de Selección de Metas';

  @override
  String get goalSelectionScreenAppBarTitle => 'Selecciona tus Metas';

  @override
  String get goalSelectionScreenSkipSemantic => 'Omitir selección de metas';

  @override
  String get goalSelectionScreenIntroText => '¿Cuáles de las siguientes metas te interesan? Puedes seleccionar varias opciones.';

  @override
  String get goalSelectionScreenNextSemantic => 'Confirmar selección de metas';

  @override
  String get goalSelectionScreenNextLabel => 'Siguiente';

  @override
  String goalSelectionTileSemantic(Object goalTitle) {
    return 'Toca para seleccionar o anular la selección de la meta $goalTitle';
  }

  @override
  String get goalConnectQuranTitle => 'Conectarte más con el Corán';

  @override
  String get goalConnectQuranDesc => 'Mejora tu relación a través de la lectura o reflexión.';

  @override
  String get goalMemorizeQuranTitle => 'Memorizar el Corán';

  @override
  String get goalMemorizeQuranDesc => 'Emprende un viaje de memorización.';

  @override
  String get goalBeMoreGratefulTitle => 'Ser más agradecido y feliz en la vida';

  @override
  String get goalBeMoreGratefulDesc => 'Concéntrate en prácticas de gratitud diarias.';

  @override
  String get goalBuildConsistencyTitle => 'Desarrollar constancia';

  @override
  String get goalBuildConsistencyDesc => 'Construye un hábito diario o semanal.';

  @override
  String get goalImproveArabicTitle => 'Mejorar mi árabe';

  @override
  String get goalImproveArabicDesc => 'Enfócate en las habilidades escritas o habladas.';

  @override
  String get goalDeepenTafsirTitle => 'Profundizar Tafsir';

  @override
  String get goalDeepenTafsirDesc => 'Estudia el comentario y los significados más profundos del Corán.';

  @override
  String get goalOtherTitle => 'Otro';

  @override
  String get goalOtherDesc => 'Busca cualquier otro objetivo personal.';

  @override
  String get commentQ => 'Textos de la pantalla de Selección de Nivel';

  @override
  String get levelSelectionScreenSemantic => 'Pantalla de Selección de Nivel';

  @override
  String get levelSelectionScreenAppBarTitle => 'Selecciona tu Nivel';

  @override
  String get levelSelectionScreenSkipSemantic => 'Omitir selección de nivel';

  @override
  String get levelSelectionScreenIntroText => 'Por favor, selecciona la opción que mejor describa tu nivel actual de recitación:';

  @override
  String get levelStarterLabel => 'Principiante';

  @override
  String get levelStarterDescription => 'Aprendiz nuevo u ocasional, comenzando a explorar la recitación del Corán.';

  @override
  String get levelAdvancedLabel => 'Avanzado';

  @override
  String get levelAdvancedDescription => 'Cómodo leyendo escritura árabe con algo de conocimiento de tajweed.';

  @override
  String get levelQariLabel => 'Qari';

  @override
  String get levelQariDescription => 'Experto en recitación con dominio sólido de tajweed.';

  @override
  String get levelSelectionNextSemantic => 'Confirmar selección de nivel';

  @override
  String get levelSelectionNextLabel => 'Siguiente';

  @override
  String levelSelectionTileSemantic(Object levelTitle) {
    return 'Toca para seleccionar la opción de nivel de recitación $levelTitle';
  }

  @override
  String get commentR => 'Textos de la pantalla de Finalización de la Introducción';

  @override
  String get onboardingCompletionScreenSemantic => 'Pantalla de Finalización de la Introducción';

  @override
  String get onboardingCompletionScreenAppBarTitle => '¡Todo Listo!';

  @override
  String get onboardingCompletionScreenImageSemantic => 'Ilustración de Hudhud con el Corán';

  @override
  String get onboardingCompletionScreenBody1 => '¡Felicidades! Has completado con éxito la configuración. Esperamos que este viaje te acerque al Corán y mejore tu gratitud hacia Allah. \n \nQue esta aplicación sea una fuente de crecimiento y bendiciones en tu vida y en la de quienes te rodean.';

  @override
  String get onboardingCompletionScreenBody2 => 'Cuando estés listo, toca el botón de abajo para continuar. Las funciones principales de memorización y progreso te esperan, y puedes registrar tu gratitud o elegir una ruta desde la barra de navegación.';

  @override
  String get onboardingCompletionScreenBody3 => 'Esta es una versión inicial — agradecemos tu apoyo y paciencia, y esperamos ofrecerte aún más funciones muy pronto inshAllah.';

  @override
  String get onboardingCompletionScreenBeginSemantic => 'Comenzar a usar la aplicación';

  @override
  String get onboardingCompletionScreenBeginLabel => 'Empecemos';

  @override
  String get commentS => 'Textos de la pantalla de Entrada de Nombre';

  @override
  String get nameEntryScreenSemantic => 'Pantalla de Entrada de Nombre';

  @override
  String get nameEntryScreenAppBarTitle => 'Tu perfil';

  @override
  String get nameEntryScreenSkipSemantic => 'Omitir la introducción de tu nombre';

  @override
  String get nameEntryScreenIntroText => '¿Cuál es tu nombre?';

  @override
  String get nameEntryTextFieldSemantic => 'Campo de texto para el nombre';

  @override
  String get nameEntryNextSemantic => 'Confirmar la entrada del nombre';

  @override
  String get nameEntryNextLabel => 'Siguiente';

  @override
  String get commentT => 'Textos para VerticalLessonIcons';

  @override
  String get verticalLessonIconsSemantic => 'Contenedor de Íconos de Lecciones Verticales';

  @override
  String get verticalLessonIconsNoLessons => 'No se encontraron lecciones.';

  @override
  String get verticalLessonIconsLoadingSurah => 'Cargando detalles de la sura';

  @override
  String get verticalLessonIconsErrorSurah => 'Error al cargar los detalles de la sura';

  @override
  String get verticalLessonIconsSurahHeaderSemantic => 'Encabezado de detalles de la sura';

  @override
  String get verticalLessonIconsHudhudIconSemantic => 'Ícono de ayuda de Hudhud';

  @override
  String get verticalLessonIconsNextPageSemantic => 'Flecha de siguiente página';

  @override
  String get verticalLessonIconsPreviousPageSemantic => 'Flecha de página anterior';

  @override
  String get verticalLessonIconsLoadingProgress => 'Cargando progreso de la lección';

  @override
  String get verticalLessonIconsErrorProgress => 'Error al cargar el progreso';

  @override
  String verticalLessonIconSemantic(Object surahAyahRange, Object percent) {
    return 'Ícono de la lección, $surahAyahRange, el progreso es $percent%';
  }

  @override
  String get verticalLessonIconsCompletedSemantic => 'Lección completada';

  @override
  String get verticalLessonIconsDialogTitle => 'Soporte y Mejora';

  @override
  String get verticalLessonIconsDialogOk => 'OK';

  @override
  String get commentU => 'Textos de la barra de navegación (Navbar)';

  @override
  String get navBarSemanticLabel => 'Barra de navegación inferior';

  @override
  String get navHomeLabel => 'Inicio';

  @override
  String get navHomeSemantic => 'Pestaña de Inicio';

  @override
  String get navQuranLabel => 'Corán';

  @override
  String get navQuranSemantic => 'Pestaña Corán';

  @override
  String get navGratitudeLabel => 'Gratitud';

  @override
  String get navGratitudeSemantic => 'Pestaña de Gratitud';

  @override
  String get navProfileLabel => 'Perfil';

  @override
  String get navProfileSemantic => 'Pestaña de Perfil';

  @override
  String get commentV => 'Textos de la barra superior (TopBar)';

  @override
  String get topBarSemanticLabel => 'Barra de navegación superior';

  @override
  String topBarTitleSemantic(Object title) {
    return 'Título de la barra superior: $title';
  }

  @override
  String topBarStreakIconSemantic(Object days) {
    return 'Ícono de racha: $days días';
  }

  @override
  String get topBarStreakDialogBody => 'Esto muestra cuántos días consecutivos has recitado o escrito una gratitud. ¡Sigue así para mantener o incrementar tu racha!';

  @override
  String get topBarHudhudIconSemantic => 'Ícono de Hudhud, toca para soporte';

  @override
  String get topBarHudhudDialogTitle => 'Soporte y Mejora';

  @override
  String get topBarHudhudDialogBody => 'Todas las funciones están en la versión gratuita, pero si lo deseas, puedes apoyarnos a crear más. Parte de tu suscripción se dona a Islamic Relief. ¡Jazāk Allāhu Khayran!';

  @override
  String get commentW => 'Textos de la ventana modal de Gratitud';

  @override
  String get gratitudeModalSemantic => 'Diálogo Modal de Gratitud';

  @override
  String get gratitudeModalTitle => '¿Por qué estás agradecido hoy basándote en estos versículos?';

  @override
  String gratitudeModalHint(Object index) {
    return 'Alhamdulilah por (ingresa gratitud) #$index';
  }

  @override
  String gratitudeModalTextFieldSemantic(Object index) {
    return 'Ingresa gratitud #$index';
  }

  @override
  String get gratitudeModalEmptyWarning => 'Por favor, ingresa al menos una gratitud.';

  @override
  String get gratitudeModalSubmitError => 'No se pudo registrar la gratitud. Por favor, inténtalo de nuevo.';

  @override
  String get dailyVoiceLimitReachedTitle => '¡MashaAllah!';

  @override
  String get dailyVoiceLimitReachedMessage => 'Has completado 10 minutos de recitación del Corán con voz. Continúa revisando por escrito y sigue recitando mañana.';

  @override
  String get upgradeVoiceUsageTitle => 'Mejorar a Premium';

  @override
  String get gratitudeModalLoadingSemantic => 'Envío de gratitud en progreso';

  @override
  String get commentX => '== NUEVAS CLAVES para submission_feedback_modal, progress_bar, surah_selector ==';

  @override
  String get submissionFeedbackModalSemanticLabel => 'Diálogo de retroalimentación de envío';

  @override
  String get submissionFeedbackModalTitle => 'Retroalimentación de Envío';

  @override
  String get submissionFeedbackModalNoNew => 'No se enviaron nuevas gratitudes.';

  @override
  String get submissionFeedbackModalYouSubmitted => 'Enviaste estas gratitudes:';

  @override
  String submissionFeedbackModalStreak(Object days) {
    return 'Racha de gratitud actual: $days días';
  }

  @override
  String submissionFeedbackModalTotalDays(Object count) {
    return 'Total de días de gratitud: $count';
  }

  @override
  String get submissionFeedbackModalLoading => 'Cargando tus datos de gratitud...';

  @override
  String get submissionFeedbackModalError => 'No se pudieron cargar los datos de gratitud.';

  @override
  String get submissionFeedbackModalViewLog => 'Ver Registro';

  @override
  String get submissionFeedbackModalClose => 'Cerrar';

  @override
  String progressBarSemanticLabel(Object percent) {
    return 'Progreso: $percent%';
  }

  @override
  String get surahSelectorSemanticLabel => 'Seleccionar una Sura';

  @override
  String get commentZ => 'Nombres y descripciones de rutas localizables para rutas definidas por el sistema';

  @override
  String get pathNameFatihah => 'Sura Al-Fātiḥah';

  @override
  String get pathDescFatihah => 'Sura completa (1:1–7). Esencial en cada rakʿah.';

  @override
  String get pathNameKafirun => 'Sura Al-Kāfirūn';

  @override
  String get pathDescKafirun => 'Sura completa (109:1–6). Declaración de Tawḥīd.';

  @override
  String get pathNameIkhlas => 'Sura Al-Ikhlāṣ';

  @override
  String get pathDescIkhlas => 'Sura completa (112:1–4). Tawḥīd de Allah.';

  @override
  String get pathNameFalaq => 'Sura Al-Falaq';

  @override
  String get pathDescFalaq => 'Sura completa (113:1–5). Refugio contra los males externos.';

  @override
  String get pathNameNas => 'Sura An-Nās';

  @override
  String get pathDescNas => 'Sura completa (114:1–6). Refugio contra los susurros internos.';

  @override
  String get pathNameAsrBegin => 'Sura Al-ʿAṣr';

  @override
  String get pathDescAsrBegin => '(103:1–3). Solo 3 versículos pero centrales para la “paciencia”.';

  @override
  String get pathNameTakathur => 'Sura At-Takāthur';

  @override
  String get pathDescTakathur => '(102:1–8) sobre la competencia mundana y la responsabilidad.';

  @override
  String get pathNameFil => 'Sura Al-Fīl';

  @override
  String get pathDescFil => '(105:1–5). Incidente del elefante; 5 versículos cortos.';

  @override
  String get pathNameQuraysh => 'Sura Quraysh';

  @override
  String get pathDescQuraysh => '(106:1–4). Sobre la gratitud por viajes seguros.';

  @override
  String get pathNameRahmanA => 'Ar-Raḥmān A';

  @override
  String get pathDescRahmanA => '(55:1–13): Enseñanza del Corán y creación de la humanidad.';

  @override
  String get pathNameRahmanB => 'Ar-Raḥmān B';

  @override
  String get pathDescRahmanB => '(55:26–36): Responsabilidad de humanos y genios.';

  @override
  String get pathNameYasinBlock => 'Sura Yā Sīn (Bloque)';

  @override
  String get pathDescYasinBlock => '(36:1–12). Introducción al mensaje del Profeta y advertencias.';

  @override
  String get pathNameMulkBlock => 'Sura Al-Mulk (Bloque)';

  @override
  String get pathDescMulkBlock => '(67:1–15). Enfatiza la soberanía de Allah y la reflexión.';

  @override
  String get pathNameBaqarah21_29 => 'Al-Baqarah (2:21–29)';

  @override
  String get pathDescBaqarah21_29 => '9 versículos sobre la creación y la reflexión para la gratitud.';

  @override
  String get pathNameNahl66_72 => 'An-Naḥl (16:66–72)';

  @override
  String get pathDescNahl66_72 => '7 versículos enumerando bendiciones: ganado, frutos, etc.';

  @override
  String get pathNameAdDuha => 'Sura Aḍ-Ḍuḥā';

  @override
  String get pathDescAdDuha => '(93:1–11) 11 versículos de esperanza y consuelo.';

  @override
  String get pathNameKahfCave => 'Al-Kahf: Los Jóvenes de la Cueva';

  @override
  String get pathDescKahfCave => '(18:9–16) La historia de jóvenes creyentes en una cueva.';

  @override
  String get pathNameKahfMusa => 'Al-Kahf: Mūsā & Al-Khiḍr';

  @override
  String get pathDescKahfMusa => '(18:60–70) Enfatiza la paciencia y la sabiduría oculta.';

  @override
  String get pathNameWaqiah => 'Al-Wāqiʿah (56:1–15)';

  @override
  String get pathDescWaqiah => '15 versículos sobre la llegada repentina de la Hora.';

  @override
  String get pathNameAsrPatience => 'Sura Al-ʿAṣr (Paciencia)';

  @override
  String get pathDescAsrPatience => '(103:1–3) nuevamente, 3 versículos, famosos sobre la paciencia.';

  @override
  String get pathNameBaq153_157 => 'Al-Baqarah (2:153–157)';

  @override
  String get pathDescBaq153_157 => '5 versículos: “Busquen ayuda con la paciencia y la oración.”';

  @override
  String get pathNameYusuf7_14 => 'Sura Yūsuf (12:7–14)';

  @override
  String get pathDescYusuf7_14 => 'Los celos de los hermanos de Yusuf. Paciencia puesta a prueba.';

  @override
  String get pathNameYusuf83_92 => 'Sura Yūsuf (12:83–92)';

  @override
  String get pathDescYusuf83_92 => 'La aflicción de Yaʿqūb y el perdón de Yusuf (10 versículos).';

  @override
  String get pathNameInshirah => 'Sura Al-Inshirāḥ (94:1–8)';

  @override
  String get pathDescInshirah => '8 versículos: consuelo después de la dificultad. Asociado a paciencia y esperanza.';

  @override
  String verticalLessonIconsSurahAyahFormat(Object surahName, Object startAyah, Object endAyah) {
    return 'Sura $surahName, Aleya $startAyah-$endAyah';
  }

  @override
  String get finishLabel => 'Finalizar';

  @override
  String get twoWordMultipleChoiceLabel => 'Selecciona las dos palabras correctas';

  @override
  String get singleWordMultipleChoiceLabel => 'Selecciona la palabra correcta';

  @override
  String get correctAnswerLabel => '¡Correcto!';

  @override
  String get incorrectAnswerLabel => '¡Incorrecto!';

  @override
  String get lessonCompletedLabel => '¡Lección completada!';

  @override
  String get profileAnalyticsScoreLabel => 'Análisis y puntuación';

  @override
  String get profileDailyLabel => 'Diario';

  @override
  String get profileWeeklyLabel => 'Semanal';

  @override
  String get profileMonthlyLabel => 'Mensual';

  @override
  String get profileTotalLabel => 'Total';

  @override
  String get profileViewChart => 'Ver gráfico';

  @override
  String get profileCloseLabel => 'Cerrar';

  @override
  String get profileScoreChartTitle => 'Gráfico de puntuación';

  @override
  String get profileScoreChartHistory => 'Historial';

  @override
  String get profileNoData => 'Sin datos';

  @override
  String get topBarDailyScoreLabel => '⭐ Hoy';

  @override
  String topBarDailyScoreSemantic(Object score) {
    return 'Tu puntuación diaria es $score';
  }

  @override
  String get profilePremiumNeeded => 'Por favor, actualiza para ver el calendario de progreso y ayúdanos a desarrollar más funciones in shā’ Allāh.';

  @override
  String get levelMultipleChoiceLabel => 'Opción múltiple';

  @override
  String get levelMultipleChoiceDescription => 'Pasos de opción múltiple de una o dos palabras, con la opción de saltarse pares.';

  @override
  String get levelBeginnerLabel => 'Principiante';

  @override
  String get levelBeginnerDescription => 'Eliminación progresiva de palabras en secuencias agrupadas para una memorización gradual.';

  @override
  String get subscriptionTierScreenPremiumLabel => 'Plus';

  @override
  String get featureUnavailableOffline => 'Función no disponible sin conexión. Conéctate o desbloquea el modo sin conexión actualizándote a Plus o Pro Beta.';

  @override
  String submissionFeedbackModalTotalCount(Object count) {
    return 'Cantidad total de agradecimientos ingresados: $count';
  }

  @override
  String get notificationDailyTitle => 'Recordatorio suave del Corán';

  @override
  String get notificationWeeklyTitle => 'Revisión semanal del Corán';

  @override
  String get notificationWeeklyBody => 'Reflexiona sobre tu progreso y memoriza una nueva porción del Corán mientras practicas la gratitud.';

  @override
  String get notificationChannelDailyRemindersName => 'Recordatorios diarios';

  @override
  String get notificationChannelDailyRemindersDesc => 'Recordatorios para la memorización diaria del Corán';

  @override
  String get notificationChannelWeeklyRemindersName => 'Recordatorios semanales';

  @override
  String get notificationChannelWeeklyRemindersDesc => 'Recordatorios para la revisión semanal de la memorización del Corán';

  @override
  String get nameEntryNotificationFrequencyDaily => 'Diario';

  @override
  String get topBarStreakDialogTitle => 'Racha';

  @override
  String get fillInTheBlanksLabel => 'Completa los espacios';

  @override
  String get loadingDataLabel => 'Cargando…';

  @override
  String ayahRangeLabel(Object start, Object end) {
    return 'Aleya $start - $end';
  }

  @override
  String get nextPageSemanticLabel => 'Página siguiente';

  @override
  String get prevPageSemanticLabel => 'Página anterior';

  @override
  String pageXOfYLabel(Object current, Object total) {
    return 'Página $current de $total';
  }

  @override
  String verseSemanticLabel(Object ayahNumber, Object surahName) {
    return 'Aleya $ayahNumber de la sura $surahName';
  }

  @override
  String get ayahLabel => 'Aleya';

  @override
  String get goToSurahViewLabel => 'Ver sura';

  @override
  String get clickOnAyaToOpenLesson => 'Haz clic en cualquier aleya a continuación para comenzar una lección';

  @override
  String get difficultyChoosingScreenIntro => 'Selecciona tu preferencia: opción múltiple o completar espacios, y cuántas veces se repite cada paso y reproducción de audio.';

  @override
  String get upgradeVoiceUsageMessage => '¡Mejora a Pro Beta para probar la función de voz y ayudarnos a mejorarla!';

  @override
  String get restorePurchasesLabel => 'Restaurar compras';

  @override
  String get subscriptionTierScreenMonthly => 'Mensual';

  @override
  String get subscriptionTierScreenYearly => 'Anual';

  @override
  String get subscriptionTierScreenFreePrice => 'Gratis';

  @override
  String get subscriptionTierScreenPremiumMonthlyPrice => 'Ahora \$3/mes (antes \$5)';

  @override
  String get subscriptionTierScreenPremiumYearlyPrice => 'Ahora \$28/año (antes \$60)';

  @override
  String get subscriptionTierScreenPremiumPlusMonthlyPrice => 'Ahora \$7/mes (antes \$10)';

  @override
  String get subscriptionTierScreenPremiumPlusYearlyPrice => 'Ahora \$45/año (antes \$84)';

  @override
  String get subscriptionPurchaseError => 'Error al comprar la suscripción';

  @override
  String get topBarExplorePlansLabel => 'Explorar planes';

  @override
  String get topBarBackHomeLabel => 'Volver al inicio';

  @override
  String get profileRequiresPlanUpdate => 'Requiere actualizar el plan';

  @override
  String get subscriptionTierScreenPremiumDescription => 'Todo lo de la versión gratuita, más aprendizaje de lecciones sin conexión y retroalimentación, análisis históricos, así como barras de progreso, perfil y personalización del Corán. ¡Apóyanos para crear más funciones!';

  @override
  String get subscriptionAutoRenewNotice => 'La suscripción se renueva automáticamente y puede cancelarse para no ser cobrado en el siguiente período. Una parte de los fondos se donará a Islamic Relief a través de la Iniciativa Almubtasim 😀.';

  @override
  String get subscriptionTierScreenSubscribeLabel => 'Suscribirse';

  @override
  String get subscriptionTierScreenFinalMessage => '¡Agradecemos tu apoyo!';

  @override
  String get subscriptionPurchaseRestoreSuccess => 'Tus compras se han restaurado correctamente.';

  @override
  String get subscriptionTierScreenRestoreLabel => 'Restaurar compras';

  @override
  String get arabicLabel => 'Árabe';

  @override
  String get transliterationLabel => 'Inglés';

  @override
  String get surahSearchScreenTitle => 'Búsqueda de Suras';

  @override
  String get genericBack => 'Volver';

  @override
  String get surahSearchSelectSurah => 'Selecciona una Sura:';

  @override
  String get surahSearchExistingPaths => 'Rutas existentes para esta Sura';

  @override
  String get surahSearchNoMatches => 'No se encontraron rutas existentes.';

  @override
  String get surahSearchHideCreateForm => 'Ocultar formulario de creación';

  @override
  String get surahSearchShowCreateForm => 'Crear nueva ruta para la Sura';

  @override
  String get createPathTrackProgress => '¿Registrar progreso?';

  @override
  String get themeScreenSearchIconSemantic => 'Buscar suras';

  @override
  String get pathListSearchIconSemantic => 'Buscar suras';

  @override
  String get pathLessonsSearchIconSemantic => 'Buscar suras';

  @override
  String get playAllSurahSemantic => 'Reproducir sura completa';

  @override
  String get toggleTransliterationLabel => 'Alternar transliteración';

  @override
  String get englishLabel => 'Inglés';

  @override
  String get subscriptionTierScreenPremiumPlusLabel => 'Apóyanos (Anual)';

  @override
  String get subscriptionTierScreenFreeDescription => '¡Todas las funciones son gratis y sin anuncios!';

  @override
  String get subscriptionTierScreenPremiumPlusDescription => '¡Ayuda a financiar nuevas funciones y mejoras! Además, invertir un monto pequeño puede ayudarte a desarrollar el hábito.';

  @override
  String get subscriptionTierScreenSupportLabel => 'Soporte Anual';

  @override
  String get verticalLessonIconsDialogBody => 'Todas las funciones están en la versión gratuita, pero si lo deseas, puedes apoyarnos a crear más. Parte de tu suscripción se dona a Islamic Relief. ¡Jazāk Allāhu Khayran!';

  @override
  String get welcomeBody => 'Hudhud cumplió un papel especial ayudando al profeta Suleiman [AS] al observar y llevar mensajes.\n\nÉl no te juzga sin importar en qué punto estés en tu camino, y está entusiasmado por guiarte a descubrir la belleza del Corán e integrar recordatorios de gratitud para valorar cada momento con él.';

  @override
  String get surahSearchByName => 'Buscar por nombre (en inglés o árabe)';

  @override
  String get surahSearchHintAnyName => 'Escribe el nombre de cualquier sura...';

  @override
  String get surahSearchFieldLabel => 'Buscar sura';

  @override
  String get surahSearchInvalidLessonsError => 'Una o más lecciones son inválidas. No se puede crear la ruta.';

  @override
  String get surahSearchUserSurahPrefix => 'Sura de usuario';

  @override
  String get notificationDailyBody => 'Tómate un momento para encontrar un poco de paz a través del Corán y recuerda por qué estás agradecido hoy.';
}
