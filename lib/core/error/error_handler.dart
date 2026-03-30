import 'dart:async';

import 'package:ezflutter/core/logging/log.dart';
import 'package:flutter/foundation.dart';

/// Global error handler for the application.
///
/// Catches Flutter errors and Dart async errors.
/// In dev: logs to console with stack trace.
/// In prod: would send to crash reporter (Crashlytics/Sentry).
class ErrorHandler {
  const ErrorHandler._();

  /// Initialize global error handling.
  static void init() {
    // Flutter framework errors
    FlutterError.onError = (details) {
      Log.error(
        'Flutter error: ${details.exceptionAsString()}',
        error: details.exception,
        stackTrace: details.stack,
      );
    };

    // Dart async errors not caught by Flutter
    PlatformDispatcher.instance.onError = (error, stack) {
      Log.fatal(
        'Uncaught platform error',
        error: error,
        stackTrace: stack,
      );
      return true;
    };
  }

  /// Run the app inside an error zone.
  static Future<void> runGuarded(Future<void> Function() appRunner) async {
    await runZonedGuarded(
      appRunner,
      (error, stackTrace) {
        Log.fatal(
          'Uncaught zone error',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }
}
