import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/vehicle_form_data.dart';
import '../../owner_routes.dart';
import '../../providers/owner_providers.dart';
import '../organisms/add_vehicle_form.dart';
import '../organisms/owner_header.dart';
import '../templates/owner_template.dart';

/// O1: Add vehicle.
class OwnerAddVehiclePage extends ConsumerStatefulWidget {
  const OwnerAddVehiclePage({super.key});

  @override
  ConsumerState<OwnerAddVehiclePage> createState() => _OwnerAddVehiclePageState();
}

class _OwnerAddVehiclePageState extends ConsumerState<OwnerAddVehiclePage> {
  bool _loading = false;
  String? _message;

  Future<void> _save(VehicleFormData data) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      setState(() => _message = 'Please log in again.');
      return;
    }
    setState(() {
      _loading = true;
      _message = null;
    });
    try {
      final id = await ref
          .read(vehicleRepositoryProvider)
          .createVehicle(ownerId: uid, data: data);
      if (!mounted) return;
      context.go(OwnerRoutes.vehicleSavedFor(id));
    } on FirebaseException catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _message = e.code == 'permission-denied'
            ? 'The database rules blocked saving this vehicle.'
            : 'We could not save your vehicle. Please try again.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _message = 'We could not save your vehicle. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OwnerTemplate(
      header: const OwnerHeader(label: 'Add vehicle', title: 'New motorcycle'),
      body: AddVehicleForm(
        onSubmit: _save,
        isLoading: _loading,
        message: _message,
      ),
    );
  }
}
