import "package:flutter/material.dart";

import "package:time_is_money/ui/theme/tailwind_colors.dart";

class AppThemeColors {
  static const brightness = Brightness.light;
  static const primary = TailwindColors.green400;
  static const onPrimary = Colors.white;
  static const secondary = TailwindColors.green200;
  static const onSecondary = TailwindColors.green500;
  static const tertiary = TailwindColors.blue400;
  static const onTertiary = TailwindColors.blue500;
  static const error = TailwindColors.red400;
  static const onError = TailwindColors.red500;
  static const surface = TailwindColors.neutral100;
  static const onSurface = TailwindColors.neutral800;
  static const outline = TailwindColors.neutral800;
  static const outlineVariant = TailwindColors.neutral400;
}

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: TailwindColors.neutral100,
  colorScheme: const ColorScheme(
    brightness: AppThemeColors.brightness,
    primary: AppThemeColors.primary,
    onPrimary: AppThemeColors.onPrimary,
    secondary: AppThemeColors.secondary,
    onSecondary: AppThemeColors.onSecondary,
    tertiary: AppThemeColors.tertiary,
    onTertiary: AppThemeColors.onTertiary,
    error: AppThemeColors.error,
    onError: AppThemeColors.onError,
    surface: AppThemeColors.surface,
    onSurface: AppThemeColors.onSurface,
    outline: AppThemeColors.outline,
    outlineVariant: AppThemeColors.outlineVariant,
  ),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.bold,
      color: TailwindColors.neutral900,
    ),
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(backgroundColor: AppThemeColors.error),
  ),
);
