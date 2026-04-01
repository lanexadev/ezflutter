// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages the app theme mode (light/dark/system).
///
/// Persists the user's choice in settings.

@ProviderFor(AppThemeMode)
final appThemeModeProvider = AppThemeModeProvider._();

/// Manages the app theme mode (light/dark/system).
///
/// Persists the user's choice in settings.
final class AppThemeModeProvider
    extends $NotifierProvider<AppThemeMode, ThemeMode> {
  /// Manages the app theme mode (light/dark/system).
  ///
  /// Persists the user's choice in settings.
  AppThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeHash();

  @$internal
  @override
  AppThemeMode create() => AppThemeMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$appThemeModeHash() => r'86fc76611bbecd7fb4cb9e28190594e9496c74e3';

/// Manages the app theme mode (light/dark/system).
///
/// Persists the user's choice in settings.

abstract class _$AppThemeMode extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
