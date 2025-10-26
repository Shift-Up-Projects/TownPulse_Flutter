import 'package:town_pulse2/features/auth/data/model/user_model.dart';

class Review {
  final String id;
  final double rating;
  final String comment;
  final User? user;
  final String? activityId;
  final DateTime? createdAt;

  Review({
    required this.id,
    required this.rating,
    required this.comment,
    this.user,
    this.activityId,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    final userJson = json['user_id'] is Map<String, dynamic>
        ? json['user_id']
        : null;

    final activityIdString = json['activity_id'] is String
        ? json['activity_id']
        : (json['activity_id'] is Map<String, dynamic>
              ? json['activity_id']['_id']
              : null);

    return Review(
      id: json['_id'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      user: userJson != null ? User.fromJson(userJson) : null,
      activityId: activityIdString,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }
}
