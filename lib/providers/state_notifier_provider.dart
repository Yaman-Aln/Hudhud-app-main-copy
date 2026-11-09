import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../providers/ff_logging_service_provider.dart';


class GratitudeData {
  final int streak;
  final int total;

  GratitudeData({required this.streak, required this.total});
}

class GratitudeNotifier extends StateNotifier<AsyncValue<GratitudeData>> {
  GratitudeNotifier() : super(const AsyncValue.loading());

  Future<void> fetchGratitudeData() async {
    try {
      final box = await Hive.openBox('gratitudeBox');
      final streak = box.get('streak', defaultValue: 0);
      final total = box.get('total', defaultValue: 0);
      state = AsyncValue.data(GratitudeData(streak: streak, total: total));
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace); // Pass both the error and stack trace
    }
  }
}

final gratitudeProvider =
StateNotifierProvider<GratitudeNotifier, AsyncValue<GratitudeData>>(
        (ref) => GratitudeNotifier());
