import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const _key = 'isDarkMode';

  Future<bool> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false; // Retorna falso si no se ha establecido aún
  }

  Future<void> setTheme(bool isDarkMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDarkMode);
  }
}
