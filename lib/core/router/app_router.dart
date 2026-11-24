import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/placeholder_pages.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/role_selection_page.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../../features/owner/owner_routes.dart';
import '../theme/app_text_styles.dart';

abstract final class AppRoutes {
  static const loading = '/';
  static const login = '/login';
  static const register = '/register';
  static const role = '/choose-role';
  static const shopDetails = '/shop-details';

  /// Kept so any existing reference still works; it now points to the new O1 screen.
  static const addVehicle = OwnerRoutes.addVehicle;
}

/// GoRouter configuration with Firebase-backed, role-aware redirects.
final appRouterProvider = Provider<GoRouter>((ref) {
  // Rebuild the redirect when auth or the user profile changes, without
  // recreating the whole router (so the navigation stack is not reset).
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoutes.loading,
    refreshListenable: refresh,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final auth = ref.read(authStateProvider);
      final user = ref.read(currentAppUserProvider);

      if (auth.isLoading) return null;

      // Signed out: only login and register are allowed.
      final firebaseUser = auth.valueOrNull;
      if (firebaseUser == null) {
        final onAuthPage =
            location == AppRoutes.login || location == AppRoutes.register;
        return onAuthPage ? null : AppRoutes.login;
      }

      if (user.isLoading) return null;

      // Signed in but no role yet: Choose Role.
      final profile = user.valueOrNull;
      if (profile == null || profile.role == null) {
        return location == AppRoutes.role ? null : AppRoutes.role;
      }

      // Owners may open any page under /owner (gate, add vehicle, home, QR).
      if (profile.role!.name == 'owner') {
        return location.startsWith(OwnerRoutes.gate) ? null : OwnerRoutes.gate;
      }

      // Shops (placeholder for now).
      return location == AppRoutes.shopDetails ? null : AppRoutes.shopDetails;
    },
    routes: [
      GoRoute(path: AppRoutes.loading, builder: (c, s) => const _SplashPage()),
      GoRoute(path: AppRoutes.login, builder: (c, s) => const LoginPage()),
      GoRoute(path: AppRoutes.register, builder: (c, s) => const RegisterPage()),
      GoRoute(path: AppRoutes.role, builder: (c, s) => const RoleSelectionPage()),
      GoRoute(
        path: AppRoutes.shopDetails,
        builder: (c, s) => const ShopDetailsPage(),
      ),
      ...ownerRoutes, // O1 to O3 and My QR
    ],
  );
});

class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(this.ref) {
    ref.listen(authStateProvider, (_, __) => notifyListeners());
    ref.listen(currentAppUserProvider, (_, __) => notifyListeners());
  }

  final Ref ref;
}

class _SplashPage extends StatelessWidget {
  const _SplashPage();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text('MotoSyncApp', style: AppTextStyles.headerTitle),
        ),
      );
}