import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import 'package:motosync_app/core/theme/app_spacing.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
/// Full-width primary or secondary action button.
class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.label, required this.onPressed, this.loading = false, this.enabled = true, this.secondary = false});
  final String label; final VoidCallback? onPressed; final bool loading, enabled, secondary;
  @override Widget build(BuildContext context) {
    final active = enabled && !loading;
    return SizedBox(width: double.infinity, height: AppSpacing.buttonHeight, child: OutlinedButton(
      onPressed: active ? onPressed : null,
      style: OutlinedButton.styleFrom(
        backgroundColor: secondary ? AppColors.surface : (active ? AppColors.primary : AppColors.disabled),
        foregroundColor: secondary ? AppColors.primary : AppColors.surface,
        side: BorderSide(color: secondary ? AppColors.borderStrong : (active ? AppColors.primary : AppColors.disabled)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusButton)),
        elevation: 0, overlayColor: AppColors.primary.withValues(alpha: .06),
      ),
      child: loading ? const SizedBox.square(dimension: 19, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.surface)) : Text(label, style: secondary ? AppTextStyles.button.copyWith(color: AppColors.primary) : AppTextStyles.button),
    ));
  }
}
