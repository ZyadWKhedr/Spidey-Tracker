import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ThemeStorageService {
  Future<ThemeMode> getSavedThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
}

class ThemeStorageServiceImpl implements ThemeStorageService {
  static const String _themeModeKey = 'spidey_theme_mode';
  final SharedPreferences _prefs;

  const ThemeStorageServiceImpl(this._prefs);

  @override
  Future<ThemeMode> getSavedThemeMode() async {
    final savedValue = _prefs.getString(_themeModeKey);
    switch (savedValue) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.light;
    }
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    final modeString = mode == ThemeMode.dark ? 'dark' : 'light';
    await _prefs.setString(_themeModeKey, modeString);
  }
}
