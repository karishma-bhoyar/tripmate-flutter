import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp(
    String email,
    String password,
    String name,
  ) async {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);

    final User? user = userCredential.user;
    if (user != null) {
      await _fireStore.collection('users').doc(user.uid).set({
        "name": name,
        "email": email,
      });
    }
    return userCredential;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
