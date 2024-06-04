// lib/themes.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sizing/my_text_size.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  // Light color scheme
  static const ColorScheme _lightColorScheme = ColorScheme(
    primary: Color(0xFF4CAF50), // A vibrant green for app branding
    onPrimary: Colors.white, // White text on primary color
    secondary: Color(0xFF2196F3), // A bright blue for additional elements
    onSecondary: Colors.white, // White text on secondary color
    error: Colors.redAccent, // Red for error messages or alerts
    onError: Colors.white, // Black text on background color
    surface: Color(0xF5F5F5F5), // White surface color for elevated UI elements
    onSurface: Color(0xFF333333), // Dark gray text on surface color
    brightness: Brightness.light,
  );

// Dark color scheme
  static const ColorScheme _darkColorScheme = ColorScheme(
    primary: Color(0xFF009688), // A teal color for app branding
    secondary: Color(0xFF673AB7), // Dark gray background for the entire app
    surface: Color(0xFF333333), // White text on background color
    error: Colors.redAccent, // Red for error messages or alerts
    onError: Colors.white, // White text on error color
    onPrimary: Colors.white, // White text on primary color
    onSecondary: Colors.white, // White text on secondary color
    onSurface: Color(0xFFFFFFFF), // White text on surface color
    brightness: Brightness.dark,
  );

  // Light theme data
  static final ThemeData lightTheme =
      _buildThemeData(_lightColorScheme, _lightFocusColor);

  // Dark theme data
  static final ThemeData darkTheme =
      _buildThemeData(_darkColorScheme, _darkFocusColor);

  // Function to build ThemeData
  static ThemeData _buildThemeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      fontFamily: 'IRANSansMobile',
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
    );
  }
}
