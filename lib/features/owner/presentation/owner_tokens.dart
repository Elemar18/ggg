import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens used by the owner screens (O1 to O9).
///
/// These mirror the values in your core/theme files. If you prefer, point each
/// constant at your own AppColors / AppSpacing / AppTextStyles so there is only
/// one source of truth. Every owner widget imports this file only.
abstract final class OwnerColors {
  static const background = Color(0xFFF9FAFB);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE5E7EB);
  static const borderStrong = Color(0xFFD1D5DB);
  static const divider = Color(0xFFF0F1F3);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);
  static const noteBackground = Color(0xFFEEF0F3);
  static const noteText = Color(0xFF4B5563);
  static const tagBackground = Color(0xFFECEEF1);
  static const tagText = Color(0xFF374151);
  static const fieldBackground = Color(0xFFF9FAFB);
  static const primaryButton = Color(0xFF111827);
  static const onPrimaryButton = Color(0xFFFFFFFF);
  static const disabledButton = Color(0xFFD1D5DB);
  static const onDisabledButton = Color(0xFF9CA3AF);
  static const pressedOverlay = Color(0x0F000000); // black at 6%
}

abstract final class OwnerMetrics {
  static const double screenH = 16;
  static const double gap = 12;
  static const double xs = 4;
  static const double sm = 8;
  static const double xl = 24;
  static const double cardRadius = 16;
  static const double fieldRadius = 12;
  static const double buttonRadius = 14;
  static const double noteRadius = 14;
  static const double cardH = 14;
  static const double cardV = 12;
  static const double buttonHeight = 52;
  static const double fieldHeight = 48;
  static const double minTap = 48;
}

abstract final class OwnerText {
  static TextStyle _s(double size, FontWeight weight, Color? color,
          {double? letterSpacing, double? height}) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  static TextStyle get headerLabel =>
      _s(11, FontWeight.w700, OwnerColors.textTertiary, letterSpacing: 1.2);
  static TextStyle get headerTitle => _s(24, FontWeight.w700, OwnerColors.textPrimary);
  static TextStyle get headerSubtitle => _s(13, FontWeight.w400, OwnerColors.textSecondary);
  static TextStyle get sectionLabel =>
      _s(11, FontWeight.w700, OwnerColors.textTertiary, letterSpacing: 1.2);
  static TextStyle get fieldLabel => _s(11, FontWeight.w700, OwnerColors.textTertiary);
  static TextStyle get fieldText => _s(15, FontWeight.w400, OwnerColors.textPrimary);
  static TextStyle get fieldHint => _s(15, FontWeight.w400, OwnerColors.textTertiary);
  static TextStyle get button => _s(16, FontWeight.w700, null);
  static TextStyle get bodySmall => _s(12, FontWeight.w400, OwnerColors.textSecondary);
  static TextStyle get note =>
      _s(13, FontWeight.w400, OwnerColors.noteText, height: 1.4);
  static TextStyle get rowTitle => _s(15, FontWeight.w700, OwnerColors.textPrimary);
  static TextStyle get rowSubtitle => _s(12, FontWeight.w400, OwnerColors.textSecondary);
  static TextStyle get tag => _s(11, FontWeight.w700, OwnerColors.tagText);
  static TextStyle get errorText => _s(11, FontWeight.w400, OwnerColors.textPrimary);
}
