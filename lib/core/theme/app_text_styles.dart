import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized Typography System for AvvocatAI
class AppTextStyles {
  // Brand / Display Headings - Playfair Display
  static TextStyle brandHeadline({
    Color color = AppColors.primaryNavy,
    double fontSize = 28,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.playfairDisplay(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.2,
    );
  }

  static TextStyle brandTitle({
    Color color = AppColors.primaryNavy,
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.playfairDisplay(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.25,
    );
  }

  // Application UI / Body Text - Inter
  static TextStyle headingLarge({
    Color color = AppColors.primaryNavy,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle headingMedium({
    Color color = AppColors.primaryNavy,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle headingSmall({
    Color color = AppColors.primaryNavy,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle bodyLarge({
    Color color = AppColors.grey,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.4,
    );
  }

  static TextStyle bodyMedium({
    Color color = AppColors.grey,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.4,
    );
  }

  static TextStyle bodySmall({
    Color color = AppColors.grey,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle buttonText({
    Color color = Colors.white,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle caption({
    Color color = AppColors.grey,
    double fontSize = 11,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
