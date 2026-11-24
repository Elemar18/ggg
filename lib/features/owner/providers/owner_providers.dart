import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/vehicle_repository.dart';
import '../domain/service_rule.dart';
import '../domain/vehicle.dart';

final vehicleRepositoryProvider = Provider<VehicleRepository>(
  (ref) => VehicleRepository(FirebaseFirestore.instance),
);

/// The signed-in user's uid (null when signed out).
final ownerUidProvider = StreamProvider<String?>(
  (ref) => FirebaseAuth.instance.authStateChanges().map((u) => u?.uid),
);

/// Decides between Add Vehicle (false) and Home (true).
final hasVehicleProvider = FutureProvider.autoDispose<bool>((ref) async {
  final uid = await ref.watch(ownerUidProvider.future);
  if (uid == null) return false;
  return ref.watch(vehicleRepositoryProvider).hasVehicle(uid);
});

/// All active vehicles of the signed-in owner (oldest first).
final ownerVehiclesProvider = StreamProvider<List<Vehicle>>((ref) {
  final uid = ref.watch(ownerUidProvider).valueOrNull;
  if (uid == null) return Stream.value(const <Vehicle>[]);
  return ref.watch(vehicleRepositoryProvider).watchVehicles(uid);
});

final vehicleProvider = StreamProvider.family<Vehicle?, String>(
  (ref, vehicleId) =>
      ref.watch(vehicleRepositoryProvider).watchVehicle(vehicleId),
);

final serviceRulesProvider = StreamProvider.family<List<ServiceRule>, String>(
  (ref, vehicleId) => ref.watch(vehicleRepositoryProvider).watchRules(vehicleId),
);

/// The owner's name for the header. Reads `fullName` or `name` from users/{uid}.
final ownerNameProvider = FutureProvider<String>((ref) async {
  final uid = await ref.watch(ownerUidProvider.future);
  if (uid == null) return '';
  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = doc.data();
  final name = (data?['fullName'] ?? data?['name']) as String?;
  return name ?? FirebaseAuth.instance.currentUser?.displayName ?? '';
});
