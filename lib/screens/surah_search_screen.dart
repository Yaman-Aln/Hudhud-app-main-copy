// surah_search_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

// Providers & Services
import '../providers/analytics_service_provider.dart';
import '../providers/ff_logging_service_provider.dart';
import '../providers/path_service_provider.dart';
import '../providers/progress_service_provider.dart';
import '../providers/lesson_service_provider.dart';
import '../providers/local_storage_service_provider.dart';

// IMPORTANT: We import quran_service.dart fully so that both
// `QuranService` and `SurahInfo` are recognized:
import '../services/quran_service.dart'; // <-- Make sure the path is correct!

import '../services/path_service.dart';
import '../services/progress_service.dart';
import '../services/lesson_service.dart';
import '../services/local_storage_service.dart';
import '../services/theme_service.dart'; // If you want to call themeService

// Models
import '../models/path_model.dart';
import '../models/lesson_model.dart';

// Widgets
import '../screens/path_detail_screen.dart';
import '../widgets/surah_selector.dart';

// Localizations
import '../l10n/app_localizations.dart';

/// A screen that allows the user to (1) pick a Surah from a dropdown,
/// (2) see all existing Paths that contain that Surah, (3) optionally create
/// a new user-defined Path, and (4) also search Surahs by typing in English/Arabic.
class SurahSearchScreen extends ConsumerStatefulWidget {
  const SurahSearchScreen({Key? key}) : super(key: key);

  @override
  SurahSearchScreenState createState() => SurahSearchScreenState();
}

class SurahSearchScreenState extends ConsumerState<SurahSearchScreen> {
  // ---------------------------------------------------------------------------
  // Surah selection
  int _selectedSurahId = 1;
  late int _totalAyahsInSurah;

  // A list of all Surahs (with Arabic & English names) for Autocomplete
  late final List<SurahInfo> _allSurahs;

  // Controller for the "type-ahead" text field
  final TextEditingController _searchCtrl = TextEditingController();

  // ---------------------------------------------------------------------------
  // Inline "create path" form controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  int _startAyah = 1;
  int _numAyahsInPath = 5;
  int _endAyah = 5;
  int _lessonSize = 5;
  bool _tracksProgress = true;

  // For lesson generation & validation
  List<Lesson> _generatedLessons = [];
  final Map<String, bool> _lessonValidity = {};

  // Whether we are showing the create form
  bool _showCreateForm = false;

  // ---------------------------------------------------------------------------
  // Access common providers & services
  LoggingService get loggingService => ref.read(ffLoggingServiceProvider);
  LocalStorageService get localStorageService => ref.read(localStorageServiceProvider);
  PathService get pathService => ref.read(pathServiceProviderRef);
  LessonService get lessonService => ref.read(lessonServiceProviderRef);
  ProgressService get progressService => ref.read(progressServiceProvider);
  QuranService get quranService => ref.read(quranServiceProvider);

  // If you want to add new paths specifically to 'theme_user_created',
  // you can also read your themeService:
  // ThemeService get themeService => ref.read(themeServiceProvider);

  // ---------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    // 1) Load all Surah info for searching (from QuranService)
    _allSurahs = quranService.getAllSurahs();

    // 2) Default to Surah #1 (Al-Fatihah)
    _totalAyahsInSurah = quranService.getVerseCount(_selectedSurahId);

    // Optional: log analytics for "surah_search_screen_viewed"
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('surah_search_screen_viewed');
  }

  // ---------------------------------------------------------------------------
  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  /// Return all existing Paths that contain the currently selected Surah
  List<Path> _matchingPathsForSurah() {
    final all = pathService.getAllPaths();
    return all.where((p) => p.lessons.any((ls) => ls.surahId == _selectedSurahId)).toList();
  }

  // ---------------------------------------------------------------------------
  /// Called whenever user changes the Surah in the dropdown or via autocomplete
  void _onSurahChanged(int newId) {
    setState(() {
      _selectedSurahId = newId;
      _startAyah = 1;
      _numAyahsInPath = 5;
      _endAyah = 5;
      _showCreateForm = false; // reset the create form if user picks a new surah

      _totalAyahsInSurah = quranService.getVerseCount(_selectedSurahId);
      _updateEndAyah();
      _nameCtrl.clear();
      _descCtrl.clear();
    });

    // Update the search text field so it matches the newly-selected Surah
    final surah = _allSurahs.firstWhere(
          (s) => s.surahId == newId,
      orElse: () => SurahInfo(surahId: newId, nameArabic: '', nameEnglish: ''),
    );
    if (surah.nameEnglish.isNotEmpty || surah.nameArabic.isNotEmpty) {
      _searchCtrl.text = '${surah.nameEnglish} – ${surah.nameArabic}';
    }

    // (Optional) log event
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('surah_search_surah_changed', parameters: {
      'surah_id': newId,
    });
  }

  // ---------------------------------------------------------------------------
  /// Recomputes the _endAyah after user changes startAyah or # of ayahs
  void _updateEndAyah() {
    if (_startAyah > _totalAyahsInSurah) {
      _startAyah = 1;
    }
    final maxAvailable = _totalAyahsInSurah - _startAyah + 1;
    if (_numAyahsInPath > maxAvailable) {
      _numAyahsInPath = maxAvailable;
    }
    final calcEnd = _startAyah + _numAyahsInPath - 1;
    setState(() {
      _endAyah = (calcEnd <= _totalAyahsInSurah) ? calcEnd : _totalAyahsInSurah;
    });
  }

  // ---------------------------------------------------------------------------
  /// Generates lessons for the chosen surah range & lessonSize
  Future<List<Lesson>> _generateLessons(String pathId) async {
    loggingService.logWarning('[SurahSearchScreen] Generating lessons for path=$pathId');
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('surah_search_generate_lessons');

    return lessonService.generateLessons(
      _selectedSurahId,
      _lessonSize,
      startAyah: _startAyah,
      endAyah: _endAyah,
      pathId: pathId,
    );
  }

  // ---------------------------------------------------------------------------
  /// Validate each lesson with LessonService
  Future<void> _validateLessons(List<Lesson> lessons, String pathId) async {
    for (var ls in lessons) {
      final ok = await lessonService.validateLesson(
        lessonId: ls.id,
        surahId: ls.surahId,
        pathId: pathId,
      );
      _lessonValidity[ls.id] = ok;
    }
  }

  // ---------------------------------------------------------------------------
  /// Creates the final Path object from the valid lessons
  Future<void> _createPathWithValidLessons() async {
    final analytics = ref.read(analyticsServiceProvider);

    final validLessons = _generatedLessons.where((ls) => _lessonValidity[ls.id] == true).toList();
    if (validLessons.isEmpty) {
      loggingService.logError('[SurahSearchScreen] No valid lessons => cannot create path.');
      return;
    }

    final newPathId = const Uuid().v4();
    loggingService.logWarning('[SurahSearchScreen] Creating new path => $newPathId');

    // By default, let's just put it in "theme_user_created":
    final themeIds = <String>['theme_user_created'];

    // Calculate total steps across all lessons:
    final lessonIds = validLessons.map((l) => l.id).toList();
    final totalSteps = await pathService.calculateTotalStepsForPath(lessonIds, newPathId);

    // Build the path
    final newPath = Path(
      id: newPathId,
      name: _nameCtrl.text.trim().isEmpty
          ? '${AppLocalizations.of(context)!.surahSearchUserSurahPrefix} $_selectedSurahId'
          : _nameCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      lessons: validLessons,
      isUserGenerated: true,
      currentStep: 0,
      totalSteps: totalSteps,
      tracksProgress: _tracksProgress,
      themeIds: themeIds,
      creationDate: DateTime.now(),
    );

    // Save it as a user path
    await pathService.addUserPath(newPath);

    // Make sure each lesson references this new path
    for (final ls in validLessons) {
      ls.pathIds.add(newPathId);
      await progressService.updateLessonProgress(ls.id, 0, pathId: newPathId);
    }

    // Optionally log success
    analytics.logEvent('surah_search_path_created', parameters: {
      'path_id': newPathId,
      'theme_ids': themeIds.join(','),
      'lesson_count': validLessons.length,
    });

    // Go to the new path’s detail screen
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PathDetailScreen(pathId: newPathId),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  /// When user submits the "Create Path" form
  Future<void> _onCreatePathSubmit() async {
    final analytics = ref.read(analyticsServiceProvider);
    analytics.logEvent('surah_search_create_submitted');

    // Capture the ScaffoldMessenger here to avoid the "Don't use BuildContext across async gaps" lint
    final messenger = ScaffoldMessenger.of(context);

    if (!_formKey.currentState!.validate()) return; // if form invalid, do nothing

    // 1) Generate lessons with a temporary path ID
    final tmpPathId = const Uuid().v4();
    _generatedLessons = await _generateLessons(tmpPathId);

    // 2) Validate them
    await _validateLessons(_generatedLessons, tmpPathId);

    // 3) If valid, finalize creation
    if (_lessonValidity.values.any((valid) => valid == false)) {
      analytics.logEvent('surah_search_lessons_invalid');
      messenger.showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.surahSearchInvalidLessonsError)),
      );
    } else {
      await _createPathWithValidLessons();
    }
  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final matchingPaths = _matchingPathsForSurah();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.surahSearchScreenTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: loc.genericBack,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1) Autocomplete text field
              Text(
                loc.surahSearchByName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              _buildSurahAutocomplete(),

              const Divider(height: 24),

              // 2) Surah dropdown (existing SurahSelector)
              Text(
                loc.surahSearchSelectSurah,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              SurahSelector(
                onSurahSelected: (int newSurahId) {
                  _onSurahChanged(newSurahId);

                  // Also update the text field
                  final info = _allSurahs.firstWhere(
                        (s) => s.surahId == newSurahId,
                    orElse: () => SurahInfo(
                      surahId: newSurahId,
                      nameArabic: '',
                      nameEnglish: '',
                    ),
                  );
                  if (info.nameEnglish.isNotEmpty || info.nameArabic.isNotEmpty) {
                    _searchCtrl.text = '${info.nameEnglish} – ${info.nameArabic}';
                  }
                },
              ),

              const Divider(height: 24),

              // Existing paths that match the selected Surah
              Text(
                loc.surahSearchExistingPaths,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              if (matchingPaths.isEmpty)
                Text(
                  loc.surahSearchNoMatches,
                  style: const TextStyle(color: Colors.grey),
                )
              else
                Column(
                  children: [
                    for (final p in matchingPaths)
                      Card(
                        child: ListTile(
                          title: Text(p.name),
                          subtitle: Text(p.description),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PathDetailScreen(pathId: p.id),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),

              const Divider(height: 24),

              // Toggle for showing/hiding the "Create new path" form
              TextButton.icon(
                icon: Icon(_showCreateForm ? Icons.close : Icons.add),
                label: Text(
                  _showCreateForm
                      ? loc.surahSearchHideCreateForm
                      : loc.surahSearchShowCreateForm,
                ),
                onPressed: () => setState(() {
                  _showCreateForm = !_showCreateForm;
                }),
              ),

              if (_showCreateForm) _buildCreateForm(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the Flutter Autocomplete for English/Arabic Surah names
  Widget _buildSurahAutocomplete() {
    return Autocomplete<SurahInfo>(
      optionsBuilder: (TextEditingValue val) {
        final query = val.text.trim();
        if (query.isEmpty) {
          return const Iterable<SurahInfo>.empty();
        }
        final lower = query.toLowerCase();
        return _allSurahs.where((surah) {
          // English (case-insensitive) or Arabic (exact substring)
          final englishMatches = surah.nameEnglish.toLowerCase().contains(lower);
          final arabicMatches = surah.nameArabic.contains(query);
          return englishMatches || arabicMatches;
        });
      },
      displayStringForOption: (surah) => '${surah.nameEnglish} – ${surah.nameArabic}',
      onSelected: (surah) {
        // Update UI for that surah
        _onSurahChanged(surah.surahId);
      },
      fieldViewBuilder:
          (BuildContext context, TextEditingController textCtrl, FocusNode focusNode, VoidCallback onFieldSubmitted) {
        // Keep our _searchCtrl in sync with the Autocomplete's controller
        textCtrl.text = _searchCtrl.text;
        textCtrl.addListener(() {
          _searchCtrl.text = textCtrl.text;
        });

        return TextField(
          controller: textCtrl,
          focusNode: focusNode,
          onSubmitted: (_) => onFieldSubmitted(),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.surahSearchHintAnyName,
            labelText: AppLocalizations.of(context)!.surahSearchFieldLabel,
          ),
        );
      },
    );
  }

  /// Builds the inline "Create New Path" form
  Widget _buildCreateForm(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Path Name
          TextFormField(
            controller: _nameCtrl,
            decoration: InputDecoration(
              labelText: loc.createPathNameLabel,
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return loc.createPathNameValidation;
              }
              return null;
            },
          ),
          const SizedBox(height: 12.0),

          // Path Description
          TextFormField(
            controller: _descCtrl,
            decoration: InputDecoration(
              labelText: loc.createPathDescriptionLabel,
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return loc.createPathDescriptionValidation;
              }
              return null;
            },
          ),
          const SizedBox(height: 12.0),

          // Start Ayah
          TextFormField(
            initialValue: _startAyah.toString(),
            decoration: InputDecoration(
              labelText: loc.createPathStartAyahLabel,
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) {
              final n = int.tryParse(val) ?? 1;
              setState(() => _startAyah = n);
              _updateEndAyah();
            },
          ),
          const SizedBox(height: 12.0),

          // Number of Ayahs
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: loc.createPathNumAyahsLabel,
                  ),
                  value: _numAyahsInPath,
                  items: _buildNumberOfAyahDropdown(context),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _numAyahsInPath = val);
                      _updateEndAyah();
                    }
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              // Read-only End Ayah
              Expanded(
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: loc.createPathEndAyahLabel,
                  ),
                  controller: TextEditingController(text: _endAyah.toString()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Words per Lesson
          DropdownButtonFormField<int>(
            decoration: InputDecoration(
              labelText: loc.createPathWordsPerLessonLabel,
            ),
            value: _lessonSize,
            items: [5, 10].map((sz) {
              return DropdownMenuItem<int>(
                value: sz,
                child: Text('$sz ${loc.createPathWordsSuffix}'),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _lessonSize = val);
              }
            },
          ),
          const SizedBox(height: 12.0),

          // Tracks progress?
          SwitchListTile(
            title: Text(loc.createPathTrackProgress),
            value: _tracksProgress,
            onChanged: (val) => setState(() => _tracksProgress = val),
          ),

          const SizedBox(height: 20.0),

          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: Text(loc.createPathCreateButton),
            onPressed: _onCreatePathSubmit,
          ),
        ],
      ),
    );
  }

  /// Builds the dropdown list for number of ayahs (similar to your CreatePathScreen).
  List<DropdownMenuItem<int>> _buildNumberOfAyahDropdown(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final maxAvailable = _totalAyahsInSurah - _startAyah + 1;
    if (maxAvailable < 1) {
      // invalid range
      return [
        DropdownMenuItem<int>(
          value: 1,
          child: Text(loc.createPathInvalidRange),
        )
      ];
    }

    final items = <DropdownMenuItem<int>>[];
    final maxOption = (maxAvailable > 25) ? 25 : maxAvailable;

    // Build step of 5, up to maxOption
    for (int i = 5; i <= maxOption; i += 5) {
      items.add(
        DropdownMenuItem<int>(
          value: i,
          child: Text('$i ${loc.createPathAyahsSuffix}'),
        ),
      );
    }

    // If there's a remainder that isn't a multiple of 5, add that too
    if (maxOption % 5 != 0 && maxOption > 0) {
      items.add(
        DropdownMenuItem<int>(
          value: maxOption,
          child: Text('$maxOption ${loc.createPathAyahsSuffix}'),
        ),
      );
    }

    // Ensure at least one item is present
    if (items.isEmpty) {
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
