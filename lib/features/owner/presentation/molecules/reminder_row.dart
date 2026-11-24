import 'package:flutter/material.dart';

import '../../domain/reminder_item.dart';
import '../../domain/service_rule.dart';
import '../atoms/status_tag.dart';
import '../owner_tokens.dart';

/// One line in the Reminders card: title, grey subtitle and a status tag.
class ReminderRow extends StatelessWidget {
  const ReminderRow({super.key, required this.item});

  final ReminderItem item;

  @override
  Widget build(BuildContext context) {
    final String label;
    final TagTone tone;
    switch (item.status) {
      case ReminderStatus.ok:
        label = 'OK';
        tone = TagTone.neutral;
      case ReminderStatus.dueSoon:
        label = 'Due soon';
        tone = TagTone.outlined;
      case ReminderStatus.overdue:
        label = 'Overdue';
        tone = TagTone.strong;
    }
    return Semantics(
      label: '${item.title}. ${item.subtitle}. Status: $label.',
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: OwnerText.rowTitle),
                  const SizedBox(height: 2),
                  Text(item.subtitle, style: OwnerText.rowSubtitle),
                ],
              ),
            ),
            const SizedBox(width: OwnerMetrics.gap),
            StatusTag(label: label, tone: tone),
          ],
        ),
      ),
    );
  }
}
