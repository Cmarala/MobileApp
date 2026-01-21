import 'package:flutter/foundation.dart';

class Logger {
  static void logInfo(String message) {
    debugPrint('[INFO] $message');
  }

  static void logError(Object error, [StackTrace? stackTrace]) {
    debugPrint('[ERROR] $error');
    if (stackTrace != null) {
      debugPrint('$stackTrace');
    }
  }
}
