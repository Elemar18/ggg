import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
import '../atoms/app_link_text.dart';
/// Centered footer copy with a navigation link.
class FormFooterLink extends StatelessWidget {
  const FormFooterLink({super.key, required this.prefix, required this.link, required this.onTap}); final String prefix, link; final VoidCallback onTap;
  @override Widget build(BuildContext context) => Wrap(alignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: [Text(prefix, style: AppTextStyles.bodySmall), AppLinkText(label: link, onTap: onTap)]);
}
