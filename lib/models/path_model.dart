// lib/models/path_model.dart

import '../models/lesson_model.dart';

/// A memorization path containing multiple lessons.
class Path {
  final String id;
  final String name;
  final String description;
  List<Lesson> lessons;
  final bool isUserGenerated;
  final int currentStep;
  int progress;
  int totalSteps;
  final DateTime? creationDate;
  final bool tracksProgress;

  /// **NEW**: an array of theme IDs that reference which theme(s) this path belongs to.
  final List<String> themeIds;

  Path({
    required this.id,
    required this.name,
    required this.description,
    List<Lesson>? lessons,
    required this.isUserGenerated,
    required this.currentStep,
    this.progress = 0,
    this.totalSteps = 0,
    this.creationDate,
    this.tracksProgress = true,
    List<String>? themeIds,
  })  : lessons = lessons ?? [],
        themeIds = themeIds ?? [] {
    // Make sure each lesson includes this path's ID in its own pathIds
    for (var lesson in this.lessons) {
      if (!lesson.pathIds.contains(id)) {
        lesson.pathIds.add(id);
      }
    }
  }

  factory Path.fromJson(Map<String, dynamic> json) {
    List<Lesson> parsedLessons = [];
    if (json['lessons'] is List) {
      parsedLessons = (json['lessons'] as List).map((lessonJson) {
        return Lesson.fromJson(Map<String, dynamic>.from(lessonJson));
      }).toList();
    }

    DateTime? parsedDate;
    if (json['creationDate'] != null) {
      try {
        parsedDate = DateTime.parse(json['creationDate']);
      } catch (_) {}
    }

    // parse themeIds
    List<String> parsedThemeIds = [];
    if (json['themeIds'] != null && json['themeIds'] is List) {
      parsedThemeIds = (json['themeIds'] as List).map((e) => e.toString()).toList();
    }

    return Path(
      id: json['id'] ?? 'unknown',
      name: json['name'] ?? 'Unnamed Path',
      description: json['description'] ?? '',
      lessons: parsedLessons,
      isUserGenerated: json['isUserGenerated'] ?? false,
      currentStep: json['currentStep'] ?? 0,
      progress: json['progress'] ?? 0,
      totalSteps: json['totalSteps'] ?? 0,
      creationDate: parsedDate,
      tracksProgress: json['tracksProgress'] ?? true,
      themeIds: parsedThemeIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'lessons': lessons.map((l) => l.toJson()).toList(),
      'isUserGenerated': isUserGenerated,
      'currentStep': currentStep,
      'progress': progress,
      'totalSteps': totalSteps,
      'creationDate': creationDate?.toIso8601String(),
      'tracksProgress': tracksProgress,
      'themeIds': themeIds,
    };
  }

  @override
  String toString() {
    return '[Path] ID=$id, name=$name, themeIds=$themeIds, progress=$progress';
  }

  /// NEW: A method to create a **copy** of this Path with optional changed fields.
  Path copyWith({
    String? id,
    String? name,
    String? description,
    List<Lesson>? lessons,
    bool? isUserGenerated,
    int? currentStep,
    int? progress,
    int? totalSteps,
    DateTime? creationDate,
    bool? tracksProgress,
    List<String>? themeIds,
  }) {
    return Path(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      lessons: lessons ?? this.lessons,
      isUserGenerated: isUserGenerated ?? this.isUserGenerated,
      currentStep: currentStep ?? this.currentStep,
      progress: progress ?? this.progress,
      totalSteps: totalSteps ?? this.totalSteps,
      creationDate: creationDate ?? this.creationDate,
      tracksProgress: tracksProgress ?? this.tracksProgress,
      themeIds: themeIds ?? this.themeIds,
    );
  }
}
