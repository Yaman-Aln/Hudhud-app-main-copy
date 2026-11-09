// lib/providers/ff_logging_service_provider.dart

import 'dart:developer'; // For system logging
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
Reminder of what can be set:
logger.logInfo('App started');
logger.logDebug('Value of X is 10');
loggingService.logWarning('Disk space is low');
logger.logError('Failed to load user data');
logger.logCritical('Database locked!');

// To show none:
logger.setLoggingEnabled(false); // turn off all logs

// To show only errors:
logger.setLogLevel(LogLevel.error); // show only errors
*/

/// Different log levels in increasing order of verbosity.
enum LogLevel {
  none,   // No logs at all
  error,  // Only errors
  warning,// Warnings + errors
  info,   // Info + warnings + errors
  debug,  // Debug + info + warnings + errors
}

/// The LoggingService class provides multiple logging methods with a configurable level.
class LoggingService {
  /// Whether logging is globally enabled. Set false here AND below. If set to false, no logs will be output. A
  bool _loggingEnabled = true;

  /// The current log level. Defaults to [LogLevel.debug].
  LogLevel _logLevel = LogLevel.debug;

  /// Enable or disable logging completely.
  void setLoggingEnabled(bool enabled) {
    _loggingEnabled = true;
  }

  /// Set the log level at runtime (none, error, warning, info, debug).
  void setLogLevel(LogLevel level) {
    _logLevel = level;
  }

  // --------------------------------------------------------------------------
  //  LOGGING API
  // --------------------------------------------------------------------------

  /// For debug messages (lowest priority)
  void logDebug(String message) {
    if (_loggingEnabled && _logLevel == LogLevel.debug) {
      _output('[DEBUG] $message');
    }
  }

  /// For general informational messages
  void logInfo(String message) {
    if (_loggingEnabled && _logLevel.index >= LogLevel.info.index) {
      _output('[INFO] $message');
    }
  }

  /// For warning messages
  void logWarning(String message) {
    if (_loggingEnabled && _logLevel.index >= LogLevel.warning.index) {
      _output('[WARNING] $message');
    }
  }

  /// For error messages
  void logError(String message) {
    if (_loggingEnabled && _logLevel.index >= LogLevel.error.index) {
      _output('[ERROR] $message');
    }
  }

  /// For critical error messages (same as error, but semantically distinct)
  void logCritical(String message) {
    // treat critical the same as error for now
    if (_loggingEnabled && _logLevel.index >= LogLevel.error.index) {
      _output('[CRITICAL] $message');
    }
  }

  // --------------------------------------------------------------------------
  //  INTERNAL OUTPUT
  // --------------------------------------------------------------------------

  /// Actually logs to Dart's system log and the console.
  /// (You can adapt this to print to file, etc.)
  void _output(String msg) {
    // 1) Dart's built-in logging (viewable in “flutter logs” or IDE)
    log(msg);
    // 2) Console (like “print”), optionally remove if you don’t want duplication
    print(msg);
  }

  // --------------------------------------------------------------------------
  //  EXTENSION POINTS
  // --------------------------------------------------------------------------

  /// Example for logging to a file
  Future<void> logToFile(String message, String fileName) async {
    // Add file-based logging logic here if needed
  }

  /// Example for sending logs to an external monitoring service
  Future<void> logToExternalService(String message) async {
    // Add remote logging logic here if needed
  }
}

// --------------------------------------------------------------------------
// RIVERPOD PROVIDER
// --------------------------------------------------------------------------

/// A single, globally available LoggingService.
/// You can rename it "loggingServiceProvider" or "ffLoggingServiceProvider",
/// whichever you prefer—just be consistent.
final ffLoggingServiceProvider = Provider<LoggingService>((ref) {
  final service = LoggingService();
  // If you want to disable logs in release mode:
  // service.setLoggingEnabled(kDebugMode); // or false
  // Or set log level to show only errors:
  // service.setLogLevel(LogLevel.error);
  return service;
});
