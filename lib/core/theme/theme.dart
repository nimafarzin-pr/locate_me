// lib/themes.dart

import 'package:flutter/material.dart';
import 'package:locate_me/core/constant/constant_names.dart';

import '../sizing/my_text_size.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);
  static const ColorScheme monochromaticLightColorScheme = ColorScheme(
    primary: Color(0xFF80CBC4), // A soft teal for app branding
    onPrimary: Colors.white,
    secondary: Color(0xFF4CAF50), // Slightly darker teal
    onSecondary: Colors.white,
    tertiary: Color(0xFF26A69A), // Even darker teal
    onTertiary: Colors.white,
    error: Color(0xFFE57373),
    onError: Colors.white,
    surface: Color(0xFFF5F5F5), // Improved light grey surface color
    onSurface: Color(0xFF333333),
    brightness: Brightness.light,
    surfaceContainer: Colors.white,
  );

  static const ColorScheme monochromaticDarkColorScheme = ColorScheme(
    primary: Color(0xFF26A69A),
    onPrimary: Colors.white,
    secondary: Color(0xFF00796B), // Darker teal
    onSecondary: Colors.white,
    tertiary: Color(0xFF004D40), // Even darker teal
    onTertiary: Colors.white,
    error: Color(0xFFEF9A9A),
    onError: Colors.black,
    surface: Color(0xFF303030), // Improved medium dark grey surface color
    onSurface: Color(0xFFEEEEEE),
    brightness: Brightness.dark,
    surfaceContainer: Color(0xFF212121),
  );

  static const ColorScheme analogousLightColorScheme = ColorScheme(
    primary: Color(0xFF80CBC4), // A soft teal
    onPrimary: Colors.white,
    secondary: Color(0xFF64B5F6), // Soft blue
    onSecondary: Colors.white,
    tertiary: Color(0xFF82B1FF), // Light blue
    onTertiary: Colors.white,
    error: Color(0xFFE57373),
    onError: Colors.white,
    surface: Color(0xFFF5F5F5), // Improved light grey surface color
    onSurface: Color(0xFF333333),
    brightness: Brightness.light,
    surfaceContainer: Colors.white,
  );

  static const ColorScheme analogousDarkColorScheme = ColorScheme(
    primary: Color(0xFF26A69A),
    onPrimary: Colors.white,
    secondary: Color(0xFF9575CD), // Muted purple
    onSecondary: Colors.white,
    tertiary: Color(0xFFBA68C8), // Muted pink
    onTertiary: Colors.white,
    error: Color(0xFFEF9A9A),
    onError: Colors.black,
    surface: Color(0xFF303030), // Improved medium dark grey surface color
    onSurface: Color(0xFFEEEEEE),
    brightness: Brightness.dark,
    surfaceContainer: Color(0xFF212121),
  );

  static const ColorScheme complementaryLightColorScheme = ColorScheme(
    primary: Color(0xFF80CBC4), // Soft teal
    onPrimary: Colors.white,
    secondary: Color(0xFFFFAB91), // Complementary soft orange
    onSecondary: Colors.white,
    tertiary: Color(0xFFEF9A9A), // Light red for accents
    onTertiary: Colors.white,
    error: Color(0xFFE57373),
    onError: Colors.white,
    surface: Color(0xFFF5F5F5), // Improved light grey surface color
    onSurface: Color(0xFF333333),
    brightness: Brightness.light,
    surfaceContainer: Colors.white,
  );

  static const ColorScheme complementaryDarkColorScheme = ColorScheme(
    primary: Color(0xFF26A69A),
    onPrimary: Colors.white,
    secondary: Color(0xFFFF7043), // Complementary deep orange
    onSecondary: Colors.white,
    tertiary: Color(0xFFF48FB1), // Light pink for accents
    onTertiary: Colors.white,
    error: Color(0xFFEF9A9A),
    onError: Colors.black,
    surface: Color(0xFF303030), // Improved medium dark grey surface color
    onSurface: Color(0xFFEEEEEE),
    brightness: Brightness.dark,
    surfaceContainer: Color(0xFF212121),
  );

  static const ColorScheme triadicLightColorScheme = ColorScheme(
    primary: Color(0xFF5C6BC0), // Rich blue
    onPrimary: Colors.black,
    secondary: Color(0xFFEC407A), // Vibrant pink
    onSecondary: Colors.white,
    tertiary: Color(0xFF66BB6A), // Fresh green
    onTertiary: Colors.white,
    error: Color(0xFFE53935), // Bold red
    onError: Colors.white,
    surface: Color(0xFFF3F4F6), // Soft light gray surface color
    onSurface: Color(0xFF212121), // Deep gray text
    brightness: Brightness.light,
    surfaceContainer: Colors.white,
  );

  static const ColorScheme triadicDarkColorScheme = ColorScheme(
    primary: Color(0xFF80CBC4), // Soft teal
    onPrimary: Colors.white,
    secondary: Color(0xFFf06292), // Soft rose
    onSecondary: Colors.white,
    tertiary: Color(0xFF4db6ac), // Seafoam green
    onTertiary: Colors.white,
    error: Color(0xFFD32F2F), // Strong red
    onError: Colors.black,
    surface: Color(0xFF303030), // Improved medium dark grey surface color
    onSurface: Color(0xFFEEEEEE), // Very light gray text
    brightness: Brightness.dark,
    surfaceContainer: Color(0xFF212121),
  );

  static const ColorScheme tetradicLightColorScheme = ColorScheme(
    primary: Color(0xFF80CBC4), // Soft teal
    onPrimary: Colors.white,
    secondary: Color(0xFFFFAB91), // Complementary soft orange
    onSecondary: Colors.white,
    tertiary: Color(0xFF7986CB), // Soft purple
    onTertiary: Colors.white,
    error: Color(0xFFE57373),
    onError: Colors.white,
    surface: Color(0xFFF5F5F5), // Improved light grey surface color
    onSurface: Color(0xFF333333),
    brightness: Brightness.light,
    surfaceContainer: Colors.white,
  );

  static const ColorScheme tetradicDarkColorScheme = ColorScheme(
    primary: Color(0xFF26A69A),
    onPrimary: Colors.white,
    secondary: Color(0xFF9575CD), // Muted purple
    onSecondary: Colors.white,
    tertiary: Color(0xFFFF7043), // Complementary deep orange
    onTertiary: Colors.white,
    error: Color(0xFFEF9A9A),
    onError: Colors.black,
    surface: Color(0xFF303030), // Improved medium dark grey surface color
    onSurface: Color(0xFFEEEEEE),
    brightness: Brightness.dark,
    surfaceContainer: Color(0xFF212121),
  );

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF80CBC4), // A soft teal for app branding
    onPrimary: Colors.white,
    secondary: Color(0xFF64B5F6), // A soft blue for additional elements
    onSecondary: Colors.white,
    tertiary: Color(0xFFF06292), // A soft pink for accents
    onTertiary: Colors.white,
    error: Color(0xFFE57373), // A soft red for error messages or alerts
    onError: Colors.white,
    surface: Color(0xFFF5F5F5), // Improved light grey surface color
    onSurface: Color(0xFF333333), // Improved dark grey text on surface color
    brightness: Brightness.light,
    surfaceContainer: Colors.white,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF26A69A), // A deeper teal for app branding
    onPrimary: Colors.white,
    secondary: Color(0xFF9575CD), // A muted purple for additional elements
    onSecondary: Colors.white,
    tertiary: Color(0xFFBA68C8), // A muted pink for accents
    onTertiary: Colors.white,
    error: Color(0xFFEF9A9A), // A soft red for error messages or alerts
    onError: Colors.black,
    surface: Color(0xFF303030), // Improved medium dark grey surface color
    onSurface: Color(0xFFEEEEEE), // Improved light grey text on surface color
    brightness: Brightness.dark,
    surfaceContainer: Color(0xFF212121), // Very dark grey for containers
  );

  // Light theme data
  static final ThemeData lightTheme =
      _buildThemeData(triadicLightColorScheme, _lightFocusColor);

  // Dark theme data
  static final ThemeData darkTheme =
      _buildThemeData(triadicDarkColorScheme, _darkFocusColor);

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
