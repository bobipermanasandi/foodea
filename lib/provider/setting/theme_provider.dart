import 'package:flutter/material.dart';
import 'package:foodea/data/local/shared_preference_service.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferenceService _service;

  ThemeProvider(this._service) {
    _loadTheme();
  }

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  Future<void> _loadTheme() async {
    _isDarkTheme = await _service.getThemePreference();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _service.setThemePreference(_isDarkTheme);
    notifyListeners();
  }
}
