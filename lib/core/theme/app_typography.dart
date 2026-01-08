import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App typography using fantasy-inspired fonts
class AppTypography {
  AppTypography._();

  /// Primary font family - soft, rounded for body text
  static String get primaryFont => GoogleFonts.quicksand().fontFamily!;

  /// Display font family - for headers and emphasis
  static String get displayFont => GoogleFonts.comfortaa().fontFamily!;

  /// Light mode text theme
  static TextTheme get lightTextTheme => _buildTextTheme(
        textColor: AppColors.light.textPrimary,
        secondaryColor: AppColors.light.textSecondary,
      );

  /// Dark mode text theme
  static TextTheme get darkTextTheme => _buildTextTheme(
        textColor: AppColors.dark.textPrimary,
        secondaryColor: AppColors.dark.textSecondary,
      );

  static TextTheme _buildTextTheme({
    required Color textColor,
    required Color secondaryColor,
  }) {
    return TextTheme(
      // Display styles - using Comfortaa for headers
      displayLarge: GoogleFonts.comfortaa(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: textColor,
      ),
      displayMedium: GoogleFonts.comfortaa(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: textColor,
      ),
      displaySmall: GoogleFonts.comfortaa(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: textColor,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.comfortaa(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.comfortaa(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.comfortaa(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: textColor,
      ),

      // Title styles - using Quicksand
      titleLarge: GoogleFonts.quicksand(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: textColor,
      ),
      titleMedium: GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: textColor,
      ),
      titleSmall: GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: textColor,
      ),

      // Body styles - using Quicksand for readability
      bodyLarge: GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: textColor,
      ),
      bodySmall: GoogleFonts.quicksand(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: secondaryColor,
      ),

      // Label styles
      labelLarge: GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: textColor,
      ),
      labelMedium: GoogleFonts.quicksand(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textColor,
      ),
      labelSmall: GoogleFonts.quicksand(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: secondaryColor,
      ),
    );
  }
}
