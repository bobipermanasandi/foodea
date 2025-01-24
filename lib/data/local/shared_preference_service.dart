import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const _themeKey = 'isDarkTheme';
  static const _alarmOnKey = 'isAlarmOn';

  Future<bool> getThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }

  Future<void> setThemePreference(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  Future<bool> getAlarmPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_alarmOnKey) ?? false;
  }

  Future<void> setAlarmPreference(bool isOn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_alarmOnKey, isOn);
  }
}
