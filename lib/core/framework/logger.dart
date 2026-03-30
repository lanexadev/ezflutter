import 'dart:developer';

class Logger {
  static void logInfo(String message) {
    log('[INFO] $message');
  }

  static void logError(String message) {
    log('[ERROR] $message', error: message);
  }
}