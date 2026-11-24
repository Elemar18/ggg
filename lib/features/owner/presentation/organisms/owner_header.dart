import 'package:flutter/material.dart';

import '../owner_tokens.dart';

/// White header with a small label, a title and a subtitle.
class OwnerHeader extends StatelessWidget {
  const OwnerHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
  });

  final String label;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 24 + topInset, 16, 14),
      decoration: const BoxDecoration(
        color: OwnerColors.surface,
        border: Border(bottom: BorderSide(color: OwnerColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: OwnerText.headerLabel),
          const SizedBox(height: 4),
          Semantics(
            header: true,
            child: Text(title, style: OwnerText.headerTitle),
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: OwnerText.headerSubtitle),
          ],
        ],
      ),
    );
  }
}
