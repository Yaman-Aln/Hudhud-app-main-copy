import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' show log;

// Analytics & Logging
import '../providers/analytics_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';

// Screens
import '../screens/path_detail_screen.dart';

// Models & Services
import '../models/path_model.dart';
import '../models/lesson_model.dart';
import '../widgets/surah_selector.dart';
import '../services/quran_service.dart';

// Providers
import '../providers/path_service_provider.dart';
import '../providers/progress_service_provider.dart';
import '../providers/lesson_service_provider.dart';

// NEW: localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

class CreatePathScreen extends ConsumerStatefulWidget {
  /// If the user wants a specific theme, pass it here.
  /// Otherwise, it will default to "theme_user_created"
  final String? themeId;

  const CreatePathScreen({Key? key, this.themeId}) : super(key: key);

  @override
  CreatePathScreenState createState() => CreatePathScreenState();
}

class CreatePathScreenState extends ConsumerState<CreatePathScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();

  /// Provide a convenient getter for the QuranService
  QuranService get quranService => ref.read(quranServiceProvider);

  /// Logger from your ff_logging_service_provider
  LoggingService get loggingService => ref.read(ffLoggingServiceProvider);

  // Surah + ayah selection
  int _selectedSurahId = 1;
  int _startAyah = 1;
  int _numAyahsInPath = 5;
  int _endAyah = 1;

  // Lesson chunk size in words
  int _lessonSize = 15;

  // We'll fetch surah's total ayahs from the QuranService
  int _totalAyahsInSurah = 7;

  // After generating lessons, we track them plus their validity
  List<Lesson> _generatedLessons = [];
  final Map<String, bool> _lessonValidity = {};

  // Tracks whether this path uses progress
  bool _tracksProgress = true;

  @override
  void initState() {
    super.initState();

    // 1) Log "create_path_screen_viewed"
    final localAnalytics = ref.read(analyticsServiceProvider);
    localAnalytics.logEvent('create_path_screen_viewed');

    // Compute total ayah count for the initial Surah
    _totalAyahsInSurah = quranService.getVerseCount(_selectedSurahId);
    _updateEndAyah();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  /// Recalculates the [endAyah] whenever [startAyah] or [numAyahsInPath] changes.
  void _updateEndAyah() {
    setState(() {
      if (_startAyah > _totalAyahsInSurah) {
        _startAyah = 1;
      }
      final maxAvailable = _totalAyahsInSurah - _startAyah + 1;
      if (_numAyahsInPath > maxAvailable) {
        _numAyahsInPath = (maxAvailable > 5) ? 5 : maxAvailable;
      }
      _endAyah = _startAyah + _numAyahsInPath - 1;
      if (_endAyah > _totalAyahsInSurah) {
        _endAyah = _totalAyahsInSurah;
      }
    });
  }

  /// Generates lessons from [lessonService] based on user-chosen surah, ayahs, and lesson size.
  Future<List<Lesson>> _generateLessons(String pathId) async {
    final localAnalytics = ref.read(analyticsServiceProvider);
    final lessonService = ref.read(lessonServiceProviderRef);

    loggingService.logWarning(
      '[CreatePathScreen] Generating lessons: '
          'surah=$_selectedSurahId, start=$_startAyah, end=$_endAyah, lessonSize=$_lessonSize',
    );

    // 2) Log "path_generation_requested"
    localAnalytics.logEvent(
      'path_generation_requested',
      parameters: {
        'path_id': pathId,
        'surah_id': _selectedSurahId,
        'start_ayah': _startAyah,
        'end_ayah': _endAyah,
        'lesson_size': _lessonSize,
      },
    );

    return lessonService.generateLessons(
      _selectedSurahId,
      _lessonSize,
      startAyah: _startAyah,
      endAyah: _endAyah,
      pathId: pathId,
    );
  }

  /// Validates each generated lesson with the lessonService.
  Future<void> _validateLessons(List<Lesson> lessons, String pathId) async {
    final lessonSvc = ref.read(lessonServiceProviderRef);
    for (var ls in lessons) {
      bool ok = await lessonSvc.validateLesson(
        lessonId: ls.id,
        surahId: ls.surahId,
        pathId: pathId,
      );
      _lessonValidity[ls.id] = ok;
    }
    if (mounted) setState(() {});
  }

  /// Creates a path from the valid lessons, logs success/failure, and navigates to PathDetail.
  Future<void> _createPathWithValidLessons() async {
    final localAnalytics = ref.read(analyticsServiceProvider);
    final logSvc = ref.read(ffLoggingServiceProvider);

    final pathSvc = ref.read(pathServiceProviderRef);
    final progressSvc = ref.read(progressServiceProvider);

    final validLessons = _generatedLessons
        .where((ls) => _lessonValidity[ls.id] == true)
        .toList();

    if (validLessons.isEmpty) {
      logSvc.logError('No valid lessons to create path with');
      return;
    }

    final pathId = const Uuid().v4();
    final themeIds = <String>[];
    if (widget.themeId != null) {
      themeIds.add(widget.themeId!);
    } else {
      themeIds.add('theme_user_created');
    }

    loggingService.logWarning(
      '[CreatePathScreen] Creating path "$pathId" '
          'with themeIds=$themeIds, tracksProgress=$_tracksProgress, '
          '#lessons=${validLessons.length}',
    );

    final lessonIds = validLessons.map((l) => l.id).toList();
    final totalSteps = await pathSvc.calculateTotalStepsForPath(lessonIds, pathId);

    final newPath = Path(
      id: pathId,
      name: _nameCtrl.text,
      description: _descCtrl.text,
      lessons: validLessons,
      isUserGenerated: true,
      currentStep: 0,
      totalSteps: totalSteps,
      tracksProgress: _tracksProgress,
      themeIds: themeIds,
    );

    await pathSvc.addUserPath(newPath);

    for (final ls in validLessons) {
      ls.pathIds.add(pathId);
      await progressSvc.updateLessonProgress(
        ls.id,
        0,
        currentStep: 0,
        pathId: pathId,
      );
    }

    // 3) Log "path_created_success"
    localAnalytics.logEvent(
      'path_created_success',
      parameters: {
        'path_id': pathId,
        'theme_ids': themeIds.join(','),
        'lesson_count': validLessons.length,
      },
    );

    // Invalidate and navigate
    ref.invalidate(asyncLessonsWithProgressProvider(pathId));
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PathDetailScreen(pathId: pathId),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    loggingService.logWarning('[CreatePathScreen] Building...');
    final localAnalytics = ref.read(analyticsServiceProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[50],
        leading: Semantics(
          label: loc.createPathBackArrowSemantic, // e.g. "Back to previous screen"
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // 6) Log "create_path_screen_back_pressed"
              localAnalytics.logEvent('create_path_screen_back_pressed', parameters: {
                'from_screen': 'create_path',
                'to_screen': 'previous',
              });
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          loc.createPathTitle, // e.g. "Create New Path"
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Path Name
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    labelText: loc.createPathNameLabel, // "Path Name"
                    labelStyle: TextStyle(color: Colors.blue[800]),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return loc.createPathNameValidation; // "Enter a path name"
                    }
                    return null;
                  },
                  onChanged: (val) {
                    // Optionally log "path_name_changed"
                    localAnalytics.logEvent(
                      'path_name_changed',
                      parameters: {
                        'current_value': val,
                      },
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                // Description
                TextFormField(
                  controller: _descCtrl,
                  decoration: InputDecoration(
                    labelText: loc.createPathDescriptionLabel, // "Description"
                    labelStyle: TextStyle(color: Colors.blue[800]),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return loc.createPathDescriptionValidation; // "Enter a description"
                    }
                    return null;
                  },
                  onChanged: (val) {
                    // Optionally log "path_description_changed"
                    localAnalytics.logEvent(
                      'path_description_changed',
                      parameters: {
                        'current_value': val,
                      },
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.03),

                // Surah label
                Text(
                  loc.createPathSurahSelectorLabel, // "Select Surah:"
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Surah Selector
                SurahSelector(
                  onSurahSelected: (newId) {
                    setState(() {
                      _selectedSurahId = newId;
                      _startAyah = 1;
                      _numAyahsInPath = 5;
                    });
                    _totalAyahsInSurah = quranService.getVerseCount(newId);
                    _updateEndAyah();

                    // 4) Log "surah_changed_in_create_path"
                    localAnalytics.logEvent(
                      'surah_changed_in_create_path',
                      parameters: {
                        'new_surah_id': newId,
                      },
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.03),

                // Start Ayah
                TextFormField(
                  decoration: InputDecoration(
                    labelText: loc.createPathStartAyahLabel, // "Start Ayah"
                  ),
                  initialValue: _startAyah.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    final newVal = int.tryParse(val) ?? 1;
                    // 7) Log "start_ayah_changed"
                    localAnalytics.logEvent(
                      'start_ayah_changed',
                      parameters: {
                        'old_value': _startAyah,
                        'new_value': newVal,
                      },
                    );
                    setState(() {
                      _startAyah = newVal;
                    });
                    _updateEndAyah();
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                // Number of Ayahs in path
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: loc.createPathNumAyahsLabel, // "Number of Ayahs in the Path"
                  ),
                  value: _numAyahsInPath,
                  items: _buildNumberOfAyahDropdown(),
                  onChanged: (val) {
                    if (val != null) {
                      // 8) Log "num_ayahs_changed"
                      localAnalytics.logEvent(
                        'num_ayahs_changed',
                        parameters: {
                          'old_value': _numAyahsInPath,
                          'new_value': val,
                        },
                      );
                      setState(() {
                        _numAyahsInPath = val;
                      });
                      _updateEndAyah();
                    }
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                // End Ayah display
                TextFormField(
                  decoration: InputDecoration(
                    labelText: loc.createPathEndAyahLabel, // "End Ayah"
                  ),
                  controller: TextEditingController(text: _endAyah.toString()),
                  enabled: false,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Words per Lesson
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: loc.createPathWordsPerLessonLabel, // "Words per Lesson"
                  ),
                  value: _lessonSize,
                  items: [5, 10, 15, 20, 25]
                      .map(
                        (sz) => DropdownMenuItem<int>(
                      value: sz,
                      child: Text('$sz ${loc.createPathWordsSuffix}'), // e.g. "15 words"
                    ),
                  )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      // 9) Log "lesson_size_changed"
                      localAnalytics.logEvent(
                        'lesson_size_changed',
                        parameters: {
                          'old_value': _lessonSize,
                          'new_value': val,
                        },
                      );
                      setState(() {
                        _lessonSize = val;
                      });
                    }
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                // CREATE button
                Semantics(
                  label: loc.createPathSubmitSemantic, // e.g. "Tap to create path"
                  button: true,
                  child: ElevatedButton(
                    onPressed: () async {
                      // 5) Log "create_path_submitted"
                      localAnalytics.logEvent('create_path_submitted');

                      if (_formKey.currentState!.validate()) {
                        final tmpPathId = const Uuid().v4();

                        _generatedLessons = await _generateLessons(tmpPathId);
                        await _validateLessons(_generatedLessons, tmpPathId);

                        // If any lesson is invalid, we might show a warning
                        if (_lessonValidity.containsValue(false)) {
                          localAnalytics.logEvent('path_lessons_invalid', parameters: {
                            'invalid_count': _lessonValidity.values.where((v) => v == false).length,
                            'path_id': tmpPathId,
                          });
                        } else {
                          await _createPathWithValidLessons();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[50],
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.02,
                      ),
                    ),
                    child: Text(
                      loc.createPathCreateButton, // "Create Path"
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the dropdown for number of ayahs in the path (5, 10, 15, etc.).
  List<DropdownMenuItem<int>> _buildNumberOfAyahDropdown() {
    final loc = AppLocalizations.of(context)!;

    final items = <DropdownMenuItem<int>>[];
    final maxAvailable = _totalAyahsInSurah - _startAyah + 1;

    if (maxAvailable <= 0) {
      items.add(
        DropdownMenuItem<int>(
          value: 5,
          child: Text(loc.createPathInvalidRange), // "Invalid range"
        ),
      );
      return items;
    }

    final maxOption = (maxAvailable > 25) ? 25 : maxAvailable;

    if (maxOption < 5) {
      items.add(
        DropdownMenuItem<int>(
          value: maxOption,
          child: Text('$maxOption ${loc.createPathAyahsSuffix}'), // e.g. "3 Ayahs"
        ),
      );
      return items;
    }

    for (int i = 5; i <= maxOption; i += 5) {
      items.add(
        DropdownMenuItem<int>(
          value: i,
          child: Text('$i ${loc.createPathAyahsSuffix}'), // e.g. "5 Ayahs"
        ),
      );
    }

    if (maxOption % 5 != 0) {
      items.add(
        DropdownMenuItem<int>(
          value: maxOption,
          child: Text('$maxOption ${loc.createPathAyahsSuffix}'),
        ),
      );
    }

    return items;
  }
}
