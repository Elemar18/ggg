import 'package:flutter/material.dart';
import '../../domain/user_role.dart';
import '../molecules/role_option_card.dart';
/// Presents the two available account roles.
class RoleSelector extends StatelessWidget {
  const RoleSelector({super.key, required this.selected, required this.onSelected}); final UserRole? selected; final ValueChanged<UserRole> onSelected;
  @override Widget build(BuildContext context) => Column(children: [RoleOptionCard(title: 'Motorcycle owner', subtitle: 'Get reminders and book services', selected: selected == UserRole.owner, onTap: () => onSelected(UserRole.owner)), const SizedBox(height: 12), RoleOptionCard(title: 'Shop / mechanic', subtitle: 'Receive requests and log services', selected: selected == UserRole.shop, onTap: () => onSelected(UserRole.shop))]);
}
