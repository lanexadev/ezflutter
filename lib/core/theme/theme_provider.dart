import 'dart:async';

import 'package:ezflutter/core/di/injection.dart';
import 'package:ezflutter/core/storage/settings_service.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

/// Manages the app theme mode (light/dark/system).
///
/// Persists the user's choice in settings.
@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    final settings = getIt<SettingsService>();
    final saved = settings.get<String>(_key);
    return switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final settings = getIt<SettingsService>();
    await settings.set(_key, mode.name);
  }

  void toggle() {
    final next = switch (state) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
    unawaited(setThemeMode(next));
  }
}

/// Provides the app's theme data based on the seed color from AppConfig.
class AppTheme {
  const AppTheme._();

  static ThemeData light(Color seedColor) => FlexThemeData.light(
        colors: FlexSchemeColor.from(primary: seedColor),
      );

  static ThemeData dark(Color seedColor) => FlexThemeData.dark(
        colors: FlexSchemeColor.from(primary: seedColor),
      );
}
