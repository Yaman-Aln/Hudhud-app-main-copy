import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:async';

// If you have a custom logging service, import here:
// import '../providers/ff_logging_service_provider.dart';

// ADDED LINE: We actually import the LoggingService now:
import '../providers/ff_logging_service_provider.dart';

// The above data models
import '../models/daily_score_data.dart'; // if separate
import '../models/mistake_log.dart';      // if separate

class ScoreService {
  static const String _scoreBoxName = 'scoreBox';

  // ADDED LINE: Create our fallback loggingService
  final loggingService = LoggingService();

  /// Returns "YYYY-MM-DD" for the given DateTime
  String _formatDate(DateTime dt) {
    return DateFormat('yyyy-MM-dd').format(dt);
  }

  /// The key we use in Hive for a given date: e.g. "score_2025-02-17"
  String _scoreKeyForDate(DateTime dt) {
    final dateStr = _formatDate(dt);
    return 'score_$dateStr';
  }

  // ------------------------------------------------------------------------
  // Get or create today's data record
  // ------------------------------------------------------------------------
  Future<DailyScoreData> _getOrCreateDailyData(DateTime dt) async {
    loggingService.logWarning('[ScoreService] _getOrCreateDailyData => $dt');

    final box = await Hive.openBox<DailyScoreData>(_scoreBoxName);
    final key = _scoreKeyForDate(dt);

    // If it doesn't exist, create an empty record for that day
    DailyScoreData? dailyData = box.get(key);
    if (dailyData == null) {
      loggingService.logWarning('[ScoreService] Creating new DailyScoreData for $key');
      dailyData = DailyScoreData.empty(_formatDate(dt));
      await box.put(key, dailyData);
    } else {
      loggingService.logInfo('[ScoreService] Found existing DailyScoreData for $key');
    }
    return dailyData;
  }

  // ------------------------------------------------------------------------
  // 1) Log a red/yellow (or optionally green) word
  // ------------------------------------------------------------------------
  Future<void> logMistake({
    required DateTime date,
    required int surahId,
    required int verseId,
    required String word,
    required String color, // "red", "yellow", or "green" if desired
    required int points,
  }) async {
    loggingService.logWarning('[ScoreService] logMistake => date=$date, surah=$surahId, verse=$verseId, word="$word", color=$color, points=$points');

    final box = await Hive.openBox<DailyScoreData>(_scoreBoxName);
    final dailyData = await _getOrCreateDailyData(date);

    // Increase total points
    dailyData.totalPoints += points;

    // If "red"/"yellow"/"green", increment counters
    if (color == 'red') {
      dailyData.redCount++;
    } else if (color == 'yellow') {
      dailyData.yellowCount++;
    } else if (color == 'green') {
      dailyData.greenCount++;
    }

    // If you only want to store red/yellow details:
    if (color == 'red' || color == 'yellow') {
      final log = MistakeLog(
        surahId: surahId,
        verseId: verseId,
        word: word,
        color: color,
        timestamp: DateTime.now().toIso8601String(),
      );
      dailyData.mistakes.add(log);
    }

    // Save updated daily data back to Hive
    await box.put(_scoreKeyForDate(date), dailyData);

    loggingService.logInfo('[ScoreService] logMistake => updated dailyData for date=${_scoreKeyForDate(date)} => totalPoints=${dailyData.totalPoints}');
  }

  // ------------------------------------------------------------------------
  // 2) Log a successful "green" answer (if you want +10 for correct)
  //
  // Alternatively, you can skip storing "green" details if you just
  // want to track the daily green count or total points. This is optional.
  // ------------------------------------------------------------------------
  Future<void> logGreen({
    required DateTime date,
    required int points,
  }) async {
    loggingService.logWarning('[ScoreService] logGreen => date=$date, points=$points');

    final box = await Hive.openBox<DailyScoreData>(_scoreBoxName);
    final dailyData = await _getOrCreateDailyData(date);

    dailyData.totalPoints += points;
    dailyData.greenCount++;

    await box.put(_scoreKeyForDate(date), dailyData);

    loggingService.logInfo('[ScoreService] logGreen => updated dailyData => totalPoints=${dailyData.totalPoints}, greenCount=${dailyData.greenCount}');
  }

  // ------------------------------------------------------------------------
  // 3) Log gratitude entries (+10 points each)
  // ------------------------------------------------------------------------
  Future<void> logGratitudes({
    required DateTime date,
    required List<String> newEntries, // unique gratitudes
  }) async {
    loggingService.logWarning('[ScoreService] logGratitudes => date=$date, newEntries=$newEntries');

    if (newEntries.isEmpty) {
      loggingService.logWarning('[ScoreService] logGratitudes => no new entries, returning');
      return;
    }

    final box = await Hive.openBox<DailyScoreData>(_scoreBoxName);
    final dailyData = await _getOrCreateDailyData(date);

    // +10 per entry
    final addedPoints = newEntries.length * 10;
    dailyData.totalPoints += addedPoints;
    dailyData.gratitudeCount += newEntries.length;
    dailyData.gratitudeEntries.addAll(newEntries);

    await box.put(_scoreKeyForDate(date), dailyData);

    loggingService.logInfo('[ScoreService] logGratitudes => added $addedPoints points for date=${_scoreKeyForDate(date)} => totalPoints=${dailyData.totalPoints}');
  }

  // ------------------------------------------------------------------------
  // 4) Fetch a single day’s data
  // ------------------------------------------------------------------------
  Future<DailyScoreData?> fetchDailyScore(DateTime date) async {
    loggingService.logWarning('[ScoreService] fetchDailyScore => date=$date');

    final box = await Hive.openBox<DailyScoreData>(_scoreBoxName);
    final result = box.get(_scoreKeyForDate(date));
    if (result == null) {
      loggingService.logInfo('[ScoreService] fetchDailyScore => no data found for date=${_scoreKeyForDate(date)}');
    } else {
      loggingService.logInfo('[ScoreService] fetchDailyScore => found totalPoints=${result.totalPoints}');
    }
    return result;
  }

  // ------------------------------------------------------------------------
  // 5) Fetch total points for a single day quickly
  // ------------------------------------------------------------------------
  Future<int> fetchDailyPoints(DateTime date) async {
    loggingService.logWarning('[ScoreService] fetchDailyPoints => date=$date');
    final data = await fetchDailyScore(date);
    final points = data?.totalPoints ?? 0;
    loggingService.logInfo('[ScoreService] fetchDailyPoints => returning $points');
    return points;
  }

  // ------------------------------------------------------------------------
  // 6) Fetch a range of daily records, e.g. for weekly or monthly
  //
  //    We iterate over all days from [startDate] to [endDate], inclusive,
  //    retrieving each day’s record and summing.
  // ------------------------------------------------------------------------
  Future<List<DailyScoreData>> fetchRange(DateTime startDate, DateTime endDate) async {
    loggingService.logWarning('[ScoreService] fetchRange => startDate=$startDate, endDate=$endDate');

    final box = await Hive.openBox<DailyScoreData>(_scoreBoxName);

    // We’ll build a list day by day
    List<DailyScoreData> results = [];
    DateTime current = startDate;
    while (!current.isAfter(endDate)) {
      final dailyData = box.get(_scoreKeyForDate(current));
      if (dailyData != null) {
        results.add(dailyData);
      }
      current = current.add(const Duration(days: 1));
    }
    loggingService.logInfo('[ScoreService] fetchRange => returning ${results.length} records');
    return results;
  }

  // ------------------------------------------------------------------------
  // 7) Weekly Score
  //    Usually we define "week" as Monday-Sunday or Sunday-Saturday.
  //    We'll assume Monday-based week.
  // ------------------------------------------------------------------------
  Future<int> fetchWeeklyScore(DateTime anyDayInWeek) async {
    loggingService.logWarning('[ScoreService] fetchWeeklyScore => anyDayInWeek=$anyDayInWeek');

    // figure out start of the week (Monday)
    int weekday = anyDayInWeek.weekday; // Monday=1, Sunday=7
    // If Monday=1, the offset is weekday - 1.
    DateTime monday = anyDayInWeek.subtract(Duration(days: weekday - 1));
    DateTime sunday = monday.add(const Duration(days: 6));

    final rangeData = await fetchRange(monday, sunday);
    int sumPoints = 0;
    for (DailyScoreData d in rangeData) {
      sumPoints += d.totalPoints;
    }
    loggingService.logInfo('[ScoreService] fetchWeeklyScore => sumPoints=$sumPoints');
    return sumPoints;
  }

  // ------------------------------------------------------------------------
  // 8) Monthly Score
  //    We'll base it on the first day of "anyDayInMonth"
  // ------------------------------------------------------------------------
  Future<int> fetchMonthlyScore(DateTime anyDayInMonth) async {
    loggingService.logWarning('[ScoreService] fetchMonthlyScore => anyDayInMonth=$anyDayInMonth');

    final year = anyDayInMonth.year;
    final month = anyDayInMonth.month;

    // first day
    final startOfMonth = DateTime(year, month, 1);
    final nextMonth = (month == 12)
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    final endOfMonth = nextMonth.subtract(const Duration(days: 1));

    final rangeData = await fetchRange(startOfMonth, endOfMonth);
    int sumPoints = 0;
    for (DailyScoreData d in rangeData) {
      sumPoints += d.totalPoints;
    }
    loggingService.logInfo('[ScoreService] fetchMonthlyScore => sumPoints=$sumPoints');
    return sumPoints;
  }

  // ------------------------------------------------------------------------
  // 9) All-Time Score
  //    We iterate over *all* keys in the box and sum their totalPoints
  // ------------------------------------------------------------------------
  Future<int> fetchAllTimeScore() async {
    loggingService.logWarning('[ScoreService] fetchAllTimeScore called');

    final box = await Hive.openBox<DailyScoreData>(_scoreBoxName);
    int sumPoints = 0;
    for (final dynamic key in box.keys) {
      // key might be "score_YYYY-MM-DD"
      final dailyData = box.get(key) as DailyScoreData?;
      if (dailyData != null) {
        sumPoints += dailyData.totalPoints;
      }
    }
    loggingService.logInfo('[ScoreService] fetchAllTimeScore => sumPoints=$sumPoints');
    return sumPoints;
  }

  // ------------------------------------------------------------------------
  // 10) Earliest Logged Date
  //    Returns the earliest date we have ever recorded in Hive.
  //    If the box is empty, returns null.
  // ------------------------------------------------------------------------
  Future<DateTime?> fetchEarliestLoggedDate(String rangeType) async {
    final box = await Hive.openBox<DailyScoreData>(_scoreBoxName);
    if (box.isEmpty) return null;

    final allDates = <DateTime>[];
    for (final dynamic k in box.keys) {
      if (k is String && k.startsWith('score_')) {
        final dateStr = k.substring(6); // remove "score_"
        try {
          final dt = DateTime.parse(dateStr);
          allDates.add(dt);
        } catch (e) {
          // If parse fails, skip
        }
      }
    }

    if (allDates.isEmpty) {
      return null;
    }

    allDates.sort();
    return allDates.first; // earliest date found
  }
}
