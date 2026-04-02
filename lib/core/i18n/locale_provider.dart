import 'dart:ui';

import 'package:ezflutter/core/di/injection.dart';
import 'package:ezflutter/core/storage/settings_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

/// Manages the current locale.
///
/// Persists the user's language choice.
@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  static const _key = 'app_locale';

  @override
  Locale build() {
    final settings = getIt<SettingsService>();
    final saved = settings.get<String>(_key);
    if (saved != null) return Locale(saved);
    return PlatformDispatcher.instance.locale;
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final settings = getIt<SettingsService>();
    await settings.set(_key, locale.languageCode);
  }
}
