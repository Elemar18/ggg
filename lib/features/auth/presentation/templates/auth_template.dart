import 'package:flutter/material.dart';
import 'package:motosync_app/core/theme/app_spacing.dart';
import 'package:motosync_app/core/theme/app_colors.dart';
import '../organisms/auth_header.dart';
/// Scrollable page template with a shared authentication header.
class AuthTemplate extends StatelessWidget {
  const AuthTemplate({super.key, required this.title, required this.subtitle, required this.children}); final String title, subtitle; final List<Widget> children;
  @override Widget build(BuildContext context) => Scaffold(backgroundColor: AppColors.background, body: SafeArea(child: Column(children: [AuthHeader(title: title, subtitle: subtitle), Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(AppSpacing.screen), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [for (var i=0; i<children.length; i++) ...[if (i>0) const SizedBox(height: AppSpacing.block), children[i]]])))])));
}
