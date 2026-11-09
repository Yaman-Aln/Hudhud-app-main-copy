import 'package:hive/hive.dart';

part 'mistake_log.g.dart';

// --------------------------------------------------
// 1) MistakeLog model
// --------------------------------------------------
// CHANGED: typeId=11 (instead of 1)
@HiveType(typeId: 11)
class MistakeLog extends HiveObject {
  @HiveField(0)
  int surahId;

  @HiveField(1)
  int verseId;

  @HiveField(2)
  String word;

  /// red or yellow (optionally "green" if you decide to store it)
  @HiveField(3)
  String color;

  /// e.g. "2025-02-17T12:34:56Z"
  @HiveField(4)
  String timestamp;

  MistakeLog({
    required this.surahId,
    required this.verseId,
    required this.word,
    required this.color,
    required this.timestamp,
  });
}
