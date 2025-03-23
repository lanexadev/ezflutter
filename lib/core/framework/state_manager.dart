import 'package:flutter/material.dart';
import '../services/translation_service.dart';

class AppState extends ChangeNotifier {
  String _appLanguage = 'en';

  String get appLanguage => _appLanguage;

  Future<void> setAppLanguage(String language) async {
    _appLanguage = language;
    await TranslationService().loadLanguage(language);
    notifyListeners();
  }
}
