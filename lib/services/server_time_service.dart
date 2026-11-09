// lib/services/server_time_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../providers/ff_logging_service_provider.dart';


/// Example service for fetching server time from worldtimeapi.org
/// and computing local midnight in UTC.
class ServerTimeService {
  final String serverTimeEndpoint;

  ServerTimeService({required this.serverTimeEndpoint});

  /// Fetch the current server time in UTC from worldtimeapi.org.
  ///
  /// Sample response snippet from worldtimeapi.org:
  /// {
  ///   "abbreviation": "UTC",
  ///   "client_ip": "123.123.123.123",
  ///   "datetime": "2025-01-08T05:10:45.123456+00:00",
  ///   "day_of_week": 3,
  ///   ...
  /// }
  ///
  /// We need to parse `data['datetime']`.
  Future<DateTime> fetchServerUtcTime() async {
    // 1) Make HTTP GET request
    final response = await http.get(Uri.parse(serverTimeEndpoint));

    // 2) Check status code
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch server time. Status: ${response.statusCode}, body: ${response.body}',
      );
    }

    // 3) Parse JSON
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    // 4) worldtimeapi.org provides `datetime` in ISO 8601, e.g. "2025-01-08T05:10:45.123456+00:00"
    final dateTimeStr = data['datetime'];
    if (dateTimeStr == null || dateTimeStr is! String) {
      throw Exception('worldtimeapi.org response missing "datetime" string field. Full data: $data');
    }

    // 5) Parse to DateTime in UTC
    final parsedDateTime = DateTime.parse(dateTimeStr).toUtc();
    return parsedDateTime;
  }

  /// Calculates the user's "local midnight" in UTC, given an offset in hours.
  ///
  /// For example, if offsetHours = +3, user is 3 hours ahead of UTC,
  /// so their local midnight is 21:00 UTC of the *previous* day.
  DateTime calculateUserLocalMidnightUtc(DateTime nowUtc, int utcOffsetHours) {
    // Convert nowUtc to user’s local time by adding the offset
    final userLocalNow = nowUtc.add(Duration(hours: utcOffsetHours));

    // Find local midnight by setting hour/min/sec to 0
    final userLocalMidnight = DateTime(
      userLocalNow.year,
      userLocalNow.month,
      userLocalNow.day,
      0, 0, 0,
    );

    // Convert that local midnight back to absolute UTC
    final localMidnightUtc = userLocalMidnight.subtract(Duration(hours: utcOffsetHours));
    return localMidnightUtc;
  }
}
