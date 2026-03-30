import 'package:ezflutter/core/framework/error_handler.dart';
import 'package:ezflutter/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/translation_service.dart';
import 'core/framework/theme_manager.dart';
import 'core/framework/state_manager.dart';
import 'core/framework/router.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    ErrorHandler.handleError(details.exception, details.stack ?? StackTrace.empty);
  };

  WidgetsFlutterBinding.ensureInitialized();
  await TranslationService().loadLanguage('en'); // Charger la langue par défaut

  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService.init(); // Initialiser les notifications

  runApp(const EzFlutter());
}

class EzFlutter extends StatelessWidget {
  const EzFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => TranslationService()), // Ajout du service de traduction
      ],
      child: Consumer<TranslationService>(
        builder: (context, translationService, child) {
          return MaterialApp(
            title: 'EzFlutter',
            locale: translationService.currentLocale,
            theme: ThemeManager().themeData,
            darkTheme: ThemeManager().darkThemeData,
            themeMode: ThemeManager().themeMode,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: '/home',
          );
        },
      ),
    );
  }
}
