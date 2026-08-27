class UserProfileModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String? photoPath;

  const UserProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone = '',
    this.photoPath,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserProfileModel(
      uid: uid,
      name: map['name'] ?? 'User',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      photoPath: map['photoPath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      if (photoPath != null) 'photoPath': photoPath,
    };
  }
}
