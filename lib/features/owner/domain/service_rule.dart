import 'package:cloud_firestore/cloud_firestore.dart';

enum ReminderStatus {
  ok,
  dueSoon,
  overdue;

  static ReminderStatus fromValue(String? value) {
    for (final s in values) {
      if (s.name == value) return s;
    }
    return ReminderStatus.ok;
  }
}

/// One tracked service for a vehicle.
/// Stored in `vehicles/{vehicleId}/serviceRules/{serviceTypeId}`.
class ServiceRule {
  const ServiceRule({
    required this.id,
    required this.serviceType,
    this.intervalKm,
    this.intervalMonths,
    this.lastServiceKm,
    this.lastServiceDate,
    this.nextDueKm,
    this.nextDueDate,
    this.status = ReminderStatus.ok,
  });

  final String id;
  final String serviceType;
  final int? intervalKm;
  final int? intervalMonths;
  final int? lastServiceKm;
  final DateTime? lastServiceDate;
  final int? nextDueKm;
  final DateTime? nextDueDate;
  final ReminderStatus status;

  factory ServiceRule.fromMap(String id, Map<String, dynamic> map) {
    DateTime? date(dynamic v) => v is Timestamp ? v.toDate() : null;
    return ServiceRule(
      id: id,
      serviceType: (map['serviceType'] as String?) ?? id,
      intervalKm: (map['intervalKm'] as num?)?.toInt(),
      intervalMonths: (map['intervalMonths'] as num?)?.toInt(),
      lastServiceKm: (map['lastServiceKm'] as num?)?.toInt(),
      lastServiceDate: date(map['lastServiceDate']),
      nextDueKm: (map['nextDueKm'] as num?)?.toInt(),
      nextDueDate: date(map['nextDueDate']),
      status: ReminderStatus.fromValue(map['status'] as String?),
    );
  }
}
