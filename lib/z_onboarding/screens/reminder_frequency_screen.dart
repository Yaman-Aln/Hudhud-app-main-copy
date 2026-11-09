// lib/z_onboarding/screens/reminder_frequency_screen.dart

import 'dart:io' show Platform;                      // For detecting Android vs. iOS
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // for formatting TimeOfDay

// Add permission_handler for Android 13+ notification permission
import 'package:permission_handler/permission_handler.dart';

// Import your analytics provider
import 'package:hudhud_quran_app_new/providers/analytics_service_provider.dart';
import '../models/unique_test_model.dart';

// note: NOT Localized *****
/// Lets the user select their preferred [ReminderFrequency]:
///  - None
///  - Once Daily (with a specific time)
///  - Multiple custom times
///
/// [onNext] passes back the final [ReminderFrequency].
/// [onSkip] allows skipping, often defaulting to [ReminderFrequency.none()].
class ReminderFrequencyScreen extends ConsumerStatefulWidget {
  final ValueChanged<ReminderFrequency> onNext;
  final VoidCallback onSkip;

  const ReminderFrequencyScreen({
    Key? key,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  ConsumerState<ReminderFrequencyScreen> createState() => _ReminderFrequencyScreenState();
}

class _ReminderFrequencyScreenState extends ConsumerState<ReminderFrequencyScreen> {
  /// Internal enum for user selection: none, once daily, or custom times.
  _ReminderType _selectedType = _ReminderType.none;

  /// If "Once Daily" is chosen, user picks a single time.
  TimeOfDay? _onceDailyTime;

  /// If "Custom" is chosen, user can pick multiple times.
  final List<TimeOfDay> _customTimes = [];

  @override
  Widget build(BuildContext context) {
    final analytics = ref.read(analyticsServiceProvider);

    // 1) Log "viewed"
    analytics.logEvent('reminder_frequency_screen_viewed');

    return Semantics(
      label: 'Reminder Frequency Screen',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Set Your Reminder Frequency'),
          actions: [
            TextButton(
              onPressed: () {
                // 2) If skip
                analytics.logEvent('reminder_frequency_skipped');
                widget.onSkip();
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // NONE
            RadioListTile<_ReminderType>(
              title: const Text('None'),
              subtitle: const Text('Disable all notifications or reminders'),
              value: _ReminderType.none,
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value ?? _ReminderType.none;
                });
              },
            ),

            // ONCE DAILY
            RadioListTile<_ReminderType>(
              title: const Text('Once Daily'),
              subtitle: const Text('Receive one reminder per day at a chosen time'),
              value: _ReminderType.onceDaily,
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value ?? _ReminderType.none;
                });
              },
            ),
            if (_selectedType == _ReminderType.onceDaily)
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: ListTile(
                  title: Text(
                    _onceDailyTime != null
                        ? 'Reminder Time: ${_formatTimeOfDay(_onceDailyTime!)}'
                        : 'Choose a time',
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () => _pickTime(context, onceDaily: true),
                ),
              ),

            // CUSTOM
            RadioListTile<_ReminderType>(
              title: const Text('Custom'),
              subtitle: const Text('Set multiple specific times throughout the day'),
              value: _ReminderType.custom,
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value ?? _ReminderType.none;
                });
              },
            ),
            if (_selectedType == _ReminderType.custom)
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_customTimes.isEmpty)
                      const Text('No times selected yet.'),
                    ..._customTimes.asMap().entries.map((entry) {
                      final index = entry.key;
                      final time = entry.value;
                      return ListTile(
                        title: Text('Time ${index + 1}: ${_formatTimeOfDay(time)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _customTimes.removeAt(index);
                            });
                          },
                        ),
                        onTap: () => _pickTime(context, index: index),
                      );
                    }).toList(),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Time'),
                      onPressed: () => _pickTime(context),
                    ),
                  ],
                ),
              ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _handleNext,
              child: const Text('Next'),
            ),
          ),
        ),
      ),
    );
  }

  /// Called when the user taps the Next button.
  /// Builds a ReminderFrequency object from the selection.
  void _handleNext() {
    final analytics = ref.read(analyticsServiceProvider);
    // 3) Log "next" event
    analytics.logEvent(
      'reminder_frequency_next',
      parameters: {
        'selected_type': _selectedType.toString(), // e.g. "_ReminderType.onceDaily"
        'times_count': _customTimes.length,
      },
    );

    // Build final ReminderFrequency
    ReminderFrequency freq;
    switch (_selectedType) {
      case _ReminderType.none:
        freq = const ReminderFrequency.none();
        break;
      case _ReminderType.onceDaily:
        freq = _buildOnceDaily();
        break;
      case _ReminderType.custom:
        freq = _buildCustom();
        break;
    }

    // If user actually wants reminders, request notification permission on Android
    // (iOS prompting is presumably handled automatically or elsewhere)
    if (_selectedType != _ReminderType.none) {
      _requestAndroidNotificationPermission();
    }

    // Finally, notify parent
    widget.onNext(freq);
  }

  // Requests POST_NOTIFICATIONS permission on Android 13+ using permission_handler
  Future<void> _requestAndroidNotificationPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        final newStatus = await Permission.notification.request();
        // For debugging or analytics if desired:
        // debugPrint('Android notification permission granted? ${newStatus.isGranted}');
      }
    }
  }

  ReminderFrequency _buildOnceDaily() {
    if (_onceDailyTime != null) {
      final now = DateTime.now();
      final onceDailyDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        _onceDailyTime!.hour,
        _onceDailyTime!.minute,
      );
      return ReminderFrequency.onceDaily(onceDailyDateTime);
    } else {
      // If no time picked, default 8 AM
      final now = DateTime.now();
      return ReminderFrequency.onceDaily(
        DateTime(now.year, now.month, now.day, 8, 0),
      );
    }
  }

  ReminderFrequency _buildCustom() {
    if (_customTimes.isEmpty) {
      // If user picks custom but no times, treat as none
      return const ReminderFrequency.none();
    } else {
      final now = DateTime.now();
      final dateTimes = _customTimes.map((tod) {
        return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
      }).toList();
      return ReminderFrequency.custom(dateTimes);
    }
  }

  Future<void> _pickTime(BuildContext context, {bool onceDaily = false, int? index}) async {
    final nowTime = TimeOfDay.now();
    final initial = onceDaily
        ? (_onceDailyTime ?? nowTime)
        : (index != null ? _customTimes[index] : nowTime);

    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (picked != null) {
      setState(() {
        if (onceDaily) {
          _onceDailyTime = picked;
        } else if (index != null) {
          _customTimes[index] = picked;
        } else {
          _customTimes.add(picked);
        }
      });
    }
  }

  /// Formats a [TimeOfDay], e.g. "8:30 AM".
  String _formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return DateFormat.jm().format(dt);
  }
}

enum _ReminderType {
  none,
  onceDaily,
  custom,
}
