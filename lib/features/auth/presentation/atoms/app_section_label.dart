import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
/// Uppercase section label used inside cards.
class AppSectionLabel extends StatelessWidget {
  const AppSectionLabel({super.key, required this.label}); final String label;
  @override Widget build(BuildContext context) => Text(label.toUpperCase(), style: AppTextStyles.sectionLabel);
}
