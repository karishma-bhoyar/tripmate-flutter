import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  User? get currentUser;
  Future<UserCredential> login(String email, String password);
  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> logOut();
}
