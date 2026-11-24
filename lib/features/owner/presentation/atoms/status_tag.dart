import 'package:flutter/material.dart';

import '../owner_tokens.dart';

enum TagTone { neutral, outlined, strong }

/// Small pill label. neutral = light grey, outlined = white with border,
/// strong = dark with white text.
class StatusTag extends StatelessWidget {
  const StatusTag({super.key, required this.label, this.tone = TagTone.neutral});

  final String label;
  final TagTone tone;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color foreground;
    Color? border;
    switch (tone) {
      case TagTone.neutral:
        background = OwnerColors.tagBackground;
        foreground = OwnerColors.tagText;
      case TagTone.outlined:
        background = OwnerColors.surface;
        foreground = OwnerColors.tagText;
        border = OwnerColors.textTertiary;
      case TagTone.strong:
        background = OwnerColors.primaryButton;
        foreground = OwnerColors.onPrimaryButton;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        border: border == null ? null : Border.all(color: border),
      ),
      child: Text(label.toUpperCase(), style: OwnerText.tag.copyWith(color: foreground)),
    );
  }
}
