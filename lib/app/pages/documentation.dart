import 'package:flutter/material.dart';
import 'package:ezflutter/app/widgets/app_header.dart';

class DocumentationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: '📖 Documentation'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection('🚀 Démarrer', 'Comment installer et configurer EzFlutter.'),
            _buildSection('📝 Créer une page', 'Comment ajouter une nouvelle page avec le routing.'),
            _buildSection('🎨 Personnaliser un thème', 'Comment modifier les couleurs et polices.'),
            _buildSection('🌍 Gérer les traductions', 'Ajouter des fichiers JSON pour plusieurs langues.'),
            _buildSection('🔧 Configurer l\'application', 'Modifier les paramètres globaux.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
            SizedBox(height: 10),
            Text(content, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
