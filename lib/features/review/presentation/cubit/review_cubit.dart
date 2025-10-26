import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/features/review/data/repo/reiview_repo.dart';
import 'package:town_pulse2/features/review/presentation/cubit/review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepo reviewRepo;
  ReviewCubit(this.reviewRepo) : super(ReviewInitial());

  static ReviewCubit get(context) => BlocProvider.of(context);
  String? get token => CacheHelper.getData(key: 'token') as String?;

  Future<void> fetchReviews(String activityId) async {
    emit(ReviewsLoading());
    try {
      final reviews = await reviewRepo.getReviewsByActivityId(activityId);
      emit(ReviewsLoaded(reviews));
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }

  Future<void> createReview({
    required String activityId,
    required double rating,
    required String comment,
  }) async {
    if (token == null) {
      emit(ReviewsError('يجب عليك تسجيل الدخول لإضافة تقييم.'));
      return;
    }
    emit(ReviewCreating());
    try {
      await reviewRepo.createReview(
        activityId: activityId,
        rating: rating,
        comment: comment,
        token: token!,
      );
      emit(ReviewCreated('تم إضافة تقييمك بنجاح'));
      await fetchReviews(activityId);
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }

  Future<void> deleteReview(String reviewId, String activityId) async {
    if (token == null) {
      emit(ReviewsError('يجب عليك تسجيل الدخول لحذف التقييم.'));
      return;
    }
    emit(ReviewDeleting());
    try {
      await reviewRepo.deleteReview(reviewId, token!);
      emit(ReviewDeleted(reviewId));
      await fetchReviews(activityId);
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }
}
