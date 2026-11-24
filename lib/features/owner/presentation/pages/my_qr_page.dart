import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/owner_providers.dart';
import '../atoms/action_button.dart';
import '../molecules/info_box.dart';
import '../organisms/owner_header.dart';
import '../organisms/owner_status_views.dart';
import '../organisms/vehicle_qr_card.dart';
import '../owner_tokens.dart';
import '../templates/owner_template.dart';

/// Opened from "Show my QR" on Home. Shows the QR to the mechanic.
class MyQrPage extends ConsumerWidget {
  const MyQrPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(ownerVehiclesProvider);
    return vehicles.when(
      loading: () => const OwnerLoadingView(),
      error: (_, __) => OwnerErrorView(
        onRetry: () => ref.invalidate(ownerVehiclesProvider),
      ),
      data: (list) {
        if (list.isEmpty) {
          return OwnerErrorView(
            message: 'No motorcycle found.',
            onRetry: () => context.pop(),
          );
        }
        final v = list.first;
        return OwnerTemplate(
          header: OwnerHeader(
            label: 'My vehicle QR',
            title: v.displayName,
            subtitle: 'Plate ${v.plate}',
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VehicleQrCard(
                title: 'Show this to the mechanic',
                payload: v.qrPayload,
                size: 200,
              ),
              const SizedBox(height: OwnerMetrics.gap),
              const InfoBox(
                'The code holds only a vehicle ID, no name, phone or history. '
                'If it is lost you can generate a new one.',
              ),
              const SizedBox(height: OwnerMetrics.gap),
              ActionButton(
                label: 'Back',
                variant: ActionButtonVariant.secondary,
                onPressed: () => context.pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
