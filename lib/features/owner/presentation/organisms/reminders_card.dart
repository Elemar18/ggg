import 'package:flutter/material.dart';

import '../../domain/reminder_item.dart';
import '../atoms/section_label.dart';
import '../atoms/surface_card.dart';
import '../molecules/reminder_row.dart';
import '../owner_tokens.dart';

/// O3: the list of service reminders.
class RemindersCard extends StatelessWidget {
  const RemindersCard({super.key, required this.items});

  final List<ReminderItem> items;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel('Reminders'),
          const SizedBox(height: 4),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('No reminders yet.', style: OwnerText.rowSubtitle),
            ),
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: OwnerColors.divider),
            ReminderRow(item: items[i]),
          ],
        ],
      ),
    );
  }
}
