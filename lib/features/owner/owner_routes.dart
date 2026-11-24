import 'package:go_router/go_router.dart';

import 'presentation/pages/my_qr_page.dart';
import 'presentation/pages/owner_add_vehicle_page.dart';
import 'presentation/pages/owner_gate_page.dart';
import 'presentation/pages/owner_home_page.dart';
import 'presentation/pages/vehicle_saved_page.dart';

/// Paths for the owner area. The owner lands on [gate] after choosing a role.
abstract final class OwnerRoutes {
  static const gate = '/owner';
  static const addVehicle = '/owner/add-vehicle';
  static const home = '/owner/home';
  static const myQr = '/owner/qr';
  static const vehicleSaved = '/owner/vehicle-saved/:vehicleId';

  static String vehicleSavedFor(String vehicleId) =>
      '/owner/vehicle-saved/$vehicleId';
}

/// Spread these into your GoRouter `routes:` list: `...ownerRoutes`.
final List<RouteBase> ownerRoutes = [
  GoRoute(
    path: OwnerRoutes.gate,
    builder: (context, state) => const OwnerGatePage(),
  ),
  GoRoute(
    path: OwnerRoutes.addVehicle,
    builder: (context, state) => const OwnerAddVehiclePage(),
  ),
  GoRoute(
    path: OwnerRoutes.vehicleSaved,
    builder: (context, state) =>
        VehicleSavedPage(vehicleId: state.pathParameters['vehicleId']!),
  ),
  GoRoute(
    path: OwnerRoutes.home,
    builder: (context, state) => const OwnerHomePage(),
  ),
  GoRoute(
    path: OwnerRoutes.myQr,
    builder: (context, state) => const MyQrPage(),
  ),
];
