import 'dart:math';
import 'dart:io' show Platform; // For detecting Android / iOS
import 'package:permission_handler/permission_handler.dart'; // For requesting Android 13 notifications

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

// For localization
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

// Import user profile & combined streak providers
import '../z_onboarding/providers/user_profile_provider.dart';
import '../z_onboarding/models/unique_test_model.dart';
import '../providers/combined_streak_provider.dart';

/// A NotificationService compatible with flutter_local_notifications ^18.0.1.
/// Uses hudhud_chirp.mp3 as the custom sound, and hudhud_quran.png as the notification icon.
/// Schedules daily/weekly notifications as gentle reminders for Quran memorization and gratitude.
///
/// Hybrid approach for runtime permissions:
/// - iOS/macOS => requestPermissions(alert: true, sound: true, badge: true)
/// - Android => use permission_handler for POST_NOTIFICATIONS on Android 13+
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  static NotificationService get instance => _instance;

  NotificationService._internal();

  bool _initialized = false;
  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  /// Call once in app startup to set up the plugin and time zones.
  Future<void> initNotificationService() async {
    if (_initialized) return;
    try {
      // 1) Initialize time zones
      tz.initializeTimeZones();

      // 2) Create plugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      // 3) Android & iOS/macOS init
      //    Replace 'hudhud_quran' with the name of your icon in the drawable folder
      final androidInit = const AndroidInitializationSettings('hudhud_quran');

      // For iOS & macOS, use one DarwinInitializationSettings object.
      final darwinInit = const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      final initSettings = InitializationSettings(
        android: androidInit,
        iOS: darwinInit,
        macOS: darwinInit,
      );

      // 4) Initialize plugin
      await _flutterLocalNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      );

      _initialized = true;
      debugPrint('[NotificationService] Initialized successfully.');
    } catch (e) {
      debugPrint('[NotificationService] Error during init: $e');
      rethrow;
    }
  }

  /// Called when the user taps on a notification in iOS or Android
  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    debugPrint('[NotificationService] onDidReceiveNotificationResponse => payload=$payload');
    // e.g. Navigate or open a specific screen if desired
  }

  // --------------------------------------------------------------------------
  // Public API
  // --------------------------------------------------------------------------

  /// Request notification permissions on iOS/macOS (alert, badge, sound),
  /// and use permission_handler for Android 13+ if needed.
  Future<void> requestPlatformPermissions() async {
    final iosPlugin = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    final macPlugin = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>();

    // 1) iOS/macOS => request alert, badge, sound
    await iosPlugin?.requestPermissions(alert: true, badge: true, sound: true);
    await macPlugin?.requestPermissions(alert: true, badge: true, sound: true);

    // 2) Android => use permission_handler to request POST_NOTIFICATIONS on Android 13+
    if (Platform.isAndroid) {
      final currentStatus = await Permission.notification.status;

      if (!currentStatus.isGranted) {
        final result = await Permission.notification.request();
        if (result.isGranted) {
          debugPrint('[NotificationService] POST_NOTIFICATIONS granted on Android.');
        } else if (result.isPermanentlyDenied) {
          debugPrint('[NotificationService] POST_NOTIFICATIONS permanently denied on Android.');
          // Optionally open app settings so user can enable it manually:
          await openAppSettings();
        } else {
          debugPrint('[NotificationService] POST_NOTIFICATIONS denied on Android.');
        }
      } else {
        debugPrint('[NotificationService] Notification permission already granted on Android.');
      }
    }
  }

  /// Shows a notification immediately (on-demand) for quick testing.
  Future<void> showImmediateNotification() async {
    if (!_initialized) {
      debugPrint('[NotificationService] Not initialized yet!');
      return;
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'on_demand_test_channel',
      'On-Demand Test Notifications',
      channelDescription: 'Channel for immediate test notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      // Use the custom sound resource in android/app/src/main/res/raw/
      sound: RawResourceAndroidNotificationSound('hudhud_chirp'),
      // Use the 'icon' parameter instead of 'smallIcon'
      icon: 'hudhud_quran',
      largeIcon: DrawableResourceAndroidBitmap('hudhud_quran'),
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      sound: 'hudhud_chirp.mp3',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      9999,
      'Immediate Notification',
      'This is your test notification with a custom sound!',
      notificationDetails,
    );

    debugPrint('[NotificationService] showImmediateNotification called => displayed.');
  }

  /// Schedules the next daily/weekly notification or cancels if freq is 'None'.
  /// Localized strings are fetched via [loc].
  Future<void> scheduleNextNotification(WidgetRef ref, AppLocalizations loc) async {
    if (!_initialized) {
      debugPrint('[NotificationService] Not initialized! Call initNotificationService() first.');
      return;
    }

    try {
      final profile = ref.read(userProfileProvider);
      final freq = profile.notificationFrequency;

      // If 'None', cancel existing schedules
      if (freq == 'None') {
        await cancelAllNotifications();
        return;
      }

      // Load localized strings
      final dailyTitle = loc.notificationDailyTitle;
      final dailyBody = loc.notificationDailyBody;
      final weeklyTitle = loc.notificationWeeklyTitle;
      final weeklyBody = loc.notificationWeeklyBody;

      // Build a random time between 6 PM and 9 PM
      final now = DateTime.now();
      final randomTime = _getRandomTimeBetween(18, 21);

      DateTime scheduleDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        randomTime.hour,
        randomTime.minute,
      );
      if (scheduleDateTime.isBefore(now)) {
        scheduleDateTime = scheduleDateTime.add(const Duration(days: 1));
      }

      if (freq == 'Daily') {
        await _scheduleNotification(
          ref: ref,
          dateTime: scheduleDateTime,
          title: dailyTitle,
          body: dailyBody,
          channelId: 'daily_reminder',
          channelName: loc.notificationChannelDailyRemindersName,
          channelDescription: loc.notificationChannelDailyRemindersDesc,
        );
        debugPrint('[NotificationService] Daily notification scheduled for $scheduleDateTime');
      } else if (freq == 'Weekly') {
        scheduleDateTime = scheduleDateTime.add(const Duration(days: 7));
        await _scheduleNotification(
          ref: ref,
          dateTime: scheduleDateTime,
          title: weeklyTitle,
          body: weeklyBody,
          channelId: 'weekly_reminder',
          channelName: loc.notificationChannelWeeklyRemindersName,
          channelDescription: loc.notificationChannelWeeklyRemindersDesc,
        );
        debugPrint('[NotificationService] Weekly notification scheduled for $scheduleDateTime');
      }
    } catch (e) {
      debugPrint('[NotificationService] Error scheduling notification: $e');
    }
  }

  /// Cancels all scheduled or active notifications.
  Future<void> cancelAllNotifications() async {
    if (!_initialized) return;
    try {
      await _flutterLocalNotificationsPlugin.cancelAll();
      debugPrint('[NotificationService] All notifications canceled.');
    } catch (e) {
      debugPrint('[NotificationService] Error canceling notifications: $e');
    }
  }

  // --------------------------------------------------------------------------
  // Internal Scheduling Logic
  // --------------------------------------------------------------------------

  /// Calls zonedSchedule with a custom sound and icon after checking user activity.
  Future<void> _scheduleNotification({
    required WidgetRef ref,
    required DateTime dateTime,
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    required String channelDescription,
  }) async {
    try {
      final userDidActivity = await _didUserActivity(ref, dateTime);
      if (userDidActivity) {
        debugPrint('[NotificationService] Activity found => skipping schedule.');
        return;
      }

      final androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        color: Colors.blue.shade600,
        icon: 'hudhud_quran',
        largeIcon: const DrawableResourceAndroidBitmap('hudhud_quran'),
        playSound: true,
        sound: RawResourceAndroidNotificationSound('hudhud_chirp'),
      );

      final iosDetails = const DarwinNotificationDetails(
        sound: 'hudhud_chirp.mp3',
      );

      final platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final tzTime = _toTZDateTime(dateTime);

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tzTime,
        platformDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: null,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      final fm = DateFormat('yyyy-MM-dd HH:mm');
      debugPrint('[NotificationService] Notification scheduled for ${fm.format(dateTime)}');
    } catch (e) {
      debugPrint('[NotificationService] Error in _scheduleNotification: $e');
    }
  }

  /// Checks if user did daily or weekly activity, using combinedStreakProvider.
  Future<bool> _didUserActivity(WidgetRef ref, DateTime dateTime) async {
    final profile = ref.read(userProfileProvider);
    final freq = profile.notificationFrequency;
    try {
      final combinedStreak = ref.read(combinedStreakProvider);

      if (freq == 'Daily') {
        // Check if user has activity on that exact day
        return combinedStreak.userHasActivityOnDay(dateTime);
      } else if (freq == 'Weekly') {
        // Check if user has activity in the last 7 days
        final now = DateTime.now();
        final sevenDaysAgo = now.subtract(const Duration(days: 7));

        for (final activeDay in combinedStreak.allActiveDays) {
          if (activeDay.isAfter(sevenDaysAgo) &&
              activeDay.isBefore(now.add(const Duration(days: 1)))) {
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      debugPrint('[NotificationService] Error checking user activity: $e');
      return false;
    }
  }

  /// Convert [DateTime] to tz.TZDateTime in device local time.
  tz.TZDateTime _toTZDateTime(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local);
  }

  /// Returns a random time-of-day between [startHour]..[endHour].
  DateTime _getRandomTimeBetween(int startHour, int endHour) {
    final rand = Random();
    final hour = startHour + rand.nextInt((endHour - startHour) + 1);
    final minute = rand.nextInt(60);
    return DateTime(2000, 1, 1, hour, minute);
  }
}

// Provide the NotificationService instance to Riverpod
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService.instance;
});
