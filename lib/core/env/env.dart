/// Environment configuration for EzFlutter.
///
/// Loaded from --dart-define-from-file at build time.
enum Environment { dev, staging, prod }

class Env {
  const Env._();

  static const String _env = String.fromEnvironment('ENV', defaultValue: 'dev');
  static const String apiBaseUrl =
      String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');
  static const String appName =
      String.fromEnvironment('APP_NAME', defaultValue: 'EzFlutter');
  static const bool enableLogging =
      bool.fromEnvironment('ENABLE_LOGGING', defaultValue: true);
  static const bool enableCrashReporting =
      bool.fromEnvironment('ENABLE_CRASH_REPORTING');

  static Environment get current {
    switch (_env) {
      case 'prod':
        return Environment.prod;
      case 'staging':
        return Environment.staging;
      default:
        return Environment.dev;
    }
  }

  static bool get isDev => current == Environment.dev;
  static bool get isStaging => current == Environment.staging;
  static bool get isProd => current == Environment.prod;
}
