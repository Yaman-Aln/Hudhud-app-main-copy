import 'package:hive/hive.dart';
import 'mistake_log.dart';
part 'daily_score_data.g.dart';

// --------------------------------------------------
// 2) DailyScoreData model
// --------------------------------------------------
// CHANGED: typeId=10 (instead of 2)
@HiveType(typeId: 10)
class DailyScoreData extends HiveObject {
  @HiveField(0)
  String date; // "YYYY-MM-DD"

  @HiveField(1)
  int totalPoints;

  @HiveField(2)
  int redCount;

  @HiveField(3)
  int yellowCount;

  @HiveField(4)
  int greenCount;

  // Only storing red/yellow details. If you want to store green logs, add them too.
  @HiveField(5)
  List<MistakeLog> mistakes;

  // Gratitude
  @HiveField(6)
  int gratitudeCount;

  // We can store just the texts or references:
  @HiveField(7)
  List<String> gratitudeEntries;

  DailyScoreData({
    required this.date,
    required this.totalPoints,
    required this.redCount,
    required this.yellowCount,
    required this.greenCount,
    required this.mistakes,
    required this.gratitudeCount,
    required this.gratitudeEntries,
  });

  // Handy factory for an empty record
  factory DailyScoreData.empty(String date) {
    return DailyScoreData(
      date: date,
      totalPoints: 0,
      redCount: 0,
      yellowCount: 0,
      greenCount: 0,
      mistakes: [],
      gratitudeCount: 0,
      gratitudeEntries: [],
    );
  }
}
