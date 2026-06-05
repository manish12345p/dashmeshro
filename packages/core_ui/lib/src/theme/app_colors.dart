import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  // Primary
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;

  // Backgrounds & Surfaces
  final Color background;
  final Color surface;
  final Color surfaceSecondary;
  final Color surfaceTertiary;

  // Border
  final Color border;

  // Typography
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textQuaternary;

  // Semantic
  final Color success;
  final Color successBg;
  final Color warning;
  final Color warningBg;
  final Color error;
  final Color errorBg;
  final Color info;
  final Color infoBg;

  const AppColors({
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.background,
    required this.surface,
    required this.surfaceSecondary,
    required this.surfaceTertiary,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textQuaternary,
    required this.success,
    required this.successBg,
    required this.warning,
    required this.warningBg,
    required this.error,
    required this.errorBg,
    required this.info,
    required this.infoBg,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryDark,
    Color? primaryLight,
    Color? background,
    Color? surface,
    Color? surfaceSecondary,
    Color? surfaceTertiary,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textQuaternary,
    Color? success,
    Color? successBg,
    Color? warning,
    Color? warningBg,
    Color? error,
    Color? errorBg,
    Color? info,
    Color? infoBg,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      primaryLight: primaryLight ?? this.primaryLight,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceTertiary: surfaceTertiary ?? this.surfaceTertiary,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textQuaternary: textQuaternary ?? this.textQuaternary,
      success: success ?? this.success,
      successBg: successBg ?? this.successBg,
      warning: warning ?? this.warning,
      warningBg: warningBg ?? this.warningBg,
      error: error ?? this.error,
      errorBg: errorBg ?? this.errorBg,
      info: info ?? this.info,
      infoBg: infoBg ?? this.infoBg,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSecondary: Color.lerp(
        surfaceSecondary,
        other.surfaceSecondary,
        t,
      )!,
      surfaceTertiary: Color.lerp(surfaceTertiary, other.surfaceTertiary, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textQuaternary: Color.lerp(textQuaternary, other.textQuaternary, t)!,
      success: Color.lerp(success, other.success, t)!,
      successBg: Color.lerp(successBg, other.successBg, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningBg: Color.lerp(warningBg, other.warningBg, t)!,
      error: Color.lerp(error, other.error, t)!,
      errorBg: Color.lerp(errorBg, other.errorBg, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoBg: Color.lerp(infoBg, other.infoBg, t)!,
    );
  }

  // Define Light Theme Colors
  static const light = AppColors(
    primary: Color(0xFF2F80ED),
    primaryDark: Color(0xFF1C6ED5),
    primaryLight: Color(0xFF56A0F6),
    background: Color(0xFFF4F6F9),
    surface: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF4F6F9), // Fallback for 3rd shade in light mode
    surfaceTertiary: Color(0xFFF4F6F9), // Fallback for 4th shade in light mode
    border: Color(0xFFE5E9F2),
    textPrimary: Color(0xFF111827),
    textSecondary: Color(0xFF1F2937),
    textTertiary: Color(0xFF4B5563),
    textQuaternary: Color(0xFF9CA3AF),
    success: Color(0xFF27AE60),
    successBg: Color(0xFFE9F7EF),
    warning: Color(0xFFE2B93B),
    warningBg: Color(0xFFFFF8E1),
    error: Color(0xFFE5533D),
    errorBg: Color(0xFFFDECEA),
    info: Color(0xFF2D9CDB),
    infoBg: Color(0xFFEAF4FB),
  );

  // Define Dark Theme Colors
  static const dark = AppColors(
    primary: Color(0xFF60A5FA),
    primaryDark: Color(0xFF3B82F6),
    primaryLight: Color(0xFF1E3A8A),
    background: Color(0xFF0F172A),
    surface: Color(0xFF111827),
    surfaceSecondary: Color(0xFF1F2937),
    surfaceTertiary: Color(0xFF273449),
    border: Color(0xFF374151),
    textPrimary: Color(0xFFF9FAFB),
    textSecondary: Color(0xFFE5E7EB),
    textTertiary: Color(0xFF9CA3AF),
    textQuaternary: Color(0xFF6B7280),
    success: Color(0xFF22C55E),
    successBg: Color(0xFF052E1F),
    warning: Color(0xFFF59E0B),
    warningBg: Color(0xFF3B2F05),
    error: Color(0xFFEF4444),
    errorBg: Color(0xFF3B0A0A),
    info: Color(0xFF38BDF8),
    infoBg: Color(0xFF082F49),
  );
}

/// Extension on ThemeData to easily access AppColors
extension AppThemeColorsX on ThemeData {
  AppColors get colors => extension<AppColors>() ?? AppColors.light;
}

/// Extension on BuildContext for an even shorter syntax: `context.colors.primary`
extension BuildContextColorsX on BuildContext {
  AppColors get colors => Theme.of(this).colors;
  ServiceColors get serviceColors =>
      Theme.of(this).extension<ServiceColors>() ?? ServiceColors.light;
}

class ServiceColors extends ThemeExtension<ServiceColors> {
  final Map<String, Map<String, dynamic>> config;

  const ServiceColors({required this.config});

  @override
  ServiceColors copyWith({Map<String, Map<String, dynamic>>? config}) {
    return ServiceColors(config: config ?? this.config);
  }

  @override
  ServiceColors lerp(ThemeExtension<ServiceColors>? other, double t) {
    if (other is! ServiceColors) return this;
    return this; // No lerp for static service configs for now
  }

  static const light = ServiceColors(
    config: {
      'amc': {
        'color': Color(0xFF10B981),
        'bg': Color(0xFFDCFCE7),
        'icon': Icons.verified_user_rounded,
      },
      'new ro': {
        'color': Color(0xFF3B82F6),
        'bg': Color(0xFFDBEAFE),
        'icon': Icons.new_releases_rounded,
      },
      'repair': {
        'color': Color(0xFFF59E0B),
        'bg': Color(0xFFFEF3C7),
        'icon': Icons.build_rounded,
      },
      'service': {
        'color': Color(0xFF8B5CF6),
        'bg': Color(0xFFEDE9FE),
        'icon': Icons.miscellaneous_services_rounded,
      },
      'pump': {
        'color': Color(0xFF06B6D4),
        'bg': Color(0xFFCFFAFE),
        'icon': Icons.water_drop_rounded,
      },
      'set pump': {
        'color': Color(0xFF0EA5E9),
        'bg': Color(0xFFE0F2FE),
        'icon': Icons.water_damage_rounded,
      },
      'new ro set change': {
        'color': Color(0xFF6366F1),
        'bg': Color(0xFFE0E7FF),
        'icon': Icons.change_circle_rounded,
      },
      'set sv': {
        'color': Color(0xFFEC4899),
        'bg': Color(0xFFFCE7F3),
        'icon': Icons.settings_input_component_rounded,
      },
      'install and set change': {
        'color': Color(0xFF14B8A6),
        'bg': Color(0xFFCCFBF1),
        'icon': Icons.install_desktop_rounded,
      },
      'set & pump': {
        'color': Color(0xFFF43F5E),
        'bg': Color(0xFFFFE4E6),
        'icon': Icons.published_with_changes_rounded,
      },
      'inline': {
        'color': Color(0xFF84CC16),
        'bg': Color(0xFFECFCCB),
        'icon': Icons.line_style_rounded,
      },
      'copper set': {
        'color': Color(0xFFD97706),
        'bg': Color(0xFFFEF3C7),
        'icon': Icons.album_rounded,
      },
      'alkaline': {
        'color': Color(0xFF10B981),
        'bg': Color(0xFFD1FAE5),
        'icon': Icons.science_rounded,
      },
      'alkaline set': {
        'color': Color(0xFF059669),
        'bg': Color(0xFFA7F3D0),
        'icon': Icons.science_rounded,
      },
      'set smps': {
        'color': Color(0xFF6B7280),
        'bg': Color(0xFFE5E7EB),
        'icon': Icons.electrical_services_rounded,
      },
      'set change': {
        'color': Color(0xFF9333EA),
        'bg': Color(0xFFF3E8FF),
        'icon': Icons.swap_horiz_rounded,
      },
      'not applicable': {
        'color': Color(0xFF4B5563),
        'bg': Color(0xFFF3F4F6),
        'icon': Icons.do_not_disturb_alt_rounded,
      },
    },
  );

  static const dark = ServiceColors(
    config: {
      'amc': {
        'color': Color(0xFF34D399),
        'bg': Color(0xFF064E3B),
        'icon': Icons.verified_user_rounded,
      },
      'new ro': {
        'color': Color(0xFF60A5FA),
        'bg': Color(0xFF1E3A8A),
        'icon': Icons.new_releases_rounded,
      },
      'repair': {
        'color': Color(0xFFFBBF24),
        'bg': Color(0xFF78350F),
        'icon': Icons.build_rounded,
      },
      'service': {
        'color': Color(0xFFA78BFA),
        'bg': Color(0xFF4C1D95),
        'icon': Icons.miscellaneous_services_rounded,
      },
      'pump': {
        'color': Color(0xFF22D3EE),
        'bg': Color(0xFF164E63),
        'icon': Icons.water_drop_rounded,
      },
      'set pump': {
        'color': Color(0xFF38BDF8),
        'bg': Color(0xFF0C4A6E),
        'icon': Icons.water_damage_rounded,
      },
      'new ro set change': {
        'color': Color(0xFF818CF8),
        'bg': Color(0xFF3730A3),
        'icon': Icons.change_circle_rounded,
      },
      'set sv': {
        'color': Color(0xFFF472B6),
        'bg': Color(0xFF831843),
        'icon': Icons.settings_input_component_rounded,
      },
      'install and set change': {
        'color': Color(0xFF2DD4BF),
        'bg': Color(0xFF134E4A),
        'icon': Icons.install_desktop_rounded,
      },
      'set & pump': {
        'color': Color(0xFFFB7185),
        'bg': Color(0xFF881337),
        'icon': Icons.published_with_changes_rounded,
      },
      'inline': {
        'color': Color(0xFFA3E635),
        'bg': Color(0xFF3F6212),
        'icon': Icons.line_style_rounded,
      },
      'copper set': {
        'color': Color(0xFFF59E0B),
        'bg': Color(0xFF78350F),
        'icon': Icons.album_rounded,
      },
      'alkaline': {
        'color': Color(0xFF34D399),
        'bg': Color(0xFF064E3B),
        'icon': Icons.science_rounded,
      },
      'alkaline set': {
        'color': Color(0xFF10B981),
        'bg': Color(0xFF064E3B),
        'icon': Icons.science_rounded,
      },
      'set smps': {
        'color': Color(0xFF9CA3AF),
        'bg': Color(0xFF1F2937),
        'icon': Icons.electrical_services_rounded,
      },
      'set change': {
        'color': Color(0xFFC084FC),
        'bg': Color(0xFF581C87),
        'icon': Icons.swap_horiz_rounded,
      },
      'not applicable': {
        'color': Color(0xFF9CA3AF),
        'bg': Color(0xFF1F2937),
        'icon': Icons.do_not_disturb_alt_rounded,
      },
    },
  );
}
