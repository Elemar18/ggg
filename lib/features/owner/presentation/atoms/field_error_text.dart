import 'package:flutter/material.dart';

import '../owner_tokens.dart';

/// Validation message with a small info icon (no red, per the design).
class FieldErrorText extends StatelessWidget {
  const FieldErrorText(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(Icons.info_outline, size: 14, color: OwnerColors.textPrimary),
        ),
        const SizedBox(width: OwnerMetrics.xs),
        Expanded(child: Text(message, style: OwnerText.errorText)),
      ],
    );
  }
}
