import "package:flutter/material.dart";

import "package:time_is_money/ui/theme/tailwind_colors.dart";

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: TailwindColors.neutral100,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: TailwindColors.green400,
    onPrimary: TailwindColors.neutral900,
    secondary: TailwindColors.green200,
    onSecondary: TailwindColors.neutral900,
    tertiary: TailwindColors.neutral500,
    onTertiary: TailwindColors.neutral900,
    error: TailwindColors.red400,
    onError: TailwindColors.red500,
    surface: TailwindColors.neutral100,
    onSurface: TailwindColors.neutral800,
    outline: TailwindColors.green500,
  ),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.bold,
      color: TailwindColors.neutral900,
    ),
  ),
);
