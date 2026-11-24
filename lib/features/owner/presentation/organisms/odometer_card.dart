import 'package:flutter/material.dart';

import '../atoms/section_label.dart';
import '../atoms/status_tag.dart';
import '../atoms/surface_card.dart';
import '../owner_tokens.dart';

/// O3: the current (estimated or confirmed) odometer with an Update tag.
class OdometerCard extends StatelessWidget {
  const OdometerCard({
    super.key,
    required this.value,
    required this.caption,
    required this.onUpdate,
  });

  final String value;
  final String caption;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel('Odometer'),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value, style: OwnerText.rowTitle),
                    const SizedBox(height: 2),
                    Text(caption, style: OwnerText.rowSubtitle),
                  ],
                ),
              ),
              Semantics(
                button: true,
                label: 'Update odometer',
                excludeSemantics: true,
                child: InkWell(
                  onTap: onUpdate,
                  borderRadius: BorderRadius.circular(999),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: OwnerMetrics.minTap,
                      minHeight: OwnerMetrics.minTap,
                    ),
                    child: const Center(
                      child: StatusTag(label: 'Update', tone: TagTone.outlined),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
