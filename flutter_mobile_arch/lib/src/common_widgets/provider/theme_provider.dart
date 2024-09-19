import 'package:flutter/material.dart';
import '../../app_configs/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = AppTheme.theme1;
  String _currentThemeName = 'theme1';

  ThemeData get currentTheme => _currentTheme;
  String get currentThemeName => _currentThemeName;

  void setTheme(String themeName) {
    if (AppTheme.themes.containsKey(themeName)) {
      _currentTheme = AppTheme.themes[themeName]!;
      _currentThemeName = themeName;
      notifyListeners();
    } else {
      throw Exception('Theme $themeName not found');
    }
  }
}
