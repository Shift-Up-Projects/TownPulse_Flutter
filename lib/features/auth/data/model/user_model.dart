// lib/features/auth/data/model/user_model.dart

class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String? role;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profile_image'] as String?,
      role: json['role'] as String?,
    );
  }
}
