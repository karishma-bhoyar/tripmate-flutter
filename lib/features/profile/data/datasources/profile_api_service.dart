import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_tripmate/features/profile/data/models/user_profile_model.dart';

class ProfileApiService {
  final Dio dio;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ProfileApiService({required this.dio});

  Future<UserProfileModel> fetchUserProfile() async {
    final User? currentUser = auth.currentUser;
    if (currentUser == null) {
      return const UserProfileModel(
        uid: 'guest',
        name: 'John Doe',
        email: 'john.doe@example.com',
      );
    }

    try {
      final doc = await firestore.collection('users').doc(currentUser.uid).get();
      if (doc.exists && doc.data() != null) {
        return UserProfileModel.fromMap(doc.data()!, currentUser.uid);
      }
      return UserProfileModel(
        uid: currentUser.uid,
        name: currentUser.displayName ?? 'User',
        email: currentUser.email ?? '',
      );
    } catch (_) {
      return UserProfileModel(
        uid: currentUser.uid,
        name: currentUser.displayName ?? 'User',
        email: currentUser.email ?? '',
      );
    }
  }

  Future<void> updateUserProfile(String name, String phone) async {
    final User? currentUser = auth.currentUser;
    if (currentUser == null) return;

    await firestore.collection('users').doc(currentUser.uid).set({
      'name': name,
      'phone': phone,
    }, SetOptions(merge: true));
  }
}
