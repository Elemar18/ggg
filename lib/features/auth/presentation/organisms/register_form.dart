import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_spacing.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import '../molecules/labeled_text_field.dart';
import '../molecules/password_field.dart';
/// Registration fields grouped into one card.
class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.name, required this.email, required this.phone, required this.password, required this.confirm, required this.errors, required this.onChanged, required this.onBlur});
  final TextEditingController name, email, phone, password, confirm; final Map<String,String?> errors; final ValueChanged<String> Function(String) onChanged; final VoidCallback Function(String) onBlur;
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.cardHorizontal, vertical: AppSpacing.cardVertical), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusCard), border: Border.all(color: AppColors.border)), child: Column(children: [
    LabeledTextField(label: 'Full name', controller: name, hint: 'Juan Dela Cruz', error: errors['name'], onChanged: onChanged('name'), onBlur: onBlur('name')),
    LabeledTextField(label: 'Email', controller: email, hint: 'juan@email.com', keyboardType: TextInputType.emailAddress, error: errors['email'], onChanged: onChanged('email'), onBlur: onBlur('email')),
    LabeledTextField(label: 'Mobile number', controller: phone, hint: '0917 123 4567', keyboardType: TextInputType.phone, error: errors['phone'], onChanged: onChanged('phone'), onBlur: onBlur('phone')),
    PasswordField(label: 'Password', controller: password, error: errors['password'], onChanged: onChanged('password'), onBlur: onBlur('password')),
    PasswordField(label: 'Confirm password', controller: confirm, error: errors['confirm'], onChanged: onChanged('confirm'), onBlur: onBlur('confirm')),
  ]));
}
