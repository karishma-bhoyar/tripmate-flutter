import 'package:flutter_application_tripmate/features/profile/data/models/user_profile_model.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileModel userProfile;

  const ProfileLoaded(this.userProfile);
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}
