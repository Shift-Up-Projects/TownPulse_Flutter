// lib/features/review/data/repo/review_repo.dart
import 'package:town_pulse2/features/review/data/model/review_model.dart';

abstract class ReviewRepo {
  Future<Review> createReview({
    required String activityId,
    required double rating,
    required String comment,
    required String token,
  });

  Future<List<Review>> getReviewsByActivityId(String activityId);

  Future<void> deleteReview(String reviewId, String token);

  Future<Review> updateReview({
    required String reviewId,
    required double rating,
    required String comment,
    required String token,
  });
}
