import 'service_rule.dart';

/// What one row of the Reminders card shows.
class ReminderItem {
  const ReminderItem({
    required this.title,
    required this.subtitle,
    required this.status,
  });

  final String title;
  final String subtitle;
  final ReminderStatus status;
}
