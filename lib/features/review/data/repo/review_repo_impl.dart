// lib/features/review/data/repo/review_repo_impl.dart
import 'package:dio/dio.dart';
import 'package:town_pulse2/features/review/data/datasource/review_remote_data_source.dart';
import 'package:town_pulse2/features/review/data/model/review_model.dart';
import 'package:town_pulse2/features/review/data/repo/reiview_repo.dart';

class ReviewRepoImpl implements ReviewRepo {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepoImpl(this.remoteDataSource);

  @override
  Future<Review> createReview({
    required String activityId,
    required double rating,
    required String comment,
    required String token,
  }) async {
    try {
      final response = await remoteDataSource.createReview(
        activityId: activityId,
        rating: rating,
        comment: comment,
        token: token,
      );
      final data = response.data['data'];
      return Review.fromJson(data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'فشل في إنشاء التقييم.');
    } catch (e) {
      throw Exception('خطأ غير متوقع أثناء إنشاء التقييم: $e');
    }
  }

  @override
  Future<List<Review>> getReviewsByActivityId(String activityId) async {
    try {
      final response = await remoteDataSource.getReviewsByActivityId(
        activityId,
      );
      final rawData = response.data['data'];

      if (rawData == null || rawData is! List) return [];

      return rawData
          .map((json) => Review.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'فشل في جلب التقييمات.');
    } catch (e) {
      throw Exception('خطأ غير متوقع أثناء جلب التقييمات: $e');
    }
  }

  @override
  Future<void> deleteReview(String reviewId, String token) async {
    try {
      await remoteDataSource.deleteReview(reviewId, token);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'فشل في حذف التقييم.');
    } catch (e) {
      throw Exception('خطأ غير متوقع أثناء حذف التقييم: $e');
    }
  }

  @override
  Future<Review> updateReview({
    required String reviewId,
    required double rating,
    required String comment,
    required String token,
  }) async {
    try {
      final response = await remoteDataSource.updateReview(
        reviewId: reviewId,
        rating: rating,
        comment: comment,
        token: token,
      );
      final data = response.data['data'];
      return Review.fromJson(data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'فشل في تحديث التقييم.');
    } catch (e) {
      throw Exception('خطأ غير متوقع أثناء تحديث التقييم: $e');
    }
  }
}
