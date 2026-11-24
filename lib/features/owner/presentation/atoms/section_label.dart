import 'package:flutter/material.dart';

import '../owner_tokens.dart';

/// Uppercase label at the top of a card, e.g. "REMINDERS".
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text.toUpperCase(), style: OwnerText.sectionLabel);
}
