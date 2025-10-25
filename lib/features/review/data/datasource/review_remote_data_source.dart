// lib/features/review/data/datasource/review_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:town_pulse2/core/utils/api_services.dart';

class ReviewRemoteDataSource {
  final Api _api = Api.instance;

  Future<Response> createReview({
    required String activityId,
    required double rating,
    required String comment,
    required String token,
  }) async {
    final body = {
      'activity_id': activityId,
      'rating': rating,
      'comment': comment,
    };
    return await _api.post(url: 'reviews', body: body, token: token);
  }

  Future<Response> getReviewsByActivityId(String activityId) async {
    final query = {'activity_id': activityId};
    return await _api.get(url: 'reviews', query: query, token: _api.token);
  }

  Future<void> deleteReview(String reviewId, String token) async {
    await _api.delete(url: 'reviews/$reviewId', token: token);
  }

  Future<Response> updateReview({
    required String reviewId,
    required double rating,
    required String comment,
    required String token,
  }) async {
    final body = {'rating': rating, 'comment': comment};
    return await _api.put(url: 'reviews/$reviewId', body: body, token: token);
  }
}
