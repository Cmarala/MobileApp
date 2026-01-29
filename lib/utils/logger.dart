import 'dart:async';
import 'package:flutter/foundation.dart';

class Logger {
  // Performance optimization: disable verbose logs in release mode
  static const bool _enableVerboseLogs = kDebugMode;
  static final _errorStreamController = StreamController<String>.broadcast();
  static Stream<String> get errorStream => _errorStreamController.stream;

  static void logInfo(String message) {
    if (_enableVerboseLogs) {
      debugPrint('[INFO] $message');
    }
  }

  static void logError(Object error, [StackTrace? stackTrace, String? uiMessage]) {
    debugPrint('[ERROR] $error');
    if (stackTrace != null) {
      debugPrint('$stackTrace');
    }
    
    // Broadcast sanitized error message to UI
    final message = uiMessage ?? _sanitizeError(error);
    _errorStreamController.add(message);
  }

  static String _sanitizeError(Object error) {
    final errorStr = error.toString();
    
    if (errorStr.contains('PostgrestException')) {
      return 'Database Sync Error';
    }
    if (errorStr.contains('SocketException') || errorStr.contains('NetworkException')) {
      return 'Network Connection Error';
    }
    if (errorStr.contains('TimeoutException')) {
      return 'Request Timeout';
    }
    if (errorStr.contains('SqliteException')) {
      return 'Local Database Error';
    }
    
    // Remove technical prefixes
    return errorStr.replaceFirst('Exception: ', '').replaceFirst('Error: ', '');
  }

  static void dispose() {
    _errorStreamController.close();
  }
}
