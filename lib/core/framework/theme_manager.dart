import 'package:flutter/material.dart';
import '../../app/themes/custom_themes.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeData get themeData => CustomThemes.lightTheme;
  ThemeData get darkThemeData => CustomThemes.darkTheme;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
