import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A pre-built settings page from declarative configuration.
///
/// ```dart
/// @RoutePage()
/// class AppSettingsPage extends EzSettingsPage {
///   const AppSettingsPage({super.key});
///
///   @override
///   String get title => 'Settings';
///
///   @override
///   List<EzSection> get sections => [
///     EzSection('Appearance', [
///       EzSetting.action(label: 'Theme', icon: Icons.brightness_6, onTap: () {}),
///     ]),
///   ];
/// }
/// ```
abstract class EzSettingsPage extends ConsumerWidget {
  const EzSettingsPage({super.key});

  /// Page title.
  String get title;

  /// Settings sections.
  List<EzSection> get sections;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        children: [
          for (final section in sections) ...[
            _SectionHeader(title: section.title),
            ...section.settings.map((s) => s.build(context, ref)),
            if (section != sections.last) const Divider(),
          ],
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

/// A section in an [EzSettingsPage].
class EzSection {
  const EzSection(this.title, this.settings);
  final String title;
  final List<EzSetting> settings;
}

/// A single setting entry.
abstract class EzSetting {
  const EzSetting();

  Widget build(BuildContext context, WidgetRef ref);

  /// A navigation setting that pushes a route.
  static EzSetting navigation({
    required String label,
    required PageRouteInfo route,
    IconData? icon,
    String? subtitle,
  }) =>
      _NavigationSetting(
        label: label,
        route: route,
        icon: icon,
        subtitle: subtitle,
      );

  /// An action setting (e.g., logout, delete account).
  static EzSetting action({
    required String label,
    required VoidCallback onTap,
    IconData? icon,
    bool isDanger = false,
  }) =>
      _ActionSetting(
        label: label,
        onTap: onTap,
        icon: icon,
        isDanger: isDanger,
      );

  /// A custom widget setting.
  static EzSetting custom(
    Widget Function(BuildContext, WidgetRef) builder,
  ) =>
      _CustomSetting(builder);
}

class _NavigationSetting extends EzSetting {
  const _NavigationSetting({
    required this.label,
    required this.route,
    this.icon,
    this.subtitle,
  });
  final String label;
  final PageRouteInfo route;
  final IconData? icon;
  final String? subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(label),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.router.push(route),
    );
  }
}

class _ActionSetting extends EzSetting {
  const _ActionSetting({
    required this.label,
    required this.onTap,
    this.icon,
    this.isDanger = false,
  });
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isDanger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = isDanger ? Theme.of(context).colorScheme.error : null;
    return ListTile(
      leading: icon != null ? Icon(icon, color: color) : null,
      title: Text(label, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }
}

class _CustomSetting extends EzSetting {
  const _CustomSetting(this._builder);
  final Widget Function(BuildContext, WidgetRef) _builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) => _builder(context, ref);
}
