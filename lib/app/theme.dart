// lib/utils/theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryOrange = Color(0xFFFF9500); // Main orange for CTAs
  static const Color lightBlueGray = Color(0xFFF0F4F8); // Backgrounds
  static const Color secondaryGray = Color(0xFFA0A0A0); // Secondary text
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray = Color(0xFF808080);
  
  // Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningYellow = Color(0xFFFFC107);
  static const Color errorRed = Color(0xFFF44336);
  
  // Offline Banner
  static const Color offlineBanner = Color(0xFFFFF3E0);
  
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryOrange,
      background: lightBlueGray,
      primary: primaryOrange,
      secondary: secondaryGray,
      onPrimary: white,
      onBackground: black,
      error: errorRed,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: lightBlueGray,
    
    // Text Theme
    textTheme: const TextTheme(
      // Titles: Bold, 24-32pt
      titleLarge: TextStyle(
        color: black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
      titleMedium: TextStyle(
        color: black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
      // Subtitles: Semi-bold, 16-20pt
      titleSmall: TextStyle(
        color: black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
      ),
      headlineSmall: TextStyle(
        color: black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
      ),
      // Body Text: Regular, 14pt
      bodyLarge: TextStyle(
        color: black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: 'Roboto',
      ),
      bodyMedium: TextStyle(
        color: gray,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: 'Roboto',
      ),
      // Button Text: Bold, 16pt
      labelLarge: TextStyle(
        color: white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    ),
    
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      foregroundColor: black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
      ),
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      color: white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: secondaryGray.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: secondaryGray.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryOrange, width: 2),
      ),
      hintStyle: TextStyle(
        color: secondaryGray,
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryOrange,
        foregroundColor: white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: primaryOrange,
      unselectedItemColor: gray,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: white,
      selectedColor: primaryOrange,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}