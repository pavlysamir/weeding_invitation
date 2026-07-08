import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryRose,
        secondary: AppColors.gold,
        surface: AppColors.surface,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 64,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          height: 1.2,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          fontSize: 36,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          fontStyle: FontStyle.italic,
        ),
        headlineLarge: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: 2.0,
        ),
        headlineMedium: GoogleFonts.cormorantGaramond(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          letterSpacing: 1.5,
        ),
        bodyLarge: GoogleFonts.cormorantGaramond(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.7,
        ),
        bodyMedium: GoogleFonts.cormorantGaramond(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.6,
        ),
        labelLarge: GoogleFonts.cormorantGaramond(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 3.0,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
