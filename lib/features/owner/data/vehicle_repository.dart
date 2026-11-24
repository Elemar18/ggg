import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/reminder_calculator.dart';
import '../domain/service_rule.dart';
import '../domain/vehicle.dart';
import '../domain/vehicle_form_data.dart';

/// A problem the user can understand, e.g. an odometer that is too low.
class VehicleException implements Exception {
  const VehicleException(this.message);
  final String message;
}

/// Default service intervals used when a vehicle is added.
abstract final class ServiceDefaults {
  static const oilKm = 3000;
  static const oilMonths = 3;
  static const checkMonths = 6;
}

/// Reads and writes vehicles and their service rules in Cloud Firestore.
class VehicleRepository {
  VehicleRepository(this._db);

  final FirebaseFirestore _db;
  static final DateTime _far = DateTime(9999);

  CollectionReference<Map<String, dynamic>> get _vehicles =>
      _db.collection('vehicles');

  Query<Map<String, dynamic>> _activeFor(String ownerId) => _vehicles
      .where('ownerId', isEqualTo: ownerId)
      .where('status', isEqualTo: 'active');

  /// One-time check, used to decide between Add Vehicle and Home.
  /// Prefers the server and falls back to the cache when offline.
  Future<bool> hasVehicle(String ownerId) async {
    final snap = await _activeFor(ownerId).limit(1).get();
    return snap.docs.isNotEmpty;
  }

  Stream<List<Vehicle>> watchVehicles(String ownerId) {
    return _activeFor(ownerId)
        .snapshots()
        // Ignore an empty first answer that only came from a cold cache.
        .where((s) => !(s.metadata.isFromCache && s.docs.isEmpty))
        .map((s) {
      final list = s.docs.map((d) => Vehicle.fromMap(d.id, d.data())).toList()
        ..sort((a, b) =>
            (a.createdAt ?? _far).compareTo(b.createdAt ?? _far));
      return list;
    });
  }

  Stream<Vehicle?> watchVehicle(String vehicleId) {
    return _vehicles
        .doc(vehicleId)
        .snapshots()
        .where((s) => s.exists || !s.metadata.isFromCache)
        .map((s) {
      final data = s.data();
      if (!s.exists || data == null) return null;
      return Vehicle.fromMap(s.id, data);
    });
  }

  Stream<List<ServiceRule>> watchRules(String vehicleId) {
    const order = ['oil_change', 'battery_check', 'tire_check'];
    return _vehicles
        .doc(vehicleId)
        .collection('serviceRules')
        .snapshots()
        .map((s) {
      final list =
          s.docs.map((d) => ServiceRule.fromMap(d.id, d.data())).toList();
      int rank(String id) {
        final i = order.indexOf(id);
        return i == -1 ? order.length : i;
      }

      list.sort((a, b) => rank(a.id).compareTo(rank(b.id)));
      return list;
    });
  }

  /// Creates the vehicle and its three starting service rules in one batch.
  /// Returns the new vehicle id.
  Future<String> createVehicle({
    required String ownerId,
    required VehicleFormData data,
  }) async {
    final ref = _vehicles.doc();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final names = _splitBrandModel(data.model);

    // The owner only gives the date of the last oil change, so the odometer
    // at that service is estimated from the average daily distance.
    final daysSince = max(0, today.difference(data.lastOilChange).inDays);
    final lastOilKm = max(
      0,
      data.odometerKm -
          (ReminderCalculator.defaultKmPerDay * daysSince).round(),
    );

    final batch = _db.batch();
    batch.set(ref, {
      'ownerId': ownerId,
      'brand': names[0],
      'model': names[1],
      'plate': data.plate.trim().toUpperCase(),
      'qrToken': _newToken(),
      'qrActive': true,
      'odometerKm': data.odometerKm,
      'odometerUpdatedAt': Timestamp.fromDate(now),
      'odometerSource': 'owner',
      'avgKmPerDay': ReminderCalculator.defaultKmPerDay,
      'status': 'active',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    void rule(
      String id,
      String label, {
      int? intervalKm,
      int? intervalMonths,
      int? lastKm,
      required DateTime lastDate,
    }) {
      final nextKm =
          (intervalKm != null && lastKm != null) ? lastKm + intervalKm : null;
      final nextDate = intervalMonths != null
          ? ReminderCalculator.addMonths(lastDate, intervalMonths)
          : null;
      final status = ReminderCalculator.evaluate(
        nextDueKm: nextKm,
        nextDueDate: nextDate,
        currentKm: data.odometerKm,
        now: now,
      );
      batch.set(ref.collection('serviceRules').doc(id), {
        'ownerId': ownerId,
        'vehicleId': ref.id,
        'serviceType': label,
        'intervalKm': intervalKm,
        'intervalMonths': intervalMonths,
        'lastServiceKm': lastKm,
        'lastServiceDate': Timestamp.fromDate(lastDate),
        'nextDueKm': nextKm,
        'nextDueDate': nextDate == null ? null : Timestamp.fromDate(nextDate),
        'status': status.name,
        'activeAppointmentId': null,
        'snoozedUntil': null,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    rule('oil_change', 'Oil change',
        intervalKm: ServiceDefaults.oilKm,
        intervalMonths: ServiceDefaults.oilMonths,
        lastKm: lastOilKm,
        lastDate: data.lastOilChange);
    // No history for these two, so tracking starts today.
    rule('battery_check', 'Battery check',
        intervalMonths: ServiceDefaults.checkMonths, lastDate: today);
    rule('tire_check', 'Tire check',
        intervalMonths: ServiceDefaults.checkMonths, lastDate: today);

    await batch.commit();
    return ref.id;
  }

  /// Saves a new odometer reading and refines the average daily distance.
  Future<void> updateOdometer({
    required Vehicle vehicle,
    required int newKm,
  }) async {
    if (newKm < vehicle.odometerKm) {
      throw VehicleException(
        "It can't be lower than your last reading (${vehicle.odometerKm} km).",
      );
    }
    final now = DateTime.now();
    final days = now.difference(vehicle.odometerUpdatedAt).inDays;
    final delta = newKm - vehicle.odometerKm;
    var avg = vehicle.avgKmPerDay;
    if (days >= 1 && delta > 0) {
      final measured = (delta / days).clamp(1.0, 300.0);
      avg = (vehicle.avgKmPerDay + measured) / 2; // blend old and new
    }
    await _vehicles.doc(vehicle.id).update({
      'odometerKm': newKm,
      'odometerUpdatedAt': Timestamp.fromDate(now),
      'odometerSource': 'owner',
      'avgKmPerDay': double.parse(avg.toStringAsFixed(1)),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// "Honda Click 125" -> ["Honda", "Click 125"]. A single word is the model.
  List<String> _splitBrandModel(String input) {
    final parts = input.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return ['', input.trim()];
    return [parts.first, parts.sublist(1).join(' ')];
  }

  /// A random, unguessable token for the QR code (25 characters).
  String _newToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random.secure();
    final body = List.generate(22, (_) => chars[rnd.nextInt(chars.length)]);
    return 'ms_${body.join()}';
  }
}
