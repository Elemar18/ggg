import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import 'package:motosync_app/core/theme/app_spacing.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
/// Styled text input atom with optional suffix control.
class AppTextInput extends StatelessWidget {
  const AppTextInput({super.key, required this.controller, required this.hint, this.keyboardType, this.obscureText = false, this.suffix, this.onChanged, this.onBlur, this.semanticLabel, this.textInputAction});
  final TextEditingController controller; final String hint; final TextInputType? keyboardType; final bool obscureText; final Widget? suffix; final ValueChanged<String>? onChanged; final VoidCallback? onBlur; final String? semanticLabel; final TextInputAction? textInputAction;
  @override Widget build(BuildContext context) => Focus(onFocusChange: (focused) { if (!focused) onBlur?.call(); }, child: SizedBox(height: AppSpacing.fieldHeight, child: Semantics(label: semanticLabel ?? hint, textField: true, child: TextField(
    controller: controller, keyboardType: keyboardType, obscureText: obscureText, onChanged: onChanged, textInputAction: textInputAction,
    style: AppTextStyles.fieldText, cursorColor: AppColors.primary,
    decoration: InputDecoration(hintText: hint, hintStyle: AppTextStyles.fieldText.copyWith(color: AppColors.tertiary), filled: true, fillColor: AppColors.fieldBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.fieldHorizontal, vertical: AppSpacing.fieldVertical),
      suffixIcon: suffix, suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusSmall), borderSide: const BorderSide(color: AppColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusSmall), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusSmall)),
    ),
  ))));
}
