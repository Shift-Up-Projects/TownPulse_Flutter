class Creator {
  final String id;
  final String name;
  final String email;
  final String profileImage;

  Creator({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profile_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'profile_image': profileImage,
    };
  }
}
