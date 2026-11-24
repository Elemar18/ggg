import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../owner_routes.dart';
import '../../providers/owner_providers.dart';
import '../organisms/owner_status_views.dart';

/// Entry point for owners: sends them to Add Vehicle (no vehicle yet) or Home.
class OwnerGatePage extends ConsumerWidget {
  const OwnerGatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasVehicle = ref.watch(hasVehicleProvider);
    return hasVehicle.when(
      loading: () => const OwnerLoadingView(),
      error: (_, __) => OwnerErrorView(
        onRetry: () => ref.invalidate(hasVehicleProvider),
      ),
      data: (has) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;
          context.go(has ? OwnerRoutes.home : OwnerRoutes.addVehicle);
        });
        return const OwnerLoadingView();
      },
    );
  }
}
