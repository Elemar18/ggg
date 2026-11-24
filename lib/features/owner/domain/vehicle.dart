import 'package:cloud_firestore/cloud_firestore.dart';

/// A motorcycle owned by a user. Stored in `vehicles/{vehicleId}`.
class Vehicle {
  const Vehicle({
    required this.id,
    required this.ownerId,
    required this.brand,
    required this.model,
    required this.plate,
    required this.qrToken,
    required this.qrActive,
    required this.odometerKm,
    required this.odometerUpdatedAt,
    required this.odometerSource,
    required this.avgKmPerDay,
    this.createdAt,
  });

  final String id;
  final String ownerId;
  final String brand;
  final String model;
  final String plate;
  final String qrToken;
  final bool qrActive;
  final int odometerKm;
  final DateTime odometerUpdatedAt;
  final String odometerSource;
  final double avgKmPerDay;
  final DateTime? createdAt;

  /// Brand and model together, e.g. "Honda Click 125".
  String get displayName {
    final name = '$brand $model'.trim();
    return name.isEmpty ? 'Motorcycle' : name;
  }

  /// Header subtitle, e.g. "Plate ABC 1234 \u00b7 Juan Dela Cruz".
  String headerSubtitle(String ownerName) =>
      ownerName.isEmpty ? 'Plate $plate' : 'Plate $plate \u00b7 $ownerName';

  /// The text encoded in the QR sticker. It holds only a random token.
  String get qrPayload => 'motorcare://vehicle/$qrToken';

  factory Vehicle.fromMap(String id, Map<String, dynamic> map) {
    DateTime? date(dynamic v) => v is Timestamp ? v.toDate() : null;
    return Vehicle(
      id: id,
      ownerId: (map['ownerId'] as String?) ?? '',
      brand: (map['brand'] as String?) ?? '',
      model: (map['model'] as String?) ?? '',
      plate: (map['plate'] as String?) ?? '',
      qrToken: (map['qrToken'] as String?) ?? '',
      qrActive: (map['qrActive'] as bool?) ?? true,
      odometerKm: (map['odometerKm'] as num?)?.toInt() ?? 0,
      odometerUpdatedAt: date(map['odometerUpdatedAt']) ?? DateTime.now(),
      odometerSource: (map['odometerSource'] as String?) ?? 'owner',
      avgKmPerDay: (map['avgKmPerDay'] as num?)?.toDouble() ?? 25,
      createdAt: date(map['createdAt']),
    );
  }
}
