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

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: BaseColors.darkBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: BaseColors.primary,
        brightness: Brightness.dark,
        primary: BaseColors.primary300,
        secondary: BaseColors.secondary300,
        error: BaseColors.error,
        surface: BaseColors.darkSurface,
      ),
      textTheme: FontTheme.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: BaseColors.darkSurface,
        foregroundColor: BaseColors.darkTextPrimary,
        elevation: 0,
        titleTextStyle: FontTheme.titleLarge.copyWith(
          color: BaseColors.darkTextPrimary,
        ),
      ),
    );
  }
}
