import 'dart:ui';

/// App configuration — the ONLY file a beginner needs to edit.
///
/// Change the seed color and app name, and the entire app adapts.
class AppConfig {
  const AppConfig._();

  /// The seed color for the entire app theme.
  /// Change this ONE color and light + dark themes are generated automatically.
  static const Color seedColor = Color(0xFF6750A4);

  /// The display name of the app.
  static const String appName = 'EzFlutter';

  /// Supported locales.
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('fr'),
  ];

  /// Default locale.
  static const Locale defaultLocale = Locale('en');
}
