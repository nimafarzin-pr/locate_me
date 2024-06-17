// lib/themes.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_me/core/constant/constant_names.dart';

import '../sizing/my_text_size.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);
// Light color scheme
  static const ColorScheme _lightColorScheme = ColorScheme(
    primary: Color(0xFF80CBC4), // A soft teal for app branding
    onPrimary: Colors.white, // White text on primary color
    secondary: Color(0xFF64B5F6), // A soft blue for additional elements
    onSecondary: Colors.white, // White text on secondary color
    tertiary: Color(0xFFF06292), // A soft pink for accents
    onTertiary: Colors.white, // White text on tertiary color
    error: Color(0xFFE57373), // A soft red for error messages or alerts
    onError: Colors.white, // White text on error color
    surface: Color(0xFFFFFFFF), // White surface color for elevated UI elements
    onSurface: Color(0xFF212121), // Dark gray text on surface color
    brightness: Brightness.light, // Dark gray text on background
    surfaceContainer: Colors.white,
  );

// Dark color scheme
  static const ColorScheme _darkColorScheme = ColorScheme(
    primary: Color(0xFF26A69A), // A deeper teal for app branding
    onPrimary: Colors.white, // White text on primary color
    secondary: Color(0xFF9575CD), // A muted purple for additional elements
    onSecondary: Colors.white, // White text on secondary color
    tertiary: Color(0xFFBA68C8), // A muted pink for accents
    onTertiary: Colors.white, // White text on tertiary color
    error: Color(0xFFEF9A9A), // A soft red for error messages or alerts
    onError: Colors.black, // Black text on error color
    surface:
        Color(0xFF424242), // Dark gray surface color for elevated UI elements
    onSurface: Color(0xFFFFFFFF), // White text on surface color
    brightness: Brightness.dark, // White text on background
    surfaceContainer: Color(0xFF212121), // Very dark gray for containers
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
      fontFamily: appFontFamily,
      fontFamilyFallback: const [appFontFamily],
      textTheme: TextTheme(
        displayLarge: AppTextFontsAndSizing.displayLarge,
        displayMedium: AppTextFontsAndSizing.displayMedium,
        displaySmall: AppTextFontsAndSizing.displaySmall,
        headlineLarge: AppTextFontsAndSizing.headlineLarge,
        headlineMedium: AppTextFontsAndSizing.headlineMedium,
        headlineSmall: AppTextFontsAndSizing.headlineSmall,
        titleLarge: AppTextFontsAndSizing.titleLarge,
        titleMedium: AppTextFontsAndSizing.titleMedium,
        titleSmall: AppTextFontsAndSizing.titleSmall,
        bodyLarge: AppTextFontsAndSizing.bodyLarge,
        bodyMedium: AppTextFontsAndSizing.bodyMedium,
        bodySmall: AppTextFontsAndSizing.bodySmall,
        labelLarge: AppTextFontsAndSizing.labelLarge,
        labelMedium: AppTextFontsAndSizing.labelMedium,
        labelSmall: AppTextFontsAndSizing.labelSmall,
      ),
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
    );
  }
}
