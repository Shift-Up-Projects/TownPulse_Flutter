import 'package:town_pulse2/features/review/data/model/review_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewsLoading extends ReviewState {}

class ReviewsLoaded extends ReviewState {
  final List<Review> reviews;
  ReviewsLoaded(this.reviews);
}

class ReviewsError extends ReviewState {
  final String message;
  ReviewsError(this.message);
}

class ReviewCreating extends ReviewState {}

class ReviewCreated extends ReviewState {
  final String message;
  ReviewCreated(this.message);
}

class ReviewDeleting extends ReviewState {}

class ReviewDeleted extends ReviewState {
  final String reviewId;
  ReviewDeleted(this.reviewId);
}
