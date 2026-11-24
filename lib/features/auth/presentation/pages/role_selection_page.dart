import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/user_role.dart';
import '../../providers/auth_providers.dart';
import '../atoms/app_button.dart';
import '../molecules/info_note.dart';
import '../organisms/role_selector.dart';
import '../templates/auth_template.dart';
/// Required role selection shown to authenticated users without a role.
class RoleSelectionPage extends ConsumerWidget { const RoleSelectionPage({super.key});
 @override Widget build(BuildContext context,WidgetRef ref){final role=ref.watch(selectedRoleProvider);return AuthTemplate(title:'How will you use the app?',subtitle:'Choose one to continue',children:[RoleSelector(selected:role,onSelected:(value)=>ref.read(selectedRoleProvider.notifier).state=value),const InfoNote(message:'Owners go to the Add Vehicle screen. Shops enter their details and are verified by an admin before receiving requests.'),AppButton(label:'Continue',enabled:role!=null,onPressed:role==null?null:()async{final uid=ref.read(authRepositoryProvider).currentUser?.uid;if(uid==null)return;await ref.read(userRepositoryProvider).setRole(uid,role);ref.invalidate(currentAppUserProvider);if(context.mounted)context.go(role==UserRole.owner?AppRoutes.addVehicle:AppRoutes.shopDetails);})]);}
}
