import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _themeKey = 'app_theme_mode';
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(_getInitialMode(_prefs));

  static ThemeMode _getInitialMode(SharedPreferences prefs) {
    final themeString = prefs.getString(_themeKey);
    if (themeString == 'ThemeMode.light') {
      return ThemeMode.light;
    } else if (themeString == 'ThemeMode.dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    await _prefs.setString(_themeKey, mode.toString());
  }

  void toggleTheme() {
    ThemeMode newMode;
    if (state == ThemeMode.dark) {
      newMode = ThemeMode.light;
    } else if (state == ThemeMode.light) {
      newMode = ThemeMode.dark;
    } else {
      newMode = ThemeMode.dark;
    }
    emit(newMode);
    _saveTheme(newMode);
  }

  void setTheme(ThemeMode mode) {
    emit(mode);
    _saveTheme(mode);
  }
}
