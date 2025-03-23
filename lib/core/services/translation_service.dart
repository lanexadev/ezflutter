import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class TranslationService extends ChangeNotifier {
  static final TranslationService _instance = TranslationService._internal();
  factory TranslationService() => _instance;
  TranslationService._internal();

  Locale _currentLocale = const Locale('en');
  Map<String, String> _localizedStrings = {};

  Locale get currentLocale => _currentLocale;

  Future<void> loadLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    String jsonString = await rootBundle.loadString('assets/locales/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    notifyListeners();
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
