// lib/app/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryOrange = Color(0xFFFF9500);
  static const Color lightBlueGray = Color(0xFFF0F4F8);
  static const Color secondaryGray = Color(0xFFA0A0A0);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray = Color(0xFF808080);
  static const Color darkGray = Color(0xFF404040);
  static const Color lightGray = Color(0xFFF3F4F6); // Added this
  
  // Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningYellow = Color(0xFFFFC107);
  static const Color errorRed = Color(0xFFF44336);
  
  // Additional Colors for Siwa Oasis
  static const Color desertSand = Color(0xFFE8D6B3);
  static const Color oasisTeal = Color(0xFF2A9D8F);
  static const Color darkGreen = Color(0xFF264653);
  
  // Gradients
  static Gradient get primaryGradient => const LinearGradient(
        colors: [Color(0xFFFF9500), Color(0xFFFFB143)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  
  static BoxDecoration get gradientBackground => const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF0F4F8), Color(0xFFE8D6B3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );

  // Text Styles with Google Fonts
  static TextStyle get headlineLarge => GoogleFonts.quicksand(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: black,
      );

  static TextStyle get headlineMedium => GoogleFonts.quicksand(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: black,
      );

  static TextStyle get titleLarge => GoogleFonts.quicksand(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: black,
      );

  static TextStyle get titleMedium => GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: black,
      );

  static TextStyle get bodyLarge => GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: black,
      );

  static TextStyle get bodyMedium => GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: gray,
      );

  static TextStyle get bodySmall => GoogleFonts.quicksand(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: secondaryGray,
      );

  static TextStyle get buttonText => GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: white,
      );

  static TextStyle get caption => GoogleFonts.quicksand(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: secondaryGray,
      );

  // Enhanced Theme Data
  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryOrange,
          primary: primaryOrange,
          secondary: oasisTeal,
          background: lightBlueGray,
          surface: white,
          onPrimary: white,
          onSecondary: white,
          onBackground: black,
          onSurface: black,
          error: errorRed,
          onPrimaryContainer: black,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: lightBlueGray,
        
        // Enhanced Text Theme
        textTheme: TextTheme(
          displayLarge: headlineLarge,
          displayMedium: headlineMedium,
          titleLarge: titleLarge,
          titleMedium: titleMedium,
          bodyLarge: bodyLarge,
          bodyMedium: bodyMedium,
          bodySmall: bodySmall,
          labelLarge: buttonText,
          labelSmall: caption,
        ),
        
        // AppBar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: white,
          foregroundColor: black,
          elevation: 2,
          centerTitle: true,
          titleTextStyle: titleLarge.copyWith(fontSize: 18),
          iconTheme: const IconThemeData(color: black),
          surfaceTintColor: white,
        ),
        
        // Card Theme - FIXED: Use CardTheme instead of CardThemeData
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: errorRed),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: errorRed, width: 2),
          ),
          hintStyle: bodyMedium.copyWith(color: secondaryGray),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: bodyMedium,
          floatingLabelStyle: bodyMedium.copyWith(color: primaryOrange),
        ),
        
        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryOrange,
            foregroundColor: white,
            disabledBackgroundColor: secondaryGray,
            disabledForegroundColor: white,
            textStyle: buttonText,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
        ),
        
        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryOrange,
            textStyle: bodyLarge.copyWith(fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        
        // Outlined Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryOrange,
            side: const BorderSide(color: primaryOrange),
            textStyle: bodyLarge.copyWith(fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        
        // Bottom Navigation Bar Theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: white,
          selectedItemColor: primaryOrange,
          unselectedItemColor: gray,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        
        // Chip Theme
        chipTheme: ChipThemeData(
          backgroundColor: white,
          selectedColor: primaryOrange,
          disabledColor: lightBlueGray,
          labelStyle: bodySmall.copyWith(fontWeight: FontWeight.w500),
          secondaryLabelStyle: bodySmall.copyWith(color: white),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: BorderSide(color: secondaryGray.withOpacity(0.3)),
        ),
        
        // Divider Theme
        dividerTheme: DividerThemeData(
          color: secondaryGray.withOpacity(0.3),
          thickness: 1,
          space: 1,
        ),
        
        // Progress Indicator Theme
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: primaryOrange,
          linearTrackColor: lightBlueGray,
        ),
      );

  // Custom Box Decorations
  static BoxDecoration get cardDecoration => BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );

  static BoxDecoration get primaryButtonDecoration => BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryOrange.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration get sectionDecoration => BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lightBlueGray),
      );

  // New: Offline Banner Decoration and Style
  static BoxDecoration get offlineBanner => BoxDecoration(
        color: lightGray,
        border: Border(
          bottom: BorderSide(color: gray, width: 1.0),
        ),
      );

  static TextStyle get offlineBannerText => bodyMedium.copyWith(
        color: darkGray,
        fontWeight: FontWeight.w500,
      );
}