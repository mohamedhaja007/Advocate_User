class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? profileImage;
  final String? dob;
  final String? gender;
  final String? bio;
  final String preferredLanguage;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.profileImage,
    this.dob,
    this.gender,
    this.bio,
    this.preferredLanguage = 'en',
  });

  String get fullName => '$firstName $lastName'.trim();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? json['firstName'] ?? '',
      lastName: json['last_name'] ?? json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImage: json['profile_image'] ?? json['profileImage'],
      dob: json['dob'],
      gender: json['gender'],
      bio: json['bio'],
      preferredLanguage: json['preferred_language'] ?? json['preferredLanguage'] ?? 'en',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'dob': dob,
      'gender': gender,
      'bio': bio,
      'preferred_language': preferredLanguage,
    };
  }
}
