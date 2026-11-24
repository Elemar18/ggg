import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../owner_routes.dart';
import '../../providers/owner_providers.dart';
import '../atoms/action_button.dart';
import '../organisms/owner_header.dart';
import '../organisms/owner_status_views.dart';
import '../organisms/vehicle_qr_card.dart';
import '../owner_tokens.dart';
import '../templates/owner_template.dart';

/// O2: Vehicle saved, with the QR code to stick on the motorcycle.
class VehicleSavedPage extends ConsumerWidget {
  const VehicleSavedPage({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(vehicleProvider(vehicleId));
    final ownerName = ref.watch(ownerNameProvider).valueOrNull ?? '';

    return vehicle.when(
      loading: () => const OwnerLoadingView(),
      error: (_, __) => OwnerErrorView(
        onRetry: () => ref.invalidate(vehicleProvider(vehicleId)),
      ),
      data: (v) {
        if (v == null) {
          return OwnerErrorView(
            message: 'We could not find this vehicle.',
            onRetry: () => context.go(OwnerRoutes.gate),
          );
        }
        return OwnerTemplate(
          header: OwnerHeader(
            label: 'Vehicle saved',
            title: 'Your QR code',
            subtitle: v.headerSubtitle(ownerName),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VehicleQrCard(
                title: 'Stick this on the motorcycle',
                payload: v.qrPayload,
                size: 190,
              ),
              const SizedBox(height: OwnerMetrics.gap),
              ActionButton(
                label: 'Go to home',
                onPressed: () => context.go(OwnerRoutes.home),
              ),
            ],
          ),
        );
      },
    );
  }
}
