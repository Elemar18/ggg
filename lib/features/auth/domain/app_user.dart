import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_role.dart';
/// Application profile stored in Firestore under users/{uid}.
class AppUser {
  const AppUser({required this.uid, required this.name, required this.email, required this.phone, this.role, this.createdAt});
  final String uid;
  final String name;
  final String email;
  final String phone;
  final UserRole? role;
  final DateTime? createdAt;
  factory AppUser.fromMap(String uid, Map<String, dynamic> map) => AppUser(
    uid: uid, name: map['name'] as String? ?? '', email: map['email'] as String? ?? '',
    phone: map['phone'] as String? ?? '', role: UserRoleValue.fromValue(map['role'] as String?),
    createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
  );
}
