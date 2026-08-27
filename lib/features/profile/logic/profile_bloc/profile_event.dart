abstract class ProfileEvent {
  const ProfileEvent();
}

class FetchProfileEvent extends ProfileEvent {
  const FetchProfileEvent();
}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String phone;

  const UpdateProfileEvent({required this.name, required this.phone});
}
