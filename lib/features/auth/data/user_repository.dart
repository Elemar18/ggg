import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/app_user.dart';
import '../domain/user_role.dart';
/// Reads and writes user profile documents in Cloud Firestore.
class UserRepository {
  UserRepository(this._firestore);
  final FirebaseFirestore _firestore;
  CollectionReference<Map<String, dynamic>> get _users => _firestore.collection('users');
  Future<void> createUser({required String uid, required String name, required String email, required String phone}) => _users.doc(uid).set({
    'name': name.trim(), 'email': email.trim(), 'phone': phone.trim(), 'role': null, 'createdAt': FieldValue.serverTimestamp(),
  });
  Future<AppUser?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();
    return doc.exists && doc.data() != null ? AppUser.fromMap(uid, doc.data()!) : null;
  }
  Future<void> setRole(String uid, UserRole role) => _users.doc(uid).set({'role': role.value}, SetOptions(merge: true));
}
