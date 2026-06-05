import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.light.background,
      colorScheme: ColorScheme.light(
        primary: AppColors.light.primary,
        surface: AppColors.light.surface,
        error: AppColors.light.error,
        onPrimary: Colors.white,
        onSurface: AppColors.light.textPrimary,
        onError: Colors.white,
      ),
      textTheme: AppTextTheme.getTheme(AppColors.light),
      dividerColor: AppColors.light.border,
      extensions: const <ThemeExtension<dynamic>>[
        AppColors.light,
        ServiceColors.light,
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.dark.background,
      colorScheme: ColorScheme.dark(
        primary: AppColors.dark.primary,
        surface: AppColors.dark.surface,
        error: AppColors.dark.error,
        onPrimary: Colors.black, // Dark text on white primary
        onSurface: AppColors.dark.textPrimary,
        onError: Colors.white,
      ),
      textTheme: AppTextTheme.getTheme(AppColors.dark),
      dividerColor: AppColors.dark.border,
      extensions: const <ThemeExtension<dynamic>>[
        AppColors.dark,
        ServiceColors.dark,
      ],
    );
  }
}
