import 'package:flutter/material.dart';

abstract final class BaseColors {
  static const Color primary50 = Color(0xFFF0F4F7);
  static const Color primary100 = Color(0xFFD9E4EC);
  static const Color primary200 = Color(0xFFB3CAD9);
  static const Color primary300 = Color(0xFF8EAFC7);
  static const Color primary400 = Color(0xFF6895B4);
  static const Color primary500 = Color(0xFF427AA1);
  static const Color primary600 = Color(0xFF386889);
  static const Color primary700 = Color(0xFF2E5571);
  static const Color primary800 = Color(0xFF244359);
  static const Color primary900 = Color(0xFF1A3140);
  static const Color primary = primary500;

  static const Color secondary50 = Color(0xFFEFF8F2);
  static const Color secondary100 = Color(0xFFD8EDDF);
  static const Color secondary200 = Color(0xFFB1DABE);
  static const Color secondary300 = Color(0xFF8BC89E);
  static const Color secondary400 = Color(0xFF64B57D);
  static const Color secondary500 = Color(0xFF3DA35D);
  static const Color secondary600 = Color(0xFF348B4F);
  static const Color secondary700 = Color(0xFF2B7241);
  static const Color secondary800 = Color(0xFF225A33);
  static const Color secondary900 = Color(0xFF184125);
  static const Color secondary = secondary500;

  static const Color background = Color(0xFFFDFDFD);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0E0E0);

  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);

  static const Color success = secondary500;
  static const Color warning = Color(0xFFFD9A00);
  static const Color error = Color(0xFFF93446);
  static const Color errorLight = Color(0xFFFDE7E9);

  // Dark mode counterparts.
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkBorder = Color(0xFF2E2E2E);

  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextDisabled = Color(0xFF6B6B6B);

  static const Color darkErrorLight = Color(0xFF3B1414);
}
