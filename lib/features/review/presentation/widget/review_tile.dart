import 'package:flutter/material.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/features/review/data/model/review_model.dart';
import 'package:town_pulse2/features/review/presentation/cubit/review_cubit.dart';

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
