import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle get displayLarge => GoogleFonts.cairo(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        height: 1.25,
      );

  static TextStyle get displayMedium => GoogleFonts.cairo(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        height: 1.3,
      );

  static TextStyle get headlineLarge => GoogleFonts.cairo(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1.35,
      );

  static TextStyle get headlineMedium => GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.4,
      );

  static TextStyle get bodyLarge => GoogleFonts.cairo(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.55,
      );

  static TextStyle get bodyMedium => GoogleFonts.cairo(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get labelLarge => GoogleFonts.cairo(
        fontSize: 13,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get labelSmall => GoogleFonts.cairo(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get caption => GoogleFonts.cairo(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryLight,
      );
}
