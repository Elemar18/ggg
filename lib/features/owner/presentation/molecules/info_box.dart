import 'package:flutter/material.dart';

import '../owner_tokens.dart';

/// Grey note box used for hints and messages.
class InfoBox extends StatelessWidget {
  const InfoBox(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: OwnerColors.noteBackground,
        borderRadius: BorderRadius.circular(OwnerMetrics.noteRadius),
      ),
      child: Text(text, style: OwnerText.note),
    );
  }
}
