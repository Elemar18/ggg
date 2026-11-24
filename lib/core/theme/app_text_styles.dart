import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
/// Inter typography tokens used throughout the application.
abstract final class AppTextStyles {
  static TextStyle get headerLabel => GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2, color: AppColors.tertiary);
  static TextStyle get headerTitle => GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primary);
  static TextStyle get headerSubtitle => GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.secondary);
  static TextStyle get sectionLabel => GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2, color: AppColors.tertiary);
  static TextStyle get fieldLabel => GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.tertiary);
  static TextStyle get fieldText => GoogleFonts.inter(fontSize: 15, color: AppColors.primary);
  static TextStyle get button => GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.surface);
  static TextStyle get bodySmall => GoogleFonts.inter(fontSize: 12, color: AppColors.secondary);
  static TextStyle get link => GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary, decoration: TextDecoration.underline);
  static TextStyle get note => GoogleFonts.inter(fontSize: 13, height: 1.4, color: AppColors.noteText);
  static TextStyle get cardTitle => GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.primary);
  static TextStyle get cardSubtitle => GoogleFonts.inter(fontSize: 12, color: AppColors.secondary);
  static TextStyle get tag => GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: .5, color: AppColors.tagText);
  static TextStyle get error => GoogleFonts.inter(fontSize: 11, color: AppColors.primary);
}
