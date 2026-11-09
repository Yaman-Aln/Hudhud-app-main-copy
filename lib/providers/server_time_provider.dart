// lib/providers/server_time_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/server_time_service.dart';
import '../providers/ff_logging_service_provider.dart';

/// Provide the time service with the worldtimeapi.org endpoint.
final serverTimeServiceProvider = Provider<ServerTimeService>((ref) {
  return ServerTimeService(
    serverTimeEndpoint: 'https://worldtimeapi.org/api/timezone/Etc/UTC',
  );
});

/// The user's UTC offset in hours, default to 0 if unknown.
/// E.g., +3 means user is 3 hours ahead of UTC, -5 means 5 hours behind UTC.
final userUtcOffsetProvider = StateProvider<int>((ref) => 0);

/// Example: fetch the current server UTC time, then compute user's local midnight in UTC.
final userLocalMidnightUtcProvider = FutureProvider<DateTime>((ref) async {
  final serverTimeSvc = ref.watch(serverTimeServiceProvider);
  final offsetHours = ref.watch(userUtcOffsetProvider);

  // 1) Fetch actual UTC from server
  final nowUtc = await serverTimeSvc.fetchServerUtcTime();

  // 2) Convert into "local midnight" in UTC space
  return serverTimeSvc.calculateUserLocalMidnightUtc(nowUtc, offsetHours);
});
