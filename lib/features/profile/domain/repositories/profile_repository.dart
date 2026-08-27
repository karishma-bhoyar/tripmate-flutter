import 'package:flutter_application_tripmate/features/profile/data/models/user_profile_model.dart';

abstract class ProfileRepository {
  Future<UserProfileModel> fetchUserProfile();
  Future<void> updateUserProfile(String name, String phone);
}
