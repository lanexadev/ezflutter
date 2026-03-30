import 'package:ezflutter/core/env/env.dart';
import 'package:logger/logger.dart' as pkg;

/// Simplified logging facade.
///
/// Usage:
/// ```dart
/// Log.info('User logged in');
/// Log.error('Payment failed', error: e, stackTrace: s);
/// ```
class Log {
  Log._();

  static final pkg.Logger _logger = pkg.Logger(
    printer: pkg.PrettyPrinter(
      errorMethodCount: 5,
      lineLength: 80,
      noBoxingByDefault: Env.isProd,
    ),
    level: _level,
  );

  static pkg.Level get _level {
    switch (Env.current) {
      case Environment.dev:
        return pkg.Level.trace;
      case Environment.staging:
        return pkg.Level.info;
      case Environment.prod:
        return pkg.Level.error;
    }
  }

  static void trace(String message) => _logger.t(message);
  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  static void fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.f(message, error: error, stackTrace: stackTrace);
}
