// lib/services/analytics_service.dart

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

// Import the toggle from main.dart
import 'package:hudhud_quran_app_new/config.dart';

/// A service class that logs events to both Firebase Analytics and Mixpanel.
class AnalyticsService {
  // Firebase Analytics instance
  final FirebaseAnalytics firebaseAnalytics;

  // Mixpanel instance
  final Mixpanel mixpanel;

  AnalyticsService({
    required this.firebaseAnalytics,
    required this.mixpanel,
  });

  /// Log a generic event with optional parameters
  Future<void> logEvent(
      String eventName, {
        Map<String, dynamic>? parameters,
      }) async {
    // 1) Log to Firebase
    try {
      await firebaseAnalytics.logEvent(
        name: _sanitizeEventNameForFirebase(eventName),
        parameters: _sanitizeParametersForFirebase(parameters),
      );
    } catch (e) {
      // In production code, you might log to Crashlytics or handle the error
    }

    // 2) Conditionally log to Mixpanel
    if (kEnableMixpanel) {
      try {
        mixpanel.track(
          eventName,
          properties: parameters ?? {},
        );
      } catch (e) {
        // In production code, handle or log the error
      }
    } else {
      // If kEnableMixpanel == false, we skip Mixpanel entirely
    }
  }

  /// Set user properties (Firebase User Properties and Mixpanel People properties)
  Future<void> setUserProperty(String propertyName, dynamic value) async {
    // For Firebase
    try {
      await firebaseAnalytics.setUserProperty(
        name: propertyName,
        value: value?.toString(),
      );
    } catch (e) {
      // Handle or log error in production
    }

    // For Mixpanel, only if enabled
    if (kEnableMixpanel) {
      try {
        mixpanel.getPeople().set(propertyName, value);
      } catch (e) {
        // Handle or log error in production
      }
    }
  }

  /// Example specialized event for lesson completion
  Future<void> logLessonCompleted(String lessonId, {String? pathId}) async {
    await logEvent(
      'lesson_completed',
      parameters: {
        'lesson_id': lessonId,
        if (pathId != null) 'path_id': pathId,
      },
    );
  }

  // --------------------------------------------------------------------------
  // Helpers for Firebase constraints
  // --------------------------------------------------------------------------

  /// Ensures Firebase event names meet the 40-char limit and contain valid chars
  String _sanitizeEventNameForFirebase(String eventName) {
    var sanitized = eventName.replaceAll(' ', '_').toLowerCase();
    if (sanitized.length > 40) {
      sanitized = sanitized.substring(0, 40);
    }
    return sanitized;
  }

  /// Ensures parameter keys/values meet Firebase's requirements:
  /// - Keys must be <= 40 chars, alphanumeric + underscores
  /// - Values must be a non-null num, String, or bool (we skip or convert null and other types)
  Map<String, Object>? _sanitizeParametersForFirebase(Map<String, dynamic>? params) {
    if (params == null) return null;

    final Map<String, Object> cleanedMap = {};

    params.forEach((key, value) {
      // Adjust the key
      var paramKey = key.replaceAll(' ', '_').toLowerCase();
      if (paramKey.length > 40) {
        paramKey = paramKey.substring(0, 40);
      }

      // Skip if value is null, because 'Object' can't be null in Firebase parameters
      if (value == null) return;

      // If it's a valid Firebase type, use it; otherwise convert to String
      if (value is String || value is num || value is bool) {
        cleanedMap[paramKey] = value;
      } else {
        cleanedMap[paramKey] = value.toString();
      }
    });

    // Return null if there are no valid parameters
    if (cleanedMap.isEmpty) return null;
    return cleanedMap;
  }
}
