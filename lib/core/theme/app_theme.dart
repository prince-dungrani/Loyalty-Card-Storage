import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5A46E6); // Vibrant Purple
  static const Color secondaryColor = Color(0xFF0F1419); // Deep Onyx
  static const Color backgroundColor = Color(0xFFF7F9FC); // Off-white/Ice
  static const Color surfaceColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      onPrimary: Colors.white,
      surface: surfaceColor,
      onSurface: secondaryColor,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.outfitTextTheme().copyWith(
      headlineMedium: GoogleFonts.outfit(
        fontWeight: FontWeight.bold,
        color: secondaryColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: GoogleFonts.outfit(
        color: secondaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: 4,
      shadowColor: secondaryColor.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
      elevation: 4,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: secondaryColor.withOpacity(0.4),
      type: BottomNavigationBarType.fixed,
      elevation: 20,
    ),
  );

  static ThemeData darkTheme = lightTheme; // For now, mirror light or omit
}
