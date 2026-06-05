import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _themeKey = 'app_theme_mode';

  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);
    if (themeString == 'ThemeMode.light') {
      emit(ThemeMode.light);
    } else if (themeString == 'ThemeMode.dark') {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.system);
    }
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.toString());
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
