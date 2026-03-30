import 'package:ezflutter/app/config.dart';
import 'package:ezflutter/core/di/injection.dart';
import 'package:ezflutter/core/error/error_handler.dart';
import 'package:ezflutter/core/lifecycle/app_lifecycle_observer.dart';
import 'package:ezflutter/core/router/app_router.dart';
import 'package:ezflutter/core/storage/settings_service.dart';
import 'package:ezflutter/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await ErrorHandler.runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    ErrorHandler.init();

    // Register SharedPreferences BEFORE DI (services depend on it)
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);

    // Initialize DI (injectable registers all services)
    await configureDependencies();

    // Initialize settings convenience accessor
    Settings.init(getIt<SettingsService>());

    // Lifecycle observer
    WidgetsBinding.instance.addObserver(AppLifecycleObserver());

    runApp(const ProviderScope(child: EzFlutterApp()));
  });
}

class EzFlutterApp extends ConsumerWidget {
  const EzFlutterApp({super.key});

  static final _router = AppRouter();
  static final _lightTheme = AppTheme.light(AppConfig.seedColor);
  static final _darkTheme = AppTheme.dark(AppConfig.seedColor);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      title: AppConfig.appName,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: themeMode,
      routerConfig: _router.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
