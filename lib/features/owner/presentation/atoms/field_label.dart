import 'package:flutter/material.dart';

import '../owner_tokens.dart';

/// Small bold label above an input field.
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Text(text, style: OwnerText.fieldLabel);
}
