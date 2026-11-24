import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
/// Material 3 theme configured with MotoSyncApp design tokens.
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(primary: AppColors.primary, surface: AppColors.surface, onPrimary: AppColors.surface, onSurface: AppColors.primary),
    textTheme: TextTheme(bodyMedium: AppTextStyles.fieldText),
    splashColor: AppColors.primary.withValues(alpha: .06),
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.surface, foregroundColor: AppColors.primary, elevation: 0),
  );
}
