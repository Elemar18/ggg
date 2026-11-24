import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
/// Accessible underlined text action.
class AppLinkText extends StatelessWidget {
  const AppLinkText({super.key, required this.label, required this.onTap}); final String label; final VoidCallback onTap;
  @override Widget build(BuildContext context) => Semantics(link: true, button: true, label: label, child: InkWell(onTap: onTap, child: Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text(label, style: AppTextStyles.link))));
}
