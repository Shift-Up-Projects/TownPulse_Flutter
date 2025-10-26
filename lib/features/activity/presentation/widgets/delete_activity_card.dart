import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/card_of_activities.dart';
import 'package:town_pulse2/features/attedence/presentation/widgets/activity_attendees_dialog.dart';
import 'package:town_pulse2/features/main_screen/presentation/view/edit_activity_view.dart';

class DeleteAndUpdateActivityCard extends StatelessWidget {
  const DeleteAndUpdateActivityCard({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(activity.id),

      background: Container(
        color: AppColors.success,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.edit, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'تعديل النشاط',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: AppColors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'حذف النشاط',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditActivityView(activity: activity),
            ),
          );
          if (result == true) context.read<ActivityCubit>().getMyActiviy();
          return false;
        } else if (direction == DismissDirection.endToStart) {
          final confirm = await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('تأكيد الحذف'),
              content: const Text('هل أنت متأكد أنك تريد حذف هذا النشاط؟'),
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
            context.read<ActivityCubit>().deleteActivity(activity.id!);
            return true;
          }
          return false;
        }
        return false;
      },
      child: CardOfActivity(
        activity: activity,
        trailingWidget: IconButton(
          icon: const Icon(Icons.people_alt, color: AppColors.secondary),
          tooltip: 'عرض الحضور',
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => ActivityAttendeesDialog(activity: activity),
            );
          },
        ),
      ),
    );
  }
}
