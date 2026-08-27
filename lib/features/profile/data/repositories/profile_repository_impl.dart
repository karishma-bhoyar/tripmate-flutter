import 'package:flutter_application_tripmate/features/profile/data/datasources/profile_api_service.dart';
import 'package:flutter_application_tripmate/features/profile/data/models/user_profile_model.dart';
import 'package:flutter_application_tripmate/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService apiService;

  ProfileRepositoryImpl({required this.apiService});

  @override
  Future<UserProfileModel> fetchUserProfile() async {
    return await apiService.fetchUserProfile();
  }

  @override
  Future<void> updateUserProfile(String name, String phone) async {
    await apiService.updateUserProfile(name, phone);
  }
}
