import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import 'package:motosync_app/core/theme/app_spacing.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
/// Neutral informational note panel.
class InfoNote extends StatelessWidget {
  const InfoNote({super.key, required this.message}); final String message;
  @override Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: AppSpacing.cardHorizontal, vertical: 10), decoration: BoxDecoration(color: AppColors.noteBackground, borderRadius: BorderRadius.circular(AppSpacing.radiusNote)), child: Text(message, style: AppTextStyles.note));
}
