// lib/features/activity/presentation/widgets/delete_activity_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/app_colors.dart'; // ✅ يجب استيراد AppColors
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/card_of_activities.dart';
import 'package:town_pulse2/features/main_screen/presentation/view/edit_activity_view.dart';

class DeleteAndUpdateActivityCard extends StatelessWidget {
  const DeleteAndUpdateActivityCard({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(activity.id),
      // ✅ الخلفية الأساسية: للتعديل (سحب لليمين)
      background: Container(
        color: AppColors.success, // لون النجاح (أخضر)
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
      // ✅ الخلفية الثانوية: للحذف (سحب لليسار)
      secondaryBackground: Container(
        color: AppColors.error, // لون الخطأ (أحمر)
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
          // ✅ منطق التعديل
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditActivityView(activity: activity),
            ),
          );
          if (result == true) context.read<ActivityCubit>().getMyActiviy();
          return false;
        } else if (direction == DismissDirection.endToStart) {
          // 🗑 منطق الحذف
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
      child: CardOfActivity(activity: activity),
    );
  }
}
