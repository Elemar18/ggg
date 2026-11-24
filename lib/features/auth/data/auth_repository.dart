import 'package:firebase_auth/firebase_auth.dart';
/// Wraps Firebase Authentication operations.
class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  Future<UserCredential> signIn(String email, String password) => _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
  Future<UserCredential> register(String email, String password) => _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
  Future<void> sendPasswordReset(String email) => _auth.sendPasswordResetEmail(email: email.trim());
  Future<void> signOut() => _auth.signOut();
  String friendlyError(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'wrong-password': case 'invalid-credential': return 'The email or password is incorrect.';
        case 'user-not-found': return 'No account was found with that email.';
        case 'email-already-in-use': return 'This email is already registered.';
        case 'weak-password': return 'Please choose a stronger password.';
        case 'invalid-email': return 'Please enter a valid email address.';
        case 'network-request-failed': return 'Network error. Check your internet connection.';
        case 'too-many-requests': return 'Too many attempts. Please try again later.';
      }
    }
    return 'Something went wrong. Please try again.';
  }
}
