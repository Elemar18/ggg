import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import 'package:motosync_app/core/theme/app_spacing.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
/// White branded header shared by authentication pages.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle}); final String title, subtitle;
  @override Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.fromLTRB(AppSpacing.screen, 24, AppSpacing.screen, 14), decoration: const BoxDecoration(color: AppColors.surface, border: Border(bottom: BorderSide(color: AppColors.border))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('MOTOSYNCAPP', style: AppTextStyles.headerLabel), const SizedBox(height: 4), Text(title, style: AppTextStyles.headerTitle), const SizedBox(height: 4), Text(subtitle, style: AppTextStyles.headerSubtitle)]));
}
