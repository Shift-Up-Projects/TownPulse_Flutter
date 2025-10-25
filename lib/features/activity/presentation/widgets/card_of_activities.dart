import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/activity/presentation/views/details_dialog_activities.dart';

class CardOfActivity extends StatelessWidget {
  final Activity activity;
  final Widget? trailingWidget;

  const CardOfActivity({
    super.key,
    required this.activity,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DetailsDialogActivities(activity: activity),
        );
      },
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  activity.title ?? '',
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    activity.category ?? '',
                    style: Styles.textStyle16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.date_range, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  activity.startDate != null
                      ? "${activity.startDate!.day}/${activity.startDate!.month}/${activity.startDate!.year}"
                      : "",
                  style: Styles.textStyle16.copyWith(color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  activity.location ?? '',
                  style: Styles.textStyle16.copyWith(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (trailingWidget != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: trailingWidget!,
              ),
          ],
        ),
      ),
    );
  }
}
