// lib/features/review/presentation/widgets/review_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/review/data/model/review_model.dart';
import 'package:town_pulse2/features/review/presentation/cubit/review_cubit.dart';
import 'package:town_pulse2/features/review/presentation/cubit/review_state.dart';
// لإضافة تقييم بصري، سنفترض وجود ويدجت بسيط للتقييم:
// Widget StarRatingPlaceholder(double rating) { ... }

// ----------------------------------------------------------------------
// 1. Review Submission Form
// ----------------------------------------------------------------------

class ReviewSubmissionForm extends StatefulWidget {
  final String activityId;
  const ReviewSubmissionForm({super.key, required this.activityId});

  @override
  State<ReviewSubmissionForm> createState() => _ReviewSubmissionFormState();
}

class _ReviewSubmissionFormState extends State<ReviewSubmissionForm> {
  final TextEditingController _commentController = TextEditingController();
  double _currentRating = 5.0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview(BuildContext context) {
    if (_commentController.text.trim().isEmpty) {
      ShowToast(message: 'الرجاء كتابة تعليق', state: toastState.warning);
      return;
    }

    ReviewCubit.get(context).createReview(
      activityId: widget.activityId,
      rating: _currentRating,
      comment: _commentController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('التقييم:', style: Styles.textStyle16),
            Row(
              children: [
                Text(
                  _currentRating.toStringAsFixed(1),
                  style: Styles.textStyle16.copyWith(color: AppColors.warning),
                ),
                // ✅ ويدجت لاختيار التقييم (بافتراض استخدام RatingBar أو قائمة منبثقة)
                PopupMenuButton<double>(
                  initialValue: _currentRating,
                  icon: const Icon(Icons.star, color: AppColors.warning),
                  onSelected: (double rating) {
                    setState(() {
                      _currentRating = rating;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<double>>[
                        const PopupMenuItem<double>(
                          value: 5.0,
                          child: Text('5.0 ★★★★★'),
                        ),
                        const PopupMenuItem<double>(
                          value: 4.0,
                          child: Text('4.0 ★★★★'),
                        ),
                        const PopupMenuItem<double>(
                          value: 3.0,
                          child: Text('3.0 ★★★'),
                        ),
                        const PopupMenuItem<double>(
                          value: 2.0,
                          child: Text('2.0 ★★'),
                        ),
                        const PopupMenuItem<double>(
                          value: 1.0,
                          child: Text('1.0 ★'),
                        ),
                      ],
                ),
              ],
            ),
          ],
        ),

        // Comment Text Field
        TextField(
          controller: _commentController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'اكتب مراجعتك هنا...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        BlocConsumer<ReviewCubit, ReviewState>(
          listener: (context, state) {
            if (state is ReviewCreated) {
              ShowToast(message: state.message, state: toastState.success);
              _commentController.clear();
              setState(() {
                _currentRating = 5.0;
              });
            }
            if (state is ReviewsError &&
                state.message.contains('تسجيل الدخول')) {
              ShowToast(message: state.message, state: toastState.error);
            } else if (state is ReviewsError) {
              ShowToast(message: state.message, state: toastState.error);
            }
          },
          builder: (context, state) {
            final isLoading = state is ReviewCreating;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: isLoading ? null : () => _submitReview(context),
                child: isLoading
                    ? const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('إرسال التقييم'),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ----------------------------------------------------------------------
// 2. Review List Section
// ----------------------------------------------------------------------
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

// ----------------------------------------------------------------------
// 3. Single Review Tile
// ----------------------------------------------------------------------
class ReviewTile extends StatelessWidget {
  final Review review;
  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final currentUserId = CacheHelper.getData(key: 'user_id');

    return Card(
      color: AppColors.bgSecondary,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Text(
            review.user?.name?[0].toUpperCase() ?? '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(review.user?.name ?? 'مستخدم', style: Styles.textStyle16),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.warning, size: 16),
                const SizedBox(width: 4),
                Text(
                  review.rating.toStringAsFixed(1),
                  style: Styles.textStyle14.copyWith(color: AppColors.warning),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(review.comment, style: Styles.textStyle14),
          ],
        ),
        // زر الحذف: يظهر فقط لمنشئ التقييم
        trailing: (currentUserId != null && review.user?.id == currentUserId)
            ? IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.error,
                  size: 20,
                ),
                onPressed: () async {
                  final confirm = await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('تأكيد الحذف'),
                      content: const Text(
                        'هل أنت متأكد أنك تريد حذف هذا التقييم؟',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('إلغاء'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('حذف'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    ReviewCubit.get(
                      context,
                    ).deleteReview(review.id, review.activityId!);
                  }
                },
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
