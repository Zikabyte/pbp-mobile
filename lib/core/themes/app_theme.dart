import 'package:flutter/material.dart';
import 'package:portfolio_mobile/core/themes/base_colors.dart';
import 'package:portfolio_mobile/core/themes/font_theme.dart';

abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: BaseColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: BaseColors.primary,
        brightness: Brightness.light,
        primary: BaseColors.primary,
        secondary: BaseColors.secondary,
        error: BaseColors.error,
        surface: BaseColors.surface,
      ),
      textTheme: FontTheme.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: BaseColors.surface,
        foregroundColor: BaseColors.textPrimary,
        elevation: 0,
        titleTextStyle: FontTheme.titleLarge.copyWith(
          color: BaseColors.textPrimary,
        ),
      ),
    );
  }
}
