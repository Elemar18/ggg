import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import 'package:motosync_app/core/theme/app_spacing.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
/// Compact selection status pill.
class AppTag extends StatelessWidget {
  const AppTag({super.key, required this.label, this.selected = false}); final String label; final bool selected;
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tagHorizontal, vertical: AppSpacing.tagVertical), decoration: BoxDecoration(color: selected ? AppColors.primary : AppColors.tagBackground, borderRadius: BorderRadius.circular(30)), child: Text(label.toUpperCase(), style: AppTextStyles.tag.copyWith(color: selected ? AppColors.surface : AppColors.tagText)));
}
