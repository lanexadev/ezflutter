import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Simple key-value settings storage.
///
/// Usage:
/// ```dart
/// await Settings.set('onboarding_done', true);
/// final done = Settings.get<bool>('onboarding_done');
/// ```
@singleton
class SettingsService {
  SettingsService(this._prefs);

  final SharedPreferences _prefs;

  T? get<T>(String key) {
    final value = _prefs.get(key);
    if (value is T) return value;
    return null;
  }

  Future<bool> set<T>(String key, T value) async {
    return switch (value) {
      final String v => _prefs.setString(key, v),
      final int v => _prefs.setInt(key, v),
      final double v => _prefs.setDouble(key, v),
      final bool v => _prefs.setBool(key, v),
      final List<String> v => _prefs.setStringList(key, v),
      _ => throw ArgumentError('Unsupported type: ${value.runtimeType}'),
    };
  }

  Future<bool> remove(String key) => _prefs.remove(key);
  Future<bool> clear() => _prefs.clear();
  bool containsKey(String key) => _prefs.containsKey(key);
}

/// Static convenience wrapper for SettingsService.
class Settings {
  Settings._();
  static SettingsService? _instance;

  static SettingsService? get instance => _instance;
  static set instance(SettingsService service) => _instance = service;

  static T? get<T>(String key) => _instance?.get<T>(key);

  static Future<bool> set<T>(String key, T value) =>
      _instance?.set(key, value) ?? Future.value(false);

  static Future<bool> remove(String key) =>
      _instance?.remove(key) ?? Future.value(false);
}
