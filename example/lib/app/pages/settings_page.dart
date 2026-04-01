import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/auth/auth_provider.dart';
import 'package:ezflutter/core/ez/ez_settings_page.dart';
import 'package:ezflutter/core/i18n/locale_provider.dart';
import 'package:ezflutter/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SettingsPage extends EzSettingsPage {
  const SettingsPage({super.key});

  @override
  String get title => 'Settings';

  @override
  List<EzSection> get sections => [
        EzSection('Appearance', [
          EzSetting.custom((context, ref) {
            final themeMode = ref.watch(appThemeModeProvider);
            return ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Theme'),
              subtitle: Text(themeMode.name),
              trailing: SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode),
                  ),
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: Icon(Icons.auto_mode),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode),
                  ),
                ],
                selected: {themeMode},
                onSelectionChanged: (modes) {
                  ref
                      .read(appThemeModeProvider.notifier)
                      .setThemeMode(modes.first);
                },
              ),
            );
          }),
        ]),
        EzSection('Language', [
          EzSetting.custom((context, ref) {
            final locale = ref.watch(appLocaleProvider);
            return ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: Text(locale.languageCode.toUpperCase()),
              trailing: SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'en', label: Text('EN')),
                  ButtonSegment(value: 'fr', label: Text('FR')),
                ],
                selected: {locale.languageCode},
                onSelectionChanged: (codes) {
                  ref
                      .read(appLocaleProvider.notifier)
                      .setLocale(Locale(codes.first));
                },
              ),
            );
          }),
        ]),
        EzSection('Account', [
          EzSetting.action(
            label: 'Logout',
            icon: Icons.logout,
            isDanger: true,
            onTap: () {
              // Will be called from a context where ref is available
              // For now this is a placeholder
            },
          ),
        ]),
      ];
}
