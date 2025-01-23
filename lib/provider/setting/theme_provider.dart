import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  String _message = "";
  String get message => _message;

  final String _keyTheme = "THEME";

  Future<void> getTheme() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final isDarkMode = pref.getBool(_keyTheme) ?? false;
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      _message =
          isDarkMode ? "Theme Mode is Dark Mode" : "Theme Mode is Light Mode";
    } catch (e) {
      _message = "Failed to get Theme";
    }
    notifyListeners();
  }

  Future<void> setTheme() async {
    try {
      final pref = await SharedPreferences.getInstance();
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
        await pref.setBool(_keyTheme, true);
      } else {
        _themeMode = ThemeMode.light;
        await pref.setBool(_keyTheme, false);
      }
      _message = "Set Theme Success";
    } catch (e) {
      _message = "Failed to set Theme";
    }
    notifyListeners();
  }
}
