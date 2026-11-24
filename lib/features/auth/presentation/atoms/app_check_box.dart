import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
/// Custom monochrome checkbox atom.
class AppCheckBox extends StatelessWidget {
  const AppCheckBox({super.key, required this.value, required this.onChanged}); final bool value; final ValueChanged<bool> onChanged;
  @override Widget build(BuildContext context) => Semantics(checked: value, label: 'Agree to Terms and Privacy Policy', child: Checkbox(value: value, onChanged: (v) => onChanged(v ?? false), activeColor: AppColors.primary, checkColor: AppColors.surface, side: const BorderSide(color: AppColors.borderStrong), materialTapTargetSize: MaterialTapTargetSize.padded, visualDensity: VisualDensity.standard));
}
