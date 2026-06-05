import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
    } else if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      // If it's system, we need to infer the current mode.
      // But a simple toggle typically switches to dark, then light.
      emit(ThemeMode.dark);
    }
  }

  void setTheme(ThemeMode mode) {
    emit(mode);
  }
}
