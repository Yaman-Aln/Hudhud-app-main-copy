// lib/models/lesson_model.dart

class Lesson {
  final String id;
  final int surahId;
  final int startAyah;
  final int endAyah;
  final List<String> pathIds;
  int progress; // Updated to be mutable to match its role in tracking
  int currentStep;
  int totalSteps;

  // Constructor with required parameters and optional parameters
  Lesson({
    required this.id,
    required this.surahId,
    required this.startAyah,
    required this.endAyah,
    required this.pathIds,
    this.progress = 0, // Default progress set to 0
    this.currentStep = 0,
    this.totalSteps = 0,
  });

  // Validation method for the lesson
  bool get isCompleted => progress >= 1.0; // Example: Completed when progress is 100%

  bool get isValid {
    return id.isNotEmpty && surahId > 0 && startAyah > 0 && endAyah >= startAyah;
  }

  // Convert a Lesson to a Map (for Hive storage or JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surahId': surahId,
      'startAyah': startAyah,
      'endAyah': endAyah,
      'pathIds': pathIds,
      'progress': progress,
      'currentStep': currentStep,
      'totalSteps': totalSteps,
    };
  }

  // Create a Lesson from a Map (for Hive retrieval or JSON decoding)
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id']?.toString() ?? '',
      surahId: json['surahId'] ?? 0,
      startAyah: json['startAyah'] ?? 0,
      endAyah: json['endAyah'] ?? 0,
      pathIds: (json['pathIds'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      progress: json['progress'] ?? 0,
      currentStep: json['currentStep'] ?? 0,
      totalSteps: json['totalSteps'] ?? 0,
    );
  }

  // CopyWith method for selectively updating fields
  Lesson copyWith({
    String? id,
    int? surahId,
    int? startAyah,
    int? endAyah,
    List<String>? pathIds,
    int? progress,
    int? currentStep,
    int? totalSteps,
  }) {
    return Lesson(
      id: id ?? this.id,
      surahId: surahId ?? this.surahId,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      pathIds: pathIds ?? this.pathIds,
      progress: progress ?? this.progress,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }

  @override
  String toString() {
    return '[Lesson] ID: $id, Surah ID: $surahId, Start Ayah: $startAyah, End Ayah: $endAyah, Progress: $progress, Current Step: $currentStep, Total Steps: $totalSteps, Path IDs: $pathIds';
  }
}
