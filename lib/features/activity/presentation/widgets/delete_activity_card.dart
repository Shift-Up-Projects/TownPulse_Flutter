import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
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
      child: CardOfActivity(activity: activity),
    );
  }
}
