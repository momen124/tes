import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF7518); // Orange
  static const Color backgroundColor = Color(0xFFD2B48C); // Sandy Beige
  static const Color secondaryColor = Color(0xFF87CEEB); // Sky Blue
  static const Color textColor = Color(0xFF000000); // Black
  static const Color white = Color(0xFFFFFFFF); // White
  static const Color errorColor = Color(0xFFFF0000); // Red
  static const Color successColor = Color(0xFF4CAF50); // Green

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      background: backgroundColor,
      primary: primaryColor,
      secondary: secondaryColor,
      onPrimary: white,
      onBackground: textColor,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColor, fontSize: 16),
      titleLarge: TextStyle(color: textColor, fontSize: 20),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      selectedItemColor: secondaryColor,
      unselectedItemColor: primaryColor,
    ),
  );
}