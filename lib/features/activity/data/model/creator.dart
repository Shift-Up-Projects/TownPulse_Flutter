class Creator {
  final String id;
  final String? name;
  final String? email;
  final String? profileImage;

  Creator({required this.id, this.name, this.email, this.profileImage});

  factory Creator.fromJson(dynamic json) {
    if (json is String) {
      return Creator(id: json);
    } else if (json is Map<String, dynamic>) {
      return Creator(
        id: json['_id'] ?? '',
        name: json['name'],
        email: json['email'],
        profileImage: json['profile_image'],
      );
    } else {
      return Creator(id: '');
    }
  }
}
