import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_spacing.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import '../atoms/app_link_text.dart';
import '../molecules/labeled_text_field.dart';
import '../molecules/password_field.dart';
/// Login form organism; page supplies the authentication callback.
class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.email, required this.password, required this.emailError, required this.passwordError, required this.onEmailChanged, required this.onEmailBlur, required this.onPasswordChanged, required this.onPasswordBlur, required this.onForgotPassword});
  final TextEditingController email, password; final String? emailError, passwordError; final ValueChanged<String> onEmailChanged, onPasswordChanged; final VoidCallback onEmailBlur, onPasswordBlur, onForgotPassword;
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.cardHorizontal, vertical: AppSpacing.cardVertical), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusCard), border: Border.all(color: AppColors.border)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [LabeledTextField(label: 'Email', controller: email, hint: 'juan@email.com', keyboardType: TextInputType.emailAddress, error: emailError, onChanged: onEmailChanged, onBlur: onEmailBlur), PasswordField(label: 'Password', controller: password, error: passwordError, onChanged: onPasswordChanged, onBlur: onPasswordBlur), Align(alignment: Alignment.centerRight, child: AppLinkText(label: 'Forgot password?', onTap: onForgotPassword))]));
}
