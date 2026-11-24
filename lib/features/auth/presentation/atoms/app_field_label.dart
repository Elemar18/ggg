import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
/// Displays a field label above an input.
class AppFieldLabel extends StatelessWidget {
  const AppFieldLabel({super.key, required this.label}); final String label;
  @override Widget build(BuildContext context) => Text(label, style: AppTextStyles.fieldLabel);
}
