import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_tripmate/view/auth/data/datasources/auth_api_service.dart';
import 'package:flutter_application_tripmate/view/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService apiService;

  AuthRepositoryImpl({required this.apiService});

  @override
  User? get currentUser => apiService.currentUser;

  @override
  Future<UserCredential> login(String email, String password) async {
    return await apiService.loginWithEmail(email, password);
  }

  @override
  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return await apiService.signUpWithEmail(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logOut() async {
    await apiService.logOut();
  }
}
