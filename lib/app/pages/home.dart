import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezflutter/core/services/translation_service.dart';
import 'package:ezflutter/core/framework/theme_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translationService = Provider.of<TranslationService>(context);
    final themeManager = Provider.of<ThemeManager>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(translationService.translate('app_title')),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              String newLang = translationService.currentLocale.languageCode == 'en' ? 'fr' : 'en';
              translationService.loadLanguage(newLang);
            },
          ),
          IconButton(
            icon: Icon(themeManager.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => themeManager.toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(context, '📖 Documentation', 'documentation', theme),
            _buildFeatureCard(context, '🔔 Notifications', 'notifications', theme),
            _buildFeatureCard(context, '🔐 Authentification', 'auth', theme),
            _buildFeatureCard(context, '🌍 Traduction', 'translation', theme),
            _buildFeatureCard(context, '🎨 Thèmes', 'themes', theme),
            _buildFeatureCard(context, '⚡ API & Stockage', 'api', theme),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, String route, ThemeData theme) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/$route'),
      child: Card(
        color: theme.colorScheme.primary.withOpacity(0.1),
        child: Center(
          child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
