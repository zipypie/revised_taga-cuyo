import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary, // Primary color
      secondary: AppColors.secondary, // Secondary color
      surface: AppColors.primaryBackground, // Background color
    ),
    scaffoldBackgroundColor: AppColors.primaryBackground,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF000000)), // Replace bodyText1
      bodyMedium: TextStyle(color: Color(0xFF000000)), // Replace bodyText2
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFBB86FC), // Primary color
      secondary: Color(0xFF03DAC6), // Secondary color
      surface: Color(0xFF121212), // Background color
    ),
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // Replace bodyText1
      bodyMedium: TextStyle(color: Color(0xFFFFFFFF)), // Replace bodyText2
    ),
  );
}
