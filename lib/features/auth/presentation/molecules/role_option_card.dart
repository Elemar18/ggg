import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import 'package:motosync_app/core/theme/app_spacing.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
import '../atoms/app_section_label.dart';
import '../atoms/app_tag.dart';
/// Selectable role card molecule.
class RoleOptionCard extends StatelessWidget {
  const RoleOptionCard({super.key, required this.title, required this.subtitle, required this.selected, required this.onTap});
  final String title, subtitle; final bool selected; final VoidCallback onTap;
  @override Widget build(BuildContext context) => Semantics(button: true, selected: selected, label: '$title. $subtitle', child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(AppSpacing.radiusCard), child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: AppSpacing.cardHorizontal, vertical: AppSpacing.cardVertical), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusCard), border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.5 : 1)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const AppSectionLabel(label: 'I AM A'), const SizedBox(height: 12), Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: AppTextStyles.cardTitle), const SizedBox(height: 4), Text(subtitle, style: AppTextStyles.cardSubtitle)])), AppTag(label: selected ? 'Selected' : 'Select', selected: selected)])]))));
}
