import 'formatters.dart';
import 'service_rule.dart';
import 'vehicle.dart';

/// Pure functions that work out reminder status and the estimated odometer.
abstract final class ReminderCalculator {
  static const int dueSoonKm = 300;
  static const int dueSoonDays = 14;
  static const double defaultKmPerDay = 25;

  /// Last real reading plus the average daily distance since it was taken.
  static int estimateOdometer(Vehicle v, {DateTime? now}) {
    final days = (now ?? DateTime.now()).difference(v.odometerUpdatedAt).inDays;
    final safeDays = days < 0 ? 0 : days;
    return v.odometerKm + (v.avgKmPerDay * safeDays).round();
  }

  /// Adds months and keeps the day inside the target month (31 Jan + 1 = 28 Feb).
  static DateTime addMonths(DateTime d, int months) {
    final total = d.month - 1 + months;
    final year = d.year + total ~/ 12;
    final month = total % 12 + 1;
    final lastDay = DateTime(year, month + 1, 0).day;
    return DateTime(year, month, d.day > lastDay ? lastDay : d.day);
  }

  /// Whole days from [now] to [due] (negative when [due] has passed).
  static int daysUntil(DateTime due, DateTime now) {
    final a = DateTime(due.year, due.month, due.day);
    final b = DateTime(now.year, now.month, now.day);
    return a.difference(b).inDays;
  }

  static ReminderStatus evaluate({
    int? nextDueKm,
    DateTime? nextDueDate,
    required int currentKm,
    DateTime? now,
  }) {
    final today = now ?? DateTime.now();
    final kmLeft = nextDueKm == null ? null : nextDueKm - currentKm;
    final daysLeft = nextDueDate == null ? null : daysUntil(nextDueDate, today);

    if ((kmLeft != null && kmLeft <= 0) || (daysLeft != null && daysLeft < 0)) {
      return ReminderStatus.overdue;
    }
    if ((kmLeft != null && kmLeft <= dueSoonKm) ||
        (daysLeft != null && daysLeft <= dueSoonDays)) {
      return ReminderStatus.dueSoon;
    }
    return ReminderStatus.ok;
  }

  /// The grey text under a reminder title, e.g. "Due at 12,400 km".
  static String subtitle(ServiceRule rule, int currentKm, DateTime now) {
    final parts = <String>[];
    final days =
        rule.nextDueDate == null ? null : daysUntil(rule.nextDueDate!, now);
    if (rule.nextDueKm != null) {
      parts.add('Due at ${formatKm(rule.nextDueKm!)} km');
    }
    if (days != null) {
      if (days < 0) {
        parts.add('${-days} day${-days == 1 ? '' : 's'} late');
      } else if (rule.nextDueKm == null) {
        parts.add(days == 0
            ? 'Due today'
            : 'Due in $days day${days == 1 ? '' : 's'}');
      }
    }
    return parts.isEmpty ? 'No schedule set' : parts.join(' \u00b7 ');
  }
}
