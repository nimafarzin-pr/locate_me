// lib/themes.dart

import 'package:flutter/material.dart';

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
    onError: Colors.white, // White text on error color
    background: Color(0xFFF2F5FA), // Light gray background for the entire app
    onBackground: Colors.black, // Black text on background color
    surface: Color(0xFFFFFFFF), // White surface color for elevated UI elements
    onSurface: Color(0xFF333333), // Dark gray text on surface color
    brightness: Brightness.light,
  );

// Dark color scheme
  static const ColorScheme _darkColorScheme = ColorScheme(
    primary: Color(0xFF009688), // A teal color for app branding
    secondary: Color(0xFF673AB7), // A deep purple for additional elements
    background: Color(0xFF212121), // Dark gray background for the entire app
    surface: Color(0xFF333333), // Dark surface color for elevated UI elements
    onBackground: Color(0xFFFFFFFF), // White text on background color
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
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.black,
          fontSize: 96,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: colorScheme,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
    );
  }
}
