import 'package:hive/hive.dart';

part 'gratitude_entry_model.g.dart'; // Required for generating the adapter

@HiveType(typeId: 0) // Unique ID 0 for this model
class GratitudeEntry extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  List<String> entries;

  GratitudeEntry({
    required this.date,
    required this.entries,
  });

  /// Factory method to create a `GratitudeEntry` for today's date.
  factory GratitudeEntry.today(List<String> entries) {
    final today = DateTime.now();
    final formattedDate = DateTime(today.year, today.month, today.day);
    return GratitudeEntry(date: formattedDate, entries: entries);
  }

  @override
  String toString() {
    return 'GratitudeEntry(date: $date, entries: $entries)';
  }
}
