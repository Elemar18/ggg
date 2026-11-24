import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
import '../atoms/app_field_label.dart';
import '../atoms/app_text_input.dart';
/// Combines a label, input, and optional inline validation message.
class LabeledTextField extends StatelessWidget {
  const LabeledTextField({super.key, required this.label, required this.controller, required this.hint, this.keyboardType, this.obscureText = false, this.suffix, this.error, this.onChanged, this.onBlur, this.textInputAction});
  final String label, hint; final TextEditingController controller; final TextInputType? keyboardType; final bool obscureText; final Widget? suffix; final String? error; final ValueChanged<String>? onChanged; final VoidCallback? onBlur; final TextInputAction? textInputAction;
  @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 8), AppFieldLabel(label: label), const SizedBox(height: 4), AppTextInput(controller: controller, hint: hint, keyboardType: keyboardType, obscureText: obscureText, suffix: suffix, onChanged: onChanged, onBlur: onBlur, semanticLabel: label, textInputAction: textInputAction), if (error != null) Padding(padding: const EdgeInsets.only(top: 4), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.info_outline, size: 13, color: AppColors.primary), const SizedBox(width: 4), Expanded(child: Text(error!, style: AppTextStyles.error))]))]);
}
