import 'package:flutter/material.dart';
import 'theme_preferences.dart';

class ThemeController with ChangeNotifier {
  ThemeData _themeData;
  final ThemePreferences _prefs = ThemePreferences();

  // Inicializa con tema claro por defecto
  ThemeController(this._themeData) {
    _themeData = ThemeData.light().copyWith(
      primaryColor: Color(0xFF0077B6),
      hintColor: Color(0xFF90E0EF),
    );
    loadTheme();
  }

  get themeData => _themeData;

  void loadTheme() async {
    bool isDarkMode = await _prefs.getTheme();
    // Asegúrate de que solo cambia si hay una preferencia guardada explícitamente
    if (isDarkMode) {
      _themeData = ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey[900],
        hintColor: Colors.tealAccent[700],
      );
    } else {
      _themeData = ThemeData.light().copyWith(
        primaryColor: Color(0xFF0077B6),
        hintColor: Color(0xFF90E0EF),
      );
    }
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    _prefs.setTheme(isDark);
    loadTheme();
  }
}
