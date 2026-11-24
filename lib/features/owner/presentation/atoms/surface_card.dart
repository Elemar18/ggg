import 'package:flutter/material.dart';

import '../owner_tokens.dart';

/// White rounded container with a thin border. Optional tap and selected state.
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.selected = false,
    this.onTap,
  });

  final Widget child;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: OwnerColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(OwnerMetrics.cardRadius),
        side: BorderSide(
          color: selected ? OwnerColors.textPrimary : OwnerColors.border,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: OwnerMetrics.cardH,
            vertical: OwnerMetrics.cardV,
          ),
          child: child,
        ),
      ),
    );
  }
}
