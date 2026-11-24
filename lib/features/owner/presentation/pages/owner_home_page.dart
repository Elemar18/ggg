import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/vehicle_repository.dart';
import '../../domain/formatters.dart';
import '../../domain/reminder_calculator.dart';
import '../../domain/reminder_item.dart';
import '../../domain/vehicle.dart';
import '../../owner_routes.dart';
import '../../providers/owner_providers.dart';
import '../atoms/action_button.dart';
import '../molecules/info_box.dart';
import '../organisms/odometer_card.dart';
import '../organisms/odometer_sheet.dart';
import '../organisms/owner_header.dart';
import '../organisms/owner_status_views.dart';
import '../organisms/reminders_card.dart';
import '../owner_tokens.dart';
import '../templates/owner_template.dart';

/// O3: Home and reminders.
class OwnerHomePage extends ConsumerWidget {
  const OwnerHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(ownerVehiclesProvider);
    return vehicles.when(
      loading: () => const OwnerLoadingView(),
      error: (_, __) => OwnerErrorView(
        onRetry: () => ref.invalidate(ownerVehiclesProvider),
      ),
      data: (list) {
        if (list.isEmpty) return const _NoVehicleView();
        // The first (oldest) vehicle is shown. Multiple vehicles come later.
        return _HomeContent(vehicle: list.first);
      },
    );
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rules = ref.watch(serviceRulesProvider(vehicle.id));
    final ownerName = ref.watch(ownerNameProvider).valueOrNull ?? '';

    final now = DateTime.now();
    final estimatedKm = ReminderCalculator.estimateOdometer(vehicle, now: now);
    final confirmedToday = vehicle.odometerSource == 'owner' &&
        isSameDay(vehicle.odometerUpdatedAt, now);

    final items = (rules.valueOrNull ?? const []).map((r) {
      return ReminderItem(
        title: r.serviceType,
        subtitle: ReminderCalculator.subtitle(r, estimatedKm, now),
        status: ReminderCalculator.evaluate(
          nextDueKm: r.nextDueKm,
          nextDueDate: r.nextDueDate,
          currentKm: estimatedKm,
          now: now,
        ),
      );
    }).toList();

    return OwnerTemplate(
      header: OwnerHeader(
        label: 'Home',
        title: vehicle.displayName,
        subtitle: vehicle.headerSubtitle(ownerName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RemindersCard(items: items),
          const SizedBox(height: 10),
          OdometerCard(
            value: confirmedToday
                ? '${formatKm(vehicle.odometerKm)} km'
                : 'About ${formatKm(estimatedKm)} km',
            caption: confirmedToday
                ? 'Confirmed by you today'
                : 'Estimated from your riding average',
            onUpdate: () => showOdometerSheet(
              context,
              lastKm: vehicle.odometerKm,
              onSave: (km) async {
                try {
                  await ref
                      .read(vehicleRepositoryProvider)
                      .updateOdometer(vehicle: vehicle, newKm: km);
                  return null;
                } on VehicleException catch (e) {
                  return e.message;
                } catch (_) {
                  return 'Could not save. Please try again.';
                }
              },
            ),
          ),
          const SizedBox(height: OwnerMetrics.gap),
          ActionButton(
            label: 'Show my QR',
            variant: ActionButtonVariant.secondary,
            onPressed: () => context.push(OwnerRoutes.myQr),
          ),
        ],
      ),
    );
  }
}

class _NoVehicleView extends StatelessWidget {
  const _NoVehicleView();

  @override
  Widget build(BuildContext context) {
    return OwnerTemplate(
      header: const OwnerHeader(label: 'Home', title: 'No motorcycle yet'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const InfoBox('Add your motorcycle to start getting maintenance reminders.'),
          const SizedBox(height: OwnerMetrics.gap),
          ActionButton(
            label: 'Add vehicle',
            onPressed: () => context.go(OwnerRoutes.addVehicle),
          ),
        ],
      ),
    );
  }
}
