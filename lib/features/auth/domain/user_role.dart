/// Roles supported by MotoSyncApp.
enum UserRole { owner, shop }

extension UserRoleValue on UserRole {
  String get value => name;
  static UserRole? fromValue(String? value) => UserRole.values.where((role) => role.name == value).firstOrNull;
}
