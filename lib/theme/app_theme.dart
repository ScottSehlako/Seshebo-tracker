import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF1E88E5);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF9E9E9E);
  static const Color white = Colors.white;

  static ThemeData themeData = ThemeData(
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: white,
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: primaryBlue,
      primary: primaryBlue,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: white,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryBlue,
    ),
  );
}
