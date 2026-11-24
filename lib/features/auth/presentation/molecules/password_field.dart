import 'package:flutter/material.dart';
import 'labeled_text_field.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
/// Labeled password input with an accessible visibility toggle.
class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.label, required this.controller, this.error, this.onChanged, this.onBlur});
  final String label; final TextEditingController controller; final String? error; final ValueChanged<String>? onChanged; final VoidCallback? onBlur;
  @override State<PasswordField> createState() => _PasswordFieldState();
}
class _PasswordFieldState extends State<PasswordField> {
  bool _hidden = true;
  @override Widget build(BuildContext context) => LabeledTextField(label: widget.label, controller: widget.controller, hint: 'Enter password', obscureText: _hidden, error: widget.error, onChanged: widget.onChanged, onBlur: widget.onBlur, suffix: IconButton(tooltip: _hidden ? 'Show password' : 'Hide password', onPressed: () => setState(() => _hidden = !_hidden), icon: Icon(_hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.tertiary)));
}