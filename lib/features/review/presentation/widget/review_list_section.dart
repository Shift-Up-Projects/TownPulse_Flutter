import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/review/presentation/cubit/review_cubit.dart';
import 'package:town_pulse2/features/review/presentation/cubit/review_state.dart';
import 'package:town_pulse2/features/review/presentation/widget/review_tile.dart';

class ReviewListSection extends StatelessWidget {
  final String activityId;
  const ReviewListSection({super.key, required this.activityId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ReviewsLoaded) {
          final reviews = state.reviews;
          if (reviews.isEmpty) {
            return const Center(
              child: Text('لا توجد تقييمات لهذا النشاط بعد.'),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: reviews
                .map((review) => ReviewTile(review: review))
                .toList(),
          );
        }
        if (state is ReviewsError) {
          return Center(child: Text('فشل في جلب التقييمات.'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
